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
GO

-- =====================
-- New Courses: Rock additions
-- =====================
MERGE [dbo].[courses] AS target
USING (VALUES
    ('a1000000-0000-0000-0000-000000000007', 'How to Be a Proper Emo with Gerard Way',          'Black parade not included',                   'See full description', 3, 5, 0, 'Gerard Way'),
    ('a1000000-0000-0000-0000-000000000008', 'Acoustic to Electric: The Rock Guitar Metamorphosis', 'Your fingers will hurt. Your soul will sing.', 'See full description', 4, 4, 0, 'Jack White')
) AS source ([Id], [Title], [ShortDescription], [LongDescription], [DurationInDays], [MaxParticipants], [TargetDemographic], [Instructor])
ON target.[Id] = source.[Id]
WHEN NOT MATCHED THEN
    INSERT ([Id], [Title], [ShortDescription], [LongDescription], [DurationInDays], [MaxParticipants], [TargetDemographic], [Instructor])
    VALUES (source.[Id], source.[Title], source.[ShortDescription], source.[LongDescription], source.[DurationInDays], source.[MaxParticipants], source.[TargetDemographic], source.[Instructor]);
GO

-- =====================
-- New Sessions (varied dates for date-filter testing)
-- =====================
MERGE [dbo].[sessions] AS target
USING (VALUES
    ('b1000000-0000-0000-0000-000000000007', 'a1000000-0000-0000-0000-000000000007', '2026-04-15T00:00:00+00:00', 0),
    ('b1000000-0000-0000-0000-000000000008', 'a1000000-0000-0000-0000-000000000008', '2026-07-01T00:00:00+00:00', 0)
) AS source ([Id], [CourseId], [StartDate], [DeliveryMode])
ON target.[Id] = source.[Id]
WHEN NOT MATCHED THEN
    INSERT ([Id], [CourseId], [StartDate], [DeliveryMode])
    VALUES (source.[Id], source.[CourseId], source.[StartDate], source.[DeliveryMode]);
GO

-- ============================================================
-- Full markdown long descriptions (update all 8 courses)
-- ============================================================

UPDATE [dbo].[courses]
SET [LongDescription] = N'## Basics of Rock

Rock music erupted from a collision of American blues, country, and electrified ambition in post-war America. This formation provides a foundational framework for everyone who wants to understand the genre at depth.

## Song Structure

Verse, chorus, bridge: three simple words that contain multitudes. We explore how tension between sections creates the emotional arc of a rock song, and why certain structural choices have proven timeless across decades.

## Instrumentation

Electric guitar, bass, drums, and vocals form the classic lineup. You will discover what each instrument contributes, how they interact, and why a great rhythm section is the foundation everything else is built upon.

## The Science of a Riff

What makes *Smoke on the Water* instantly recognizable? Why does the opening of *Whole Lotta Love* feel like a physical force? We break down the theory behind rock''s most immortal moments in plain, accessible language.

## Cultural Roots

Rock cannot be separated from its era. From the sexual liberation of the 1960s to punk''s fury in the 1970s, from stadium excess in the 1980s to grunge''s raw honesty in the 1990s, each generation reinvented the form in response to its world.

## Who Should Attend

This course requires no musical background. It is designed for curious listeners who want a structured framework for understanding what moves them, and for aspiring musicians who want context for the tradition they are joining.

By the end of this formation, you will hear every rock song differently: the decision-making, the craft, and the history embedded in every note and silence.'
WHERE [Id] = 'a1000000-0000-0000-0000-000000000001';
GO

UPDATE [dbo].[courses]
SET [LongDescription] = N'## Elvis Was a Fraud (Kinda)

Few figures in rock history provoke stronger reactions than Elvis Presley. To some, he was the King who invented rock and roll. To others, he was a white performer who appropriated Black music and achieved mainstream fame while the originators — Little Richard, Chuck Berry, Fats Domino — remained in relative obscurity.

The truth, as always, is more complicated.

## The Theft Argument

We confront the documented history honestly: Elvis recorded songs by Black artists, major labels marketed them to white audiences who would never have heard the originals, and financial rewards were deeply unequal. This is historical fact, not editorial opinion.

## The Defense (Such As It Is)

Elvis genuinely loved the music. He was deeply influenced by Black gospel and rhythm and blues from childhood. He did not design the system that exploited him and the artists he admired. And he introduced millions of young white Americans to the sonic vocabulary of Black America.

## Little Richard''s Own Words

Interestingly, Little Richard''s statements about Elvis were mixed across the decades. He was justifiably angry, but also, at moments, generous. We examine this relationship through primary sources and let participants draw their own conclusions.

## What It Means Today

Cultural appropriation in music remains deeply contentious. From Led Zeppelin to Eminem, the same dynamics recur in different forms. Understanding the Elvis debate gives you tools to think about these questions with more clarity and less heat.

## The Verdict

There is no clean answer here. Elvis was simultaneously a barrier-breaker and a beneficiary of a racist system. You will leave this formation with a more nuanced understanding of both the man and the machinery that made him.'
WHERE [Id] = 'a1000000-0000-0000-0000-000000000002';
GO

UPDATE [dbo].[courses]
SET [LongDescription] = N'## How to Sing Beautifully

A voice is the most intimate instrument. Unlike a guitar, which you can set down at the end of a session, your voice travels with you everywhere. This formation, taught in the spirit of Amy Lee''s extraordinary vocal legacy, treats the instrument with the respect and care it deserves.

## The Physical Foundation

Singing beautifully begins before you open your mouth. Posture, breath support, and core engagement determine whether your voice soars or strains. We cover:

- **Diaphragmatic breathing**: The difference between chest breathing and diaphragmatic breathing is the difference between a small voice and a commanding one
- **Resonance chambers**: Your chest, throat, and head each amplify different frequencies. Directing sound deliberately unlocks your full range
- **Warm-up routines**: The exercises professional vocalists use to protect and prepare their instrument

## Emotional Truth in Singing

Amy Lee did not become one of rock''s most distinctive voices through technique alone. Her power comes from emotional commitment to every phrase. We study how to access genuine feeling without losing control, and how vulnerability becomes strength when channeled with intention.

## Vocal Styles in Rock

From Ann Wilson''s crystalline clarity to Janis Joplin''s raw grain, rock accommodates an enormous range of vocal approaches. You will explore different stylistic traditions and identify which resonates most with your own voice.

## Care and Longevity

A damaged voice takes time to heal. We cover hydration, rest, the habits that harm vocal folds, and how to sing safely at high volume — because in rock, there will always be volume.

By the end of this formation, you will have practical, tested tools to develop and protect your most personal instrument.'
WHERE [Id] = 'a1000000-0000-0000-0000-000000000003';
GO

UPDATE [dbo].[courses]
SET [LongDescription] = N'## How to Scream Like a Demon

The extreme vocal styles of heavy metal and death metal may sound like pure aggression, but they are built on precise technique. Done incorrectly, screaming destroys a voice within months. Done correctly, it can be sustained for decades. This advanced formation teaches the right way.

## The Physiology of Extreme Vocals

Ryo Kinoshita of Crystal Lake has one of the most technically impressive extreme vocal deliveries in modern metal. The foundation of his approach: using false fold techniques rather than true fold distortion, which prevents the hemorrhaging that ends careers prematurely.

We cover:

- **False cord engagement**: How to activate the ventricular folds to create distortion without damaging the true vocal folds
- **Breath pressure management**: Extreme vocals require enormous and carefully controlled air support
- **The growl, the shriek, the mid-range scream**: Each technique has different physical requirements and optimal entry points

## Safety First

This course takes vocal health with absolute seriousness. Before any extreme technique, participants will:

1. Complete a baseline vocal assessment
2. Learn to identify warning signs of strain and emerging damage
3. Understand absolute contraindications — conditions under which extreme vocals must stop immediately

## Training Progressions

You do not learn to scream like a demon in a single session. We provide a structured 12-week progression from basic fry screaming to full death metal growls, with mandatory rest periods built into every stage.

## The Presidents-Only Restriction

This formation is reserved for elected presidents. The intensity of the content and its physical demands require a foundation of vocal experience validated through your presidential status.

By the end of this course, the demons will be taking notes.'
WHERE [Id] = 'a1000000-0000-0000-0000-000000000004';
GO

UPDATE [dbo].[courses]
SET [LongDescription] = N'## How to Scream Like a Possessed Person

Where the previous formation focused on technical precision, this course explores the expressive, almost shamanistic dimension of extreme vocals. Corey Taylor of Slipknot occupies a unique position in rock: a vocalist who moves from whispered intimacy to full demonic possession within the same song, often within the same breath.

## The Philosophy of Possession

Great screaming is not about volume. It is about conviction. The listener needs to believe that something has displaced the singer''s personality — that what you are hearing is not a person performing but something using a person as a conduit. This requires total commitment and complete surrendering of self-consciousness.

## Corey Taylor''s Methodology

We study Taylor''s approach in careful detail:

- **The emotional trigger**: Finding the internal state — rage, grief, ecstasy — that makes the sound feel necessary rather than performed
- **The physical ritual**: Pre-performance preparation that makes possession possible on demand
- **Dynamic contrast as weapon**: Why the whisper that precedes the scream is more important than the scream itself

## Extended Techniques

This formation explores territory that few vocalists venture into:

- Throat singing elements integrated with metal screaming for simultaneous tonal layers
- Harmonic distortion layering for combined tonal and atonal output
- Microphone technique for extreme dynamics in both live and recording contexts

## For Presidents Only

As with its companion formation, this course is restricted to elected presidents. The material requires an existing foundation in extreme vocals and the psychological resilience to fully commit to what is taught here.

This is not a course for the faint of heart. It is for those who understand that music, at its most powerful, borders on exorcism.'
WHERE [Id] = 'a1000000-0000-0000-0000-000000000005';
GO

UPDATE [dbo].[courses]
SET [LongDescription] = N'## Metal Can Be Fun

Heavy metal has a reputation problem. For those who have not grown up with it, the genre''s visual and sonic code can feel like a barrier deliberately constructed to keep outsiders away. This formation exists to demolish that barrier entirely.

Kevin Ratajczak understands that metal, in its purest form, is joyful. It celebrates technical mastery, community, and the very human desire to express intensity without restraint. It is one of the most emotionally rich genres in existence, and it should not be the exclusive domain of those who discovered it in their youth.

## What Makes Metal Fun

**The Complexity Under the Noise**

Metal musicians are among the most technically accomplished players in all of popular music. The guitar work of Dimebag Darrell, the drumming of Neil Peart, the bass lines of Steve Harris: these are extraordinary feats of musicianship. Learning to hear them transforms what sounds like aggression into something approaching deep admiration.

**The Community**

Metal concerts are among the safest, most welcoming live music environments you will encounter. The mosh pit''s fearsome reputation is largely myth. This formation includes a primer on live metal culture: what actually happens, the etiquette that governs it, and the warmth that metal audiences extend to newcomers.

**The Subgenres**

Power metal, doom metal, folk metal, progressive metal, symphonic metal: the genre contains worlds within worlds. We explore the full spectrum and help you find the subgenre that speaks to you — because almost everyone has one, even if they do not know it yet.

## The Promise

You do not have to become a metalhead. But by the end of this formation, when someone puts on Iron Maiden or Sabaton or Nightwish, you will understand what is happening, and you will feel it.'
WHERE [Id] = 'a1000000-0000-0000-0000-000000000006';
GO

UPDATE [dbo].[courses]
SET [LongDescription] = N'## How to Be a Proper Emo with Gerard Way

In a world of relentless optimism and curated positivity, the emo movement stands as a radical act of honesty. This formation, built around the philosophy and artistry of Gerard Way — co-founder of My Chemical Romance and author of *The Umbrella Academy* — offers a complete curriculum in authentic emotional expression.

## What Emo Actually Means

Emo is not about sadness. It is about refusing to pretend. It is the insistence that difficult emotions — grief, alienation, self-doubt, rage — deserve to be expressed with the same craft and conviction as joy. Way did not tell his audience to feel better. He told them their pain was real, it was shared, and it could become something beautiful.

## The Curriculum

**Emotional Vocabulary**

Lyrical analysis of MCR songs — *Cancer*, *Famous Last Words*, *Welcome to the Black Parade* — as case studies in turning private anguish into universal art that saves lives.

**The Aesthetic**

Black is not just a colour. It is a philosophy. We explore how visual language — clothing, makeup, imagery, stage design — functions as identity and communication, and how Way synthesized glam rock, horror imagery, and punk ethics into something wholly original.

**The Eyeliner Tutorial**

Practical session. Bring your own pencil.

**The Concept Album**

*Three Cheers for Sweet Revenge* and *The Black Parade* are masterclasses in sustained narrative across a full album. We study their construction in detail, from track sequencing to instrumental callbacks.

**Surviving Ironic Distance**

Being genuinely earnest in 2026 requires courage. This course teaches you to hold your sincerity without apology and to create work that means something without hedging.

## Who It Is For

Anyone who once sang along quietly when nobody was watching. You know who you are.

By the end of this formation, you will understand not only why millions of teenagers found salvation in a band from New Jersey, but how to carry that emotional intelligence into whatever creative work you do.'
WHERE [Id] = 'a1000000-0000-0000-0000-000000000007';
GO

UPDATE [dbo].[courses]
SET [LongDescription] = N'## Acoustic to Electric: The Rock Guitar Metamorphosis

The electric guitar is the most expressive, most versatile, and most abused instrument in rock music. From the angular minimalism of Jack White to the towering riffs of Tony Iommi, the instrument contains more sonic territory than most musicians ever fully explore. This formation takes you through the complete journey from acoustic foundation to electric mastery.

## Why Acoustic Comes First

There are no shortcuts in this course. We begin with acoustic guitar because the electric will forgive your weaknesses. Gain will hide your timing. Overdrive will mask your tone. The acoustic reveals everything. Players who sound genuinely good acoustic sound extraordinary once they plug in.

## The Physics of Electric Sound

**Pickups and Tone**

Single coil versus humbucker, neck position versus bridge position: these are not abstract technical specifications. They are choices that determine whether your guitar sounds like Jimi Hendrix or Kurt Cobain, and understanding exactly why that is matters enormously for developing your own voice.

**The Amplifier as Instrument**

Your amplifier is not a speaker. It is half your sound. We cover the full interaction between guitar, cable, amp, and effects chain — and explain in practical terms why Jack White deliberately uses cheap, imperfect equipment to achieve expensive, distinctive results.

**Effects Pedals: Power and Restraint**

Fuzz, overdrive, distortion, reverb, delay: the palette of electric rock. We teach how to use each effect intentionally and, just as critically, when not to reach for them at all.

## Technique

From open tunings — the secret weapon of Keith Richards and Joni Mitchell alike — to alternate picking to slide guitar, this formation covers the physical techniques that separate technically competent players from genuinely memorable ones.

## The Final Session

You will plug in, turn up, and play. Loudly. That is the entire point.'
WHERE [Id] = 'a1000000-0000-0000-0000-000000000008';
GO
