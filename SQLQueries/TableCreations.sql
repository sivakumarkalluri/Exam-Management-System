create database ExamPortal
use ExamPortal

--  UserLogin Data ------------------------------------------------------
CREATE TABLE userLoginData (
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

INSERT INTO userLoginData (firstname, lastname, email, mobile, gender, password, role, registeredAt)
VALUES
    ('John', 'Doe', 'johndoe@example.com', '1234567890', 'Male', 'password123', 'User', GETDATE()),
    ('Jane', 'Smith', 'janesmith@example.com', '9876543210', 'Female', 'p@ssw0rd', 'Admin', GETDATE());


--drop table userLoginData


------------- Table for Creating an new Exam -----------------------------

create table exam
(
exam_id int identity(1,1) primary key,
exam_name nvarchar(500),
exam_description nvarchar(MAX),
exam_duration int,
question_mark int,
exam_totalquestion int,
exampass_marks int

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
option_1 nvarchar(50),
option_2 nvarchar(50),
option_3 nvarchar(50),
option_4 varchar(50),
correctAnswer int,

)

select * from exam

select * from userLoginData

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
    FOREIGN KEY (userId) REFERENCES userLoginData (userId),
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
total_marks int,
pass_flag BIT,
attemptedAt DateTime

)

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
    SELECT @passMarks = exampass_marks
    FROM exam
    WHERE exam_id = @examId

    -- Determine the pass flag
    IF @totalMarks >= @passMarks
        SET @passFlag = 1
    ELSE
        SET @passFlag = 0

    -- Insert the result into userResults table
    INSERT INTO userResults (userId, exam_id, total_marks, pass_flag,attemptedAt)
    VALUES (@userId, @examId, @totalMarks, @passFlag,GETDATE())
END

delete from userResults;
drop procedure InsertUserResult
EXEC InsertUserResult @userId=1,@examId=1;

select * from userResults;

 SELECT SUM(e.question_mark) as total_marks
    FROM usersExamData AS ud
	join exam as e on e.exam_id=ud.exam_id
    JOIN questions AS q ON ud.question_id = q.question_id
    WHERE ud.userId =1 AND ud.exam_id = 2 AND ud.answer = q.correctAnswer