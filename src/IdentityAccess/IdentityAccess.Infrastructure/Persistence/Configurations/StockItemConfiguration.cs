using AfghanCommerceCloud.IdentityAccess.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace AfghanCommerceCloud.IdentityAccess.Infrastructure.Persistence.Configurations;

public class StockItemConfiguration : IEntityTypeConfiguration<StockItem>
{
    public void Configure(EntityTypeBuilder<StockItem> builder)
    {
        builder.ToTable("stockitems");
        builder.HasKey(x => x.Id);
        builder.Property(x => x.Id).HasColumnName("id");
        builder.Property(x => x.Date).HasColumnName("date").IsRequired();
        builder.Property(x => x.Name).HasColumnName("name").HasMaxLength(255).IsRequired();
        builder.Property(x => x.LabelName).HasColumnName("labelName").HasMaxLength(255);
        builder.Property(x => x.Code).HasColumnName("code").HasMaxLength(255);
        builder.Property(x => x.Company).HasColumnName("company").HasMaxLength(255);
        builder.Property(x => x.Category).HasColumnName("category").HasMaxLength(255);
        builder.Property(x => x.BaseUnit).HasColumnName("baseUnit").HasMaxLength(255).IsRequired();
        builder.Property(x => x.SafetyStock).HasColumnName("safetyStock").HasPrecision(18, 4);
        builder.Property(x => x.GenerateBarcode).HasColumnName("generateBarcode").HasDefaultValue(false);
        builder.Property(x => x.Barcode).HasColumnName("barcode").HasMaxLength(100);
        builder.Property(x => x.PurchasePriceAmount).HasColumnName("purchasePriceAmount").HasPrecision(18, 4);
        builder.Property(x => x.SalePriceAmount).HasColumnName("salePriceAmount").HasPrecision(18, 4);

        builder.HasIndex(x => x.Code).IsUnique();
    }
}
