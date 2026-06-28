namespace AfghanCommerceCloud.IdentityAccess.Application.Common;

public interface IUserContext
{
    int UserId { get; }
    bool IsAdmin { get; }
    Task<bool> HasPermissionAsync(string module, string action, CancellationToken cancellationToken = default);
}
