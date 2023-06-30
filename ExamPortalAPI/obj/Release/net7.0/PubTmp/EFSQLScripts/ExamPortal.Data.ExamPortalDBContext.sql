IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230630133221_Initial Migration')
BEGIN
    CREATE TABLE [categories] (
        [CategoryId] int NOT NULL IDENTITY,
        [CategoryName] nvarchar(max) NOT NULL,
        [CategoryDesc] nvarchar(max) NOT NULL,
        CONSTRAINT [PK_categories] PRIMARY KEY ([CategoryId])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230630133221_Initial Migration')
BEGIN
    CREATE TABLE [examImages] (
        [exam_Name] nvarchar(max) NOT NULL,
        [imagePath] nvarchar(max) NOT NULL
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230630133221_Initial Migration')
BEGIN
    CREATE TABLE [exams] (
        [ExamId] int NOT NULL IDENTITY,
        [Category_Id] int NOT NULL,
        [ExamName] nvarchar(max) NOT NULL,
        [ExamDescription] nvarchar(max) NOT NULL,
        [ExamDuration] int NOT NULL,
        [QuestionMark] decimal(18,2) NOT NULL,
        [ExamTotalQuestion] int NOT NULL,
        [ExamPassPercent] decimal(18,2) NOT NULL,
        CONSTRAINT [PK_exams] PRIMARY KEY ([ExamId])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230630133221_Initial Migration')
BEGIN
    CREATE TABLE [questions] (
        [question_id] int NOT NULL IDENTITY,
        [exam_id] int NOT NULL,
        [category_id] int NOT NULL,
        [question_desc] nvarchar(max) NOT NULL,
        [option_1] nvarchar(max) NOT NULL,
        [option_2] nvarchar(max) NOT NULL,
        [option_3] nvarchar(max) NOT NULL,
        [option_4] nvarchar(max) NOT NULL,
        [correctAnswer] int NOT NULL,
        CONSTRAINT [PK_questions] PRIMARY KEY ([question_id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230630133221_Initial Migration')
BEGIN
    CREATE TABLE [userExamDatas] (
        [Id] int NOT NULL IDENTITY,
        [testId] int NOT NULL,
        [userId] int NOT NULL,
        [exam_id] int NOT NULL,
        [category_id] int NOT NULL,
        [question_id] int NOT NULL,
        [answer] int NULL,
        [attemptedAt] datetime2 NOT NULL,
        CONSTRAINT [PK_userExamDatas] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230630133221_Initial Migration')
BEGIN
    CREATE TABLE [userResults] (
        [ResultId] int NOT NULL IDENTITY,
        [TestId] int NOT NULL,
        [UserId] int NOT NULL,
        [Exam_Id] int NOT NULL,
        [Category_Id] int NOT NULL,
        [Attempted_Questions] int NOT NULL,
        [NotAttempted_Questions] int NOT NULL,
        [Correct_Answers] int NOT NULL,
        [Wrong_Answers] int NOT NULL,
        [Total_MarksObtained] decimal(18,2) NOT NULL,
        [Exam_Total] decimal(18,2) NOT NULL,
        [Percentage] decimal(18,2) NOT NULL,
        [Pass_Flag] bit NOT NULL,
        [AttemptedAt] datetime2 NOT NULL,
        [passPercentageRequired] decimal(18,2) NOT NULL,
        CONSTRAINT [PK_userResults] PRIMARY KEY ([ResultId])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230630133221_Initial Migration')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20230630133221_Initial Migration', N'7.0.8');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230630144332_Initial Migration2')
BEGIN
    ALTER TABLE [userResults] ADD [examTotalQuestions] int NOT NULL DEFAULT 0;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230630144332_Initial Migration2')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20230630144332_Initial Migration2', N'7.0.8');
END;
GO

COMMIT;
GO

