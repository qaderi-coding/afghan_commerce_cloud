using AfghanCommerceCloud.IdentityAccess.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace AfghanCommerceCloud.IdentityAccess.Infrastructure.Persistence.Configurations;

public class FinancialPeriodConfiguration : IEntityTypeConfiguration<FinancialPeriod>
{
    public void Configure(EntityTypeBuilder<FinancialPeriod> builder)
    {
        builder.ToTable("financialperiods");
        builder.HasKey(x => x.Id);
        builder.Property(x => x.Id).HasColumnName("id");
        builder.Property(x => x.Date).HasColumnName("date").IsRequired();
        builder.Property(x => x.Remarks).HasColumnName("remarks").HasMaxLength(255);
        builder.Property(x => x.IsActive).HasColumnName("isActive").HasDefaultValue(true);
        builder.Property(x => x.StartDate).HasColumnName("startDate");
        builder.Property(x => x.EndDate).HasColumnName("endDate");
    }
}
