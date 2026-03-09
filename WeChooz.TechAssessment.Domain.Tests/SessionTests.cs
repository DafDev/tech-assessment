namespace WeChooz.TechAssessment.Domain.Tests;

public class SessionTests
{
    [Fact]
    public void GivenSessionWithAvailableSeats_WhenAddingAttendant_ThenAttendantIsAdded()
    {
        // Arrange
        var course = new Course("Course Title", "Short Description", 5, 3, TargetDemographic.ElectedMember, new Person("John", "Doe"));
        var session = new Session(course, new DateTimeOffset(2026, 3, 15));
        var attendant = new Attendant(new Person("Jane", "Smith"), TargetDemographic.ElectedMember);

        // Act
        session.AddAttendant(attendant);

        // Assert
        Assert.Contains(attendant, session.Attendants);
    }
}
