using AfghanCommerceCloud.SharedKernel.Domain.Entities;

namespace AfghanCommerceCloud.IdentityAccess.Domain.Entities;

public class StockItem : BaseEntity, IAuditable, ISoftDeletable
{
    public string Date { get; set; } = string.Empty;
    public string Name { get; set; } = string.Empty;
    public string? LabelName { get; set; }
    public string? Code { get; set; }
    public string? Company { get; set; }
    public string? Category { get; set; }
    public string BaseUnit { get; set; } = string.Empty;
    public decimal? SafetyStock { get; set; }
    public bool GenerateBarcode { get; set; }
    public string? Barcode { get; set; }
    public decimal PurchasePriceAmount { get; set; }
    public string PurchasePriceCode { get; set; } = "AFN";
    public decimal SalePriceAmount { get; set; }
    public string SalePriceCode { get; set; } = "AFN";
    public int? UserId { get; set; }
    public DateTimeOffset CreatedAt { get; set; }
    public DateTimeOffset UpdatedAt { get; set; }
    public DateTimeOffset? DeletedAt { get; set; }
}
