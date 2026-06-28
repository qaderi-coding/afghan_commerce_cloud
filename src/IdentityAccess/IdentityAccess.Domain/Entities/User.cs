using AfghanCommerceCloud.IdentityAccess.Domain.ValueObjects;
using AfghanCommerceCloud.SharedKernel.Domain.Entities;

namespace AfghanCommerceCloud.IdentityAccess.Domain.Entities;

public class User : BaseEntity, IAuditable, ISoftDeletable
{
    public Username Username { get; private set; } = default!;
    public HashedPassword PasswordHash { get; private set; } = default!;
    public bool IsAdmin { get; private set; }
    public bool IsActive { get; private set; }
    public DateTimeOffset CreatedAt { get; set; }
    public DateTimeOffset UpdatedAt { get; set; }
    public DateTimeOffset? DeletedAt { get; set; }

    private readonly List<UserPrivilege> _privileges = new();
    public IReadOnlyCollection<UserPrivilege> Privileges => _privileges.AsReadOnly();

    private User() { }

    public User(Username username, HashedPassword passwordHash, bool isAdmin = false)
    {
        Username = username;
        PasswordHash = passwordHash;
        IsAdmin = isAdmin;
        IsActive = true;
        CreatedAt = DateTimeOffset.UtcNow;
        UpdatedAt = DateTimeOffset.UtcNow;
    }

    public void ChangePassword(HashedPassword newHash)
    {
        PasswordHash = newHash;
        UpdatedAt = DateTimeOffset.UtcNow;
    }

    public void Deactivate()
    {
        IsActive = false;
        DeletedAt = DateTimeOffset.UtcNow;
    }
}
