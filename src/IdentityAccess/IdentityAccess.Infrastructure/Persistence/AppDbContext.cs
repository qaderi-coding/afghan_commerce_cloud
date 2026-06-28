namespace AfghanCommerceCloud.IdentityAccess.Infrastructure.Persistence;

using AfghanCommerceCloud.IdentityAccess.Domain.Entities;
using Microsoft.EntityFrameworkCore;

public class AppDbContext : DbContext
{
    public DbSet<User> Users => Set<User>();
    public DbSet<Privilege> Privileges => Set<Privilege>();
    public DbSet<UserPrivilege> UserPrivileges => Set<UserPrivilege>();
    public DbSet<Account> Accounts => Set<Account>();
    public DbSet<AccountCategory> AccountCategories => Set<AccountCategory>();
    public DbSet<Journal> Journals => Set<Journal>();
    public DbSet<Transaction> Transactions => Set<Transaction>();
    public DbSet<FinancialPeriod> FinancialPeriods => Set<FinancialPeriod>();
    public DbSet<StockItem> StockItems => Set<StockItem>();
    public DbSet<StockLevel> StockLevels => Set<StockLevel>();
    public DbSet<KeyValue> KeyValues => Set<KeyValue>();

    public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
    {
    }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.ApplyConfigurationsFromAssembly(typeof(AppDbContext).Assembly);
        base.OnModelCreating(modelBuilder);
    }
}
