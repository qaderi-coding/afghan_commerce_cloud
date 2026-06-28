namespace AfghanCommerceCloud.IdentityAccess.Application.Users.Commands;

using AfghanCommerceCloud.IdentityAccess.Application.Users.DTOs;
using AfghanCommerceCloud.IdentityAccess.Application.Common;
using AfghanCommerceCloud.IdentityAccess.Domain.Entities;
using AfghanCommerceCloud.IdentityAccess.Domain.ValueObjects;
using MediatR;

public class LoginCommandHandler : IRequestHandler<LoginCommand, LoginResponseDto>
{
    private readonly IRepository<User> _userRepository;

    public LoginCommandHandler(IRepository<User> userRepository)
    {
        _userRepository = userRepository;
    }

    public async Task<LoginResponseDto> Handle(LoginCommand request, CancellationToken ct)
    {
        var username = Username.From(request.Username);
        var users = (await _userRepository.GetAllAsync(ct)).ToList();
        var user = users.FirstOrDefault(u => u.Username.Value == username.Value && u.IsActive);
        if (user == null) throw new UnauthorizedAccessException("Invalid credentials");

        var passwordHash = HashedPassword.From(request.Password);
        if (!user.PasswordHash.Verify(request.Password))
            throw new UnauthorizedAccessException("Invalid credentials");

        var token = Convert.ToBase64String(System.Text.Encoding.UTF8.GetBytes($"{user.Id}:{DateTimeOffset.UtcNow.ToUnixTimeSeconds()}"));
        return new LoginResponseDto(user.Id, user.Username.Value, user.IsAdmin, token, DateTimeOffset.UtcNow.AddHours(1));
    }
}
