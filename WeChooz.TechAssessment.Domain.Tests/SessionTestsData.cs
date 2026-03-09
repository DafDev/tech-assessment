namespace WeChooz.TechAssessment.Domain.Tests;

public class SessionTestsData : TheoryData<Session, Attendant, bool>
{
    public SessionTestsData()
    {
        var durationInDays = 5;
        var courseWithAvailableSeats = new Course("Basics of Rock", "Short Description", durationInDays, 3, TargetDemographic.ElectedMember, new Person("Chuck", "Berry"));
        var courseWithNoAvailableSeats = new Course("Elvis was a fraud (kinda)", "I mean...", durationInDays, 2, TargetDemographic.ElectedMember, new Person("Little", "Richard"));
        var courseForEveryoneAddPresident = new Course("How to sing beautifully", "Bring me to life", durationInDays, 5, TargetDemographic.ElectedMember, new Person("Amy", "Lee"));
        var courseForPresidentAddPresident = new Course("How to scream like a demon", "Demonic growl", durationInDays, 5, TargetDemographic.President, new Person("Ryo", "Kinoshita"));
        var courseForPresidentAddElectedMember = new Course("How to scream like a possessed person", "Demonic growl", durationInDays, 5, TargetDemographic.President, new Person("Corey", "Taylor"));
        var courseWithAttendantAlreadyIInIt = new Course("Metal can be fun", "It's not all doom and gloom", durationInDays, 5, TargetDemographic.ElectedMember, new Person("Kevin", "Ratajczak"));
        var date = new DateTimeOffset(new DateTime(2026, 3, 15));

        Add(
            new Session(courseWithAvailableSeats, date, DeliveryMode.OnSite),
            new Attendant(new Person("Josh", "Homme"), TargetDemographic.ElectedMember),
            true
        );
        Add(
            new Session(courseWithNoAvailableSeats, date, DeliveryMode.Remote,
            [
                new Attendant(new Person("Dave", "Grohl"), TargetDemographic.ElectedMember),
                new Attendant(new Person("Ronny", "Radke"), TargetDemographic.ElectedMember)
            ]),
            new Attendant(new Person("Kurt", "Cobain"), TargetDemographic.ElectedMember),
            false
        );
        Add(
            new Session(courseForEveryoneAddPresident, date, DeliveryMode.OnSite),
            new Attendant(new Person("Oli", "Sykes"), TargetDemographic.President),
            true
        );
        Add(
            new Session(courseForPresidentAddPresident, date, DeliveryMode.OnSite),
            new Attendant(new Person("Marylin", "Manson"), TargetDemographic.President),
            true
        );
        Add(
            new Session(courseForPresidentAddElectedMember, date, DeliveryMode.OnSite),
            new Attendant(new Person("Ariana", "Grande"), TargetDemographic.ElectedMember),
            false
        );
        Add(
            new Session(courseWithAttendantAlreadyIInIt, date, DeliveryMode.OnSite,
            [
                new Attendant(new Person("Ariana", "Grande"), TargetDemographic.ElectedMember, "ariana.grande@singer.com", "Republic Records")
            ]),
            new Attendant(new Person("Ariana", "Grande"), TargetDemographic.ElectedMember, "ariana.grande@singer.com", "Republic Records"),
            false
        );
    }
}
