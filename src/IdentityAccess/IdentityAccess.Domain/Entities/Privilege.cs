using AfghanCommerceCloud.SharedKernel.Domain.Entities;

namespace AfghanCommerceCloud.IdentityAccess.Domain.Entities;

public class Privilege : BaseEntity
{
    public string Name { get; private set; } = string.Empty;
    public string RulesJson { get; private set; } = string.Empty;
    public DateTime Date { get; private set; } = DateTime.UtcNow;

    private Privilege() { }

    public Privilege(string name, string rulesJson)
    {
        Name = name;
        RulesJson = rulesJson;
        Date = DateTime.UtcNow;
    }
}
