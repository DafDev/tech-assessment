-- TargetDemographic: ElectedMember = 0, President = 1
-- DeliveryMode:      OnSite = 0, Remote = 1

-- =====================
-- Courses
-- =====================
MERGE [dbo].[courses] AS target
USING (VALUES
    ('a1000000-0000-0000-0000-000000000001', 'Basics of Rock',                       'Short Description',               'A comprehensive introduction to rock music fundamentals',              5, 3, 0, 'Chuck Berry'),
    ('a1000000-0000-0000-0000-000000000002', 'Elvis was a fraud (kinda)',             'I mean...',                       'In fairness, he did popularize rock and roll for mainstream audiences', 5, 2, 0, 'Little Richard'),
    ('a1000000-0000-0000-0000-000000000003', 'How to sing beautifully',               'Bring me to life',                'A deep dive into vocal techniques for all skill levels',                5, 5, 0, 'Amy Lee'),
    ('a1000000-0000-0000-0000-000000000004', 'How to scream like a demon',            'Demonic growl',                   'Advanced extreme vocal techniques reserved for presidents',             5, 5, 1, 'Ryo Kinoshita'),
    ('a1000000-0000-0000-0000-000000000005', 'How to scream like a possessed person', 'Demonic growl',                   'Mastering the art of extreme vocals exclusively for presidents',        5, 5, 1, 'Corey Taylor'),
    ('a1000000-0000-0000-0000-000000000006', 'Metal can be fun',                      'It''s not all doom and gloom',    'Exploring the lighter and more accessible side of heavy metal',         5, 5, 0, 'Kevin Ratajczak')
) AS source ([Id], [Title], [ShortDescription], [LongDescription], [DurationInDays], [MaxParticipants], [TargetDemographic], [Instructor])
ON target.[Id] = source.[Id]
WHEN NOT MATCHED THEN
    INSERT ([Id], [Title], [ShortDescription], [LongDescription], [DurationInDays], [MaxParticipants], [TargetDemographic], [Instructor])
    VALUES (source.[Id], source.[Title], source.[ShortDescription], source.[LongDescription], source.[DurationInDays], source.[MaxParticipants], source.[TargetDemographic], source.[Instructor]);
GO

-- =====================
-- Sessions (all on 2026-03-15)
-- =====================
MERGE [dbo].[sessions] AS target
USING (VALUES
    ('b1000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000001', '2026-03-15T00:00:00+00:00', 0),  -- courseWithAvailableSeats        | OnSite
    ('b1000000-0000-0000-0000-000000000002', 'a1000000-0000-0000-0000-000000000002', '2026-03-15T00:00:00+00:00', 1),  -- courseWithNoAvailableSeats       | Remote
    ('b1000000-0000-0000-0000-000000000003', 'a1000000-0000-0000-0000-000000000003', '2026-03-15T00:00:00+00:00', 0),  -- courseForEveryoneAddPresident    | OnSite
    ('b1000000-0000-0000-0000-000000000004', 'a1000000-0000-0000-0000-000000000004', '2026-03-15T00:00:00+00:00', 0),  -- courseForPresidentAddPresident   | OnSite
    ('b1000000-0000-0000-0000-000000000005', 'a1000000-0000-0000-0000-000000000005', '2026-03-15T00:00:00+00:00', 0),  -- courseForPresidentAddElectedMember | OnSite
    ('b1000000-0000-0000-0000-000000000006', 'a1000000-0000-0000-0000-000000000006', '2026-03-15T00:00:00+00:00', 0)   -- courseWithAttendantAlreadyInIt   | OnSite
) AS source ([Id], [CourseId], [StartDate], [DeliveryMode])
ON target.[Id] = source.[Id]
WHEN NOT MATCHED THEN
    INSERT ([Id], [CourseId], [StartDate], [DeliveryMode])
    VALUES (source.[Id], source.[CourseId], source.[StartDate], source.[DeliveryMode]);
GO

-- =====================
-- Attendants
-- =====================
MERGE [dbo].[attendants] AS target
USING (VALUES
    ('c1000000-0000-0000-0000-000000000001', 'Dave Grohl',    '',                            '',                  0),
    ('c1000000-0000-0000-0000-000000000002', 'Ronny Radke',   '',                            '',                  0),
    ('c1000000-0000-0000-0000-000000000003', 'Ariana Grande', 'ariana.grande@singer.com',    'Republic Records',  0)
) AS source ([Id], [Person], [Email], [CompanyName], [TargetDemographic])
ON target.[Id] = source.[Id]
WHEN NOT MATCHED THEN
    INSERT ([Id], [Person], [Email], [CompanyName], [TargetDemographic])
    VALUES (source.[Id], source.[Person], source.[Email], source.[CompanyName], source.[TargetDemographic]);
GO

-- =====================
-- Sessions <-> Attendants
-- =====================
MERGE [dbo].[sessions_attendants] AS target
USING (VALUES

    ('b1000000-0000-0000-0000-000000000002', 'c1000000-0000-0000-0000-000000000001'),
    ('b1000000-0000-0000-0000-000000000002', 'c1000000-0000-0000-0000-000000000002'),
    ('b1000000-0000-0000-0000-000000000006', 'c1000000-0000-0000-0000-000000000003')
) AS source ([SessionId], [AttendantId])
ON target.[SessionId] = source.[SessionId] AND target.[AttendantId] = source.[AttendantId]
WHEN NOT MATCHED THEN
    INSERT ([SessionId], [AttendantId])
    VALUES (source.[SessionId], source.[AttendantId]);
