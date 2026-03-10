namespace WeChooz.TechAssessment.Domain;

public class Course(string title, string shortDescription, string longDescription, int durationInDays, int maxParticipants, TargetDemographic targetDemographic, Person instructor, Guid? id = null)
{
    public string Title { get; set; } = title;
    public string ShortDescription { get; set; } = shortDescription;
    public string LongDescription { get; set; } = longDescription;
    public int DurationInDays { get; set; } = durationInDays;
    public int MaxParticipants { get; set; } = maxParticipants;
    public TargetDemographic TargetDemographic { get; set; } = targetDemographic;
    public Person Instructor { get; set; } = instructor;
    public readonly Guid Id = id ?? Guid.NewGuid();
}