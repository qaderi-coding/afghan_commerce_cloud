namespace AfghanCommerceCloud.IdentityAccess.Application.Users.DTOs;

public record LoginResponseDto(int UserId, string Username, bool IsAdmin, string AccessToken, DateTimeOffset ExpiresAt);
