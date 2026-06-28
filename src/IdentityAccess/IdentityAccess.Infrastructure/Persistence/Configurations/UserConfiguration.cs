using AfghanCommerceCloud.IdentityAccess.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace AfghanCommerceCloud.IdentityAccess.Infrastructure.Persistence.Configurations;

public class UserConfiguration : IEntityTypeConfiguration<User>
{
    public void Configure(EntityTypeBuilder<User> builder)
    {
        builder.ToTable("users");
        builder.HasKey(x => x.Id);
        builder.Property(x => x.Id).HasColumnName("id");
        builder.Property(x => x.Username).HasMaxLength(255).IsRequired();
        builder.Property(x => x.PasswordHash).HasColumnName("password").HasMaxLength(255).IsRequired();
        builder.Property(x => x.IsAdmin).HasColumnName("isAdmin").HasDefaultValue(false);
        builder.Property(x => x.IsActive).HasColumnName("isActive").HasDefaultValue(true);
        builder.Property(x => x.CreatedAt).HasColumnName("createdAt");
        builder.Property(x => x.UpdatedAt).HasColumnName("updatedAt");
        builder.Property(x => x.DeletedAt).HasColumnName("deletedAt");

        builder.HasIndex(x => x.Username).IsUnique();
    }
}
