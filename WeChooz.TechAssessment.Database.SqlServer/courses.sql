CREATE TABLE [dbo].[courses]
(
  [Id] NVARCHAR(36) NOT NULL PRIMARY KEY,
  [Title] NVARCHAR(300) NOT NULL,
  [ShortDescription] NVARCHAR(500) NOT NULL,
  [LongDescription] NVARCHAR(MAX) NOT NULL,
  [DurationInDays] INT NOT NULL,
  [MaxParticipants] INT NOT NULL,
  [TargetDemographic] INT NOT NULL,
  [Instructor] NVARCHAR(150) NOT NULL
);