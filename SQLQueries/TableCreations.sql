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
	imagePath nvarchar(Max),
	role varchar(10) not null,
	registeredAt DateTime not null
);


CREATE TABLE userLogin(
	email varchar(50),
	password varchar(50),
	role varchar(10)
)

-----------------------------------------
INSERT INTO userRegisterData (firstname, lastname, email, mobile, gender, password, role, registeredAt)
VALUES
    
    ('Siva', 'Kumar', 'siva@gmail.com', '9876543210', 'Female', 'admin', 'Admin', GETDATE());

	---------------------------------------------------------------------------------------------------
create table Categories(
category_id int primary key identity(1,1),
category_name nvarchar(500) not null,
category_desc nvarchar(1000) not null

)


---------------------------------------------------------------------------------


------------- Table for Creating an new Exam -----------------------------
create table exam
(
exam_id int identity(1,1) primary key,
category_id int not null,
exam_name nvarchar(500) not null,
exam_description nvarchar(MAX) not null,
exam_duration int not null,
question_mark decimal not null,
exam_totalquestion int not null,
exampass_percent decimal(5,2) not null,
Constraint [FK_exam_category] foreign key(category_id) references Categories (category_id)

)






-----------------Table for adding Questions --------------------------------

create table questions(
question_id int primary key identity(1,1),
exam_id int not null,
category_id int not null,
question_desc nvarchar(MAX) not null,
option_1 nvarchar(500) not null,
option_2 nvarchar(500) not null,
option_3 nvarchar(500) not null,
option_4 varchar(500) not null,
correctAnswer int not null ,
Constraint [FK_questions_exam] foreign  key(exam_id) references exam (exam_id),
Constraint [FK_questions_category] foreign key(category_id) references categories(category_id)


)
select * from questions where exam_id=1
----Table containing users attempted questions data -----------------------------

CREATE TABLE usersExamData (
	testId INT not null,
    userId INT not null,
    exam_id INT not null,
	category_id int not null,
    question_id INT not null,
    answer INT,
	attemptedAt DateTime
    Constraint [FK_usersExamData_users] FOREIGN KEY (userId) REFERENCES userRegisterData (userId),
    Constraint [FK_usersExamData_exam] FOREIGN KEY (exam_id) REFERENCES exam (exam_id),
	Constraint [FK_usersExamData_categories] FOREIGN KEY (category_id) REFERENCES categories (category_id),
    Constraint [FK_usersExamData_questions] FOREIGN KEY (question_id) REFERENCES Questions (question_id)
);


-------------Table containing users Results -----------------------------------

create table userResults(
resultId int primary Key identity(1,1),
testId int not null,
userId int not null,
exam_id int not null,
category_id int not null,
attempted_Questions int,
notAttempted_Questions int,
correct_answers int,
wrong_answers int,
total_marksObtained decimal,
exam_total decimal,
percentage decimal(5,2),
passPercentageRequired(5,2),
pass_flag BIT,

attemptedAt DateTime,
Constraint [FK_usersResults_users] foreign key (userId) references userRegisterData(userId),
Constraint [FK_usersResults_exam] foreign key (exam_Id) references exam(exam_id),
Constraint [FK_usersResults_categories] foreign key (category_id) references categories(category_id),

)


-- Add the new column to the userResults table






ALTER TABLE exam DROP CONSTRAINT FK_exam_category
Alter table questions drop constraint [FK_questions_category]
ALTER TABLE questions DROP CONSTRAINT [FK_questions_exam]
alter table userResults drop constraint [FK_usersResults_categories]
alter table userResults drop constraint [FK_usersResults_exam]
alter table userResults drop constraint [FK_usersResults_users]
alter table usersExamData drop constraint [FK_usersExamData_categories]
alter table usersExamData drop constraint [FK_usersExamData_exam]
alter table usersExamData drop constraint [FK_usersExamData_questions]
alter table usersExamData drop constraint [FK_usersExamData_users]


