using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using HotChocolate;
using HotChocolate.AspNetCore;
using AfghanCommerceCloud.IdentityAccess.Application.Users.DTOs;
using AfghanCommerceCloud.IdentityAccess.Infrastructure.Persistence;
using AfghanCommerceCloud.IdentityAccess.Domain.Entities;
using AfghanCommerceCloud.IdentityAccess.Domain.ValueObjects;
using System.Security.Cryptography;
using System.Text;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddDbContext<AppDbContext>(options =>
    options.UseMySql(
        builder.Configuration.GetConnectionString("DefaultConnection") ?? "Server=localhost;Port=3306;Database=afghan_commerce;User=admin;Password=adminpass;",
        new MySqlServerVersion(new Version(8, 0, 0))
    )
);

builder.Services
    .AddGraphQLServer()
    .AddQueryType<Query>()
    .AddMutationType<Mutation>();

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseDeveloperExceptionPage();
}

app.MapGet("/health", () => "Afghan Commerce Cloud API Gateway is running");

app.MapGraphQL();

app.Run();

public class Query
{
    public async Task<User?> Login([Service] AppDbContext db, string username, string password)
    {
        var user = await db.Users.FirstOrDefaultAsync(u => u.Username == username && u.IsActive);
        if (user == null) return null;
        
        var hash = Convert.ToBase64String(SHA256.HashData(Encoding.UTF8.GetBytes(password)));
        return user;
    }

    public async Task<IEnumerable<Account>> SearchAccounts([Service] AppDbContext db, string? q, string? subType)
    {
        var query = db.Accounts.AsNoTracking();
        if (!string.IsNullOrEmpty(q))
            query = query.Where(a => a.Name.Contains(q) || (a.Phone != null && a.Phone.Contains(q)));
        if (!string.IsNullOrEmpty(subType))
            query = query.Where(a => a.SubType == subType);
        return await query.Take(50).ToListAsync();
    }

    public async Task<Account?> Account([Service] AppDbContext db, int id)
    {
        return await db.Accounts.FindAsync(id);
    }
}

public class Mutation
{
    public async Task<User> Register([Service] AppDbContext db, string username, string password, bool isAdmin = false)
    {
        var passwordHash = Convert.ToBase64String(SHA256.HashData(Encoding.UTF8.GetBytes(password)));
        var user = new User(
            Username.From(username),
            HashedPassword.FromHash(passwordHash),
            isAdmin
        );
        db.Users.Add(user);
        await db.SaveChangesAsync();
        return user;
    }

    public async Task<Account> CreateAccount([Service] AppDbContext db, Account input)
    {
        input.Date = DateTime.UtcNow.ToString("yyyy-MM-dd HH:mm:ss");
        input.CreatedAt = DateTimeOffset.UtcNow;
        input.UpdatedAt = DateTimeOffset.UtcNow;
        db.Accounts.Add(input);
        await db.SaveChangesAsync();
        return input;
    }
}