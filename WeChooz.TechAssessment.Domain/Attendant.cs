namespace WeChooz.TechAssessment.Domain;

public class Attendant(Person person, TargetDemographic targetDemographic)
{
    public Person Person { get; set; } = person;
    public TargetDemographic TargetDemographic { get; set; } = targetDemographic;
}