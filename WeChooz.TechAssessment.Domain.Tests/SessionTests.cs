namespace WeChooz.TechAssessment.Domain.Tests;

public class SessionTests
{
    private readonly Person _instructor = new Person("Jean", "Biche");
    [Fact]
    public void GivenSessionWithAvailableSeats_WhenAddingAttendant_ThenAttendantIsAdded()
    {
        // Arrange
        var course = new Course("Course Title", "Short Description", 5, 3, TargetDemographic.ElectedMember, _instructor);
        var session = new Session(course, new DateTimeOffset(new DateTime(2026, 3, 15)));
        var attendant = new Attendant(new Person("Jane", "Smith"), TargetDemographic.ElectedMember);

        // Act
        session.AddAttendant(attendant);

        // Assert
        Assert.Contains(attendant, session.Attendants);
    }

    [Fact]
    public void GivenSessionWithNoAvailableSeats_WhenAddingAttendant_ThenAttendantIsNotAdded()
    {
        // Arrange
        List<Attendant> initialAttendants = 
        [
            new Attendant(new Person("Jane", "Smith"), TargetDemographic.ElectedMember),
            new Attendant(new Person("John", "Doe"), TargetDemographic.ElectedMember)
        ];
        var course = new Course("Course Title", "Short Description", 5, 2, TargetDemographic.ElectedMember, _instructor);
        var session = new Session(course, new DateTimeOffset(new DateTime(2026, 3, 15)), initialAttendants);
        var attendantAlice = new Attendant(new Person("Alice", "Johnson"), TargetDemographic.ElectedMember);

        // Act
        session.AddAttendant(attendantAlice);

        // Assert
        Assert.DoesNotContain(attendantAlice, session.Attendants);
    }
}
