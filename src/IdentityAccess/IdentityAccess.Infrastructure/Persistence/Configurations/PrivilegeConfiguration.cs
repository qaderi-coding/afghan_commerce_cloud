using AfghanCommerceCloud.IdentityAccess.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace AfghanCommerceCloud.IdentityAccess.Infrastructure.Persistence.Configurations;

public class PrivilegeConfiguration : IEntityTypeConfiguration<Privilege>
{
    public void Configure(EntityTypeBuilder<Privilege> builder)
    {
        builder.ToTable("privileges");
        builder.HasKey(x => x.Id);
        builder.Property(x => x.Id).HasColumnName("id");
        builder.Property(x => x.Name).HasMaxLength(255).IsRequired();
        builder.Property(x => x.RulesJson).HasColumnName("rules").HasColumnType("jsonb").IsRequired();
        builder.Property(x => x.Date).HasColumnName("date");
    }
}
