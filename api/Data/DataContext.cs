using api.Data.Constants;
using api.Data.Entities;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace api.Data;

/// <summary>
/// Data context
/// </summary>
public partial class DataContext : IdentityDbContext<User, Role, Guid>
{
    /// <summary>
    /// Constructor
    /// </summary>
    /// <param name="options"></param>
    public DataContext(DbContextOptions<DataContext> options) : base(options)
    {

    }

    /// <summary>
    /// User
    /// </summary>
    public virtual DbSet<User> User { get; set; }

    /// <summary>
    /// Role
    /// </summary>
    public virtual DbSet<User> Role { get; set; }

    /// <summary>
    /// On model creating
    /// </summary>
    /// <param name="builder"></param>
    protected override void OnModelCreating(ModelBuilder builder)
    {
        base.OnModelCreating(builder);
        builder.Entity<IdentityUserRole<Guid>>().HasKey(p => new { p.UserId, p.RoleId });

        OnModelCreatingPartial(builder);
    }

    partial void OnModelCreatingPartial(ModelBuilder builder);
}
