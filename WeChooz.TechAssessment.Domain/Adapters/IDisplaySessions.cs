namespace WeChooz.TechAssessment.Domain.Adapters;

public interface IDisplaySessions
{
    Task<IEnumerable<Session>> GetSessions(DateTimeOffset? from = null, DateTimeOffset? to = null, DeliveryMode? deliveryMode = null);
}