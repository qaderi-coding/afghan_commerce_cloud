using AfghanCommerceCloud.IdentityAccess.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace AfghanCommerceCloud.IdentityAccess.Infrastructure.Persistence.Configurations;

public class JournalConfiguration : IEntityTypeConfiguration<Journal>
{
    public void Configure(EntityTypeBuilder<Journal> builder)
    {
        builder.ToTable("journals");
        builder.HasKey(x => x.Id);
        builder.Property(x => x.Id).HasColumnName("id");
        builder.Property(x => x.Date).HasColumnName("date").IsRequired();
        builder.Property(x => x.Type).HasColumnName("type").HasMaxLength(255).IsRequired();
        builder.Property(x => x.TargetId).HasColumnName("targetId").HasMaxLength(255).IsRequired();
        builder.Property(x => x.Description).HasColumnName("description").HasMaxLength(255);
        builder.Property(x => x.UserId).HasColumnName("userId");
        builder.Property(x => x.ParentId).HasColumnName("parentId");
        builder.Property(x => x.FinancialPeriodId).HasColumnName("fpId").IsRequired();

        builder.HasIndex(x => x.Date);
        builder.HasIndex(x => x.Type);
        builder.HasIndex(x => new { x.Date, x.FinancialPeriodId });
    }
}
