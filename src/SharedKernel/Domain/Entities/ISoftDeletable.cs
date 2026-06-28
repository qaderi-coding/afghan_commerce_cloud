namespace AfghanCommerceCloud.SharedKernel.Domain.Entities;

public interface ISoftDeletable
{
    DateTimeOffset? DeletedAt { get; set; }
}
