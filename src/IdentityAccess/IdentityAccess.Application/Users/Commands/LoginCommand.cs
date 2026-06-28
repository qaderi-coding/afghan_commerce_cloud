namespace AfghanCommerceCloud.IdentityAccess.Application.Users.Commands;

using AfghanCommerceCloud.IdentityAccess.Application.Users.DTOs;
using AfghanCommerceCloud.IdentityAccess.Application.Common;
using AfghanCommerceCloud.IdentityAccess.Domain.Entities;
using AfghanCommerceCloud.IdentityAccess.Domain.ValueObjects;
using MediatR;

public record LoginCommand(string Username, string Password) : IRequest<LoginResponseDto>;
