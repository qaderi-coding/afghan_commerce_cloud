using AfghanCommerceCloud.SharedKernel.Domain.Entities;

namespace AfghanCommerceCloud.IdentityAccess.Domain.Entities;

public class Transaction : BaseEntity, IAuditable, ISoftDeletable
{
    public string Type { get; set; } = string.Empty;
    public decimal Amount { get; set; }
    public string Code { get; set; } = string.Empty;
    public decimal BaseAmount { get; set; }
    public string BaseCode { get; set; } = string.Empty;
    public string? Description { get; set; }
    public int? JournalId { get; set; }
    public int? AccountId { get; set; }
    public DateTimeOffset CreatedAt { get; set; }
    public DateTimeOffset UpdatedAt { get; set; }
    public DateTimeOffset? DeletedAt { get; set; }
}
