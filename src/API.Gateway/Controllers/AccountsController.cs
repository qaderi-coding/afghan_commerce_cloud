using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using AfghanCommerceCloud.IdentityAccess.Domain.Entities;
using AfghanCommerceCloud.IdentityAccess.Infrastructure.Persistence;

namespace AfghanCommerceCloud.API.Gateway.Controllers;

[ApiController]
[Route("api/[controller]")]
public class AccountsController : ControllerBase
{
    private readonly AppDbContext _db;

    public AccountsController(AppDbContext db)
    {
        _db = db;
    }

    [HttpGet]
    public async Task<ActionResult<IEnumerable<AccountDto>>> SearchAccounts(string? q, string? subType)
    {
        var query = _db.Accounts.AsNoTracking();
        
        if (!string.IsNullOrEmpty(q))
            query = query.Where(a => a.Name.Contains(q) || (a.Phone != null && a.Phone.Contains(q)));
        
        if (!string.IsNullOrEmpty(subType))
            query = query.Where(a => a.SubType == subType);
        
        var accounts = await query.Take(50).ToListAsync();
        
        var result = accounts.Select(a => new AccountDto(
            a.Id, a.Name, a.Type, a.SubType, a.Phone, a.Address, a.Code, a.IsSystem, a.MaxCreditSales));
        
        return Ok(result);
    }

    [HttpGet("{id:int}")]
    public async Task<ActionResult<AccountDto>> GetAccount(int id)
    {
        var account = await _db.Accounts.FindAsync(id);
        if (account == null) return NotFound();
        
        return Ok(new AccountDto(
            account.Id, account.Name, account.Type, account.SubType, account.Phone, account.Address, account.Code, account.IsSystem, account.MaxCreditSales));
    }

    [HttpPost]
    public async Task<ActionResult<AccountDto>> CreateAccount([FromBody] CreateAccountDto input)
    {
        var account = new Account
        {
            Date = DateTime.UtcNow.ToString("yyyy-MM-dd HH:mm:ss"),
            Name = input.Name,
            Type = input.Type,
            BalanceType = input.BalanceType,
            SubType = input.SubType,
            Phone = input.Phone,
            Address = input.Address,
            Code = input.Code,
            IsSystem = input.IsSystem,
            MaxCreditSales = input.MaxCreditSales,
            CreatedAt = DateTimeOffset.UtcNow,
            UpdatedAt = DateTimeOffset.UtcNow
        };

        _db.Accounts.Add(account);
        await _db.SaveChangesAsync();

        return CreatedAtAction(nameof(GetAccount), new { id = account.Id }, new AccountDto(
            account.Id, account.Name, account.Type, account.SubType, account.Phone, account.Address, account.Code, account.IsSystem, account.MaxCreditSales));
    }
}

public record AccountDto(int Id, string Name, string Type, string? SubType, string? Phone, string? Address, string? Code, bool IsSystem, decimal MaxCreditSales);
public record CreateAccountDto(string Name, string Type, string BalanceType, string? SubType, string? Phone, string? Address, string? Code, bool IsSystem = false, decimal MaxCreditSales = 0);