using AfghanCommerceCloud.IdentityAccess.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace AfghanCommerceCloud.IdentityAccess.Infrastructure.Persistence.Configurations;

public class AccountConfiguration : IEntityTypeConfiguration<Account>
{
    public void Configure(EntityTypeBuilder<Account> builder)
    {
        builder.ToTable("accounts");
        builder.HasKey(x => x.Id);
        builder.Property(x => x.Id).HasColumnName("id");
        builder.Property(x => x.Date).HasColumnName("date").IsRequired();
        builder.Property(x => x.Name).HasColumnName("name").HasMaxLength(255).IsRequired();
        builder.Property(x => x.Type).HasColumnName("type").HasMaxLength(255).IsRequired();
        builder.Property(x => x.BalanceType).HasColumnName("balanceType").HasMaxLength(2).IsRequired();
        builder.Property(x => x.SubType).HasColumnName("subType").HasMaxLength(255);
        builder.Property(x => x.Phone).HasColumnName("phone").HasMaxLength(255);
        builder.Property(x => x.Address).HasColumnName("address").HasMaxLength(255);
        builder.Property(x => x.Code).HasColumnName("code").HasMaxLength(255);
        builder.Property(x => x.IsSystem).HasColumnName("system").HasDefaultValue(false);
        builder.Property(x => x.MaxCreditSales).HasColumnName("maxCreditSales").HasPrecision(18, 4);

        builder.HasIndex(x => new { x.SubType, x.IsSystem });
    }
}
