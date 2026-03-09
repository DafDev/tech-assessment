namespace WeChooz.TechAssessment.Domain;

public class Course(string title, string shortDescription, int durationInDays, int maxParticipants, TargetDemographic targetDemographic, Person instructor)
{
    public string Title { get; set; } = title;
    public string ShortDescription { get; set; } = shortDescription;
    public int DurationInDays { get; set; } = durationInDays;
    public int MaxParticipants { get; set; } = maxParticipants;
    public TargetDemographic TargetDemographic { get; set; } = targetDemographic;
    public Person Instructor { get; set; } = instructor;
}