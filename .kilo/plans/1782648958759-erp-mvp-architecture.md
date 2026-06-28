# Afghan Commerce Cloud — MVP Execution Plan

## 0. Constraints & Stack

- Backend: .NET 8 Web API + GraphQL (HotChocolate) (HotChocolate), Clean Architecture, Modular Monolith
- Frontend: React 18 + TypeScript + Vite + MUI + Apollo Client
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
| 38 | stockpossales | POS fast sales | Yes |
| 39 | stockpossaleitems | POS sale lines | Yes |
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

### 1.5 Sales / POS

| Table | Purpose | Key FKs | Issues |
|-------|---------|---------|--------|
| stocksales | Regular sales invoice | customerAccountId → accounts, cashAccountId → accounts | `customerAccountId` NULL allowed → enforce NOT NULL for MVP |
| stocksaleitems | Invoice lines | stockSaleId, stockItemId, stockAccountId | `double` → `decimal` |
| stocksalebillcosts | Sales-side costs (e.g. delivery) | stockSaleId, cashAccountId | — |
| stocksaleexcashes | Cash split per sale (AFN/USD) | stockSaleId | Replace with `cashreceipts` linkage |
| stockpossales | POS fast sales | customerAccountId → accounts, cashAccountId, stockAccountId | `customer` varchar(255) → FK to accounts |
| stockpossaleitems | POS sale lines | stockPOSSaleId, stockItemId | `double` → `decimal` |

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

### 2.4 Sales / POS Context

**Aggregates:** StockSale, StockPOSSale
**Entities:** StockSaleItem, StockPOSSaleItem, StockSaleExCash, WalkInCustomer
**Value Objects:** PaymentType(cash|credit|partial), CustomerLookup
**Domain Services:** SalePriceValidator, COGSCalculator, CashSplitter
**Rules:**
- POS sale auto-generates cash receipt + revenue + COGS + stock journals
- `stockPOSSaleId` links to `cashreceipts.journalId` for traceability
- Customer free-text stored only if not found in accounts under same session
- Partial payment: remaining → A/R account

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

### 3.1 POS Sale Flow

```
Customer selection (account search by name/phone)
  ↓
Cart assembly (scan barcode or search stockitems)
  ↓
Cart validations:
  - qty > 0
  - stock available (or allowNegativeStock)
  - price editable iff user.allowPriceEditing
  ↓
Checksout:
  1. BeginTransaction (ambient, cross-module)
  2. Create Journal(type=stockPOSSale, fpId=current)
  3. Post Cash Transactions:
     - Dr CashAccount (total)
     - Cr RevenueAccount (total - discount)
     - If discount: Dr DiscountExpense / Cr CashAccount (discount portion)
  4. Post COGS + Stock:
     - Dr COGSAccount (sum of avg cost * qty)
     - Cr StockAccount (same amount)
  5. Decrease StockLevels (-qty)
  6. Create StockPOSSale + StockPOSSaleItems
  7. Create CashReceipt (linked to journal)
  8. Create CashReceiptItems (AFN/USD split if needed)
  9. Create StockSaleExCash (if multi-currency tendered)
 10. CommitTransaction
 11. Publish StockUpdated event → Redis invalidation
 12. Emit AuditLog(userId, action='pos_sale', refType='StockPOSSale', refId)
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

### 3.4 Cash Receipt (Customer Payment)

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

### 3.5 Cash Payment (Vendor Payment)

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

### 3.6 Cash Exchange (AFN ↔ USD)

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
│       ├── GraphQL (Queries/Mutations/Types)/
│       ├── Middleware/
│       └── Program.cs (GraphQL server composition)
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
- **Cross-Aggregate Atomicity:** POS sale uses single transaction across Accounting + Inventory + Cash contexts via same `AppDbContext` (shared DbContext in modular monolith).
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
| Sales.Domain | StockSale, StockPOSSale, StockSaleItem, WalkInCustomer |
| Sales.Application | POS checkout workflow, cart validation |
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

## 5. Frontend Architecture (React + TypeScript + Vite)

### 5.1 Folder Structure

```
src/
├── app/
│   ├── layout.tsx (root with providers)
│   ├── router.tsx (React Router v7)
│   └── store.ts (Zustand for UI-only state)
├── features/
│   ├── auth/
│   │   ├── components/ (LoginForm, ProtectedRoute)
│   │   ├── hooks/ (useAuth)
│   │   ├── api/ (authApi)
│   │   └── types/
│   ├── pos/
│   │   ├── components/ (Cart, ProductSearch, BarcodeScanner, CheckoutDrawer)
│   │   ├── pages/ (POSPage)
│   │   ├── hooks/ (usePOSCart, useBarcodeScanner)
│   │   ├── api/ (posApi)
│   │   └── store/ (cartSlice)
│   ├── inventory/
│   │   ├── components/ (StockTable, StockAdjustmentDialog)
│   │   ├── pages/ (InventoryPage, StockItemDetailPage)
│   │   ├── api/ (inventoryApi)
│   │   └── types/
│   ├── purchasing/
│   │   ├── components/ (PurchaseForm, PurchaseList, BillCostTable)
│   │   ├── pages/ (PurchasesPage, PurchaseDetailPage)
│   │   └── api/
│   ├── sales/
│   ├── accounting/
│   ├── cash/
│   └── payroll/
├── shared/
│   ├── components/ (AppShell, Sidebar, DataTable, CurrencyInput)
│   ├── hooks/ (useReactQuery, useDebounce, useMediaQuery)
│   ├── lib/ (apolloClient, queryClient, auth)
│   ├── types/ (Money, JournalEntry, StockItem)
│   └── utils/ (formatMoney, currencySymbols, dateHelpers)
└── main.tsx
```

### 5.2 State Strategy

| State | Tool | Scope |
|-------|------|-------|
| Server data | React Query v5 | All domain entities (cache, invalidation, optimistic updates) |
| POS cart | Zustand | Ephemeral checkout state |
| Auth | React Context + React Query | User, permissions, token |
| UI (dialogs, filters, theme) | Zustand | Transient UI state |

### 5.3 API Layer

```typescript
// shared/lib/apolloClient.ts
export const api = axios.create({ baseURL: '/api' });
api.interceptors.request.use((cfg) => {
  const token = getToken();
  if (token) cfg.headers.Authorization = `Bearer ${token}`;
  return cfg;
});
```

```typescript
// features/pos/api/posApi.ts
export const posApi = {
  searchProducts: (q: string) => api.get<StockItem[]>('/api/inventory/items', { params: { q } }),
  getStockLevel: (id: string) => api.get<StockLevel>(`/api/inventory/items/${id}/stock`),
  checkout: (dto: CheckoutDTO) => api.post('/api/pos/checkout', dto),
  searchAccounts: (q: string) => api.get<Account[]>('/api/accounting/accounts', { params: { q } }),
};
```

### 5.4 POS Screen UX

- **Left:** Product grid + search + barcode input (autofocus on mount)
- **Right:** Cart (Qty, Price override toggle, line total, remove)
- **Bottom bar:** Total, discount %, customer selector, payment method (AFN/USD/cash), Pay button
- **On Pay:** modal for tendered amount + change; success receipt (thermal ready)
- **Barcode scanner:** HID keyboard emulation; Enter key triggers search

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
- **API**: HTTP/GraphQL endpoints. Depends on Infrastructure + Application.

**Rule: Outer layers can depend on inner layers, never the reverse.**

#### What is a Modular Monolith?
Instead of 7 separate microservices (too complex for MVP), we build ONE application
with clear internal boundaries. Each "module" (Inventory, Sales, etc.) is a folder
with its own Domain/Application/Infrastructure/API structure.

#### What is GraphQL?
Instead of REST endpoints (`GET /api/users`, `POST /api/accounts`), you have ONE endpoint
(`/graphql`) where clients ask for exactly the data they need.

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
| M2 Inventory | Inventory.Domain + Inventory.Application | Inventory.Infrastructure + GraphQL Types |
| M3 Purchasing | Purchasing.Domain + Purchasing.Application | Purchasing.Infrastructure + GraphQL Types |
| M4 POS | Sales.Domain + Sales.Application | Sales.Infrastructure + GraphQL Types |
| M5 Accounting | Accounting.Domain + Accounting.Application | Accounting.Infrastructure + GraphQL Types |
| M6 Cash | Cash.Domain + Cash.Application | Cash.Infrastructure + GraphQL Types |
| M7 Payroll | Payroll.Domain + Payroll.Application | Payroll.Infrastructure + GraphQL Types |
| M8 Hardening | Add tests + validators | RBAC middleware + CI/CD |

---

## 7. Milestone Plan (Step-by-Step)

### M1: Foundation (2 weeks) — "Hello, Clean Architecture!"

**What you'll learn:**
- How to structure a .NET solution
- What are Value Objects and why they matter
- How EF Core maps C# classes to MariaDB tables
- How to run a GraphQL server

**Deliverables:**
1. Working solution with 3 projects (SharedKernel, IdentityAccess.Domain, IdentityAccess.Infrastructure)
2. MariaDB running in Docker with 5 tables (users, accounts, journals, transactions, financialperiods)
3. GraphQL endpoint at `/graphql` with 2 queries + 2 mutations
4. Seed script that creates admin user + Chart of Accounts

**Step-by-step tasks:**

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

#### M1.5: API.Gateway + GraphQL (Days 11-14)
- [ ] Create GraphQL `Query` type with:
  - `login(username, password): User` resolver
  - `searchAccounts(q, subType): [Account]` resolver
  - `account(id: Int!): Account` resolver
- [ ] Create GraphQL `Mutation` type with:
  - `register(username, password, isAdmin): User` resolver
  - `createAccount(input: AccountInput!): Account` resolver
- [ ] Configure MariaDB connection string
- [ ] Create seed script (build/migrations/0001_initial.sql)
- [ ] **Verify:** Run `docker compose up`, apply migration, open GraphQL Playground, run queries

**DoD (Definition of Done):**
- [ ] `docker compose up` starts MariaDB + Redis + API
- [ ] GraphQL Playground accessible at `http://localhost:5000/graphql`
- [ ] Can register a new user via mutation
- [ ] Can search accounts via query
- [ ] Seed data creates admin user (username: `administrator`, password: `1`)

---

### M2: Inventory Core (2 weeks) — "Products & Stock"

**What you'll learn:**
- How to model products with variants (UoM)
- How stock levels are derived from journal entries
- How to use EF Core value conversions

**Deliverables:**
1. StockItem CRUD via GraphQL
2. StockLevel tracking per item per account
3. Stock adjustment flow (increase/decrease) with journalization
4. Barcode auto-generation

**Step-by-step tasks:**

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

#### M2.4: Inventory.GraphQL (Days 23-25)
- [ ] Add `stockItems` query (paginated, filterable)
- [ ] Add `stockLevel(itemId)` query
- [ ] Add `createStockItem` mutation
- [ ] Add `adjustStock` mutation (increase/decrease)
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
1. StockPurchase CRUD via GraphQL
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

#### M3.3: Purchasing.Infrastructure + API (Days 31-34)
- [ ] EF configurations for all 5 tables
- [ ] GraphQL mutations + queries
- [ ] **Verify:** Credit purchase creates A/P journal entry

---

### M4: POS System (2 weeks) — "Fast Checkout"

**What you'll learn:**
- How to build a transaction that spans multiple aggregates
- How to use ambient transactions
- How to emit domain events

**Deliverables:**
1. POS checkout GraphQL mutation
2. Creates 4 journals atomically (cash, revenue, COGS, stock)
3. Decreases stock levels
4. Creates cash receipt

#### M4.1: Sales.Domain (Days 35-37)
- [ ] Create `StockSale` entity
- [ ] Create `StockSaleItem` entity
- [ ] Create `StockPOSSale` entity
- [ ] Create `StockPOSSaleItem` entity
- [ ] Create `StockSaleExCash` entity
- [ ] Create `WalkInCustomer` entity

#### M4.2: Sales.Application (Days 38-39)
- [ ] Create `CheckoutCommand` (the big one!)
- [ ] Create `Cart` value object (validation, totals)

#### M4.3: Sales.Infrastructure + API (Days 40-43)
- [ ] EF configurations for 7 tables
- [ ] GraphQL mutation `posCheckout`
- [ ] **Verify:** Full POS sale creates 4 journals atomically

---

### M5: Accounting Engine (2 weeks) — "Double-Entry Bookkeeping"

**What you'll learn:**
- How double-entry accounting works in code
- How to enforce `sum(dr) == sum(cr)`
- How financial periods control posting

**Deliverables:**
1. Journal posting service
2. Trial balance report
3. Account ledger report

#### M5.1: Accounting.Domain (Days 44-46)
- [ ] Add `Revenues` entity
- [ ] Add `Expenses` entity
- [ ] Add `BalanceAdjustment` entity

#### M5.2: Accounting.Application (Days 47-48)
- [ ] Create `JournalPoster` service (validates dr==cr)
- [ ] Create `GetTrialBalanceQuery`
- [ ] Create `GetAccountLedgerQuery`

#### M5.3: Accounting.Infrastructure + API (Days 49-52)
- [ ] EF configurations
- [ ] GraphQL queries for reports

---

### M6: Cash Management (1.5 weeks) — "Money In, Money Out"

**What you'll learn:**
- How cash receipts/payments journalize
- How currency exchange creates 4-leg journals with gain/loss

**Deliverables:**
1. Cash receipt flow
2. Cash payment flow
3. AFN↔USD exchange with gain/loss

#### M6.1: Cash.Domain + Application (Days 53-55)
- [ ] CashPayment, CashPaymentItem entities
- [ ] CashReceipt, CashReceiptItem entities
- [ ] CashExchange entity
- [ ] CashTransfer entity
- [ ] Withdrawal entity

#### M6.2: Cash.Infrastructure + API (Days 56-58)
- [ ] EF configurations for 7 tables
- [ ] GraphQL mutations
- [ ] **Verify:** Exchange creates 4-leg journal with correct gain/loss

---

### M7: Payroll Light (1 week) — "Salaries"

**What you'll learn:**
- How payroll runs link to journals
- How payment splits work

**Deliverables:**
1. Employee master
2. Salary payment with journalization

#### M7.1-7.2: Payroll (Days 59-63)
- [ ] EmployeeAccount entity
- [ ] Payroll, PayrollItem entities
- [ ] EmployeePayment, EmployeePaymentItem entities
- [ ] GraphQL mutations

---

### M8: Hardening (1.5 weeks) — "Production Ready"

**What you'll learn:**
- How to add RBAC to GraphQL resolvers
- How to write integration tests
- How to set up CI/CD

**Deliverables:**
1. RBAC on all GraphQL fields
2. Integration tests for POS + Purchase + Exchange
3. Docker Compose for full stack
4. GitHub Actions CI/CD

#### M8.1-8.2: Security + Testing (Days 64-68)
- [ ] Add `[Authorize]` + permission checks to GraphQL resolvers
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

---

## 9. Quick Reference: GraphQL HotChocolate

```csharp
// 1. Define your schema types
public class Query
{
    public async Task<User?> Login([Service] AppDbContext db, string username, string password)
    {
        // Your resolver logic here
    }
}

public class Mutation
{
    public async Task<User> Register([Service] AppDbContext db, string username, string password)
    {
        // Your mutation logic here
    }
}

// 2. Register in Program.cs
builder.Services
    .AddGraphQLServer()
    .AddQueryType<Query>()
    .AddMutationType<Mutation>();

// 3. Map the endpoint
app.MapGraphQL();

// 4. Access playground at /graphql (dev only)
```

---

## 8. Security Architecture

### 8.1 Auth (.NET)
- JWT Bearer with RS256 (private key in env, public exposed)
- Access token: 1h, Refresh token: 7d (HttpOnly Secure cookie)
- Password: ASP.NET Core Identity's `PasswordHasher<TUser>` (PBKDF2)
- `users.password` column re-purposed as Identity hash; legacy migration required

### 8.2 RBAC
- `privileges.rules` JSON: `{ "module": "inventory", "actions": ["read","write","delete"] }`
- Evaluated in MediatR pipeline behavior + frontend route guard
- `isAdmin` bypasses all checks

### 8.3 Frontend Protection
- `ProtectedRoute` wrapper checks `hasPermission(module, action)` from React Context
- Route config: `{ path: '/pos', module: 'pos', action: 'read' }`

### 8.4 MariaDB Security
- Connection via TCP/wire TLS
- App DB user: DML only (no DDL). Migrations run via separate admin user.
- Single-tenant MVP; prepare for multi-tenant later.
- `MariaDB audit plugin` for DDL audit.

### 8.5 Audit Logging
- `auditlogs(id, userId, action, refType, refId, oldValue, newValue, ip, userAgent, createdAt)`
- Inserted by MediatR post-processing pipeline (after commit)
- Immutable: no UPDATE/DELETE allowed (enforced by trigger squashing to readonly replica for compliance).

### 8.6 OWASP Protections
- JWT in Authorization header only (no query string)
- CORS strict origin allowlist
- All inputs validated via FluentValidation (backend) + Zod (frontend)
- SQL injection: EF Core parameterized queries only
- XSS: MUI sanitizes; React auto-escapes
- CSRF: SameSite cookies for refresh token + header-based access token
- Rate limiting: ASP.NET Core `RateLimiter` middleware (100 req/min per user for POS, 30 for login)

---

## 9. Performance Strategy (MariaDB)

### 9.1 Indexing
```sql
-- Core lookups
CREATE INDEX ix_accounts_subtype ON accounts(subType) WHERE isSystem = 0;
CREATE INDEX ix_stockitems_code ON stockitems(code);
CREATE INDEX ix_stocklevels_item_account ON stocklevels(stockItemId, stockAccountId);
CREATE INDEX ix_journals_date_fp ON journals(date, fpId);
CREATE INDEX ix_journals_type ON journals(type);
CREATE INDEX ix_transactions_account ON transactions(accountId);
CREATE INDEX ix_stockpossales_customer ON stockpossales(customerAccountId);

-- Cash lookups
CREATE INDEX ix_cashreceipts_journal ON cashreceipts(journalId);
CREATE INDEX ix_cashpayments_journal ON cashpayments(journalId);

-- JSON
CREATE INDEX ix_privileges_rules ON privileges ( (JSON_LENGTH(rules)) );
```

### 9.2 Query Optimization
- Avoid N+1: Use EF Core `Include` for stocklevels -> stockitems; eager load in Read models.
- Pagination: Cursor-based for large journal/transaction lists; offset for UI tables (page 50 max).
- Materialized View (optional): daily stock snapshot refreshed nightly for reports.

### 9.3 Connection Pooling
- MySql connection pool: Min 5, Max 50 per service.
- Redis connection: separate pool, multiplexed.

### 9.4 Redis Caching
| Key | TTL | Invalidation |
|-----|-----|--------------|
| `stock:{id}:level` | 5m | On stockadjustment / sale / purchase |
| `account:{id}:balance` | 1m | On cashpayment / receipt / journal |
| `user:{id}:permissions` | 15m | On privilege change |
| `org:config` | 1h | On org update |
| `financial:period:current` | 10m | On period close |

### 9.5 POS Performance
- Product search: Redis-backed query cache + MariaDB trigram index on `stockitems(name)`
- Barcode lookup: unique index on `stockitems.code` (covers barcode if unified)
- Cart Add: single `UPDATE stocklevels SET quantity = quantity - :qty WHERE stockItemId = :id`
- Receipt generation: async background job (not blocking POS response)

---

## 10. Testing & QA Strategy

### 10.1 Backend (.NET)
| Layer | Tool | Scope |
|-------|------|-------|
| Unit | xUnit | Domain logic (e.g. DoubleEntryValidator, Unit conversion) |
| Integration | xUnit + Respawn + Testcontainers (MariaDB) | Full repository + EF Core mapping |
| API | xUnit + WebApplicationFactory | End-to-end per module |
| Contract | Verify (or manual) | JSON schema per endpoint |

**Key integration tests:**
- `PosSaleScenario`: create journal, post transactions, decrease stock, create cash receipt → read back trial balance == 0
- `PurchaseCreditScenario`: create purchase on credit, verify A/P balance
- `ExchangeScenario`: convert USD → AFN, verify gain/loss leg + cash balances
- `UnauthorizedAccess`: user without privilege gets 403

### 10.2 Frontend
| Layer | Tool | Scope |
|-------|------|-------|
| Component | Vitest + RTL | POS cart, stock table, login form |
| Hook | Vitest | usePOSCart, useDebounce, useAuth |
| E2E | Playwright | Full POS flow: login → search → cart → checkout → receipt |

---

## 11. Monitoring & Observability

### 11.1 Logging (Serilog)
```csharp
Log.Logger = new LoggerConfiguration()
  .Enrich.FromLogContext()
  .Enrich.WithMachineName()
  .WriteTo.Console()
  .WriteTo.MariaDB(connectionString, "logs", restrictedToMinimumLevel: Serilog.Events.LogEventLevel.Information)
  .CreateLogger();
```

Structured fields: `UserId`, `Action`, `RefType`, `RefId`, `DurationMs`, `CorrelationId`

### 11.2 Tracing (OpenTelemetry)
- Instrument ASP.NET Core, EF Core, HttpClient, MediatR
- Export to Jaeger (dev) / OTLP collector (prod)
- Trace per POS sale: full span tree across inventory → accounting → cash

### 11.3 Metrics (Prometheus)
- `http_request_duration_seconds` by route + status
- `db_query_duration_seconds` by query hash
- `pos_checkout_duration_seconds`
- `stock_level_updates_total`
- `active_users gauge`

### 11.4 Health Checks
Per module: `Identity`, `Inventory`, `Accounting`, `Cash`, `Database`, `Redis`
Endpoint: `/health` (liveness) + `/health/ready` (readiness)

---

## 12. Caching Strategy

### 12.1 Redis Keys
```
stock:levels:{stockItemId}     → JSON { qty, cost }
account:balance:{accountId}    → JSON { dr, cr, net }
user:perms:{userId}            → JSON { module: [actions] }
org:config                     → JSON { allowNegativeStock, decimals }
fx:rate:{from}:{to}:{date}    → decimal  (optional future)
```

### 12.2 Invalidation Rules
- Stock level updated → `DEL stock:levels:{id}`
- Account balance changed → `DEL account:balance:{id}`
- Privilege changed → `DEL user:perms:{id}` + pub/sub notify all instances
- Config changed → `DEL org:config`

### 12.3 Cache-Aside Pattern
All reads:
```
val = await redis.GetAsync(key);
if (val == null) { val = await db.GetAsync(); await redis.SetAsync(key, val, ttl); }
return val
```

---

## 13. Audit System Design

### 13.1 Table
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

### 13.2 Capture Points
| Event | oldValue | newValue |
|-------|----------|----------|
| POS Sale | — | StockPOSSale summary |
| Purchase | — | StockPurchase summary |
| Journal Post | — | Journal transactions |
| Stock Adjustment | Before stocklevel | After stocklevel |
| Cash Exchange | Before balances | After balances |
| Permission Change | Before rules | After rules |

### 13.3 Compliance
- Append-only (no UPDATE/DELETE on auditlogs)
- Retention: 7 years (archival to S3 quarterly)
- Access: read-only for all except superadmin

---

## 14. DevOps & Deployment

### 14.1 Docker
```yaml
# docker-compose.yml
services:
  api:
    build: ./src/API
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

### 14.2 CI/CD (GitHub Actions)
- `build.yml`: dotnet build + test + docker build
- `deploy.yml`: on merge to main → SSH into server → docker pull + compose up
- `migrate.yml`: run `dotnet ef database update` against target env (staged, prod)
- `backup.yml`: daily mysqldump to `/backups` + upload to S3

### 14.3 Environment Strategy
| Env | DB | Purpose |
|-----|----|---------|
| local | Docker MariaDB | Dev |
| staging | Docker MariaDB | QA / UAT |
| production | Managed MariaDB (e.g. Supabase/Railway) | Live |

### 14.4 Migration Strategy
- `dotnet ef migrations add` per bounded context change
- Migrations run in CI/CD only (never auto-run on app start in production)
- Down migrations: supported but require manual approval + backup before execute

### 14.5 Backup Strategy
- Continuous binary log archiving (MariaDB `binlog` to S3)
- Daily base backup (mariabackup)
- Retention: 30 days hot, 1 year cold (S3 Glacier)

### 14.6 Rollback
1. Feature flags (LaunchDarkly or simple DB table): hot-disable new flows
2. DB migration rollback: `dotnet ef database update PreviousMigration`
3. Deployment rollback: `docker compose down && docker compose up <previous-image>`

---

## 15. Final Deliverables

1. **MariaDB schema** — fully migrated from MySQL, numeric-safe, indexed
2. **7 .NET 8 projects** — modular monolith, Clean Architecture per module
3. **React SPA** — POS-first, TypeScript, MUI, React Query + Apollo Client
4. **Docker Compose** — one-command local/dev startup
5. **GitHub Actions** — CI/CD + daily backup
6. **API documentation** — GraphQL Playground + HotChocolate schema per module, aggregated in gateway
7. **Runbook** — backup/restore, rollback, monitoring queries
8. **UAT checklist** — per milestone DoD with test scenarios
