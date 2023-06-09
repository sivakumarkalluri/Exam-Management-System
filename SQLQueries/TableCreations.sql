create database ExamPortal
use ExamPortal

--  UserLogin Data ------------------------------------------------------
CREATE TABLE userRegisterData (
    userId INT PRIMARY KEY Identity(1,1),
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    email VARCHAR(100),
    mobile VARCHAR(20),
    gender VARCHAR(10),
	password Varchar(20),
	role varchar(10),
	registeredAt DateTime
);
select * from userRegisterData
drop table userRegisterData
drop table usersExamData

CREATE TABLE userLogin(
	email varchar(50),
	password varchar(50),
	role varchar(10)
)

INSERT INTO userRegisterData (firstname, lastname, email, mobile, gender, password, role, registeredAt)
VALUES
    
    ('Siva', 'Kumar', 'siva@gmail.com', '9876543210', 'Female', 'admin', 'Admin', GETDATE());

------------- Table for Creating an new Exam -----------------------------

create table exam
(
exam_id int identity(1,1) primary key,
exam_name nvarchar(500),
exam_description nvarchar(MAX),
exam_duration int,
question_mark int,
exam_totalquestion int,
exampass_percent int

)

update exam set exampass_marks=2 where exam_id=1; 
update exam set exampass_marks=1 where exam_id=2; 

insert into exam (exam_name,exam_description,exam_duration,question_mark,exam_totalquestion,exampass_marks)
values ('Aptitude','This is an Aptitude Exam',30,5,3,10),('General Knowledge','This is an GK Exam',30,5,2,5)


-----------------Table for adding Questions --------------------------------

create table questions(
question_id int primary key identity(1,1),
exam_id int,
question_desc nvarchar(1000),
option_1 nvarchar(500),
option_2 nvarchar(500),
option_3 nvarchar(500),
option_4 varchar(500),
correctAnswer int,

)

drop table questions

select * from questions;

select * from userRegisterData

INSERT INTO questions (exam_id, question_desc, option_1, option_2, option_3, option_4, correctAnswer)
VALUES
    (1, 'What is the capital of France?', 'Paris', 'London', 'Rome', 'Berlin', 1),
    (1, 'Who painted the Mona Lisa?', 'Pablo Picasso', 'Leonardo da Vinci', 'Vincent van Gogh', 'Michelangelo', 2),
    (1, 'What is the largest planet in our solar system?', 'Mars', 'Saturn', 'Jupiter', 'Neptune', 3),
    (2, 'What is the formula for water?', 'H2O2', 'NaCl', 'CO2', 'H2O', 4),
    (2, 'Which scientist developed the theory of relativity?', 'Albert Einstein', 'Isaac Newton', 'Galileo Galilei', 'Nikola Tesla', 1);


----Table containing users attempted questions data -----------------------------

CREATE TABLE usersExamData (
    userId INT,
    exam_id INT,
    question_id INT,
    answer INT,
	attemptedAt DateTime
    FOREIGN KEY (userId) REFERENCES userRegisterData (userId),
    FOREIGN KEY (exam_id) REFERENCES exam (exam_id),
    FOREIGN KEY (question_id) REFERENCES Questions (question_id)
);
select * from questions;

insert into usersExamData (userId,exam_id,question_id,answer,attemptedAt)
values (1,2,4,1,GETDATE()),(1,2,5,2,GETDATE())
insert into usersExamData (userId,exam_id,question_id,answer,attemptedAt)
values (1,1,1,1,GETDATE()),(1,1,1,2,GETDATE()),(1,1,1,1,GETDATE())
select * from usersExamData

-------------Table containing users Results -----------------------------------

create table userResults(
userId int,
exam_id int,
attempted_Questions int,
notAttempted_Questions int,
correct_answers int,
wrong_answers int,
total_marksObtained int,
exam_total int,
percentage decimal,
pass_flag BIT,
attemptedAt DateTime

)

drop table userResults
-----------------Stored Procedure for calculating the total_marks and pass or fail and inserting into userResults Table -----------------

CREATE PROCEDURE InsertUserResult
    @userId INT,
    @examId INT
AS
BEGIN
    DECLARE @totalMarks INT
    DECLARE @passMarks INT
    DECLARE @passFlag BIT

    -- Calculate total marks obtained by the user in the exam
    SELECT @totalMarks =ISNULL(SUM(e.question_mark), 0)
    FROM usersExamData AS ud
    JOIN questions AS q ON ud.question_id = q.question_id
	join exam as e on e.exam_id=ud.exam_id
    WHERE ud.userId = @userId AND ud.exam_id = @examId AND ud.answer = q.correctAnswer

    -- Get the pass marks for the exam
    SELECT @passPercent = exampass_percent
    FROM exam
    WHERE exam_id = @examId

    -- Determine the pass flag
    IF @totalMarks >= @passPercent
        SET @passFlag = 1
    ELSE
        SET @passFlag = 0

    -- Insert the result into userResults table
    INSERT INTO userResults (userId, exam_id, total_marks, pass_flag,attemptedAt)
    VALUES (@userId, @examId, @totalMarks, @passFlag,GETDATE())
END


select * from userResults;



select * from userResults
select

EXEC GetExamStatistics;




CREATE PROCEDURE InsertUserResult
    @userId INT,
    @examId INT
AS
BEGIN
    DECLARE @totalMarks INT
    DECLARE @passPercent INT
    DECLARE @passFlag BIT
    DECLARE @totalQuestions INT
    DECLARE @questionMark INT
    DECLARE @attemptedQuestions INT
    DECLARE @notAttemptedQuestions INT
    DECLARE @correctAnswers INT
    DECLARE @wrongAnswers INT
    DECLARE @percentage DECIMAL(5, 2)
    DECLARE @examTotal INT

    -- Get the total questions and question mark for the exam
    SELECT @totalQuestions = exam_totalquestion,
           @questionMark = question_mark
    FROM exam
    WHERE exam_id = @examId

    -- Calculate the exam total marks
    SET @examTotal = @totalQuestions * @questionMark

     SELECT @attemptedQuestions = COUNT(usersExamData.answer),
           @correctAnswers = SUM(CASE WHEN usersExamData.answer = questions.correctAnswer THEN 1 ELSE 0 END),
           @wrongAnswers = SUM(CASE WHEN usersExamData.answer <> questions.correctAnswer THEN 1 ELSE 0 END)
    FROM usersExamData 
    JOIN questions ON usersExamData.question_id =  questions.question_id AND usersExamData.exam_id = questions.exam_id
    WHERE usersExamData.userId = @userId AND usersExamData.exam_id = @examId

    -- Calculate the not attempted questions
    SET @notAttemptedQuestions = @totalQuestions - @attemptedQuestions

    -- Calculate total marks obtained by the user in the exam
    SELECT @totalMarks =ISNULL(SUM(exam.question_mark), 0)
    FROM usersExamData
    JOIN questions ON usersExamData.question_id = questions.question_id
	join exam on exam.exam_id=usersExamData.exam_id
    WHERE usersExamData.userId = @userId AND usersExamData.exam_id = @examId AND usersExamData.answer = questions.correctAnswer

    -- Calculate the percentage obtained
    SET @percentage = (@totalMarks / (CAST(@examTotal AS DECIMAL) / 100))

    -- Get the pass marks for the exam
    SELECT @passPercent = exampass_percent
    FROM exam
    WHERE exam_id = @examId

    -- Determine the pass flag
    IF @percentage >= @passPercent
        SET @passFlag = 1
    ELSE
        SET @passFlag = 0

    -- Insert the result into userResults table
    INSERT INTO userResults (
        userId,
        exam_id,
        attempted_Questions,
        notAttempted_Questions,
        correct_answers,
        wrong_answers,
        total_marksObtained,
        exam_total,
        percentage,
        pass_flag,
        attemptedAt
    )
    VALUES (
        @userId,
        @examId,
        @attemptedQuestions,
        @notAttemptedQuestions,
        @correctAnswers,
        @wrongAnswers,
        @totalMarks,
        @examTotal,
        @percentage,
        @passFlag,
        GETDATE()
    )
END

drop procedure InsertUserResult

exec InsertUserResult @userId=2,@examId=1;
exec InsertUserResult @userId=2,@examId=2;
exec InsertUserResult @userId=2,@examId=3;
exec InsertUserResult @userId=3,@examId=2;
exec InsertUserResult @userId=3,@examId=1;
exec InsertUserResult @userId=4,@examId=1;
exec InsertUserResult @userId=5,@examId=1;
exec InsertUserResult @userId=5,@examId=3;
exec InsertUserResult @userId=6,@examId=3;
exec InsertUserResult @userId=7,@examId=3;
exec InsertUserResult @userId=8,@examId=6;
exec InsertUserResult @userId=9,@examId=6;
exec InsertUserResult @userId=10,@examId=6;
exec InsertUserResult @userId=11,@examId=6;
exec InsertUserResult @userId=11,@examId=5;
exec InsertUserResult @userId=13,@examId=5;

exec InsertUserResult @userId=15,@examId=5;

exec InsertUserResult @userId=17,@examId=3;
exec InsertUserResult @userId=19,@examId=3;




select * from userResults;
delete from userResults;

exec GetFailStatistics

CREATE PROCEDURE GetAdminStatistics
AS
BEGIN
    DECLARE @UserCount INT
    DECLARE @ExamCount INT
    DECLARE @StudentsWithExamCount INT
    DECLARE @StudentsWithoutExamCount INT

    -- Total number of users with role 'User'
    SELECT @UserCount = COUNT(*)
    FROM userRegisterData
    WHERE role = 'User'

    -- Total number of exams
    SELECT @ExamCount = COUNT(*)
    FROM exam

    -- Total number of students who have taken at least one exam
    SELECT @StudentsWithExamCount = COUNT(DISTINCT userId)
    FROM usersExamData

    -- Total number of students who didn't attend any exam
    SELECT @StudentsWithoutExamCount = @UserCount - @StudentsWithExamCount

  
    -- Additional Information
    SELECT 'Total number of users with role User: ' AS [Description], @UserCount AS [Count]
    UNION ALL
    SELECT 'Total number of exams: ', @ExamCount
    UNION ALL
    SELECT 'Total number of students who have taken at least one exam: ', @StudentsWithExamCount
    UNION ALL
    SELECT 'Total number of students who didn''t attend any exam: ', @StudentsWithoutExamCount
END

CREATE PROCEDURE GetExamPassStatistics
AS
BEGIN
    SELECT e.exam_id, e.exam_name,
        COUNT(CASE WHEN ur.pass_flag = 1 THEN ur.exam_id END) AS PassedCount,
        COUNT(CASE WHEN ur.pass_flag = 0 THEN ur.exam_id END) AS FailedCount
    FROM exam AS e
    LEFT JOIN userResults AS ur ON e.exam_id = ur.exam_id
    GROUP BY e.exam_id, e.exam_name
END

CREATE PROCEDURE CountStudentsAttemptedExams
AS
BEGIN
    SELECT e.exam_id, e.exam_name, COUNT(DISTINCT ue.userId) AS StudentsAttempted
    FROM exam e
    LEFT JOIN usersExamData ue ON e.exam_id = ue.exam_id
    GROUP BY e.exam_id, e.exam_name
END


exec GetExamPassStatistics

exec CountStudentsAttemptedExams

exec GetAdminStatistics;