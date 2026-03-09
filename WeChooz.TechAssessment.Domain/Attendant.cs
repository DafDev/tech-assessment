namespace WeChooz.TechAssessment.Domain;

public class Attendant(Person person, TargetDemographic targetDemographic, string email = "", string companyName = "")
{
    public Person Person { get; set; } = person;
    public TargetDemographic TargetDemographic { get; set; } = targetDemographic;
    public string Email { get; set; } = email;
    public string CompanyName { get; set; } = companyName;
}