using AfghanCommerceCloud.SharedKernel.Domain.Entities;

namespace AfghanCommerceCloud.IdentityAccess.Domain.Entities;

public class UserPrivilege
{
    public int PrivilegeId { get; private set; }
    public Privilege Privilege { get; private set; } = null!;
    public int UserId { get; private set; }
    public User User { get; private set; } = null!;

    private UserPrivilege() { }

    public UserPrivilege(int privilegeId, int userId)
    {
        PrivilegeId = privilegeId;
        UserId = userId;
    }
}
