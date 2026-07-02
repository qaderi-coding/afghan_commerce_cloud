# Afghan Commerce Cloud — ERP MVP

Modern ERP system for Afghan commerce businesses. Built with **.NET 8**, **Clean Architecture**, **GraphQL**, and **MariaDB**.

## What This Project Does

- **Point of Sale (POS):** Fast checkout with barcode scanning, multi-currency (AFN/USD), receipt printing
- **Inventory Management:** Stock items, units of measure, stock levels, adjustments, expiry alerts
- **Purchasing:** Vendor management, purchase orders, bill costs, credit purchases (A/P)
- **Accounting:** Double-entry bookkeeping, journals, trial balance, account ledger
- **Cash Management:** Receipts, payments, AFN↔USD exchange with gain/loss calculation
- **Payroll:** Employee master, salary payments, journalization

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Backend | .NET 8 Web API |
| Architecture | Clean Architecture / Modular Monolith |
| API | GraphQL (HotChocolate v14) |
| Database | MariaDB 11 (Pomelo EF Core provider) |
| Cache | Redis 7 |
| Frontend | React 18 + TypeScript + Vite + MUI + Apollo Client |
| Infra | Docker, Docker Compose |
| Logging | Serilog |

## Project Structure

```
src/
├── SharedKernel/              # Common building blocks
│   ├── Domain/
│   │   ├── Entities/         # BaseEntity, IAuditable, ISoftDeletable
│   │   ├── ValueObjects/     # Money, CurrencyCode
│   │   └── Exceptions/       # DomainException
│   └── Common/               # Result<T>, Guard
│
├── IdentityAccess/           # Authentication & Authorization
│   ├── Domain/               # User, Privilege, Account, Journal, Transaction
│   ├── Application/          # Queries, Mutations (use cases)
│   ├── Infrastructure/       # EF Core configs, MariaDB, Repositories
│   └── API/                  # GraphQL types, Program.cs
│
├── Inventory/                # (Coming in M2) Stock items, levels, adjustments
├── Purchasing/               # (Coming in M3) Purchase orders, bill costs
├── Sales/                    # (Coming in M4) POS, StockSale, StockPOSSale
├── Accounting/               # (Coming in M5) Journals, Trial Balance, Ledger
├── Cash/                     # (Coming in M6) Receipts, Payments, Exchange
└── Payroll/                  # (Coming in M7) Employees, Salary payments
```

## Architecture Rules

```
API → Application → Domain
      Infrastructure → Domain
      SharedKernel ← all
```

- **Domain** has ZERO external dependencies
- **Application** depends only on Domain + SharedKernel
- **Infrastructure** depends on Domain + Application
- **API** depends on everything

## Current Progress

### ✅ Completed (M1 — Foundation)

| Component | Status |
|-----------|--------|
| Solution structure (7 projects) | ✅ |
| SharedKernel (BaseEntity, Result, Guard, Money VO) | ✅ |
| IdentityAccess.Domain (User, Privilege, Account, Journal, Transaction, FinancialPeriod) | ✅ |
| IdentityAccess.Application (IRepository, IUserContext, Queries) | ✅ |
| IdentityAccess.Infrastructure (AppDbContext, 10 EF Configurations) | ✅ |
| API.Gateway (GraphQL server, Login/Register mutations, Account queries) | ✅ |
| Docker Compose (MariaDB + Redis + API) | ✅ |
| Build verification (all projects compile) | ✅ |

### 📋 Database: 63 Tables Documented

All tables from `database-backup.sql` are catalogued in the plan with purpose, FKs, and migration notes.

### 🔜 Next Up (M2 — Inventory Core)

- StockItem, StockLevel, StockItemUnit, StockAdjustment entities
- GraphQL mutations for CRUD
- Stock adjustment journalization

## Quick Start

### Prerequisites

- [Docker](https://www.docker.com/) (only requirement — MariaDB runs in Docker)

### 1. Start Services

```bash
docker compose up -d
```

This starts:
- **MariaDB** on `localhost:3306`
- **Redis** on `localhost:6379`
- **API** on `localhost:5000`

### 2. Apply Database Schema

```bash
docker exec -i afcc_mariadb mysql -u admin -padminpass afghan_commerce < build/migrations/0001_initial_schema.sql
```

### 3. Verify Setup

```bash
# Check MariaDB is running
docker exec -it afcc_mariadb mysql -u admin -padminpass -e "SELECT 1"

# Check tables were created
docker exec -it afcc_mariadb mysql -u admin -padminpass afghan_commerce -e "SHOW TABLES;"
```

### 4. Run API

```bash
# From project root
dotnet run --project src/API.Gateway/API.Gateway.csproj
```

### 5. Open GraphQL Playground

Navigate to: **http://localhost:5000/graphql**

## Database Connection Details

| Setting | Value |
|---------|-------|
| Host | `localhost` (or `mariadb` from Docker) |
| Port | `3306` |
| Database | `afghan_commerce` |
| Username | `admin` |
| Password | `adminpass` |
| Root Password | `rootpass` |

## GraphQL Schema (Current)

```graphql
type Query {
  login(username: String!, password: String!): User
  searchAccounts(q: String, subType: String): [Account]
  account(id: Int!): Account
}

type Mutation {
  register(username: String!, password: String!, isAdmin: Boolean): User
  createAccount(input: AccountInput!): Account
}
```

## Common Issues & Fixes

| Issue | Solution |
|-------|----------|
| `Port 3306 already in use` | Stop local MySQL: `sudo systemctl stop mysql` |
| `UseIdentityAlwaysColumn` error | Already fixed — using `AUTO_INCREMENT` for MariaDB |
| `Npgsql` not found | Already fixed — using Pomelo MySQL provider |
| `jsonb` column error | Already fixed — using `json` for MariaDB |

## Development Commands

```bash
# Build all projects
dotnet build

# Run API with hot reload
dotnet watch run --project src/API.Gateway/API.Gateway.csproj

# Docker logs
docker compose logs -f api

# Stop everything
docker compose down

# Reset database (WARNING: deletes data)
docker compose down -v && docker compose up -d
```

## Learning Path

This project follows a **step-by-step learning approach** for .NET beginners:

1. **M1 (Now):** Foundation — Learn Clean Architecture, EF Core, GraphQL basics
2. **M2:** Inventory — Learn value objects, derived entities, journalization
3. **M3:** Purchasing — Learn aggregate design, command handling
4. **M4:** POS — Learn ambient transactions, domain events, atomic operations
5. **M5:** Accounting — Learn double-entry validation, reporting
6. **M6:** Cash — Learn multi-currency, exchange gain/loss
7. **M7:** Payroll — Learn payment workflows
8. **M8:** Hardening — Learn RBAC, testing, CI/CD

Each milestone has detailed checkboxes in `.kilo/plans/1782648958759-erp-mvp-architecture.md`.

## Key Design Decisions

| Decision | Rationale |
|----------|-----------|
| MariaDB over PostgreSQL | Matches legacy schema; avoids migration conflicts |
| GraphQL over REST | POS needs flexible queries (cart + customer + stock in one request) |
| Modular Monolith | Single deployment, clear boundaries, easier than microservices for MVP |
| decimal(18,4) for money | Avoids floating-point rounding errors |
| Ambient transactions | POS sale spans 4+ aggregates — needs atomic commit |

## Contributing

Work is distributed by module to avoid conflicts:

| Person | Focus |
|--------|-------|
| Developer A | Domain + Application layers |
| Developer B | Infrastructure + API/GraphQL layers |

Never edit the same file at the same time. Coordinate via the milestone plan.

## License

Private — Fazli Technology
