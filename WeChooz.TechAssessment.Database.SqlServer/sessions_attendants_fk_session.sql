ALTER TABLE [dbo].[sessions_attendants]
    ADD CONSTRAINT [FK_sessions_attendants_SessionId]
        FOREIGN KEY ([SessionId]) REFERENCES [dbo].[sessions] ([Id]);
