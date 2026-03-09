namespace WeChooz.TechAssessment.Domain.Tests;

public class SessionTests
{
    [Theory]
    [ClassData(typeof(SessionTestsData))]
    public void GivenSession_WhenAddingAttendant_ShouldReturnExpected(Session session, Attendant attendant, bool expected)
    {
        // Act
        var actual = session.AddAttendant(attendant);

        // Assert
        Assert.Equal(expected, actual);
    }
}
