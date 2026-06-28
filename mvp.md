# 🇦🇫 Afghan Commerce Cloud
## 🟢 MVP PLAN (Retail ERP Core System)

---

# 🎯 1. MVP OVERVIEW

## Purpose

The MVP of Afghan Commerce Cloud is a **production-ready Retail ERP system** designed for a spare parts shop.

It focuses on:

- POS operations
- Inventory management
- Purchasing & sales cycles
- Cash flow tracking
- Basic accounting integration
- Secure user access
- Full transaction auditability

---

## 🧠 MVP Principle

> Every business action must result in a traceable financial + inventory transaction.

---

# 🧱 2. MVP MODULE ARCHITECTURE (BASED ON DATABASE SCHEMA)

---

# 🟢 2.1 ACCOUNTING CORE (FINANCIAL ENGINE)

### Tables
- accounts
- accountcategories
- journals
- transactions
- revenues
- expenses
- balanceadjustments
- withdrawals
- financialperiods
- profitdistributions
- profitdistributionitems
- profitsharepercentages
- keyvalues

### Responsibilities
- Double-entry accounting system
- Ledger management
- Financial period control
- Profit/loss tracking
- Transaction audit foundation

---

# 🟢 2.2 CASH & PAYMENT SYSTEM

### Tables
- cashpayments
- cashpaymentitems
- cashreceipts
- cashreceiptitems
- cashexchanges
- cashtransfers

### Responsibilities
- Cash inflow/outflow tracking
- Payment breakdown per transaction
- Cash register logic
- Internal cash movements

---

# 🟢 2.3 INVENTORY CORE (STOCK ENGINE)

### Tables
- items
- stockitems
- stocklevels
- stockitemunits
- stockitemvaluedists
- stockadjustments
- stocklosses
- stockexpiryalerts

### Responsibilities
- Product/item management
- Stock tracking per item
- Stock valuation (average cost method)
- Stock adjustments and corrections
- Expiry/loss monitoring

---

# 🟢 2.4 PURCHASE SYSTEM

### Tables
- stockpurchases
- stockpurchaseitems
- stockpurchasecosts
- stockpurchasebillcosts
- stockpurchasecloses
- stockitemexchanges

### Responsibilities
- Supplier purchasing process
- Stock inflow management
- Cost calculation per item
- Purchase lifecycle management

---

# 🟢 2.5 SALES / POS SYSTEM

### Tables
- stocksales
- stocksaleitems
- stocksalebillcosts
- stockpossales
- stockpossaleitems
- stocksaleexcashes

### Responsibilities
- POS sales screen (fast checkout)
- Invoice-based sales
- Stock deduction
- Cash receipt generation
- Sales cost tracking

---

# 🟢 2.6 STOCK MOVEMENT SYSTEM

### Tables
- stocktransfers
- stocktransferitems
- stocktransfercosts
- stocktransfercostdists

### Responsibilities
- Stock movement between locations
- Internal transfers
- Cost distribution handling

---

# 🟢 2.7 USERS & SECURITY SYSTEM

### Tables
- users
- usersprivileges
- privileges
- orginfomodels
- notes
- walkincustomers

### Responsibilities
- Authentication system (JWT)
- Role-based access control (RBAC)
- User permissions
- Organization configuration
- Basic customer tracking

---

# 🟢 2.8 EMPLOYEE PAYROLL (LIGHT MVP VERSION)

### Tables
- employeeaccounts
- employeepayments
- employeepaymentitems
- payrolls
- payrollitems

### Responsibilities
- Basic employee salary payments
- Payroll records
- Employee transaction tracking

---

# 🧠 3. CORE BUSINESS FLOW (VERY IMPORTANT)

---

## 🟢 SALES FLOW (POS)

```text
StockPosSales
 → StockPosSaleItems
 → StockLevels (decrease stock)
 → CashReceipts
 → Transactions (revenue entry)