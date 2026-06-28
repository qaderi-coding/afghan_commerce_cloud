namespace AfghanCommerceCloud.SharedKernel.Common;

public static class Guard
{
    public static void AgainstNullOrEmpty(string? value, string paramName)
    {
        if (string.IsNullOrWhiteSpace(value))
            throw new ArgumentException($"{paramName} cannot be null or empty.");
    }

    public static void AgainstNegative(decimal value, string paramName)
    {
        if (value < 0)
            throw new ArgumentOutOfRangeException(paramName, $"{paramName} cannot be negative.");
    }

    public static void AgainstLessThan(decimal value, decimal min, string paramName)
    {
        if (value < min)
            throw new ArgumentOutOfRangeException(paramName, $"{paramName} must be at least {min}.");
    }
}
