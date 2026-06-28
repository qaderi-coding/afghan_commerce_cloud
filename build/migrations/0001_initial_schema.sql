BEGIN TRANSACTION;

CREATE TABLE IF NOT EXISTS public."users" (
    id bigserial PRIMARY KEY,
    username varchar(255) UNIQUE NOT NULL,
    password varchar(255) NOT NULL,
    "isAdmin" boolean NOT NULL DEFAULT false,
    "isActive" boolean NOT NULL DEFAULT true,
    "date" date NOT NULL,
    "msdp" numeric(18,4) DEFAULT 0,
    "allowBonus" boolean DEFAULT false,
    "allowPriceEditing" boolean DEFAULT false,
    "noCogsAlert" boolean DEFAULT false,
    "createdAt" timestamptz NOT NULL DEFAULT now(),
    "updatedAt" timestamptz NOT NULL DEFAULT now(),
    "deletedAt" timestamptz
);

CREATE TABLE IF NOT EXISTS public."privileges" (
    id bigserial PRIMARY KEY,
    name varchar(255) UNIQUE NOT NULL,
    rules jsonb NOT NULL,
    "date" date NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public."user_privileges" (
    "privilegeId" bigint NOT NULL REFERENCES public."privileges"(id),
    "userId" bigint NOT NULL REFERENCES public."users"(id),
    PRIMARY KEY ("privilegeId", "userId")
);

CREATE TABLE IF NOT EXISTS public."accounts" (
    id bigserial PRIMARY KEY,
    "date" timestamptz NOT NULL DEFAULT now(),
    name varchar(255) NOT NULL,
    type varchar(255) NOT NULL,
    "balanceType" char(2) NOT NULL,
    "subType" varchar(255),
    phone varchar(255),
    address varchar(255),
    code varchar(255) UNIQUE,
    "isSystem" boolean NOT NULL DEFAULT false,
    "maxCreditSales" numeric(18,4) DEFAULT 0,
    "userId" bigint REFERENCES public."users"(id),
    "createdAt" timestamptz NOT NULL DEFAULT now(),
    "updatedAt" timestamptz NOT NULL DEFAULT now(),
    "deletedAt" timestamptz
);

CREATE INDEX IF NOT EXISTS ix_accounts_subtype_system ON public."accounts"("subType") WHERE "isSystem" = false;

CREATE TABLE IF NOT EXISTS public."account_categories" (
    id bigserial PRIMARY KEY,
    name varchar(255) NOT NULL,
    "accountId" bigint REFERENCES public."accounts"(id),
    created_at timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS ix_account_categories_name ON public."account_categories"(name);

CREATE TABLE IF NOT EXISTS public."financial_periods" (
    id bigserial PRIMARY KEY,
    "date" timestamptz NOT NULL DEFAULT now(),
    remarks varchar(255),
    "isActive" boolean NOT NULL DEFAULT true,
    "startDate" timestamptz,
    "endDate" timestamptz,
    "userId" bigint REFERENCES public."users"(id),
    "createdAt" timestamptz NOT NULL DEFAULT now(),
    "updatedAt" timestamptz NOT NULL DEFAULT now(),
    "deletedAt" timestamptz
);

CREATE TABLE IF NOT EXISTS public."journals" (
    id bigserial PRIMARY KEY,
    "date" timestamptz NOT NULL DEFAULT now(),
    type varchar(255) NOT NULL,
    "targetId" varchar(255) NOT NULL,
    description varchar(255),
    "userId" bigint REFERENCES public."users"(id),
    "parentId" bigint REFERENCES public."journals"(id),
    "fpId" bigint NOT NULL REFERENCES public."financial_periods"(id),
    "createdAt" timestamptz NOT NULL DEFAULT now(),
    "updatedAt" timestamptz NOT NULL DEFAULT now(),
    "deletedAt" timestamptz
);

CREATE TABLE IF NOT EXISTS public."transactions" (
    id bigserial PRIMARY KEY,
    type char(2) NOT NULL,
    amount numeric(18,4) NOT NULL,
    code char(3) NOT NULL,
    "baseAmount" numeric(18,4) NOT NULL,
    "baseCode" char(3) NOT NULL,
    description text,
    "journalId" bigint NOT NULL REFERENCES public."journals"(id) ON DELETE RESTRICT,
    "accountId" bigint NOT NULL REFERENCES public."accounts"(id) ON DELETE RESTRICT,
    "createdAt" timestamptz NOT NULL DEFAULT now(),
    "updatedAt" timestamptz NOT NULL DEFAULT now(),
    "deletedAt" timestamptz
);

CREATE TABLE IF NOT EXISTS public."stock_items" (
    id bigserial PRIMARY KEY,
    "date" timestamptz NOT NULL DEFAULT now(),
    name varchar(255) NOT NULL,
    "labelName" varchar(255),
    code varchar(255) UNIQUE,
    company varchar(255),
    category varchar(255),
    "baseUnit" varchar(255) NOT NULL,
    "safetyStock" numeric(18,4),
    "generateBarcode" boolean DEFAULT false,
    barcode varchar(100),
    "purchasePriceAmount" numeric(18,4) DEFAULT 0,
    "purchasePriceCode" char(3) DEFAULT 'AFN',
    "salePriceAmount" numeric(18,4) DEFAULT 0,
    "salePriceCode" char(3) DEFAULT 'AFN',
    "userId" bigint REFERENCES public."users"(id),
    "createdAt" timestamptz NOT NULL DEFAULT now(),
    "updatedAt" timestamptz NOT NULL DEFAULT now(),
    "deletedAt" timestamptz
);

CREATE TABLE IF NOT EXISTS public."stock_levels" (
    id bigserial PRIMARY KEY,
    quantity numeric(18,4) NOT NULL,
    "journalId" bigint REFERENCES public."journals"(id),
    "stockItemId" bigint NOT NULL REFERENCES public."stock_items"(id) ON DELETE RESTRICT,
    "stockAccountId" bigint NOT NULL REFERENCES public."accounts"(id) ON DELETE RESTRICT,
    "lastUpdated" timestamptz,
    "createdAt" timestamptz NOT NULL DEFAULT now(),
    "updatedAt" timestamptz NOT NULL DEFAULT now(),
    "deletedAt" timestamptz
);

CREATE INDEX IF NOT EXISTS ix_stocklevels_item_account ON public."stock_levels"("stockItemId", "stockAccountId");

CREATE TABLE IF NOT EXISTS public."keyvalues" (
    id bigserial PRIMARY KEY,
    "key" varchar(255) UNIQUE NOT NULL,
    value jsonb NOT NULL,
    "createdAt" timestamptz NOT NULL DEFAULT now(),
    "updatedAt" timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public."auditlogs" (
    id bigserial PRIMARY KEY,
    "userId" bigint NOT NULL REFERENCES public."users"(id),
    action varchar(100) NOT NULL,
    "refType" varchar(100) NOT NULL,
    "refId" bigint NOT NULL,
    "oldValue" jsonb,
    "newValue" jsonb,
    ip inet,
    "userAgent" text,
    "createdAt" timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS ix_auditlogs_user ON public."auditlogs"("userId", "createdAt");
CREATE INDEX IF NOT EXISTS ix_auditlogs_ref ON public."auditlogs"("refType", "refId");

COMMIT;
