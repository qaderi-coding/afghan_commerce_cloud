using AfghanCommerceCloud.IdentityAccess.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace AfghanCommerceCloud.IdentityAccess.Infrastructure.Persistence.Configurations;

public class StockLevelConfiguration : IEntityTypeConfiguration<StockLevel>
{
    public void Configure(EntityTypeBuilder<StockLevel> builder)
    {
        builder.ToTable("stocklevels");
        builder.HasKey(x => x.Id);
        builder.Property(x => x.Id).HasColumnName("id");
        builder.Property(x => x.Quantity).HasColumnName("quantity").HasPrecision(18, 4).IsRequired();
        builder.Property(x => x.JournalId).HasColumnName("journalId");
        builder.Property(x => x.StockItemId).HasColumnName("stockItemId").IsRequired();
        builder.Property(x => x.StockAccountId).HasColumnName("stockAccountId").IsRequired();
        builder.Property(x => x.LastUpdated).HasColumnName("lastUpdated");

        builder.HasIndex(x => new { x.StockItemId, x.StockAccountId });
    }
}
