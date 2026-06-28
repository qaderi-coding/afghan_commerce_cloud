using AfghanCommerceCloud.IdentityAccess.Application.Common;
using AfghanCommerceCloud.IdentityAccess.Infrastructure.Persistence;
using AfghanCommerceCloud.SharedKernel.Domain.Entities;
using Microsoft.EntityFrameworkCore;

namespace AfghanCommerceCloud.IdentityAccess.Infrastructure.Repositories;

public class EfCoreRepository<T> : IRepository<T> where T : class
{
    protected readonly AppDbContext _context;

    public EfCoreRepository(AppDbContext context)
    {
        _context = context;
    }

    public async Task<T?> GetByIdAsync(int id, CancellationToken ct = default)
    {
        return await _context.Set<T>().FindAsync([id], cancellationToken: ct);
    }

    public async Task<IReadOnlyList<T>> GetAllAsync(CancellationToken ct = default)
    {
        return await _context.Set<T>().AsNoTracking().ToListAsync(ct);
    }

    public async Task<T> AddAsync(T entity, CancellationToken ct = default)
    {
        await _context.Set<T>().AddAsync(entity, ct);
        await _context.SaveChangesAsync(ct);
        return entity;
    }

    public async Task UpdateAsync(T entity, CancellationToken ct = default)
    {
        _context.Set<T>().Update(entity);
        await _context.SaveChangesAsync(ct);
    }

    public async Task DeleteAsync(T entity, CancellationToken ct = default)
    {
        _context.Set<T>().Remove(entity);
        await _context.SaveChangesAsync(ct);
    }

    public async Task SoftDeleteAsync(T entity, CancellationToken ct = default)
    {
        if (entity is IAuditable auditable && entity is ISoftDeletable softDeletable)
        {
            softDeletable.DeletedAt = DateTimeOffset.UtcNow;
            auditable.UpdatedAt = DateTimeOffset.UtcNow;
            await UpdateAsync(entity, ct);
        }
        else
        {
            await DeleteAsync(entity, ct);
        }
    }
}
