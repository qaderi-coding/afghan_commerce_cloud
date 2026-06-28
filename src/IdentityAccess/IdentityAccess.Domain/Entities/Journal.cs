using AfghanCommerceCloud.SharedKernel.Domain.Entities;

namespace AfghanCommerceCloud.IdentityAccess.Domain.Entities;

public class Journal : BaseEntity, IAuditable, ISoftDeletable
{
    public string Date { get; set; } = string.Empty;
    public string Type { get; set; } = string.Empty;
    public string TargetId { get; set; } = string.Empty;
    public string? Description { get; set; }
    public int? UserId { get; set; }
    public int? ParentId { get; set; }
    public int FinancialPeriodId { get; set; }
    public DateTimeOffset CreatedAt { get; set; }
    public DateTimeOffset UpdatedAt { get; set; }
    public DateTimeOffset? DeletedAt { get; set; }
}
