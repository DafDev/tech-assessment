using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using WeChooz.TechAssessment.Domain;

namespace WeChooz.TechAssessment.Infra;
public class SessionContext : DbContext
{
    public SessionContext(DbContextOptions<SessionContext> options) : base(options)
    {
    }

    public DbSet<Session> Sessions { get; set; } = null!;
    public DbSet<Course> Courses { get; set; } = null!;
    public DbSet<Attendant> Attendants { get; set; } = null!;

    // Person is a value object — stored as a single string column in the DB.
    private static string PersonToString(Person p) => p.ToString();
    private static Person PersonFromString(string s)
    {
        var idx = s.IndexOf(' ');
        return idx < 0
            ? new Person(s, string.Empty)
            : new Person(s.Substring(0, idx), s.Substring(idx + 1));
    }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        var personConverter = new ValueConverter<Person, string>(
            p => PersonToString(p),
            s => PersonFromString(s)
        );

        modelBuilder.Entity<Course>(b =>
        {
            b.ToTable("courses");
            b.HasKey(c => c.Id);
            b.Property(c => c.Id).HasConversion<string>().HasColumnName("Id");
            b.Property(c => c.Instructor)
             .HasColumnName("Instructor")
             .HasConversion(personConverter);
        });

        modelBuilder.Entity<Attendant>(b =>
        {
            b.ToTable("attendants");
            b.HasKey(a => a.Id);
            b.Property(a => a.Id).HasConversion<string>().HasColumnName("Id");
            b.Property(a => a.Person)
             .HasColumnName("Person")
             .HasConversion(personConverter);
        });

        modelBuilder.Entity<Session>(b =>
        {
            b.ToTable("sessions");
            b.HasKey(s => s.Id);
            b.Property(s => s.Id).HasConversion<string>().HasColumnName("Id");
            b.HasOne(s => s.Course).WithMany().HasForeignKey("CourseId");
            b.HasMany(s => s.Attendants).WithMany()
             .UsingEntity("sessions_attendants",
                 l => l.HasOne(typeof(Attendant)).WithMany().HasForeignKey("AttendantId").HasPrincipalKey("Id"),
                 r => r.HasOne(typeof(Session)).WithMany().HasForeignKey("SessionId").HasPrincipalKey("Id"));
        });
    }
}