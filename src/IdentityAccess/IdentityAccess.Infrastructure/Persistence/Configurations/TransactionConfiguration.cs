using AfghanCommerceCloud.IdentityAccess.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace AfghanCommerceCloud.IdentityAccess.Infrastructure.Persistence.Configurations;

public class TransactionConfiguration : IEntityTypeConfiguration<Transaction>
{
    public void Configure(EntityTypeBuilder<Transaction> builder)
    {
        builder.ToTable("transactions");
        builder.HasKey(x => x.Id);
        builder.Property(x => x.Id).HasColumnName("id");
        builder.Property(x => x.Type).HasColumnName("type").HasMaxLength(2).IsRequired();
        builder.Property(x => x.Amount).HasColumnName("amount").HasPrecision(18, 4).IsRequired();
        builder.Property(x => x.Code).HasColumnName("code").HasMaxLength(3).IsRequired();
        builder.Property(x => x.BaseAmount).HasColumnName("baseAmount").HasPrecision(18, 4).IsRequired();
        builder.Property(x => x.BaseCode).HasColumnName("baseCode").HasMaxLength(3).IsRequired();
        builder.Property(x => x.Description).HasColumnName("description");
        builder.Property(x => x.JournalId).HasColumnName("journalId");
        builder.Property(x => x.AccountId).HasColumnName("accountId");
    }
}
