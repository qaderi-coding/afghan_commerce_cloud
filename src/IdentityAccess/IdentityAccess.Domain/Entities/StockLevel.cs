using AfghanCommerceCloud.SharedKernel.Domain.Entities;

namespace AfghanCommerceCloud.IdentityAccess.Domain.Entities;

public class StockLevel : BaseEntity, IAuditable, ISoftDeletable
{
    public decimal Quantity { get; set; }
    public int? JournalId { get; set; }
    public int StockItemId { get; set; }
    public int StockAccountId { get; set; }
    public DateTimeOffset? LastUpdated { get; set; }
    public DateTimeOffset CreatedAt { get; set; }
    public DateTimeOffset UpdatedAt { get; set; }
    public DateTimeOffset? DeletedAt { get; set; }
}
