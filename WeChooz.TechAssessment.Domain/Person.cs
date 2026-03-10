namespace WeChooz.TechAssessment.Domain;
public record Person(string FirstName, string LastName)
{
    public override string ToString() => $"{FirstName} {LastName}";
}