namespace AfghanCommerceCloud.SharedKernel.Domain.Events;

public interface IDomainEvent
{
    Guid Id { get; }
    DateTimeOffset OccurredOn { get; }
}

public interface INotification : IDomainEvent
{
}
