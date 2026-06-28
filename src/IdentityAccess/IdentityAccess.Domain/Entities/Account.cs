using AfghanCommerceCloud.SharedKernel.Domain.Entities;

namespace AfghanCommerceCloud.IdentityAccess.Domain.Entities;

public class Account : BaseEntity, IAuditable, ISoftDeletable
{
    public string Date { get; set; } = string.Empty;
    public string Name { get; set; } = string.Empty;
    public string Type { get; set; } = string.Empty;
    public string BalanceType { get; set; } = string.Empty;
    public string? SubType { get; set; }
    public string? Phone { get; set; }
    public string? Address { get; set; }
    public string? Code { get; set; }
    public bool IsSystem { get; set; }
    public decimal MaxCreditSales { get; set; }
    public int? UserId { get; set; }
    public DateTimeOffset CreatedAt { get; set; }
    public DateTimeOffset UpdatedAt { get; set; }
    public DateTimeOffset? DeletedAt { get; set; }
}
