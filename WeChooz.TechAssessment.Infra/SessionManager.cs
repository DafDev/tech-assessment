using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Conventions;
using Microsoft.Extensions.Logging;
using WeChooz.TechAssessment.Domain;
using WeChooz.TechAssessment.Domain.Adapters;
namespace WeChooz.TechAssessment.Infra;

public class SessionManager(SessionContext context, ILogger<SessionManager> logger) : IManageSessions
{

    public async Task<Guid> CreateOrUpdateCourse(Course course)
    {
        logger.LogInformation("Creating or updating course with id {CourseId}", course.Id);
        context.Courses.Update(course);
        await context.SaveChangesAsync();
        return course.Id;
    }

    public async Task<Guid> CreateOrUpdateSession(Session session)
    {
        logger.LogInformation("Creating or updating session with id {SessionId}", session.Id);
        context.Sessions.Update(session);
        await context.SaveChangesAsync();
        return session.Id;
    }

    public async Task<bool> DeleteSession(Session session)
    {
        logger.LogInformation("Deleting session with id {SessionId}", session.Id);
        var deleted = context.Sessions.Remove(session);
        await context.SaveChangesAsync();
        
        if(deleted is not null) logger.LogInformation("Deleted session with id {SessionId}", session.Id);
        else logger.LogWarning("Failed to delete session with id {SessionId}", session.Id);
        
        return deleted is not null;
    }

    public Task<Course> GetCourseById(Guid courseId)
    {
        throw new NotImplementedException();
    }

    public Task<Course> GetCourseByName(string courseName)
    {
        throw new NotImplementedException();
    }

    public async Task<Session> GetSessionById(Guid sessionId)
     => await context.Sessions
        .AsNoTracking()
        .Include(session => session.Course)
        .Include(session => session.Attendants)
        .FirstOrDefaultAsync(session => session.Id == sessionId)
        ?? throw new Exception($"Session with id {sessionId} not found");

    public async Task<IEnumerable<Session>> GetSessions() => await context.Sessions
            .AsNoTracking()
            .Include(session => session.Course)
            .Include(session => session.Attendants)
            .ToListAsync();
}
