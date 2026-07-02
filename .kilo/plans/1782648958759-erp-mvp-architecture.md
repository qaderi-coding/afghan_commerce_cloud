# Afghan Commerce Cloud — MVP Execution Plan

## 0. Constraints & Stack

- Backend: .NET 8 Web API + REST, Clean Architecture, Modular Monolith
- Frontend: React 18 + TypeScript + Vite + MUI + React Query
- Database: MariaDB (EF Core Pomelo provider) — use existing `database-backup.sql` as source of truth
- Infra: Docker, Redis, Nginx, GitHub Actions, Serilog + OpenTelemetry
- Currency: AFN base, USD active, multi-currency amounts stored as decimal + code
- All money = `decimal(18,4)` only. No double/float.

---

## 1. Database Analysis (MariaDB Schema)

### 1.0 Complete Table Inventory (from database-backup.sql)

| # | Table | Purpose | MVP? |
|---|-------|---------|------|
| 1 | users | Auth principals | Yes |
| 2 | privileges | Permission definitions (JSON rules) | Yes |
| 3 | usersprivileges | User ↔ privilege join | Yes |
| 4 | accounts | Chart of Accounts + customer/vendor registry | Yes |
| 5 | accountcategories | Links account → business category | Yes |
| 6 | journals | Central transaction hub; parent/child split entries | Yes |
| 7 | transactions | Double-entry lines per journal | Yes |
| 8 | revenues | Revenue recognition entries | Yes |
| 9 | expenses | Expense entries | Yes |
| 10 | balanceadjustments | A/R A/P balance corrections | Yes |
| 11 | financialperiods | Open/close accounting periods | Yes |
| 12 | keyvalues | System settings (JSON blob) → migrate to typed settings | Yes |
| 13 | cashpayments | Outgoing payments | Yes |
| 14 | cashpaymentitems | Multi-currency / split payment lines | Yes |
| 15 | cashreceipts | Incoming receipts | Yes |
| 16 | cashreceiptitems | Receipt split lines | Yes |
| 17 | cashexchanges | AFN↔USD conversions | Yes |
| 18 | cashtransfers | Internal cash transfers | Yes |
| 19 | withdrawals | Owner/partner withdrawals | Yes |
| 20 | stockitems | Main product catalog (spare parts) | Yes |
| 21 | stocklevels | Current quantity per stock item + stock account | Yes |
| 22 | stockitemunits | Unit-of-measure variants | Yes |
| 23 | stockitemvaluedists | Value distribution across units | Yes |
| 24 | stockadjustments | Manual + automated stock corrections | Yes |
| 25 | stocklosses | Damaged/expired write-offs | Yes |
| 26 | averagecostadjustments | Average cost adjustment entries | Yes |
| 27 | averagecosts | Average cost history snapshots | Yes |
| 28 | stockexpiryalerts | Expiry monitoring | Later |
| 29 | stockpurchases | Purchase order / bill header | Yes |
| 30 | stockpurchaseitems | Line items | Yes |
| 31 | stockpurchasebillcosts | Transport/clearance costs on purchase | Yes |
| 32 | stockpurchasecosts | Extra costs (e.g. freight) | Later |
| 33 | stockpurchasecloses | Purchase closure / finalization | Later |
| 34 | stocksales | Regular sales invoice | Yes |
| 35 | stocksaleitems | Invoice lines | Yes |
| 36 | stocksalebillcosts | Sales-side costs | Yes |
| 37 | stocksaleexcashes | Cash split per sale | Yes |
| 38 | stockpossales | Fast sales / quick invoices | Yes |
| 39 | stockpossaleitems | Fast sale lines | Yes |
| 40 | stocktransfers | Inter-location stock movement | Later |
| 41 | stocktransferitems | Transfer lines | Later |
| 42 | stocktransfercosts | Transfer-side costs | Later |
| 43 | stocktransfercostdists | Cost distribution across items | Later |
| 44 | stockitemexchanges | Swap item A for item B | Later |
| 45 | fixedassets | Capital asset register | Later |
| 46 | fixedassetlqs | Asset liquidation/sale | Later |
| 47 | employeeaccounts | Employee master | Later |
| 48 | employeepayments | Salary / advance payments | Later |
| 49 | employeepaymentitems | Payment split lines | Later |
| 50 | payrolls | Payroll run header | Later |
| 51 | payrollitems | Per-employee payroll lines | Later |
| 52 | investments | Investment entries | Later |
| 53 | profitdistributions | Profit distribution header | Later |
| 54 | profitdistributionitems | Profit distribution lines | Later |
| 55 | profitsharepercentages | Profit share percentages | Later |
| 56 | currencies | Currency master | Yes |
| 57 | orginfomodels | Single-row tenant/org config | Yes |
| 58 | items | Generic item master (legacy) | Merge into stockitems |
| 59 | itemsubmissions | Item submission header | Later |
| 60 | itemsubmissionitems | Item submission lines | Later |
| 61 | newfpitemvalues | New financial period item values | Later |
| 62 | notes | Notes | Later |
| 63 | walkincustomers | Walk-in customer info (linked to stockSale) | Yes |

### 1.1 Accounting Core

| Table | Purpose | Key FKs | Issues |
|-------|---------|---------|--------|
| accounts | Chart of Accounts + customer/vendor registry (subType classification) | userId → users | `double` → `decimal(18,4)`; `userId` nullable; add `isSystem` bool |
| accountcategories | Links account → business category | accountId → accounts | name varchar(255) → enum |
| journals | Central transaction hub; parent/child for split entries | fpId → financialPeriods, userId → users | Parent self-ref: enforce depth <= 2 |
| transactions | Double-entry lines per journal | journalId, accountId | `double` → `decimal(18,4)` |
| revenues | Revenue recognition entries | journalId, revenueAccountId, cashAccountId | `double` → `decimal(18,4)` |
| expenses | Expense entries | journalId, expenseAccountId, cashAccountId | `double` → `decimal(18,4)` |
| balanceadjustments | A/R A/P balance corrections | journalId, accountId, capitalAccountId | `double` → `decimal(18,4)` |
| financialperiods | Open/close accounting periods | userId → users | Add `startDate`, `endDate` for range queries |
| keyvalues | System settings (JSON blob) | — | Migrate to typed `settings` table |

**Index reco:** `accounts(subType, isSystem)`, `journals(date, fpId, type)`, `transactions(accountId, journalId)`

### 1.2 Cash Management

| Table | Purpose | Key FKs | Issues |
|-------|---------|---------|--------|
| cashpayments | Outgoing payments | journalId, recipientAccountId, cashAccountId | `meta` LONGTEXT → `json` |
| cashpaymentitems | Multi-currency / split payment lines | cashPaymentId → cashpayments | `double` → `decimal` |
| cashreceipts | Incoming receipts | journalId, payerAccountId, cashAccountId | `meta` LONGTEXT → `json` |
| cashreceiptitems | Receipt split lines | cashReceiptId → cashreceipts | `double` → `decimal` |
| cashexchanges | AFN↔USD conversions | journalId, accountId | `double` → `decimal`; add `rate` column |
| cashtransfers | Internal cash transfers (e.g. petty→main) | journalId, fromAccountId, toAccountId | `double` → `decimal` |
| withdrawals | Owner/partner withdrawals | journalId, withdrawalAccountId, cashAccountId | `double` → `decimal` |

**Index reco:** `cashpayments(journalId, date)`, `cashreceipts(journalId, date)`, `cashtransfers(date)`

### 1.3 Inventory / Stock

| Table | Purpose | Key FKs | Issues |
|-------|---------|---------|--------|
| items | Generic item master (legacy) | userId → users | Merge into stockitems for MVP; create unique constraint |
| stockitems | Main product catalog (spare parts) | userId → users | `code` UNIQUE but `barcode` TEXT → `varchar(100)`; `quantity` stored only in stocklevels |
| stocklevels | Current quantity per stock item + stock account | stockItemId, stockAccountId | Missing `lastUpdated` datetime |
| stockitemunits | Unit-of-measure variants (e.g. carton, piece, meter) | stockItemId → stockitems | Add `baseUnitId` self-ref for conversion |
| stockitemvaluedists | Value distribution across units on journalized events | stockItemId | `baseQuantity` → `decimal` |
| stockadjustments | Manual + automated stock corrections | stockItemId, stockAccountId, capitalAccountId | `double` → `decimal`; add `reason` text |
| stocklosses | Damaged/expired write-offs | stockItemId, stockAccountId | `double` → `decimal` |
| averagecostadjustments | Average cost adjustment journal entries | journalId, stockItemId, capitalAccountId | `double` → `decimal` |
| averagecosts | Average cost history snapshots | journalId, stockItemId | preQuantity, newQuantity, amount, code |
| stockexpiryalerts | Expiry monitoring | stockItemId | Add `isResolved` bool |

**Index reco:** `stockitems(code)`, `stocklevels(stockItemId, stockAccountId)`, `stockadjustments(journalId)`, `averagecosts(stockItemId, journalId)`

### 1.4 Purchasing

| Table | Purpose | Key FKs | Issues |
|-------|---------|---------|--------|
| stockpurchases | Purchase order / bill header | vendorAccountId → accounts, cashAccountId → accounts | `isPending` bool; `paymentType` enum |
| stockpurchaseitems | Line items (qty, unit price, cost, sale price) | stockPurchaseId, stockItemId, stockAccountId | `double` → `decimal`; add `receivedQty` for partial |
| stockpurchasebillcosts | Transport/clearance costs on purchase | stockPurchaseId, cashAccountId | `type` ENUM: costsOnUs / costsOnVendor |
| stockpurchasecosts | Extra costs (e.g. freight) | journalId, cashAccountId | `double` → `decimal` |
| stockpurchasecloses | Purchase closure / finalization | stockPurchaseId, journalId | — |

### 1.5 Sales / Invoicing

| Table | Purpose | Key FKs | Issues |
|-------|---------|---------|--------|
| stocksales | Regular sales invoice | customerAccountId → accounts, cashAccountId → accounts | `customerAccountId` NULL allowed → enforce NOT NULL for MVP |
| stocksaleitems | Invoice lines | stockSaleId, stockItemId, stockAccountId | `double` → `decimal` |
| stocksalebillcosts | Sales-side costs (e.g. delivery) | stockSaleId, cashAccountId | — |
| stocksaleexcashes | Cash split per sale (AFN/USD) | stockSaleId | Replace with `cashreceipts` linkage |
| stockpossales | Fast sales / quick invoices | customerAccountId → accounts, cashAccountId, stockAccountId | `customer` varchar(255) → FK to accounts |
| stockpossaleitems | Fast sale lines | stockPOSSaleId, stockItemId | `double` → `decimal` |

### 1.6 Transfers & Exchanges

| Table | Purpose | Key FKs |
|-------|---------|---------|
| stocktransfers | Inter-location stock movement | fromStockAccountId, toStockAccountId, journalId |
| stocktransferitems | Transfer lines | stockTransferId, stockItemId |
| stocktransfercosts | Transfer-side costs | stockTransferId, accountId |
| stocktransfercostdists | Cost distribution across items | stockTransferId, stockItemId |
| stockitemexchanges | Swap item A for item B (return+buy) | soldItemId, boughtItemId, journalId |
| fixedassets | Capital asset register | itemId, assetAccountId, cashAccountId, journalId |
| fixedassetlqs | Asset liquidation/sale | itemId, assetAccountId, cashAccountId, journalId |

### 1.7 HR / Payroll (Light MVP)

| Table | Purpose | Key FKs |
|-------|---------|---------|
| employeeaccounts | Employee master | — |
| employeepayments | Salary / advance payments | employeeAccountId, cashAccountId, journalId |
| employeepaymentitems | Payment split lines | employeePaymentId |
| payrolls | Payroll run header | journalId |
| payrollitems | Per-employee payroll lines | payrollId, employeeAccountId |

### 1.8 Additional Tables (Future / Light)

| Table | Purpose | Key FKs |
|-------|---------|---------|
| investments | Investment entries | journalId, investorId, investedIntoId |
| profitdistributions | Profit distribution header | journalId, profitAccountId |
| profitdistributionitems | Profit distribution lines | profitDistributionId, accountId |
| profitsharepercentages | Profit share percentages | userId, accountId |
| currencies | Currency master | — |
| orginfomodels | Single-row tenant/org config | — |
| itemsubmissions | Item submission header | journalId, marketerAccountId |
| itemsubmissionitems | Item submission lines | itemSubmissionId, stockItemId, stockAccountId |
| newfpitemvalues | New financial period item values | journalId, stockItemId |
| notes | Notes | userId |
| walkincustomers | Walk-in customer info | stockSaleId |

### 1.9 Critical Migration Warnings

1. `double` → `decimal(18,4)` for ALL monetary columns. Use EF Core `decimal`.
2. `meta` LONGTEXT → `json` (MariaDB native JSON) for structured metadata.
3. `barcode` TEXT → `varchar(100)` with B-tree index.
4. `code` char(3) → keep as currency code but add FK check or CHECK constraint.
5. `quantity` in fixedassets is `varchar` → `decimal(18,4)`.
6. `stockpossales.customer` must become FK to `accounts(id)`.
7. `keyvalues` → `settings(key varchar PK, value json, updatedAt datetime)`.
8. Add `createdAt`, `updatedAt`, `deletedAt` to all major tables for audit/soft-delete.
9. All FK columns need `ON DELETE RESTRICT` (not SET NULL) for accounting integrity.
10. `journal.parentId` self-loop: enforce max depth 2 via trigger or app logic.

---

## 2. Domain Model & Bounded Contexts

### Shared Kernel (all contexts depend on this)

- `Money(value: numeric, currency: CurrencyCode)` value object
- `UserId`, `AccountId`, `StockItemId`, `JournalId` entity IDs
- `Result<T>` / `Error` discriminated union
- `IAuditable`, `ISoftDeletable` base interfaces

### 2.1 Identity & Access Context

**Aggregates:** User, Privilege
**Entities:** UserPrivilege
**Value Objects:** Username, HashedPassword, PermissionRule (JSON)
**Domain Services:** PermissionEvaluator
**Rules:**
- `users.isAdmin` supersedes all privilege checks
- `privileges.rules` JSON schema: `{ "module": string, "actions": ["read","write","delete","approve"] }`

### 2.2 Inventory Context

**Aggregates:** StockItem, StockLevel, StockItemUnit
**Entities:** StockAdjustment, StockLoss, StockExpiryAlert, AverageCostAdjustment, AverageCost, Item
**Value Objects:** UnitOfMeasure, Barcode, SafetyStock, Price(amount, currency)
**Domain Services:** AverageCostCalculator, StockAvailabilityChecker
**Rules:**
- StockLevel quantity is derived; only change via Journalized event
- Negative stock blocked unless org setting `allowNegativeStock` = true
- Barcode auto-generated or manual (flag per item)

### 2.3 Purchasing Context

**Aggregates:** StockPurchase
**Entities:** StockPurchaseItem, StockPurchaseBillCost, StockPurchaseCost, StockPurchaseClose
**Value Objects:** PurchasePaymentType(cash|credit), BillNumber, VendorAccountId
**Domain Services:** PurchaseCostAllocator
**Rules:**
- credit purchases create A/P entry automatically
- `isPending` blocks closure until fully paid/received
- Partial receipt updates stocklevels + creates sub-journal
- Bill costs allocated across items by ratio or weight

### 2.4 Sales / Billing Context

**Aggregates:** StockSale, StockPOSSale, CreditNote
**Entities:** StockSaleItem, StockPOSSaleItem, StockSaleExCash, WalkInCustomer, CreditNoteItem
**Value Objects:** PaymentType(cash|credit|partial), CustomerLookup, InvoiceNumber, CreditNoteNumber
**Domain Services:** SalePriceValidator, COGSCalculator, CashSplitter, SalesReturnProcessor
**Rules:**
- Sales invoice auto-generates cash receipt + revenue + COGS + stock journals
- `stockSaleId` links to `cashreceipts.journalId` for traceability
- Customer free-text stored only if not found in accounts under same session
- Partial payment: remaining → A/R account
- Credit note references original sale; restores stock + reverses revenue/COGS
- Refund path: create cash payment or customer credit

### 2.5 Accounting Context

**Aggregates:** Account, Journal
**Entities:** Transaction, Revenue, Expense, BalanceAdjustment, FinancialPeriod
**Value Objects:** DebitCredit(dr|cr), AccountType(currentAsset|liability|revenue|expense|capital|profit|systemReserved), AccountSubType
**Domain Services:** DoubleEntryValidator, TrialBalanceChecker, JournalPoster
**Rules:**
- Every journal has ≥2 transactions; sum(dr) == sum(cr)
- Financial period must be open for posting
- System accounts (isSystem=1) cannot be edited/deleted via UI
- journals.parentId only used for compound entries (max depth 2)

### 2.6 Cash Management Context

**Aggregates:** CashPayment, CashReceipt, CashExchange, CashTransfer, Withdrawal
**Entities:** CashPaymentItem, CashReceiptItem
**Value Objects:** CashAccountId, ExchangeRate
**Domain Services:** CashDenominator, ExchangeGainLossCalculator
**Rules:**
- AFN is base; USD amounts stored with base-AFN equivalent
- Exchange creates 4-leg journal: Dr Cash(AFN) / Cr Cash(USD) @ rate + gain/loss

### 2.7 Payroll Context (Light)

**Aggregates:** EmployeeAccount, Payroll
**Entities:** PayrollItem, EmployeePayment, EmployeePaymentItem
**Value Objects:** SalaryAmount, PaymentType
**Domain Services:** PayrollCalculator
**Rules:**
- Payment immediately journalizes to expense + cash
- Payroll run = group of employee payments linked to one journal

---

## 3. End-to-End Business Flows

### 3.1 Sales Invoice Flow

```
Customer selection (account search by name/phone, subType='customer')
  ↓
Invoice assembly:
  - Select stockitems (scan barcode or search)
  - Enter qty, unit price per line
  - Add delivery costs if any (stocksalebillcosts)
  - paymentType = cash|credit|partial
  ↓
Validation:
  - qty > 0
  - stock available (or allowNegativeStock)
  - price editable iff user.allowPriceEditing
  ↓
Submit:
  1. BeginTransaction (ambient, cross-module)
  2. Create Journal(type=stockSale, fpId=current)
  3. Post A/R Entry:
     - Dr CustomerAccount (A/R) (total)
     - Cr RevenueAccount (total - discount)
     - If discount: Dr DiscountExpense / Cr CustomerAccount (discount portion)
  4. Post COGS + Stock:
     - Dr COGSAccount (sum of avg cost * qty)
     - Cr StockAccount (same amount)
  5. Decrease StockLevels (-qty)
  6. Create StockSale + StockSaleItems
  7. Create StockSaleBillCosts (if any)
  8. If cash/partial: Create CashReceipt (linked to journal)
  9. Create CashReceiptItems (AFN/USD split if needed)
 10. If stockSaleExCash needed: create stockSaleExCash
 11. CommitTransaction
 12. Publish StockUpdated event → Redis invalidation
 13. Emit AuditLog(userId, action='sale_invoice', refType='StockSale', refId)
```

### 3.2 Purchase Flow

```
Vendor selection (account search by name/phone, filter subType='supplier')
  ↓
Purchase entry:
  - Select stockitems + qty + unit price + sale price
  - Add bill costs (transport, clearance)
  - paymentType = cash|
  ↓
Submit:
  1. BeginTransaction
  2. Create Journal(type=stockPurchase, fpId=current)
  3. Post A/P Entry:
     - Dr StockAccount (total item cost)
     - Dr ExpenseAccount (bill costs)
     - Cr VendorAccount (total + bill costs)
  4. Increase StockLevels (+receivedQty)
  5. Update stockitem.valuedists by ratio
  6. If cash: create CashPayment → Cr CashAccount
  7. Else: remain as A/P (isPending=1)
  8. Create StockPurchase + StockPurchaseItems + StockPurchaseBillCosts
  9. CommitTransaction
 10. AuditLog
```

### 3.3 Stock Adjustment Flow

```
User selects stockitem + adjustment type (increase/decrease)
  ↓
Enter qty, unit cost, reason
  ↓
Validate:
  - decrease: must have sufficient stock
  - cost within acceptable range (configurable threshold)
  ↓
1. BeginTransaction
2. Create Journal(type=stockAdjustment)
3. Post:
   - if increase: Dr StockAccount, Cr CapitalAccount
   - if decrease: Dr ExpenseAccount (loss), Cr StockAccount
4. Update StockLevels
5. Create StockAdjustment record
6. Commit
7. AuditLog
```

### 3.4 Sales Return Flow (Credit Note)

```
Select original StockSale to return against
  ↓
Return entry:
  - Select stockitems + qty to return (must be ≤ original qty)
  - Reason (damaged, wrong item, customer dissatisfaction)
  - Refund method (cash, credit memo, future offset)
  - Restocking fee (optional, configurable)
  ↓
Validation:
  - relatedSaleId must exist and be posted
  - qty > 0 and qty ≤ original qty
  - Financial period open
  ↓
Submit:
  1. BeginTransaction
  2. Create Journal(type=salesReturn, fpId=current)
  3. Post Stock Restoration:
     - Dr StockAccount (avg cost * return qty)
     - Cr COGSAccount (same amount)
  4. Post Revenue Reversal:
     - If full return: Dr RevenueAccount, Cr CustomerAccount (A/R)
     - If partial: reverse proportionally
     - If restocking fee: Dr CashAccount, Cr RevenueAccount (fee)
  5. Increase StockLevels (+return qty, update average cost)
  6. Create CreditNote + CreditNoteItems
  7. If refund=cash: Create CashPayment (linked to creditnote)
  8. If refund=creditMemo: update customer balance via cashreceipt offset or account category
  9. CommitTransaction
 10. AuditLog
```

### 3.5 Purchase Return Flow (Vendor Return)

```
Select original StockPurchase to return against
  ↓
Return entry:
  - Select stockitems + qty to return (must be ≤ received qty)
  - Reason (defective, wrong item, excess)
  - Return type: refund (money back) or creditMemo (vendor credit)
  ↓
Validation:
  - relatedPurchaseId must exist and be closed/received
  - qty > 0 and qty ≤ received qty
  - qty must still be in stock if physical return
  ↓
Submit:
  1. BeginTransaction
  2. Create Journal(type=purchaseReturn, fpId=current)
  3. Post Stock Removal:
     - Dr COGS / ExpenseAccount (avg cost * return qty)
     - Cr StockAccount (same amount)
  4. Post A/P Reduction:
     - Dr VendorAccount (A/P) (purchase price * qty)
     - If refund: Cr CashAccount (or track as vendor receivable)
     - If creditMemo: Cr VendorAccount net (creates negative A/P = vendor credit)
  5. Decrease StockLevels (-return qty)
  6. Create PurchaseReturn + PurchaseReturnItems
  7. If refund: Create CashPayment
  8. CommitTransaction
  9. AuditLog
```

### 3.6 Cash Receipt (Customer Payment)

```
Select customer account (A/R)
  ↓
Enter amount + currency + exchange details
  ↓
1. BeginTransaction
2. Create Journal(type=cashReceipt)
3. Post:
   - Dr CashAccount
   - Cr CustomerAccount (A/R)
4. Create CashReceipt + CashReceiptItems
5. Update account balance (accountcategories handles grouping)
6. Commit
7. AuditLog
```

### 3.7 Cash Payment (Vendor Payment)

```
Select vendor account (A/P)
  ↓
Enter amount + currency + exchange details
  ↓
1. BeginTransaction
2. Create Journal(type=cashPayment)
3. Post:
   - Dr VendorAccount (A/P)
   - Cr CashAccount
4. Create CashPayment + CashPaymentItems
5. Commit
6. AuditLog
```

### 3.8 Cash Exchange (AFN ↔ USD)

```
Select from cash account + to cash account
Enter foreign amount + exchange rate
  ↓
1. BeginTransaction
2. Create Journal(type=cashexchange)
3. Calculate base AFN equivalent
4. Post 4 legs:
   - Dr ToCashAccount (foreign amount in base)
   - Cr FromCashAccount (base amount)
   - If gain: Dr ExchangeGainLoss, Cr ToCashAccount(gain)
   - If loss: Dr FromCashAccount(loss), Cr ExchangeGainLoss(loss)
5. Create CashExchange record with rate + gain/loss
6. Commit
7. AuditLog
```

---

## 4. Backend Architecture (.NET 8)

### 4.1 Solution Structure

```
src/
├── SharedKernel/
│   ├── Domain/
│   │   ├── Entities/ (BaseEntity, AuditableEntity, SoftDeletableEntity)
│   │   ├── ValueObjects/ (Money, CurrencyCode, DebitCredit)
│   │   ├ Events/ (IDomainEvent, INotification)
│   │   └ Exceptions/ (DomainException)
│   ├── Common/
│   │   ├── Result.cs
│   │   ├── Guard.cs
│   │   └── Maybe.cs
│   └── SharedKernel.csproj
├── IdentityAccess/
│   ├── IdentityAccess.Domain/
│   │   ├── Entities/ (User, Privilege, UserPrivilege)
│   │   ├── ValueObjects/ (Username, HashedPassword)
│   │   ├── Services/ (IPermissionEvaluator)
│   │   └── Events/ (UserLoggedInEvent, PrivilegeChangedEvent)
│   ├── IdentityAccess.Application/
│   │   ├── Users/ (Commands, Queries, DTOs, Validators)
│   │   ├── Privileges/
│   │   └── Common/ (IUserContext, IPermissionService)
│   ├── IdentityAccess.Infrastructure/
│   │   ├── Persistence/ (AppDbContext, Configurations, Repositories)
│   │   ├── Identity/ (PasswordHasher, JwtTokenService)
│   │   └── Services/ (PermissionEvaluator)
│   └── IdentityAccess.API/
│       ├── Controllers/
│       ├── Middleware/
│       └── Program.cs (REST API composition)
├── Inventory/
│   └── [same layers: Domain / Application / Infrastructure / API]
├── Purchasing/
│   └── ...
├── Sales/
│   └── ...
├── Accounting/
│   └── ...
├── Cash/
│   └── ...
└── Payroll/
    └── ...

build/
deploy/
tests/
├── UnitTests/
├── IntegrationTests/
└── E2E/
```

### 4.2 Dependency Rules

```
API → Application → Domain
      Infrastructure → Domain
      SharedKernel ← all

NO cross-module Application/Infrastructure references.
Cross-module calls go through:
  a) Domain Events (publish/subscribe in infrastructure)
  b) SharedKernel interfaces (e.g. IJournalPoster in Accounting exposed via DI)
  c) Application Service Facade
```

### 4.3 Cross-Module Contracts (SharedKernel interfaces)

```csharp
// Accounting
public interface IJournalPoster {
  Task<Result<JournalId>> PostAsync(JournalEntry entry, CancellationToken ct);
  Task<Result<TrialBalance>> GetTrialBalanceAsync(FinancialPeriodId fpId, CancellationToken ct);
}

// Inventory
public interface IStockService {
  Task<Result> DecreaseAsync(StockItemId id, Quantity delta, CancellationToken ct);
  Task<Result> IncreaseAsync(StockItemId id, Quantity delta, CancellationToken ct);
  Task<Result<StockLevel>> GetLevelAsync(StockItemId id, CancellationToken ct);
}

// Cash
public interface ICashService {
  Task<Result<CashAccountId>> GetCashAccountIdAsync(AccountId id, CancellationToken ct);
}

// Identity (provided to all via IUserContext)
public interface IUserContext {
  UserId UserId { get; }
  bool IsAdmin { get; }
  Task<bool> HasPermissionAsync(string module, string action, CancellationToken ct);
}
```

### 4.4 Transaction Strategy

- **Modular Monolith Unit of Work:** `IUnitOfWork` is scoped per HTTP request.
- **Ambient Transaction:** MediatR pipeline behavior opens `IDbContextTransaction` at start of command; commits on success, rolls back on failure.
- **Cross-Aggregate Atomicity:** Sales invoice uses single transaction across Accounting + Inventory + Cash contexts via same `AppDbContext` (shared DbContext in modular monolith).
- **Eventual Consistency:** Non-critical side effects (email, SMS, cache invalidation) via `INotification` handlers OUTSIDE the ambient transaction.

### 4.5 Key Projects Breakdown

| Project | Responsibility |
|---------|---------------|
| SharedKernel | Abstractions, VO's, domain events, guard clauses |
| IdentityAccess.Domain | User, Privilege aggregates + permission rules |
| IdentityAccess.Application | CQRS commands/queries, validators |
| IdentityAccess.Infrastructure | EF Core configs, JWT, password hashing |
| IdentityAccess.API | Auth controllers, middleware |
| Inventory.Domain | StockItem, StockLevel, UoM, StockAdjustment |
| Inventory.Application | CRUD, stock queries, barcode logic |
| Inventory.Infrastructure | Repositories, stock snapshot denormalization |
| Sales.Domain | StockSale, StockPOSSale, CreditNote, CreditNoteItem |
| Sales.Application | Invoice checkout, return processing, cart validation |
| Accounting.Domain | Account, Journal, Transaction, FinancialPeriod |
| Accounting.Application | Post journal, trial balance, COGS calc |
| Cash.Domain | CashPayment, CashReceipt, CashExchange, CashTransfer |
| Cash.Application | Payment posting, exchange settlement |
| Purchasing.Domain | StockPurchase, PurchaseItem, BillCost |
| Purchasing.Application | Purchase creation, cost allocation |
| Payroll.Domain | EmployeeAccount, Payroll, EmployeePayment |
| Payroll.Application | Payroll run, payment |
| API.Gateway | Minimal API composition, health checks, middleware pipeline |

---

## 5. Frontend Architecture (Enterprise React + TypeScript + Vite)

### 5.1 Technology Stack & Rationale

| Concern | Choice | Rationale |
|---------|--------|-----------|
| Framework | React 18 + TypeScript + Vite | Fast dev server, HMR, enterprise standard |
| Component Library | MUI v6 + MUI X DataGrid Pro/Advanced | Enterprise grid power; Excel-like editing with Microsoft-inspired themeability |
| Forms | React Hook Form + Zod | Performance (uncontrolled + TS inference), smaller bundle than Formik, optimal for AI codegen |
| Server State | TanStack Query v5 | Caching, background refetch, optimistic updates, devtools |
| Client State | Redux Toolkit + RTK | See §5.2; best for large ERP with undo/redo, draft persistence, wizard state |
| Routing | React Router v7 | Data routers, type-safe params, nested routes for master-detail |
| Validation | Zod (shared with backend schemas) | Single source of truth; TS-first; AI-friendly |
| HTTP Client | Axios + TanStack Query | Interceptors for auth, retry, structured logging |
| Theming | MUI emotion theme + CssBaseline | Microsoft enterprise aesthetic (Dynamics 365 / Azure Portal density) |
| i18n | react-i18next | Lazy-loaded locales, namespace per module |
| Testing | Vitest + React Testing Library + Playwright | Fast unit tests, accessible component tests, E2E for critical paths |
| Code Quality | ESLint + Prettier + Husky + lint-staged | Enforced standards; AI agents emit consistent code |
| Build | Vite + Rollup | Tree-shaking, chunk splitting, env-based config |

### 5.2 Client State Management: Redux Toolkit (Recommended)

**Decision: Redux Toolkit + RTK** for client-only global state.

Why Redux Toolkit over Zustand for this ERP:
- **Scalability:** Single source of truth with normalized state (entities by ID), time-travel debugging, and Redux DevTools — essential for debugging complex invoice/purchase state across 20+ tables.
- **Maintainability:** Enforced patterns (`createSlice`, `createAsyncThunk`), immutability, and middleware for logging/undo. AI agents generate predictable Redux code because the surface area is well-documented.
- **Performance:** Selector memoization (`createSelector`) prevents re-renders in dense DataGrids. Granular subscriptions matter when a single invoice has 50 line items.
- **AI-assisted development:** Strongly typed state, established file conventions (`features/X/slice.ts`), and abundant training data make Redux the safest bet for AI codegen at scale.

**State split:**
- **TanStack Query:** All server-derived data — entities, lists, lookup options, audit logs.
- **Redux Toolkit:** Client-only state — active wizard steps, undo/redo stacks for invoice/purchase entry, draft auto-save, UI theme/compactness settings, notification queue, print preview state.
- **React Hook Form:** Form values and field-level validation — invoices, returns, adjustments. Do NOT lift form state into Redux.

### 5.3 Microsoft-Inspired Enterprise Theme

Target: Dynamics 365 / Azure Portal / Office aesthetic — clean, high-density, command-bar-driven.

Key styling rules:
- **Density:** Compact by default (`density: -2` in MUI). Minimal padding, smaller touch targets for desktop-only users.
- **Command Bar:** Top-of-page action bar with icon buttons (Save, Submit, Void, Print, Export) matching Office ribbon behavior.
- **Typography:** Segoe UI / system font stack. No rounded corners or shadows on data surfaces. Flat or 1px borders.
- **Color:** Minimal accent color (blue `#0078d4` equivalent). Status via font weight and subtle left-border indicators, not colored pills.
- **Navigation:** Left sidebar with icon + text; top breadcrumb; tab-based detail panes.
- **Forms:** No floating labels. Standard top-aligned labels with right-aligned text. Inline validation messages below fields.
- **Data Grids:** Frozen first column (actions), alternating row tint optional off, grid lines at 1px `divider` color.

### 5.4 Reusable Forms Framework

**Core components:**
- `ErpForm` — wrapper around `react-hook-form` + ` zodResolver`
- `FormSection` — collapsible grouped fields with section header
- `FormField` — label, input, error message, help text; supports `TextField`, `Select`, `DatePicker`, `CurrencyInput`, `LookupSearch`
- `LookupSearch` — autocomplete against TanStack Query cache; debounced search; keyboard arrow selection; FAB/magnifying-glass trigger
- `CurrencyInput` — AFN/USD toggle; base-AFN equivalent shown; validates 4 decimals
- `DynamicTable` — form-driven mini grid for line items (invoice lines). Uses `react-hook-form` + `useFieldArray` + `MUI X DataGrid` under the hood. Supports add/remove/reorder.

**Validation strategy:**
- Zod schemas co-located with domain types in `shared/contracts`.
- Server-side validation errors mapped to field-level via `FormField` error prop.
- Client-side: required, min/max qty, date range, balance checks.
- Cross-field validation (e.g., credit total ≤ A/R limit) via `zod.refine`.

**Lookup controls:**
- All customer/vendor/stockitem lookups use `LookupSearch`.
- Debounced query against `/api/accounting/accounts?q=...&subType=customer`.
- Results cached by TanStack Query; staleTime 5 min for static lookups.
- Create-new flow: "Not found? Create account" opens `AccountDialog` pre-filtered by subType.

### 5.5 Reusable Tables Framework

**Core wrappers over MUI X DataGrid Pro/Advanced:**

| Component | Purpose |
|-----------|---------|
| `ErpDataGrid` | Base grid: column defs, server-side sort/filter/pag, loading, empty state, export (CSV/XLSX), print |
| `EditableDataGrid` | Inline editing per cell; optimistic save; rollback on error; dirty indicators |
| `MasterDetailDataGrid` | Expandable rows: master header + child line items (e.g., StockSale → StockSaleItems) |
| `SelectionDataGrid` | Checkbox column; bulk actions bar (Void, Export, Print) |
| `CurrencyColumn` | Right-aligned, 4 decimals, AFN/USD color hint, edit renderer |
| `StatusColumn` | Pill-free: colored left border + bold text (e.g., Posted / Draft / Returned) |

**Enterprise table capabilities:**
- Server-side pagination, sorting, filtering via TanStack Query `keepPreviousData`
- Column management: pin, hide, resize, reorder persisted to `localStorage` per user
- Export: CSV via `@mui/x-data-grid-pro` export; XLSX via `xlsx` for multi-sheet reports
- Print: `@react-pdf/renderer` or print-specific CSS media query with page breaks
- Inline editing: double-click or Enter; Tab to next cell; Esc to cancel; dirty row highlight
- Keyboard: Excel-style navigation (arrows, Enter, Tab, F2) enabled by default
- Virtualization: `--mui-x-charts-height` container virtualization for 1000+ rows
- Density toggle: Compact / Standard / Comfortable (persisted in Redux)

### 5.6 API Layer & Server State

**API client (`shared/lib/apiClient.ts`):**
```typescript
export const api = axios.create({ baseURL: '/api', timeout: 30_000 });
api.interceptors.request.use((cfg) => {
  const token = getToken();
  if (token) cfg.headers.Authorization = `Bearer ${token}`;
  return cfg;
});
api.interceptors.response.use((res) => res, (err) => {
  if (err.response?.status === 401) { /* redirect login */ }
  return Promise.reject(err);
});
```

**Feature API modules (`features/*/api/*Api.ts`):**
- All endpoints typed with DTOs from `shared/contracts`.
- Direct TanStack Query usage in hooks (`features/*/hooks/*.ts`).
- Cache keys: `['sales', 'invoices', { customerId, fpId, status }]` etc.

**Query patterns:**
- List queries: `useQuery` + `keepPreviousData` for pagination
- Detail queries: `useQuery` with `enabled: !!id`
- Mutations: `useMutation` → invalidate affected lists → toast
- Optimistic updates: invoice/purchase submit updates list cache immediately

### 5.7 Project Structure (AI-Agent Friendly)

```
src/
├── app/
│   ├── layout.tsx          # Providers: Redux, Router, Query, Theme, i18n
│   ├── router.tsx          # React Router v7 data routers
│   └── routes.ts           # Route definitions + auth guards
├── features/               # Vertical slices — each owns its page/component/api/state
│   ├── auth/
│   ├── sales/
│   │   ├── pages/          # InvoicePage, ReturnPage, CreditNotePage
│   │   ├── components/     # InvoiceForm, InvoiceLinesTable, ReturnDialog
│   │   ├── api/            # salesApi.ts
│   │   ├── hooks/          # useInvoice, useReturns
│   │   └── types/          # sales.types.ts
│   ├── purchasing/
│   ├── returns/
│   ├── inventory/
│   ├── accounting/
│   ├── cash/
│   └── payroll/
├── shared/
│   ├── components/         # ErpDataGrid, ErpForm, FormField, LookupSearch...
│   ├── hooks/              # useDebounce, useMediaQuery, usePrint
│   ├── lib/                # apiClient, auth, i18n, Redux store config
│   ├── stores/             # Redux slices (ui.slice, wizard.slice, undo.slice)
│   ├── contracts/          # Zod schemas + TypeScript types shared with backend
│   ├── theme/              # MUI theme (enterprise palette, density, typography)
│   └── utils/              # formatMoney, dateHelpers, exportHelpers
├── assets/
├── main.tsx
└── vite-env.d.ts
```

**Rules for AI agents:**
- Never add UI state to Redux unless it must survive tab navigation or be undoable.
- Forms stay local to the feature; lift only IDs and totals to Redux.
- Every `features/X` folder must be independently buildable/testable.
- Shared components live in `shared/components`, never in `features`.

### 5.8 Frontend Development Milestones (M1–M9)

> Each frontend milestone pairs with the backend milestone of the same number.
> Deliverables are shippable UI increments.

#### M1: Foundation (Weeks 1–2) — "Shared Shell & Auth"

**Goal:** Running app shell, auth flow, and Redux/Query wiring.

| Task | Owner | Acceptance Criteria |
|------|-------|---------------------|
| Initialize Vite + React + TypeScript | Frontend A | `npm run dev` works; Vitest green |
| Install MUI v6, MUI X DataGrid Pro, Redux Toolkit, TanStack Query, React Router v7, React Hook Form, Zod | Frontend A | All packages resolve; TypeScript strict mode passes |
| Create enterprise theme (Microsoft Dynamics-inspired) | Frontend B | Compact density; command bar; Segoe/system font; blue accent |
| Build `AppShell` with sidebar + command bar + breadcrumb + tab content | Frontend B | Layout responsive; sidebar collapsible; themes toggleable |
| Implement auth flow (login → JWT → redirect) | Frontend A | Login screen; token in memory + silent refresh; ProtectedRoute |
| Wire Redux store with UI slice (theme density, sidebar collapsed) | Frontend A | Settings persist to `localStorage`; no prop drilling |
| Wire TanStack Query `QueryClientProvider` with default options | Frontend A | Devtools enabled; staleTime 30s for lists; retry 1 |
| `ProtectedRoute` + RBAC integration | Frontend A | Redirects unauthorized; module/action checks from `IUserContext` |

**DoD:**
- App loads login screen; after auth, shows empty shell with sidebar
- Redux DevTools shows state tree
- TanStack Query DevTools shows cache
- Theme toggle changes density globally

---

#### M2: Inventory UI (Weeks 3–4) — "Tables & Forms Skeleton"

**Goal:** Deliver the first real data module with reusable table/form primitives.

| Task | Owner | Acceptance Criteria |
|------|-------|---------------------|
| Build `ErpDataGrid` and `EditableDataGrid` wrappers | Frontend B | Server-side sort/filter/pag; loading skeletons; empty state; CSV export |
| Build `ErpForm` + `FormField` + `LookupSearch` | Frontend A | Validation errors display; lookup debounced; keyboard navigable |
| Stock items list page | Frontend B | Grid with columns: Code, Name, Barcode, Base Unit, Sale Price, Stock Qty, Actions |
| Stock item detail page | Frontend A | Master-detail: header form + child stock levels table |
| Stock adjustment dialog | Frontend A | Type (increase/decrease), qty, cost, reason → POST `/api/inventory/adjustments` |

**DoD:**
- Can list stock items, search, sort, page
- Can create/edit stock item with validation
- Can perform stock adjustment and see stock level update without page reload

---

#### M3: Purchasing UI (Weeks 5–6) — "Bill Entry & Line Items"

**Goal:** Purchase bill entry with embedded editable line grid.

| Task | Owner | Acceptance Criteria |
|------|-------|---------------------|
| `DynamicTable` form-driven mini-grid | Frontend B | Add/remove/reorder rows; per-row stockitem lookup; qty/price/cost columns |
| Purchase list page | Frontend B | Status filter, date range, vendor search, exported headers |
| Purchase detail / create page | Frontend A | Header form (vendor, dates, payment type) + `DynamicTable` for items + bill costs section |
| Purchase closure workflow | Frontend A | Close button disabled until `isPending=false`; confirmation modal |

**DoD:**
- Can create purchase on cash or credit
- Line items editable inline; totals auto-calculate
- Bill costs section allocates to items visually
- Credit purchase shows A/P badge after refresh

---

#### M4: Sales & Billing UI (Weeks 7–8) — "Invoices"

**Goal:** Sales invoice entry end-to-end with barcode and customer selection.

| Task | Owner | Acceptance Criteria |
|------|-------|---------------------|
| Barcode input + product quick-add | Frontend A | Autofocus on mount; Enter triggers search; adds to invoice lines |
| `CurrencyInput` component (AFN/USD toggle) | Frontend A | Base-AFN equivalent updates instantly; validates 4 decimals |
| Invoice list page | Frontend B | Status tabs (Draft / Posted / Returned); customer filter; export |
| Invoice create/edit page | Frontend A | Header form + `DynamicTable` lines + `CurrencyInput` totals + command bar |
| Invoice submit flow | Frontend A | Validation → confirmation → loading → receipt view; list invalidates |

**DoD:**
- Can create invoice with customer, lines, payment type
- Barcode scanner physically works (HID emulation)
- Submit creates journals (backend M4 complete) and shows receipt
- Negative stock blocked per org setting

---

#### M5: Returns & Adjustments UI (Weeks 9–10) — "Credit Notes & Vendor Returns"

**Goal:** Return entry screens linked to original documents.

| Task | Owner | Acceptance Criteria |
|------|-------|---------------------|
| `ReturnDialog` (sales return) | Frontend A | Pre-populated from original invoice; qty ≤ original; reason picker; refund method |
| `PurchaseReturnDialog` | Frontend A | Linked to original purchase; return type (refund/creditMemo) |
| Returns list page | Frontend B | Filter by sale/purchase; status workflow (draft/posted/refunded) |
| Return print view | Frontend B | Print-ready layout matching sales/purchase print |

**DoD:**
- Can open return from invoice detail
- Return saves, posts reversing entries, restores stock
- Cash refund or credit memo reflected in cash/payment module

---

#### M6: Accounting UI (Weeks 11–12) — "Ledgers & Reports"

**Goal:** Read-heavy accounting screens with master-detail journals.

| Task | Owner | Acceptance Criteria |
|------|-------|---------------------|
| Journals master-detail grid | Frontend B | Journal header → transaction lines expansion; date range filter |
| Account ledger page | Frontend B | Account search → running balance; drill-to-journal; export CSV |
| Trial balance page | Frontend B | Dry-run vs posted; period selector; acc/debit/credit columns |
| Journal void/reverse action | Frontend A | Confirmation; creates reversing journal; updates list |

**DoD:**
- Can view all posted journals with drill-down
- Trial balance ties to zero (or expected opening balance)
- Void operation creates audit trail entry

---

#### M7: Cash Management UI (Weeks 13–14) — "Receipts, Payments, Exchange"

**Goal:** Cash receipt/payment entry with multi-currency splits.

| Task | Owner | Acceptance Criteria |
|------|-------|---------------------|
| Cash receipts list + create | Frontend A | Customer selection; amount in AFN/USD; split lines table |
| Cash payments list + create | Frontend A | Vendor selection; split lines; linked to A/P when possible |
| Currency exchange dialog | Frontend B | From/to cash account; rate input; gain/loss preview; 4-leg journal creation |
| Cash transfer / withdrawal | Frontend A | Simple forms; validate against current balance |

**DoD:**
- Cash receipt updates A/R balance
- Exchange creates entries with correct gain/loss legs
- Print receipt available

---

#### M8: Payroll UI (Weeks 15–16) — "Salaries"

**Goal:** Simple employee payment entry.

| Task | Owner | Acceptance Criteria |
|------|-------|---------------------|
| Employee list + detail | Frontend B | Grid with search; detail shows payments history |
| Salary payment entry | Frontend A | Employee selector; amount; splits; journalizes |

**DoD:**
- Payment creates expense + cash journal
- Payroll run summary page

---

#### M9: Hardening & Print (Weeks 17–18) — "Enterprise Polish"

**Goal:** RBAC, print/export, accessibility, performance, AI-agent handoff.

| Task | Owner | Acceptance Criteria |
|------|-------|---------------------|
| RBAC gating on all routes and action buttons | Frontend A | `hasPermission(module, action)` drives hide vs disable |
| Print stylesheet for invoices, returns, receipts | Frontend B | Browser print preview clean; no sidebar; fits A4 |
| XLSX multi-sheet export for reports | Frontend B | Header formatting; number formats; frozen panes preserved |
| Virtualization tuning for 10k+ row lists | Frontend B | 60fps scroll; dynamic row height if needed |
| Accessibility audit (keyboard, ARIA, color contrast) | Frontend A | WCAG AA; axe-core clean |
| i18n scaffolding (English + Dari/Pashto placeholders) | Frontend A | `t()` function; lazy-loaded locales; RTL toggle reserved |
| Error boundaries + Sentry (or equivalent) integration | Frontend A | Frontend errors captured with user context |
| E2E critical paths (Login → Invoice → Return) | Frontend B | Playwright tests pass in CI |

**DoD:**
- All CRUD screens respect RBAC
- Print and export work offline (cached data)
- Lighthouse performance > 90 on list pages

---

### 5.9 Frontend Developer Standards (AI-Agent Ready)

**Git commit messages:**
```
feat(sales): add invoice submit command bar action
fix(inventory): prevent negative stock on adjustment
refactor(shared): extract CurrencyColumn into ErpDataGrid
test(sales): invoice submit happy path
```

**Branch naming:**
- `feat/M4-sales-invoice`
- `fix/M2-stock-adjustment-validation`

**PR checklist:**
- [ ] TypeScript strict mode passes
- [ ] Vitest `--coverage` ≥ 80% for changed files
- [ ] No `any` types without `// eslint-disable-next-line` justification
- [ ] TanStack Query cache keys follow `[module, entity, params]` convention
- [ ] Redux slice added only if state must survive route change or be undoable
- [ ] Form validation error mapped to `FormField` error prop
- [ ] Print layout tested in Chrome/Firefox print preview

**File naming:**
- `InvoicePage.tsx` — page component
- `InvoiceForm.tsx` — feature-specific form
- `useInvoice.ts` — feature query/mutation hooks
- `salesApi.ts` — feature API surface
- `invoiceSlice.ts` — Redux slice (if needed)

**AI-agent guardrails:**
- Always import from `@tanstack/react-query`, never mock fetch.
- Use `zod` schemas from `shared/contracts` for validation.
- Never inline styles; use `sx` prop or `styled()`.
- Never store JWT in localStorage; use memory + HttpOnly refresh fallback.
- Grid columns defined as `GridColDef[]` array with `type`, `width`, `editable`, `valueFormatter`.

---

## 6. Learning Path & Task Distribution

> **For beginners:** This is a code-along project. Each milestone builds on the previous one.
> Follow the steps in order. Don't skip ahead. Test after every small change.
>
> **Conflict avoidance:** Each milestone has ONE primary module. If 2 people work together,
> one does Domain/Application, the other does Infrastructure/API for the SAME module.

---

### How to Approach This Project (Beginner Guide)

#### What is Clean Architecture?
Think of it like a building:
- **Domain** (inner core): Business rules, entities, value objects. No external dependencies.
- **Application**: Use cases, commands, queries. Depends only on Domain.
- **Infrastructure**: Database, file system, external APIs. Depends on Domain + Application.
- **API**: REST endpoints. Depends on Infrastructure + Application.

**Rule: Outer layers can depend on inner layers, never the reverse.**

#### What is a Modular Monolith?
Instead of 7 separate microservices (too complex for MVP), we build ONE application
with clear internal boundaries. Each "module" (Inventory, Sales, etc.) is a folder
with its own Domain/Application/Infrastructure/API structure.

#### What is REST API?
Instead of GraphQL, clients interact with traditional REST endpoints (`GET /api/users`, `POST /api/accounts`). Each endpoint returns a specific resource representation.

**Key concepts:**
- **Query**: Read data (like GET)
- **Mutation**: Write data (like POST/PUT/DELETE)
- **Resolver**: Function that fetches data for a field
- **Schema**: Contract between client and server

---

### Task Distribution Matrix (Avoid Conflicts)

| Milestone | Person A (Domain + Application) | Person B (Infrastructure + API) |
|-----------|--------------------------------|--------------------------------|
| M1 Foundation | SharedKernel (VO, Result, Guard) + IdentityAccess.Domain | EF Core Configs + IdentityAccess.Infrastructure + API.Gateway |
| M2 Inventory | Inventory.Domain + Inventory.Application | Inventory.Infrastructure + REST Controllers |
| M3 Purchasing | Purchasing.Domain + Purchasing.Application | Purchasing.Infrastructure + REST Controllers |
| M4 Sales & Billing | Sales.Domain + Sales.Application | Sales.Infrastructure + REST Controllers |
| M5 Returns & Adjustments | Sales.Domain + Purchasing.Domain (return logic) | Sales.Infrastructure + Purchasing.Infrastructure + REST Controllers |
| M6 Accounting | Accounting.Domain + Accounting.Application | Accounting.Infrastructure + REST Controllers |
| M7 Cash | Cash.Domain + Cash.Application | Cash.Infrastructure + REST Controllers |
| M8 Payroll | Payroll.Domain + Payroll.Application | Payroll.Infrastructure + REST Controllers |
| M9 Hardening | Add tests + validators | RBAC middleware + CI/CD |

---

## 7. Milestone Plan (Step-by-Step) — Backend & Frontend Pairs

> Each backend milestone (BM) pairs with a frontend milestone (FM). Backend must complete first before frontend can integrate.

### M1: Foundation (2 weeks) — "Hello, Clean Architecture!"

**Backend Goals:** Solution structure, auth flow, core entities
**Frontend Goals:** App shell, routing, auth UI, shared framework foundations

#### BM1.1-BM1.5: Backend Tasks (Days 1-14)
*See original plan lines 1084-1144*

#### FM1.1: Shared Shell Foundation (Days 1-3)
| Task | Owner | Acceptance Criteria |
|------|-------|---------------------|
| Initialize Vite + React + TypeScript project structure | Frontend A | `npm run dev` works; TypeScript strict mode enabled |
| Install core packages: MUI v6, Redux Toolkit, TanStack Query v5, React Router v7, React Hook Form, Zod, axios | Frontend A | All packages resolve; no version conflicts |
| Create enterprise MUI theme with Microsoft-inspired design system | Frontend A | Compact density (`-2`), Segoe UI font, `#0078d4` accent, flat borders |
| Build `AppShell` layout with sidebar, header command bar, breadcrumb area | Frontend B | Layout responsive; sidebar collapsible; content area ready |
| Implement `QueryClientProvider` with caching defaults | Frontend A | staleTime 30s, cacheTime 5min, retry 1, devtools enabled |
| Implement Redux store with `ui.slice` (density, sidebar state) | Frontend A | Settings persist to localStorage; Redux DevTools connected |

**DoD:**
- [ ] `npm run dev` shows login screen in enterprise theme
- [ ] Sidebar with placeholder navigation links
- [ ] Redux DevTools shows state tree
- [ ] TanStack Query DevTools shows cache structure

#### FM1.2: Authentication Flow (Days 4-7)
| Task | Owner | Acceptance Criteria |
|------|-------|---------------------|
| Create `authApi.ts` with login/register endpoints | Frontend A | Typed DTOs from `shared/contracts` |
| Build `LoginPage` with username/password form using `ErpForm` | Frontend A | Zod validation; loading state; error handling |
| Implement JWT token storage (in-memory + refresh cookie) | Frontend A | Token not in localStorage; HttpOnly refresh fallback |
| Create `ProtectedRoute` component with permission checks | Frontend A | Redirects unauthorized; checks `module/action` perms |
| Build `AuthProvider` context for user session management | Frontend B | Provides `user`, `isAuthenticated`, `hasPermission` |
| Create route definitions in `router.tsx` | Frontend B | Nested routes for master-detail; auth guards applied |

**DoD:**
- [ ] Can login and receive JWT; protected routes redirect to login
- [ ] Protected route enforces permission check via `hasPermission`
- [ ] Logout clears session, redirects to login

#### FM1.3: Shared Components Foundation (Days 8-10)
| Task | Owner | Acceptance Criteria |
|------|-------|---------------------|
| Create `ErpForm` wrapper around React Hook Form + Zod | Frontend B | `react-hook-form` + `zodResolver` integrated |
| Build `FormField` component with label, input, error display | Frontend B | Supports TextField, Select, DatePicker variants |
| Create `LookupSearch` autocomplete component | Frontend A | Debounced search; keyboard navigation; create-new flow |
| Build `CurrencyInput` with AFN/USD toggle | Frontend A | 4 decimal validation; base-AFN equivalent display |
| Create loading/empty states for all components | Frontend A | Skeleton loaders for lists; empty state illustrations |

**DoD:**
- [ ] Form validation shows inline errors
- [ ] LookupSearch can search accounts with debouncing
- [ ] CurrencyInput validates and formats correctly

#### FM1.4: Frontend Integration Testing (Days 11-14)
| Task | Owner | Acceptance Criteria |
|------|-------|---------------------|
| Wire auth flow to backend endpoints | Frontend A | Login creates session; ProtectedRoute works |
| Test protected route navigation | Frontend A | Unauthorized access redirects; authorized access proceeds |
| Verify Redux + Query persistence | Frontend B | Refresh doesn't lose theme settings |
| Add Vitest + React Testing Library config | Frontend B | Tests run with coverage; basic accessibility tests |

**DoD:**
- [ ] Complete auth flow working end-to-end
- [ ] First passing unit tests in place

#### M1.1: SharedKernel (Days 1-2)
- [ ] Create `src/SharedKernel/SharedKernel.csproj`
- [ ] Create `BaseEntity` class with `Id` property
- [ ] Create `IAuditable` interface (CreatedAt, UpdatedAt)
- [ ] Create `ISoftDeletable` interface (DeletedAt)
- [ ] Create `CurrencyCode` value object (3-char, AFN default)
- [ ] Create `Money` value object (amount + currency, prevents adding different currencies)
- [ ] Create `Result<T>` struct (Success/Failure pattern)
- [ ] Create `Guard` class (validation helpers)
- [ ] **Verify:** `dotnet build` succeeds

#### M1.2: IdentityAccess.Domain (Days 3-5)
- [ ] Create `User` entity (inherits BaseEntity, implements IAuditable, ISoftDeletable)
- [ ] Create `Username` value object (lowercase, 3-255 chars)
- [ ] Create `HashedPassword` value object (SHA256 for now, upgrade later)
- [ ] Create `Privilege` entity (Name + RulesJson)
- [ ] Create `UserPrivilege` entity (join table)
- [ ] Create `Account` entity (Chart of Accounts)
- [ ] Create `Journal` entity (parent/child support)
- [ ] Create `Transaction` entity (double-entry line)
- [ ] Create `FinancialPeriod` entity
- [ ] **Verify:** Domain project builds, no external dependencies

#### M1.3: IdentityAccess.Application (Days 6-7)
- [ ] Create `IRepository<T>` interface
- [ ] Create `IUserContext` interface
- [ ] Create `LoginQuery` (returns user + token)
- [ ] Create `SearchAccountsQuery` (filter by name/phone/subType)
- [ ] **Verify:** Application project builds, only references Domain + SharedKernel

#### M1.4: IdentityAccess.Infrastructure (Days 8-10)
- [ ] Create `AppDbContext` class
- [ ] Add `Pomelo.EntityFrameworkCore.MySql` NuGet package
- [ ] Create `UserConfiguration` (table name, column types, indexes)
- [ ] Create `AccountConfiguration`
- [ ] Create `JournalConfiguration`
- [ ] Create `TransactionConfiguration`
- [ ] Create `FinancialPeriodConfiguration`
- [ ] Create `EfCoreRepository<T>` implementation
- [ ] **Verify:** `dotnet build` succeeds for all projects

#### M1.5: API.Gateway + REST Controllers (Days 11-14)
- [ ] Create AuthController with:
  - `POST /api/auth/login` (returns JWT)
  - `POST /api/auth/register` (creates user)
- [ ] Create AccountsController with:
  - `GET /api/accounting/accounts` (search with q, subType query)
  - `GET /api/accounting/accounts/{id}`
  - `POST /api/accounting/accounts` (create account)
- [ ] Configure JWT Bearer authentication in Program.cs
- [ ] Configure MariaDB connection string
- [ ] Create seed script (build/migrations/0001_initial.sql)
- [ ] **Verify:** Run `docker compose up`, apply migration, test endpoints with curl/Postman

**DoD (Definition of Done):**
- [ ] `docker compose up` starts MariaDB + Redis + API
- [ ] REST endpoints accessible at `http://localhost:5000/api/*`
- [ ] Can register/login user via REST and receive JWT token
- [ ] Can search accounts via `GET /api/accounting/accounts?q=name`
- [ ] Seed data creates admin user (username: `administrator`, password: `1`)

---

### M2: Inventory Core (2 weeks) — "Products & Stock"

**Backend Goals:** StockItem CRUD, StockLevel tracking, Stock adjustment
**Frontend Goals:** Reusable grid/form components, stock item management UI

#### BM2.1-BM2.4: Backend Tasks (Days 15-25)
*See original plan lines 1162-1202*

#### FM2.1: Reusable Table Framework (Days 15-17)
| Task | Owner | Acceptance Criteria |
|------|-------|---------------------|
| Build `ErpDataGrid` wrapper around MUI X DataGrid | Frontend B | Server-side pagination, sorting, filtering; loading/empty states |
| Create `CurrencyColumn` renderer component | Frontend B | Right-aligned; 4 decimals; AFN/USD color hint |
| Create `StatusColumn` renderer (no pills, left border + bold) | Frontend A | Uses theme status colors; text-based status |
| Implement column persistence to localStorage | Frontend A | Pinned/hidden/resized columns saved per user |
| Add export to CSV/XLSX capability | Frontend B | Uses MUI X export API; preserves formatting |
| Add print view for grids | Frontend B | CSS print media query; no sidebar in print |

**DoD:**
- [ ] Generic grid component works with any data source
- [ ] Export downloads correctly formatted file
- [ ] Column preferences persist across refreshes

#### FM2.2: Stock Items UI (Days 18-21)
| Task | Owner | Acceptance Criteria |
|------|-------|---------------------|
| Create `inventoryApi.ts` with all endpoints from BM2.4 | Frontend A | Typed hooks: `useStockItems`, `useStockItem`, `useCreateStockItem` |
| Build `StockItemsListPage` using `ErpDataGrid` | Frontend B | Columns: Code, Name, Barcode, Base Unit, Sale Price, Stock Qty, Actions |
| Implement search/filter by name, barcode, category | Frontend B | Debounced search; server-side filtering |
| Create `StockItemForm` with `ErpForm` | Frontend A | All fields validated; barcode format check |
| Build `StockItemDialog` for create/edit | Frontend A | Opens from list; closes on success; invalidates list |
| Add barcode quick-add with keyboard shortcut | Frontend A | Focus on barcode field; enter adds new item |

**DoD:**
- [ ] Can list, search, paginate stock items
- [ ] Can create/edit with validation
- [ ] Stock level displays correctly

#### FM2.3: Stock Adjust Entity UI (Days 22-25)
| Task | Owner | Acceptance Criteria |
|------|-------|---------------------|
| Create `StockAdjustmentDialog` component | Frontend A | Reason picker; qty input; increase/decrease toggle |
| Add stock adjustment button to StockItem detail | Frontend A | Opens dialog; shows adjustment history |
| Implement adjustment history grid (`ErpDataGrid`) | Frontend B | Date, Type, Qty, Cost, Reason, User columns |
| Hook up to backend `/api/inventory/adjustments` | Frontend A | POST creates adjustment; invalidates stock level |
| Add optimistic update for stock level change | Frontend A | UI updates immediately; rollback on error |

**DoD:**
- [ ] Can adjust stock from item detail
- [ ] Adjustment history shows all changes
- [ ] Stock level updates without page reload

#### M2.1: Inventory.Domain (Days 15-17)
- [ ] Create `StockItem` entity (name, code, barcode, prices)
- [ ] Create `StockLevel` entity (quantity per item per account)
- [ ] Create `StockItemUnit` entity (UoM variants)
- [ ] Create `StockAdjustment` entity (increase/decrease with reason)
- [ ] Create `StockLoss` entity (damaged/expired)
- [ ] Create `AverageCostAdjustment` entity
- [ ] Create `AverageCost` entity (history snapshots)
- [ ] **Verify:** Domain builds, no infrastructure references

#### M2.2: Inventory.Application (Days 18-19)
- [ ] Create `CreateStockItemCommand`
- [ ] Create `AdjustStockCommand` (increase/decrease)
- [ ] Create `GetStockLevelQuery`
- [ ] Create `SearchStockItemsQuery`
- [ ] **Verify:** Application builds, uses MediatR pattern

#### M2.3: Inventory.Infrastructure (Days 20-22)
- [ ] Create `StockItemConfiguration`, `StockLevelConfiguration`, etc.
- [ ] Add all 8 inventory tables to `AppDbContext`
- [ ] Create `StockItemRepository`, `StockLevelRepository`
- [ ] **Verify:** Migrations apply to MariaDB

#### M2.4: Inventory.API Controllers (Days 23-25)
- [ ] Create `StockItemsController` with:
  - `GET /api/inventory/items` (paginated, filterable)
  - `GET /api/inventory/items/{id}`
  - `POST /api/inventory/items`
  - `PUT /api/inventory/items/{id}`
- [ ] Create `StockLevelsController` with:
  - `GET /api/inventory/items/{id}/stock`
- [ ] Create `StockAdjustmentsController` with:
  - `POST /api/inventory/adjustments` (increase/decrease)
- [ ] **Verify:** Can create item, adjust stock, see stock level change

**DoD:**
- [ ] Can create a stock item with name, barcode, base unit
- [ ] Can increase stock (creates journal + stocklevel record)
- [ ] Can decrease stock (blocks if insufficient unless org allows)
- [ ] Stock level query returns current quantity

---

### M3: Purchasing (2 weeks) — "Buy from Vendors"

**What you'll learn:**
- How purchase orders work with bill costs
- How A/P (Accounts Payable) is auto-created
- How partial payments work

**Deliverables:**
1. StockPurchase CRUD via REST API
2. Bill cost allocation
3. Credit purchase creates A/P automatically
4. Purchase closure with payment

#### M3.1: Purchasing.Domain (Days 26-28)
- [ ] Create `StockPurchase` entity (vendor, payment type, totals)
- [ ] Create `StockPurchaseItem` entity (line items)
- [ ] Create `StockPurchaseBillCost` entity (transport, clearance)
- [ ] Create `StockPurchaseCost` entity
- [ ] Create `StockPurchaseClose` entity

#### M3.2: Purchasing.Application (Days 29-30)
- [ ] Create `CreatePurchaseCommand`
- [ ] Create `ClosePurchaseCommand`
- [ ] Create `GetPurchaseQuery`

#### M3.3: Purchasing.Infrastructure + API Controllers (Days 31-34)
- [ ] EF configurations for all 5 tables
- [ ] REST Controllers for purchases endpoints
- [ ] **Verify:** Credit purchase creates A/P journal entry

---

### M4: Sales & Billing (2 weeks) — "Invoices & Revenue"

**What you'll learn:**
- How sales invoices span multiple aggregates
- How to use ambient transactions
- How A/R (Accounts Receivable) is created
- How revenue recognition + COGS + stock happen atomically

**Deliverables:**
1. Sales invoice REST endpoint (`POST /api/sales/invoices`)
2. Creates journals atomically (A/R, revenue, COGS, stock)
3. Decreases stock levels
4. Creates cash receipt or A/R balance

#### M4.1: Sales.Domain (Days 35-37)
- [ ] Create `StockSale` entity (customer, payment type, totals)
- [ ] Create `StockSaleItem` entity (line items)
- [ ] Create `StockPOSSale` entity (fast invoice variant)
- [ ] Create `StockPOSSaleItem` entity
- [ ] Create `StockSaleExCash` entity
- [ ] Create `WalkInCustomer` entity

#### M4.2: Sales.Application (Days 38-39)
- [ ] Create `SubmitInvoiceCommand` (the big one!)
- [ ] Create `InvoiceCart` value object (validation, totals)

#### M4.3: Sales.Infrastructure + API Controllers (Days 40-43)
- [ ] EF configurations for 7 tables
- [ ] SalesController with `POST /api/sales/invoices` endpoint
- [ ] **Verify:** Full invoice creates journals atomically

---

### M5: Returns & Adjustments (2 weeks) — "Customer & Vendor Returns"

**What you'll learn:**
- How sales returns reverse A/R, revenue, and COGS
- How purchase returns reverse A/P and stock valuation
- How refunds and credit memos work in double-entry

**Deliverables:**
1. Sales return (credit note) REST endpoint (`POST /api/sales/returns`)
2. Purchase return REST endpoint (`POST /api/purchasing/returns`)
3. Reversing journals + stock restoration
4. Refund and credit memo flows

#### M5.1: Sales Returns (Days 44-46)
- [ ] Create `CreditNote` entity (references original sale)
- [ ] Create `CreditNoteItem` entity
- [ ] Create `SubmitSalesReturnCommand`
- [ ] REST endpoint: `POST /api/sales/returns`
- [ ] **Verify:** Return creates reversing journals, restores stock

#### M5.2: Purchase Returns (Days 47-49)
- [ ] Create `PurchaseReturn` entity (references original purchase)
- [ ] Create `PurchaseReturnItem` entity
- [ ] Create `SubmitPurchaseReturnCommand`
- [ ] REST endpoint: `POST /api/purchasing/returns`
- [ ] **Verify:** Return reverses A/P, decreases stock, creates refund or credit memo

#### M5.3: Return Flows Integration (Days 50-52)
- [ ] Cash payment for refunds
- [ ] Credit memo -> future invoice offset
- [ ] Audit logs for returns
- [ ] **Verify:** End-to-end return + refund flow works

---

### M6: Accounting Engine (2 weeks) — "Double-Entry Bookkeeping"

**What you'll learn:**
- How double-entry accounting works in code
- How to enforce `sum(dr) == sum(cr)`
- How financial periods control posting

**Deliverables:**
1. Journal posting service
2. Trial balance report
3. Account ledger report

#### M6.1: Accounting.Domain (Days 53-55)
- [ ] Add `Revenues` entity
- [ ] Add `Expenses` entity
- [ ] Add `BalanceAdjustment` entity

#### M6.2: Accounting.Application (Days 56-57)
- [ ] Create `JournalPoster` service (validates dr==cr)
- [ ] Create `GetTrialBalanceQuery`
- [ ] Create `GetAccountLedgerQuery`

#### M6.3: Accounting.Infrastructure + API Controllers (Days 58-61)
- [ ] EF configurations
- [ ] REST Controllers for journals, transactions, trial balance, account ledger endpoints

---

### M7: Cash Management (1.5 weeks) — "Money In, Money Out"

**What you'll learn:**
- How cash receipts/payments journalize
- How currency exchange creates 4-leg journals with gain/loss

**Deliverables:**
1. Cash receipt flow
2. Cash payment flow
3. AFN↔USD exchange with gain/loss

#### M7.1: Cash.Domain + Application (Days 62-64)
- [ ] CashPayment, CashPaymentItem entities
- [ ] CashReceipt, CashReceiptItem entities
- [ ] CashExchange entity
- [ ] CashTransfer entity
- [ ] Withdrawal entity

#### M7.2: Cash.Infrastructure + API Controllers (Days 65-67)
- [ ] EF configurations for 7 tables
- [ ] REST Controllers for cash endpoints (receipts, payments, exchanges)
- [ ] **Verify:** Exchange creates 4-leg journal with correct gain/loss

---

### M8: Payroll Light (1 week) — "Salaries"

**What you'll learn:**
- How payroll runs link to journals
- How payment splits work

**Deliverables:**
1. Employee master
2. Salary payment with journalization

#### M8.1-8.2: Payroll (Days 68-72)
- [ ] EmployeeAccount entity
- [ ] Payroll, PayrollItem entities
- [ ] EmployeePayment, EmployeePaymentItem entities
- [ ] REST Controllers for payroll endpoints

---

### M9: Hardening (1.5 weeks) — "Production Ready"

**What you'll learn:**
- How to add RBAC to REST endpoints
- How to write integration tests
- How to set up CI/CD

**Deliverables:**
1. RBAC on all REST endpoints
2. Integration tests for Invoice + Purchase + Return + Exchange
3. Docker Compose for full stack
4. GitHub Actions CI/CD

#### M9.1-9.2: Security + Testing (Days 73-77)
- [ ] Add `[Authorize]` + permission checks to REST controllers
- [ ] Write 4 key integration tests
- [ ] Add Serilog logging
- [ ] Add health checks

---

## 8. Quick Reference: Common Errors & Fixes

| Error | Cause | Fix |
|-------|-------|-----|
| `UseIdentityAlwaysColumn` not found | PostgreSQL syntax | Use `.ValueGeneratedOnAdd()` for MariaDB |
| `Npgsql` not found | Wrong provider | Use `Pomelo.EntityFrameworkCore.MySql` |
| `jsonb` column type | PostgreSQL syntax | Use `json` for MariaDB |
| `timestamptz` not found | PostgreSQL type | Use `datetime(6)` for MariaDB |
| `bigserial` not found | PostgreSQL type | Use `bigint AUTO_INCREMENT` for MariaDB |
| Cannot assign to read-only property | Domain entity has private set | Use constructor or make setter internal |
| Return quantity exceeds original sale | Business rule violation | Validate return qty ≤ original invoice qty |
| Purchase return without stock | Stock not physically returned | Require stock on hand or allow negative stock |

---

## 9. Quick Reference: REST API Controllers

```csharp
// 1. Define your controller
[ApiController]
[Route("api/[controller]")]
public class SalesController : ControllerBase
{
    [HttpPost("invoices")]
    public async Task<ActionResult<StockSale>> CreateInvoice([FromBody] CreateInvoiceRequest request)
    {
        // Your logic here
    }

    [HttpPost("returns")]
    public async Task<ActionResult<CreditNote>> CreateReturn([FromBody] CreateReturnRequest request)
    {
        // Your logic here
    }
}

// 2. Register in Program.cs
builder.Services.AddControllers();
builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options => { /* configure */ });

app.UseAuthentication();
app.UseAuthorization();
app.MapControllers();

// 3. Access Swagger at /swagger (dev only)
```

---

## 10. Security Architecture

### 10.1 Auth (.NET)
- JWT Bearer with HS256 (shared key in env)
- Access token: 1h, Refresh token: 7d (HttpOnly Secure cookie)
- Password: SHA256 for MVP (upgrade to ASP.NET Core Identity PBKDF2 later)
- `users.password` column stores SHA256 hash

### 10.2 RBAC
- `privileges.rules` JSON: `{ "module": "inventory", "actions": ["read","write","delete"] }`
- Evaluated via middleware + frontend route guard
- `isAdmin` bypasses all checks

### 10.3 Frontend Protection
- `ProtectedRoute` wrapper checks `hasPermission(module, action)` from React Context
- Route configs:
  - Sales invoices: `{ path: '/sales', module: 'sales', action: 'read' }`
  - Returns: `{ path: '/returns', module: 'sales', action: 'write' }`
  - Purchasing: `{ path: '/purchasing', module: 'purchasing', action: 'read' }`

### 10.4 MariaDB Security
- Connection via TCP/wire TLS in production
- App DB user: DML only (no DDL). Migrations run via separate admin user.
- Single-tenant MVP; prepare for multi-tenant later.

### 10.5 Audit Logging
- `auditlogs(id, userId, action, refType, refId, oldValue, newValue, ip, userAgent, createdAt)`
- Inserted by MediatR post-processing pipeline (after commit)
- Immutable: no UPDATE/DELETE allowed (enforced by trigger squashing to readonly replica for compliance).

### 10.6 OWASP Protections
- JWT in Authorization header only (no query string)
- CORS strict origin allowlist in production
- All inputs validated via FluentValidation (backend) + Zod (frontend)
- SQL injection: EF Core parameterized queries only
- XSS: MUI sanitizes; React auto-escapes
- Rate limiting: ASP.NET Core `RateLimiter` middleware (100 req/min per user for invoices, 30 for login)

---

## 11. Testing & QA Strategy

### 11.1 Backend (.NET)
| Layer | Tool | Scope |
|-------|------|-------|
| Unit | xUnit | Domain logic (e.g. DoubleEntryValidator, Unit conversion) |
| Integration | xUnit + Respawn + Testcontainers (MariaDB) | Full repository + EF Core mapping |
| API | xUnit + WebApplicationFactory | End-to-end per module |
| Contract | Verify (or manual) | JSON schema per endpoint |

**Key integration tests:**
- `InvoiceScenario`: create invoice, post transactions, decrease stock, create cash receipt → read back trial balance == 0
- `PurchaseCreditScenario`: create purchase on credit, verify A/P balance
- `SalesReturnScenario`: create credit note, reverse revenue/COGS, restore stock, refund cash
- `PurchaseReturnScenario`: create purchase return, reverse A/P, decrease stock
- `ExchangeScenario`: convert USD → AFN, verify gain/loss leg + cash balances
- `UnauthorizedAccess`: user without privilege gets 403

### 11.2 Frontend
| Layer | Tool | Scope |
|-------|------|-------|
| Component | Vitest + RTL | Invoice form, stock table, return dialog, login form |
| Hook | Vitest | useInvoiceCart, useDebounce, useAuth |
| E2E | Playwright | Full sales flow: login → search → invoice → submit → return |

---

## 12. Performance Strategy (MariaDB)

### 12.1 Indexing
```sql
-- Core lookups
CREATE INDEX ix_accounts_subtype ON accounts(subType) WHERE isSystem = 0;
CREATE INDEX ix_stockitems_code ON stockitems(code);
CREATE INDEX ix_stocklevels_item_account ON stocklevels(stockItemId, stockAccountId);
CREATE INDEX ix_journals_date_fp ON journals(date, fpId);
CREATE INDEX ix_journals_type ON journals(type);
CREATE INDEX ix_transactions_account ON transactions(accountId);
CREATE INDEX ix_stockpossales_customer ON stockpossales(customerAccountId);
CREATE INDEX ix_creditnotes_related_sale ON creditnotes(relatedSaleId);
CREATE INDEX ix_purchasereturns_related_purchase ON purchasereturns(relatedPurchaseId);

-- Cash lookups
CREATE INDEX ix_cashreceipts_journal ON cashreceipts(journalId);
CREATE INDEX ix_cashpayments_journal ON cashpayments(journalId);
```

### 12.2 Query Optimization
- Avoid N+1: Use EF Core `Include` for stocklevels -> stockitems; eager load in Read models.
- Pagination: Cursor-based for large journal/transaction lists; offset for UI tables (page 50 max).
- Materialized View (optional): daily stock snapshot refreshed nightly for reports.

### 12.3 Connection Pooling
- MySql connection pool: Min 5, Max 50 per service.
- Redis connection: separate pool, multiplexed.

---

## 13. Caching Strategy

### 13.1 Redis Keys
```
stock:levels:{stockItemId}     → JSON { qty, cost }
account:balance:{accountId}    → JSON { dr, cr, net }
user:perms:{userId}            → JSON { module: [actions] }
org:config                     → JSON { allowNegativeStock, decimals }
fx:rate:{from}:{to}:{date}    → decimal  (optional future)
```

### 13.2 Invalidation Rules
- Stock level updated → `DEL stock:levels:{id}`
- Account balance changed → `DEL account:balance:{id}`
- Privilege changed → `DEL user:perms:{id}` + pub/sub notify all instances
- Config changed → `DEL org:config`

### 13.3 Cache-Aside Pattern
All reads:
```
val = await redis.GetAsync(key);
if (val == null) { val = await db.GetAsync(); await redis.SetAsync(key, val, ttl); }
return val
```

---

## 14. Monitoring & Observability

### 14.1 Logging (Serilog)
```csharp
Log.Logger = new LoggerConfiguration()
  .Enrich.FromLogContext()
  .Enrich.WithMachineName()
  .WriteTo.Console()
  .WriteTo.MariaDB(connectionString, "logs", restrictedToMinimumLevel: Serilog.Events.LogEventLevel.Information)
  .CreateLogger();
```

Structured fields: `UserId`, `Action`, `RefType`, `RefId`, `DurationMs`, `CorrelationId`

### 14.2 Tracing (OpenTelemetry)
- Instrument ASP.NET Core, EF Core, HttpClient, MediatR
- Export to Jaeger (dev) / OTLP collector (prod)
- Trace per invoice submit: full span tree across sales → inventory → accounting → cash

### 14.3 Metrics (Prometheus)
- `http_request_duration_seconds` by route + status
- `db_query_duration_seconds` by query hash
- `invoice_submit_duration_seconds`
- `purchase_return_duration_seconds`
- `stock_level_updates_total`
- `active_users gauge`

### 14.4 Health Checks
Per module: `Identity`, `Inventory`, `Accounting`, `Cash`, `Database`, `Redis`
Endpoint: `/health` (liveness) + `/health/ready` (readiness)

---

## 15. Audit System Design

### 15.1 Table
```sql
CREATE TABLE auditlogs (
  id bigint AUTO_INCREMENT PRIMARY KEY,
  userId bigint NOT NULL,
  action varchar(100) NOT NULL,
  refType varchar(100) NOT NULL,
  refId bigint NOT NULL,
  oldValue json,
  newValue json,
  ip varchar(45),
  userAgent text,
  createdAt datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  INDEX ix_auditlogs_user (userId, createdAt),
  INDEX ix_auditlogs_ref (refType, refId),
  INDEX ix_auditlogs_action (action)
);
```

### 15.2 Capture Points
| Event | oldValue | newValue |
|-------|----------|----------|
| Invoice Submit | — | StockSale summary |
| Purchase | — | StockPurchase summary |
| Journal Post | — | Journal transactions |
| Stock Adjustment | Before stocklevel | After stocklevel |
| Sales Return (Credit Note) | Before stocklevel | After stocklevel |
| Purchase Return | Before stocklevel | After stocklevel |
| Cash Exchange | Before balances | After balances |
| Permission Change | Before rules | After rules |

### 15.3 Compliance
- Append-only (no UPDATE/DELETE on auditlogs)
- Retention: 7 years (archival to S3 quarterly)
- Access: read-only for all except superadmin

---

## 16. DevOps & Deployment

### 16.1 Docker
```yaml
# docker-compose.yml
services:
  api:
    build: ./src/API.Gateway
    depends_on: [mariadb, redis]
  web:
    build: ./src/web
  nginx:
    image: nginx:alpine
    ports: ["80:80"]
  mariadb:
    image: mariadb:11
    volumes: [mariadb_data:/var/lib/mysql]
  redis:
    image: redis:7-alpine
```

### 16.2 CI/CD (GitHub Actions)
- `build.yml`: dotnet build + test + docker build
- `deploy.yml`: on merge to main → SSH into server → docker pull + compose up
- `migrate.yml`: run `dotnet ef database update` against target env (staged, prod)
- `backup.yml`: daily mysqldump to `/backups` + upload to S3

### 16.3 Environment Strategy
| Env | DB | Purpose |
|-----|----|---------|
| local | Docker MariaDB | Dev |
| staging | Docker MariaDB | QA / UAT |
| production | Managed MariaDB (e.g. Supabase/Railway) | Live |

### 16.4 Migration Strategy
- `dotnet ef migrations add` per bounded context change
- Migrations run in CI/CD only (never auto-run on app start in production)
- Down migrations: supported but require manual approval + backup before execute

### 16.5 Backup Strategy
- Continuous binary log archiving (MariaDB `binlog` to S3)
- Daily base backup (mariabackup)
- Retention: 30 days hot, 1 year cold (S3 Glacier)

### 16.6 Rollback
1. Feature flags (LaunchDarkly or simple DB table): hot-disable new flows
2. DB migration rollback: `dotnet ef database update PreviousMigration`
3. Deployment rollback: `docker compose down && docker compose up <previous-image>`

---

## 17. Final Deliverables

1. **MariaDB schema** — fully migrated from MySQL, numeric-safe, indexed
2. **7 .NET 8 projects** — modular monolith, Clean Architecture per module
3. **React SPA** — Sales/Billing-first, TypeScript, MUI, React Query
4. **Docker Compose** — one-command local/dev startup
5. **GitHub Actions** — CI/CD + daily backup
6. **API documentation** — Swagger/OpenAPI per module, aggregated in gateway
7. **Runbook** — backup/restore, rollback, monitoring queries
8. **UAT checklist** — per milestone DoD with test scenarios
