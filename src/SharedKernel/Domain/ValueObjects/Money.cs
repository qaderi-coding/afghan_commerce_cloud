namespace AfghanCommerceCloud.SharedKernel.Domain.ValueObjects;

public readonly record struct Money
{
    private const int DefaultScale = 4;
    public decimal Amount { get; }
    public CurrencyCode Currency { get; }

    private Money(decimal amount, CurrencyCode currency)
    {
        Amount = decimal.Round(amount, DefaultScale, MidpointRounding.AwayFromZero);
        Currency = currency;
    }

    public static Money From(decimal amount, CurrencyCode currency) => new(amount, currency);

    public static Money operator +(Money left, Money right)
    {
        if (!left.Currency.Equals(right.Currency))
            throw new InvalidOperationException("Cannot add Money with different currencies");
        return new Money(left.Amount + right.Amount, left.Currency);
    }

    public static Money operator -(Money left, Money right)
    {
        if (!left.Currency.Equals(right.Currency))
            throw new InvalidOperationException("Cannot subtract Money with different currencies");
        return new Money(left.Amount - right.Amount, left.Currency);
    }

    public override string ToString() => $"{Amount:N4} {Currency}";
}
