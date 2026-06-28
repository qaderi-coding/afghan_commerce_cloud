namespace AfghanCommerceCloud.IdentityAccess.Application.Accounts.Queries;

using AfghanCommerceCloud.IdentityAccess.Application.Common;
using AfghanCommerceCloud.IdentityAccess.Domain.Entities;
using MediatR;

public record SearchAccountsQuery(string? Q, string? SubType) : IRequest<IReadOnlyList<Account>>;
