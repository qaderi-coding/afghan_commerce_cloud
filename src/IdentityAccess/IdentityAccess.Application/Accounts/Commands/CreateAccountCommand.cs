namespace AfghanCommerceCloud.IdentityAccess.Application.Accounts.Commands;

using AfghanCommerceCloud.IdentityAccess.Application.Common;
using AfghanCommerceCloud.IdentityAccess.Domain.Entities;
using MediatR;

public record CreateAccountCommand(string Name, string Type, string? SubType = null) : IRequest<Account>;
