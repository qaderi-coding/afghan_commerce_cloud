namespace AfghanCommerceCloud.SharedKernel.Domain.ValueObjects;

public readonly record struct CurrencyCode
{
    private const string DefaultCode = "AFN";
    public string Value { get; }

    private CurrencyCode(string value) => Value = value;

    public static CurrencyCode From(string value)
    {
        if (string.IsNullOrWhiteSpace(value) || value.Length != 3)
            throw new ArgumentException("Currency code must be 3 characters", nameof(value));
        return new CurrencyCode(value.ToUpperInvariant());
    }

    public static CurrencyCode Default => new(DefaultCode);
    public override string ToString() => Value;
    public static implicit operator string(CurrencyCode code) => code.Value;
}
