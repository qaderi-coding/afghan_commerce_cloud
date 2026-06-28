using AfghanCommerceCloud.SharedKernel.Domain.Entities;

namespace AfghanCommerceCloud.IdentityAccess.Domain.Entities;

public class AccountCategory : BaseEntity
{
    public string Name { get; set; } = string.Empty;
    public int? AccountId { get; set; }
}
