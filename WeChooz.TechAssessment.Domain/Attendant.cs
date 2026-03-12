namespace WeChooz.TechAssessment.Domain;

public class Attendant(Person person, TargetDemographic targetDemographic, string email = "", string companyName = "", Guid? id = null) : IEquatable<Attendant>
{
    protected Attendant() : this(new Person("", ""), default) { }

    public Guid Id { get; private set; } = id ?? Guid.NewGuid();
    public Person Person { get; set; } = person;
    public TargetDemographic TargetDemographic { get; set; } = targetDemographic;
    public string Email { get; set; } = email;
    public string CompanyName { get; set; } = companyName;

    public bool Equals(Attendant? other)
        => other is not null 
        && Person == other.Person
        && TargetDemographic == other.TargetDemographic
        && Email == other.Email
        && CompanyName == other.CompanyName;

    public override bool Equals(object? obj) => Equals(obj as Attendant);
    public override int GetHashCode() => HashCode.Combine(Person, TargetDemographic, Email, CompanyName);
    public static bool operator ==(Attendant? left, Attendant? right) => Equals(left, right);
    public static bool operator !=(Attendant? left, Attendant? right) => !Equals(left, right);
    
}