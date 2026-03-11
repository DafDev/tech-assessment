using Microsoft.EntityFrameworkCore;
using WeChooz.TechAssessment.Domain;

namespace WeChooz.TechAssessment.Infra;
public class SessionContext : DbContext
{
    public SessionContext(DbContextOptions<SessionContext> options) : base(options)
    {
    }

    public DbSet<Session> Sessions { get; set; }
    public DbSet<Course> Courses { get; set; }
    public DbSet<Attendant> Attendants { get; set; }
}