namespace WeChooz.TechAssessment.Domain;
public class Session(Course course, DateTimeOffset startDate, IEnumerable<Attendant>? attendants = null)
{
    public Course Course { get; set; } = course;
    public DateTimeOffset StartDate { get; set; } = startDate;
    public IEnumerable<Attendant> Attendants { get; set; } = attendants ?? [];

    public int AvailableSeats => Course.MaxParticipants - Attendants.Count();

    public bool IsFull => AvailableSeats <= 0;

    public bool AddAttendant(Attendant attendant)
    {
        if (IsFull)
            return false;

        Attendants = Attendants.Append(attendant);
        return true;
    }

}