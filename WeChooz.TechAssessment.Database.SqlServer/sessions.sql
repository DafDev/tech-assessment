CREATE TABLE [dbo].[sessions]
(
  [Id]           NVARCHAR(36)     NOT NULL PRIMARY KEY,
  [CourseId]     NVARCHAR(36)     NOT NULL,
  [StartDate]    DATETIMEOFFSET   NOT NULL,
  [DeliveryMode] INT              NOT NULL
);
