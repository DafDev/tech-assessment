CREATE TABLE [dbo].[sessions_attendants]
(
  [SessionId]   NVARCHAR(36) NOT NULL,
  [AttendantId] NVARCHAR(36) NOT NULL,
  CONSTRAINT [PK_sessions_attendants] PRIMARY KEY ([SessionId], [AttendantId])
);
