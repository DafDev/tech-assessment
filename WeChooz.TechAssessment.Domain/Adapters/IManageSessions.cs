namespace WeChooz.TechAssessment.Domain.Adapters;

public interface IManageSessions
{
    Task<IEnumerable<Session>> GetSessions();
    Task<Guid> CreateOrUpdateSession(Session session);
    Task<bool> DeleteSession(Session session);
    Task<Session> GetSessionById(Guid sessionId);
    // Task<Guid> CreateOrUpdateAttendant(Attendant attendant);
    // Task<bool> DeleteAttendant(Attendant attendant);
    // Task<Attendant> GetAttendantById(Guid attendantId);
    Task<Course> GetCourseById(Guid courseId);
    Task<Course> GetCourseByName(string courseName);
    Task<Guid> CreateOrUpdateCourse(Course course);
}
