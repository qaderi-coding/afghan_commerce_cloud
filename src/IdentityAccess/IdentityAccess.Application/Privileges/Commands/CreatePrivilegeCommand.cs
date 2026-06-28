namespace AfghanCommerceCloud.IdentityAccess.Application.Privileges.Commands;

using AfghanCommerceCloud.IdentityAccess.Application.Common;
using AfghanCommerceCloud.IdentityAccess.Domain.Entities;
using MediatR;

public record CreatePrivilegeCommand(string Name, string RulesJson) : IRequest<Privilege>;

public class CreatePrivilegeCommandHandler : IRequestHandler<CreatePrivilegeCommand, Privilege>
{
    private readonly IRepository<Privilege> _repository;

    public CreatePrivilegeCommandHandler(IRepository<Privilege> repository)
    {
        _repository = repository;
    }

    public async Task<Privilege> Handle(CreatePrivilegeCommand request, CancellationToken cancellationToken)
    {
        var privilege = new Privilege(request.Name, request.RulesJson);
        await _repository.AddAsync(privilege, cancellationToken);
        return privilege;
    }
}
