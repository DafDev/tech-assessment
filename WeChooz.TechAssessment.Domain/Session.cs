namespace WeChooz.TechAssessment.Domain;
public class Session(Course course, DateTimeOffset startDate, DeliveryMode deliveryMode, IEnumerable<Attendant>? attendants = null, Guid? id = null)
{
    protected Session() : this(null!, default, default) { }

    public Guid Id { get; private set; } = id ?? Guid.NewGuid();

    public Course Course { get; set; } = course;
    public DateTimeOffset StartDate { get; set; } = startDate;
    public DeliveryMode DeliveryMode { get; set; } = deliveryMode;
    public List<Attendant> Attendants { get; set; } = attendants?.ToList() ?? [];

    public int AvailableSeats => Course.MaxParticipants - Attendants.Count();

    public bool IsFull => AvailableSeats <= 0;

    public bool AddAttendant(Attendant attendant)
    {
        if (IsAttendantNotAllowed(attendant)) return false;

        Attendants.Add(attendant);
        return true;
    }

    private bool IsAttendantNotAllowed(Attendant attendant)
    {
        if (Attendants.Contains(attendant)) return true;

        if (IsFull
            || attendant.TargetDemographic is TargetDemographic.ElectedMember && Course.TargetDemographic is TargetDemographic.President  
        )
            return true;

        return false;
    }
}