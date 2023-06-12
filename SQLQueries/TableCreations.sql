create database ExamPortal
use ExamPortal

--  UserLogin Data ------------------------------------------------------
CREATE TABLE userRegisterData (
    userId INT PRIMARY KEY Identity(1,1),
    firstname VARCHAR(50) not null,
    lastname VARCHAR(50) not null,
    email VARCHAR(100) not null unique,
    mobile VARCHAR(20) not null,
    gender VARCHAR(10) not null,
	password Varchar(20) not null,
	role varchar(10) not null,
	registeredAt DateTime not null
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


create table Categories(
category_id int primary key identity(1,1),
category_name nvarchar(500) not null,
category_desc nvarchar(1000) not null

)


------------- Table for Creating an new Exam -----------------------------
drop table Categories
create table exam
(
exam_id int identity(1,1) primary key,
category_id int not null,
exam_name nvarchar(500) not null,
exam_description nvarchar(MAX) not null,
exam_duration int not null,
question_mark int not null,
exam_totalquestion int not null,
exampass_percent decimal not null,
foreign key(category_id) references Categories (category_id)

)

SELECT fk.name AS constraint_name
FROM sys.foreign_keys fk
INNER JOIN sys.columns c ON fk.parent_object_id = c.object_id
INNER JOIN sys.tables t ON fk.referenced_object_id = t.object_id
WHERE t.name = 'exam' AND c.name = 'category_id';


ALTER TABLE exam
ALTER COLUMN question_mark DECIMAL;

drop table exam
drop table usersExamData
update exam set exampass_marks=2 where exam_id=1; 
update exam set exampass_marks=1 where exam_id=2; 

insert into exam (exam_name,exam_description,exam_duration,question_mark,exam_totalquestion,exampass_marks)
values ('Aptitude','This is an Aptitude Exam',30,5,3,10),('General Knowledge','This is an GK Exam',30,5,2,5)


-----------------Table for adding Questions --------------------------------

create table questions(
question_id int primary key identity(1,1),
exam_id int not null,
category_id int not null,
question_desc nvarchar(1000) not null,
option_1 nvarchar(500) not null,
option_2 nvarchar(500) not null,
option_3 nvarchar(500) not null,
option_4 varchar(500) not null,
correctAnswer int not null ,
foreign key(exam_id) references exam (exam_id),
foreign key(category_id) references categories(category_id)


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
    userId INT not null,
    exam_id INT not null,
	category_id int not null,
    question_id INT not null,
    answer INT,
	attemptedAt DateTime
    FOREIGN KEY (userId) REFERENCES userRegisterData (userId),
    FOREIGN KEY (exam_id) REFERENCES exam (exam_id),
	FOREIGN KEY (category_id) REFERENCES categories (category_id),
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
resultId int primary Key identity(1,1),
userId int not null,
exam_id int not null,
category_id int not null,
attempted_Questions int,
notAttempted_Questions int,
correct_answers int,
wrong_answers int,
total_marksObtained int,
exam_total int,
percentage decimal,
pass_flag BIT,
attemptedAt DateTime,
foreign key (userId) references userRegisterData(userId),
foreign key (exam_Id) references exam(exam_id),
foreign key (category_id) references categories(category_id)

)

drop table userResults
-----------------Stored Procedure for calculating the total_marks and pass or fail and inserting into userResults Table -----------------



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
    DECLARE @categoryId INT

    -- Get the total questions, question mark, and category_id for the exam
    SELECT @totalQuestions = exam_totalquestion,
           @questionMark = question_mark,
           @categoryId = category_id
    FROM exam
    WHERE exam_id = @examId

    -- Calculate the exam total marks
    SET @examTotal = @totalQuestions * @questionMark

    SELECT @attemptedQuestions = COUNT(usersExamData.answer),
           @correctAnswers = SUM(CASE WHEN usersExamData.answer = questions.correctAnswer THEN 1 ELSE 0 END),
           @wrongAnswers = SUM(CASE WHEN usersExamData.answer <> questions.correctAnswer THEN 1 ELSE 0 END)
    FROM usersExamData 
    JOIN questions ON usersExamData.question_id = questions.question_id AND usersExamData.exam_id = questions.exam_id
    WHERE usersExamData.userId = @userId AND usersExamData.exam_id = @examId

    -- Calculate the not attempted questions
    SET @notAttemptedQuestions = @totalQuestions - @attemptedQuestions

    -- Calculate total marks obtained by the user in the exam
    SELECT @totalMarks = ISNULL(SUM(exam.question_mark), 0)
    FROM usersExamData
    JOIN questions ON usersExamData.question_id = questions.question_id
    JOIN exam ON exam.exam_id = usersExamData.exam_id
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
        category_id,
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
        @categoryId,
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
    DECLARE @CategoryCount INT

    -- Total number of users with role 'User'
    SELECT @UserCount = COUNT(*)
    FROM userRegisterData
    WHERE role = 'User'

    -- Total number of exams
    SELECT @ExamCount = COUNT(*)
    FROM exam

    -- Total number of categories
    SELECT @CategoryCount = COUNT(*)
    FROM Categories

    -- Total number of students who have taken at least one exam
    SELECT @StudentsWithExamCount = COUNT(DISTINCT userId)
    FROM usersExamData

    -- Total number of students who didn't attend any exam
    SELECT @StudentsWithoutExamCount = @UserCount - @StudentsWithExamCount

  
    -- Additional Information
   Select @UserCount as 'TotalUsers' ,@ExamCount as 'TotalExams',
   @CategoryCount as 'TotalCategories',@StudentsWithExamCount as 'StudentsTakenAtLeastOneExam',
   @StudentsWithoutExamCount as 'StudentsNotTakenAtLeastOneExam'
END


drop procedure GetAdminStatistics

CREATE PROCEDURE GetExamPassStatistics
AS
BEGIN
    SELECT e.exam_id, e.exam_name, e.category_id,
        COUNT(CASE WHEN ur.pass_flag = 1 THEN ur.exam_id END) AS PassedCount,
        COUNT(CASE WHEN ur.pass_flag = 0 THEN ur.exam_id END) AS FailedCount
    FROM exam AS e
    LEFT JOIN userResults AS ur ON e.exam_id = ur.exam_id
    GROUP BY e.exam_id, e.exam_name, e.category_id
END

exec GetExamPassStatistics
drop procedure GetExamPassStatistics



CREATE PROCEDURE CountStudentsAttemptedExams
AS
BEGIN
    SELECT e.exam_id, e.exam_name, e.category_id, COUNT(DISTINCT ue.userId) AS StudentsAttempted
    FROM exam e
    LEFT JOIN usersExamData ue ON e.exam_id = ue.exam_id
    GROUP BY e.exam_id, e.exam_name, e.category_id
END


CREATE PROCEDURE CountStudentsAttemptedByCategory
AS
BEGIN
    SELECT c.category_id, c.category_name, COUNT(DISTINCT ue.userId) AS StudentsAttempted
    FROM Categories c
    LEFT JOIN exam e ON c.category_id = e.category_id
    LEFT JOIN usersExamData ue ON e.exam_id = ue.exam_id
    GROUP BY c.category_id, c.category_name
END


exec CountStudentsAttemptedByCategory

drop procedure CountStudentsAttemptedExams

exec GetExamPassStatistics

exec CountStudentsAttemptedExams

exec GetAdminStatistics;


CREATE TYPE QuestionListType AS TABLE (
    QuestionDesc NVARCHAR(1000),
    Option1 NVARCHAR(500),
    Option2 NVARCHAR(500),
    Option3 NVARCHAR(500),
    Option4 NVARCHAR(500),
    CorrectAnswer INT
);

CREATE PROCEDURE InsertCategoryExamQuestions
    @categoryName NVARCHAR(50),
    @categoryDesc NVARCHAR(100),
    @examName NVARCHAR(50),
    @examDesc NVARCHAR(100),
    @examDuration INT,
    @questionMark INT,
    @examTotalQuestion INT,
    @examPassPercent DECIMAL,
    @questionList QuestionListType READONLY  -- Use the user-defined table type
AS
BEGIN
    DECLARE @categoryId INT;
    DECLARE @examId INT;

    -- Insert into Categories table
    INSERT INTO Categories (Category_Name, category_desc)
    VALUES (@categoryName, @categoryDesc);

    SET @categoryId = SCOPE_IDENTITY();

    -- Insert into Exams table
    INSERT INTO Exam (Category_Id, Exam_Name, Exam_Description, Exam_Duration, Question_Mark, Exam_TotalQuestion, ExamPass_Percent)
    VALUES (@categoryId, @examName, @examDesc, @examDuration, @questionMark, @examTotalQuestion, @examPassPercent);

    SET @examId = SCOPE_IDENTITY();

    -- Insert into Questions table
    INSERT INTO Questions (Exam_Id, Category_Id, Question_desc, Option_1, Option_2, Option_3, Option_4, CorrectAnswer)
    SELECT @examId, @categoryId, QuestionDesc, Option1, Option2, Option3, Option4, CorrectAnswer
    FROM @questionList;
	select @categoryName as CategoryName,@categoryDesc as categoryDesc,
	@examName as examName,
	@examDesc as examDesc,@examDuration as examDuration,
	@questionMark as questionMark,@examTotalQuestion as examTotalQuestion,@examPassPercent as examPassPercent,
	questionDesc ,option1, option2, option3, option4, correctAnswer
    FROM @questionList;
END


drop procedure InsertCategoryExamQuestions

-- Sample data for input parameters
DECLARE @categoryName NVARCHAR(50) = 'Category 1';
DECLARE @categoryDesc NVARCHAR(100) = 'Category 1 Description';
DECLARE @examName NVARCHAR(50) = 'Exam 1';
DECLARE @examDesc NVARCHAR(100) = 'Exam 1 Description';
DECLARE @examDuration INT = 60;
DECLARE @questionMark INT = 5;
DECLARE @examTotalQuestion INT = 10;
DECLARE @examPassPercent DECIMAL = 70.0;

DECLARE @questionList QuestionListType;
INSERT INTO @questionList (QuestionDesc, Option1, Option2, Option3, Option4, CorrectAnswer)
VALUES
    ('Question 1', 'Option 1', 'Option 2', 'Option 3', 'Option 4', 2),
    ('Question 2', 'Option 1', 'Option 2', 'Option 3', 'Option 4', 3),
    ('Question 3', 'Option 1', 'Option 2', 'Option 3', 'Option 4', 1);
EXEC InsertCategoryExamQuestions
    @categoryName,
    @categoryDesc,
    @examName,
    @examDesc,
    @examDuration,
    @questionMark,
    @examTotalQuestion,
    @examPassPercent,
    @questionList;

select * from Categories

-- Execute the stored procedure
drop type QuestionListType

select * from exam
select * from Questions