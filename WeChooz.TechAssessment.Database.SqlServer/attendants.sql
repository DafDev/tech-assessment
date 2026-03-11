CREATE TABLE [dbo].[attendants]
(
  [Id] NVARCHAR(36) NOT NULL PRIMARY KEY,
  [Person] NVARCHAR(300) NOT NULL,
  [Email] NVARCHAR(150) NOT NULL,
  [CompanyName] NVARCHAR(150) NOT NULL,
  [TargetDemographic] INT NOT NULL
);