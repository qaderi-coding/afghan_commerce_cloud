namespace AfghanCommerceCloud.IdentityAccess.Domain.ValueObjects;

using System.Security.Cryptography;
using System.Text;

public readonly record struct HashedPassword
{
    public string Value { get; }

    private HashedPassword(string value) => Value = value;

    public static HashedPassword From(string plainText)
    {
        var bytes = Encoding.UTF8.GetBytes(plainText);
        var hash = Convert.ToBase64String(SHA256.HashData(bytes));
        return new HashedPassword(hash);
    }

    public static HashedPassword FromHash(string hash) => new(hash);

    public bool Verify(string plainText)
    {
        var test = From(plainText);
        return Value == test.Value;
    }

    public override string ToString() => Value;
}
