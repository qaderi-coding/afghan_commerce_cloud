-- Initial seed data for Afghan Commerce Cloud MVP
-- Run after database is created

INSERT INTO `users` (`username`, `password`, `isAdmin`, `isActive`, `createdAt`, `updatedAt`) 
VALUES ('administrator', 'XzYgGkLQ5sU=', 1, 1, NOW(6), NOW(6));

SET @adminUserId = LAST_INSERT_ID();

-- Chart of Accounts (system accounts)
INSERT INTO `accounts` (`date`, `name`, `type`, `balanceType`, `subType`, `isSystem`, `createdAt`, `updatedAt`) VALUES
('2026-03-28 17:28:39', 'نغدي', 'currentAsset', 'dr', 'cash', 1, NOW(6), NOW(6)),
('2026-03-28 17:28:39', 'اصلي سټاک', 'currentAsset', 'dr', 'stock', 1, NOW(6), NOW(6)),
('2026-03-28 17:28:39', 'د لاسته راوړو وړ پیسې', 'currentAsset', 'dr', NULL, 1, NOW(6), NOW(6)),
('2026-03-28 17:28:39', 'د تادیې وړ پیسې', 'liability', 'cr', NULL, 1, NOW(6), NOW(6)),
('2026-03-28 17:28:39', 'د ثابتی شتمنۍ خرڅلاو', 'revenue', 'cr', NULL, 1, NOW(6), NOW(6)),
('2026-03-28 17:28:39', 'د ثابتی شتمنۍ تمام شد قیمت', 'expense', 'dr', NULL, 1, NOW(6), NOW(6)),
('2026-03-28 17:28:39', 'سرمایه', 'capital', 'cr', NULL, 1, NOW(6), NOW(6));

SET @cashAccountId = (SELECT id FROM accounts WHERE subType = 'cash' LIMIT 1);
SET @stockAccountId = (SELECT id FROM accounts WHERE subType = 'stock' LIMIT 1);
SET @revenueAccountId = (SELECT id FROM accounts WHERE type = 'revenue' LIMIT 1);
SET @expenseAccountId = (SELECT id FROM accounts WHERE type = 'expense' LIMIT 1);
SET @capitalAccountId = (SELECT id FROM accounts WHERE type = 'capital' LIMIT 1);

-- Insert default currency if not exists
INSERT IGNORE INTO `currencies` (`name`, `code`, `isBaseCode`, `isActive`) VALUES
('afghani', 'AFN', 1, 1),
('united states dollar', 'USD', 0, 1);

-- Create initial financial period
INSERT INTO `financialperiods` (`date`, `remarks`, `isActive`) 
VALUES (NOW(6), 'Initial Period', 1);

SELECT 'Seed completed successfully' as message;