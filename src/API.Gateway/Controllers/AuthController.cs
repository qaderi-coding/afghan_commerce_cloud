using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using AfghanCommerceCloud.IdentityAccess.Domain.Entities;
using AfghanCommerceCloud.IdentityAccess.Domain.ValueObjects;
using AfghanCommerceCloud.IdentityAccess.Infrastructure.Identity;
using AfghanCommerceCloud.IdentityAccess.Infrastructure.Persistence;

namespace AfghanCommerceCloud.API.Gateway.Controllers;

[ApiController]
[Route("api/[controller]")]
public class AuthController : ControllerBase
{
    private readonly AppDbContext _db;
    private readonly JwtTokenGenerator _tokenGenerator;

    public AuthController(AppDbContext db, JwtTokenGenerator tokenGenerator)
    {
        _db = db;
        _tokenGenerator = tokenGenerator;
    }

    [HttpPost("login")]
    public async Task<ActionResult<LoginResponseDto>> Login([FromBody] LoginRequestDto request)
    {
        var user = await _db.Users.FirstOrDefaultAsync(u => u.Username.Value == request.Username && u.IsActive);
        if (user == null) return Unauthorized(new { message = "Invalid credentials" });

        if (!user.PasswordHash.Verify(request.Password))
            return Unauthorized(new { message = "Invalid credentials" });

        var token = _tokenGenerator.GenerateToken(user);
        return Ok(new LoginResponseDto(
            UserId: user.Id,
            Username: user.Username.Value,
            IsAdmin: user.IsAdmin,
            Token: token,
            ExpiresAt: DateTimeOffset.UtcNow.AddHours(1)
        ));
    }

    [HttpPost("register")]
    public async Task<ActionResult<UserResponseDto>> Register([FromBody] RegisterRequestDto request)
    {
        var exists = await _db.Users.AnyAsync(u => u.Username.Value == request.Username);
        if (exists) return BadRequest(new { message = "Username already exists" });

        var user = new User(
            Username.From(request.Username),
            HashedPassword.From(request.Password),
            request.IsAdmin
        );

        _db.Users.Add(user);
        await _db.SaveChangesAsync();

        return Ok(new UserResponseDto(Id: user.Id, Username: user.Username.Value, IsAdmin: user.IsAdmin));
    }
}

public record LoginRequestDto(string Username, string Password);
public record LoginResponseDto(int UserId, string Username, bool IsAdmin, string Token, DateTimeOffset ExpiresAt);
public record RegisterRequestDto(string Username, string Password, bool IsAdmin = false);
public record UserResponseDto(int Id, string Username, bool IsAdmin);