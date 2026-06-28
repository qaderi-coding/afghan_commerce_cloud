namespace AfghanCommerceCloud.IdentityAccess.Domain.ValueObjects;

public readonly record struct Username
{
    public string Value { get; }

    private Username(string value) => Value = value;

    public static Username From(string value)
    {
        if (string.IsNullOrWhiteSpace(value) || value.Length < 3 || value.Length > 255)
            throw new ArgumentException("Username must be between 3 and 255 characters.", nameof(value));
        return new Username(value.ToLowerInvariant());
    }

    public override string ToString() => Value;
    public static implicit operator string(Username username) => username.Value;
}
