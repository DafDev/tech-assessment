ALTER TABLE [dbo].[sessions_attendants]
    ADD CONSTRAINT [FK_sessions_attendants_AttendantId]
        FOREIGN KEY ([AttendantId]) REFERENCES [dbo].[attendants] ([Id]);
