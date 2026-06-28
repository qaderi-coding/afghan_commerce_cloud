using AfghanCommerceCloud.SharedKernel.Domain.Entities;

namespace AfghanCommerceCloud.IdentityAccess.Domain.Entities;

public class FinancialPeriod : BaseEntity, IAuditable, ISoftDeletable
{
    public string Date { get; set; } = string.Empty;
    public string? Remarks { get; set; }
    public bool IsActive { get; set; } = true;
    public DateTimeOffset? StartDate { get; set; }
    public DateTimeOffset? EndDate { get; set; }
    public int? UserId { get; set; }
    public DateTimeOffset CreatedAt { get; set; }
    public DateTimeOffset UpdatedAt { get; set; }
    public DateTimeOffset? DeletedAt { get; set; }
}
