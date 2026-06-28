namespace AfghanCommerceCloud.IdentityAccess.Application.Users.Commands;

using AfghanCommerceCloud.IdentityAccess.Application.Common;
using AfghanCommerceCloud.SharedKernel.Common;
using AfghanCommerceCloud.IdentityAccess.Domain.Entities;
using AfghanCommerceCloud.IdentityAccess.Domain.ValueObjects;
using MediatR;

public record CreateUserCommand(string Username, string Password, bool IsAdmin = false) : IRequest<Result<User>>;

public class CreateUserCommandHandler
{
    public Task<Result<User>> Handle(CreateUserCommand command, CancellationToken ct)
    {
        try
        {
            var username = Username.From(command.Username);
            var passwordHash = HashedPassword.From(command.Password);
            var user = new User(username, passwordHash, command.IsAdmin);
            return Task.FromResult(Result<User>.Success(user));
        }
        catch (Exception ex)
        {
            return Task.FromResult(Result<User>.Failure(ex.Message));
        }
    }
}
