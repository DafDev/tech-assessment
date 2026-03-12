ALTER TABLE [dbo].[sessions]
    ADD CONSTRAINT [FK_sessions_CourseId]
        FOREIGN KEY ([CourseId]) REFERENCES [dbo].[courses] ([Id]);
