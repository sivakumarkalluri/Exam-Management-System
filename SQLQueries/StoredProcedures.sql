
--- Stored Procedure for calculating user results -----------------
CREATE PROCEDURE InsertUserResult
	@testId INT,
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
    DECLARE @passPercentageRequired DECIMAL(5, 2) -- Added parameter

    -- Get the total questions, question mark, category_id, and passPercentageRequired for the exam
    SELECT @totalQuestions = exam_totalquestion,
           @questionMark = question_mark,
           @categoryId = category_id,
           @passPercentageRequired = exampass_percent -- Added column
    FROM exam
    WHERE exam_id = @examId

    -- Calculate the exam total marks
    SET @examTotal = @totalQuestions * @questionMark

    SELECT @attemptedQuestions = COUNT(usersExamData.answer),
           @correctAnswers = SUM(CASE WHEN usersExamData.answer = questions.correctAnswer THEN 1 ELSE 0 END),
           @wrongAnswers = SUM(CASE WHEN usersExamData.answer <> questions.correctAnswer THEN 1 ELSE 0 END)
    FROM usersExamData 
    JOIN questions ON usersExamData.question_id = questions.question_id AND usersExamData.exam_id = questions.exam_id
    WHERE usersExamData.testId = @testId AND usersExamData.exam_id = @examId and usersExamData.userId=@userId

    -- Calculate the not attempted questions
    SET @notAttemptedQuestions = @totalQuestions - @attemptedQuestions

    -- Calculate total marks obtained by the user in the exam
    SELECT @totalMarks = ISNULL(SUM(exam.question_mark), 0)
    FROM usersExamData
    JOIN questions ON usersExamData.question_id = questions.question_id
    JOIN exam ON exam.exam_id = usersExamData.exam_id
    WHERE usersExamData.userId = @userId AND usersExamData.exam_id = @examId AND usersExamData.answer = questions.correctAnswer and usersExamData.testId = @testId

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
		testId,
        userId,
        exam_id,
        category_id,
		examTotalQuestions,

        attempted_Questions,
        notAttempted_Questions,
        correct_answers,
        wrong_answers,
        total_marksObtained,
        exam_total,
        percentage,
        pass_flag,
        passPercentageRequired, -- Added column
        attemptedAt
    )
    VALUES (
		@testId,
        @userId,
        @examId,
        @categoryId,
		@totalQuestions,
        @attemptedQuestions,
        @notAttemptedQuestions,
        @correctAnswers,
        @wrongAnswers,
        @totalMarks,
        @examTotal,
        @percentage,
        @passFlag,
        @passPercentageRequired, -- Added column
        GETDATE()
    )

	select @testId as testId

END

select * from questions
select * from usersExamData
select * from userResults
--------------------------------------------------------------------------------------------------
--- Stored Procedure for getting AdminDashboard Card Statistics



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


exec GetAdminStatistics


---------------------------------------------------------------------------------------------------------
---Stored Procedure for ExamPass/Fail Statistics


CREATE PROCEDURE GetExamPassStatistics
AS
BEGIN
---virtual table for recent attempted
    WITH LatestUserResults AS (
        SELECT userId, exam_id, MAX(attemptedAt) AS latestAttemptedAt
        FROM userResults
        GROUP BY userId, exam_id
    )
    SELECT e.exam_id, e.exam_name, e.category_id,
        COUNT(CASE WHEN ur.pass_flag = 1 THEN ur.exam_id END) AS PassedCount,
        COUNT(CASE WHEN ur.pass_flag = 0 THEN ur.exam_id END) AS FailedCount
    FROM exam AS e
    LEFT JOIN LatestUserResults AS lur ON e.exam_id = lur.exam_id
    LEFT JOIN userResults AS ur ON lur.userId = ur.userId AND lur.exam_id = ur.exam_id AND lur.latestAttemptedAt = ur.attemptedAt
    GROUP BY e.exam_id, e.exam_name, e.category_id
END

exec GetExamPassStatistics


-------------------------------------------------------------------------------------------------------------
---Stored procedure for Counting Students Attempted by Exams Name

CREATE PROCEDURE CountStudentsAttemptedExams
AS
BEGIN
    SELECT e.exam_id, e.exam_name, e.category_id, COUNT(DISTINCT ue.userId) AS StudentsAttempted
    FROM exam e
    LEFT JOIN userResults ue ON e.exam_id = ue.exam_id
	group by e.exam_id,e.exam_name,e.category_id
 
END
-----------------------------------------------------------------------------------------------------------
---Stored procedure for Counting Students Attempted by Category Name

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


------------------------------------------------------------------------------------------------------------
---Question List Type for inserting data

CREATE TYPE QuestionListType AS TABLE (
    QuestionDesc NVARCHAR(1000),
    Option1 NVARCHAR(500),
    Option2 NVARCHAR(500),
    Option3 NVARCHAR(500),
    Option4 NVARCHAR(500),
    CorrectAnswer INT
);



---Stored Procedure for Inserting new Category and its Exam and questions

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



--------------------------------------------------------------------------------------------------------------
--- Stored Procedure for UsersData in Admin Dispaly

CREATE PROCEDURE GetUsersData
AS
BEGIN
    SELECT 
        u.userId,
        u.firstname,
        u.lastname,
        u.email,
        u.mobile,
        u.gender,
        u.registeredAt,
        COUNT(ur.resultId) AS NumberOfExamsWritten
    FROM userRegisterData u
    LEFT JOIN userResults ur ON u.userId = ur.userId
    WHERE u.role = 'User'
    GROUP BY 
        u.userId,
        u.firstname,
        u.lastname,
        u.email,
        u.mobile,
        u.gender,
        u.registeredAt;
END


-----------------------------------------------------------------------------------------------------------------

---Stored Procedure for Getting Admin User Results Data


CREATE PROCEDURE GetAdminUserResultsData
AS
BEGIN
    SELECT
        ur.userId,
		ur.testId,
        CONCAT(urd.firstname, ' ', urd.lastname) AS fullName,
        urd.email,
        e.exam_name as examName,
        c.category_name as categoryName,
		ur.examTotalQuestions,
        ur.attempted_Questions as attemptedQuestions,
        ur.notAttempted_Questions as notAttemptedQuestions,
        ur.correct_answers as correctAnswers,
        ur.wrong_answers as wrongAnswers,
        ur.total_marksObtained as totalMarksObtained,
        ur.exam_total as examTotal,
        ur.percentage as percentageObtained,
		e.examPass_Percent AS passPercentage,
        CASE
            WHEN ur.pass_flag = 1 THEN 'Pass'
            ELSE 'Fail'
        END as PassOrFail,
        
        ur.attemptedAt
    FROM userResults ur
    INNER JOIN userRegisterData urd ON ur.userId = urd.userId
    INNER JOIN exam e ON ur.exam_id = e.exam_id
    INNER JOIN categories c ON ur.category_id = c.category_id;
END


----------------------------------------------------------------------------------------------------------------
--- Stored Procedure of Deleting category


CREATE PROCEDURE DeleteCategoryData
    @categoryId INT
AS
BEGIN
    -- Delete from UsersExamData table
    DELETE FROM UsersExamData
    WHERE Exam_Id IN (
        SELECT Exam_Id
        FROM Exam
        WHERE Category_Id = @categoryId
    );

	Delete from Questions 
	where Exam_Id IN (
        SELECT Exam_Id
        FROM Exam
        WHERE Category_Id = @categoryId
    );

    -- Delete from UserResults table
    DELETE FROM UserResults
    WHERE Exam_Id IN (
        SELECT Exam_Id
        FROM Exam
        WHERE Category_Id = @categoryId
    );

    -- Delete from Exam table
    DELETE FROM Exam
    WHERE Category_Id = @categoryId;



    -- Delete from Categories table
    DELETE FROM Categories
    WHERE Category_Id = @categoryId;

	select @categoryId as categoryId
END



-----------------------------------------------------------------------------------------------------------
----stored Procedure for Adding Exam

CREATE PROCEDURE AddExam
    @categoryId int,
    @examName NVARCHAR(50),
    @examDesc NVARCHAR(100),
    @examDuration INT,
    @questionMark INT,
    @examTotalQuestion INT,
    @examPassPercent DECIMAL,
    @questionList QuestionListType READONLY  -- Use the user-defined table type
AS
BEGIN
    DECLARE @examId INT;

   
    -- Insert into Exams table
    INSERT INTO Exam (Category_Id, Exam_Name, Exam_Description, Exam_Duration, Question_Mark, Exam_TotalQuestion, ExamPass_Percent)
    VALUES (@categoryId, @examName, @examDesc, @examDuration, @questionMark, @examTotalQuestion, @examPassPercent);

    SET @examId = SCOPE_IDENTITY();

    -- Insert into Questions table
    INSERT INTO Questions (Exam_Id, Category_Id, Question_desc, Option_1, Option_2, Option_3, Option_4, CorrectAnswer)
    SELECT @examId, @categoryId, QuestionDesc, Option1, Option2, Option3, Option4, CorrectAnswer
    FROM @questionList;
	select @categoryId as categoryId,
	@examName as examName,
	@examDesc as examDesc,@examDuration as examDuration,
	@questionMark as questionMark,@examTotalQuestion as examTotalQuestion,@examPassPercent as examPassPercent,
	questionDesc ,option1, option2, option3, option4, correctAnswer
    FROM @questionList;
END


-----------------------------------------------------------------------------------------------------

--Stored Procedure for getting data for Exam Crud Operation
CREATE PROCEDURE AdminCRUDExamData
AS
BEGIN
    SELECT c.Category_Id, c.Category_Name, e.Exam_Id, e.Exam_Name, e.exam_totalquestion,
        (SELECT COUNT(*) FROM Exam WHERE Category_Id = c.Category_Id) AS Total_Exams
    FROM Categories c
    INNER JOIN Exam e ON c.Category_Id = e.Category_Id
    ORDER BY c.Category_Id
END

------------------------------------------------------------------------------------------------------------
-- Stored Procedure for Deleting an Exam

CREATE PROCEDURE DeleteExamWithQuestions
    @examId INT
AS
BEGIN
   
        -- Delete questions related to the exam
        DELETE FROM questions
        WHERE exam_id = @examId;

        -- Delete the exam
        DELETE FROM exam
        WHERE exam_id = @examId;

		select @examID as exam_Id
      
END

----------------------------------------------------------------------------------------------------------
-- Stored Procedure for Deleting and Question and reducing the number Total Questions in Exam

CREATE PROCEDURE DeleteQuestion
    @questionId INT
AS
BEGIN
    
    -- Get the exam_id for the question being deleted
    DECLARE @examId INT;
    SELECT @examId = exam_id
    FROM questions
    WHERE question_id = @questionId;

    -- Delete the question from the questions table
    DELETE FROM questions
    WHERE question_id = @questionId;

    -- Update the total_questions value in the exam table
    UPDATE exam
    SET exam_totalquestion = exam_totalquestion - 1
    WHERE exam_id = @examId;

	select @questionId as question_Id
END


-------------------------------------------------------------------------------------------------------
-- Stored Procedure for adding question and incrementing the questions count in exam


CREATE PROCEDURE AddQuestionToExam
  @examId int,
  @categoryId int,
  @questionDesc varchar(max),
  @option1 varchar(500),
  @option2 varchar(500),
  @option3 varchar(500),
  @option4 varchar(500),
  @correctAnswer INT

as 
BEGIN
  

  -- Insert the question into the questions table
  INSERT INTO questions (exam_id,category_id,question_desc, option_1, option_2, option_3, option_4, correctAnswer)
  VALUES (@examId,@categoryId,@questionDesc, @option1, @option2, @option3, @option4, @correctAnswer);

 

  -- Increment the totalQuestions count in the exam table
  UPDATE exam
  SET exam_totalquestion = exam_totalquestion + 1
  WHERE exam_id = @examId;

  -- Return the question ID
  SELECT @examId as exam_Id;
END



------------------------------------------------------------------------------


CREATE PROCEDURE UserDashBoardStatistics
	@userId INT
AS
BEGIN
    SELECT
        -- Calculate total exams available
        (SELECT COUNT(DISTINCT exam_id) FROM exam) AS totalExamsAvailable,
        
        -- Calculate total exams written by the user
        (SELECT COUNT(DISTINCT exam_id) FROM userResults WHERE userId = @userId) AS totalExamsWritten,
        
        -- Calculate total tests attempted by the user
        (SELECT COUNT(*) FROM userResults WHERE userId = @userId) AS totalTestsAttempted,
        
        -- Calculate total exams not written by the user
        (SELECT COUNT(DISTINCT exam_id) FROM exam WHERE exam_id NOT IN (SELECT DISTINCT exam_id FROM userResults WHERE userId = @userId)) AS totalExamsNotWritten;
END;

exec UserDashBoardStatistics @userId=2



---------------------------------------------------------------------------------------------


CREATE PROCEDURE GetUserPassStats
	@userId INT
AS
BEGIN
    SELECT e.exam_name, MAX(ur.percentage) AS maxPercentage
    FROM exam AS e
    INNER JOIN userResults AS ur ON e.exam_id = ur.exam_id
    WHERE ur.userId = @userId
    GROUP BY e.exam_name;
END;

-------------------------------------------------------------------------

CREATE PROCEDURE UserExamSheet
    @testId INT
AS
BEGIN
    SELECT
        ued.testId,
        ued.userId,
        ued.exam_id,
        ued.category_id,
        ued.question_id,
        ued.answer,
        ued.attemptedAt,
        e.exam_name,
        c.category_name,
        e.exampass_percent AS pass_percentage,
        q.question_desc,
        q.option_1,
        q.option_2,
        q.option_3,
        q.option_4,
        q.correctAnswer,
        ur.total_marksObtained,
        ur.percentage AS percentage_obtained,
        ur.pass_flag AS pass_fail
    FROM usersExamData AS ued
    INNER JOIN exam AS e ON ued.exam_id = e.exam_id
    INNER JOIN categories AS c ON ued.category_id = c.category_id
    INNER JOIN questions AS q ON ued.question_id = q.question_id
    INNER JOIN userResults AS ur ON ued.testId = ur.testId
    WHERE ued.testId = @testId;
END

----------------------------------------------------------------------------------------
-------------Stored Procedure for Particular UserResults

CREATE PROCEDURE GetUserResultDetails
@userId int
AS
BEGIN
    SELECT
        ur.resultId,
        ur.testId,
        ur.userId,
        ur.exam_id AS exam_Id,
        ur.category_id AS category_Id,
		ur.examTotalQuestions,

        ur.attempted_Questions,
        ur.notAttempted_Questions,
        ur.correct_answers AS correct_Answers,
        ur.wrong_answers AS wrong_Answers,
        ur.total_marksObtained,
        ur.exam_total AS exam_Total,
        ur.percentage,
        CASE
            WHEN ur.pass_flag = 1 THEN 'Pass'
            ELSE 'Fail'
        END as PassOrFail,
        ur.attemptedAt,
        e.exam_name AS exam_Name,
        c.category_name AS category_Name,
        ur.passPercentageRequired
    FROM
        userResults ur
        INNER JOIN exam e ON ur.exam_id = e.exam_id
        INNER JOIN Categories c ON ur.category_id = c.category_id where ur.userId=@userId;
END


----------------------------------------------------------------------------------
select * from exam
select * from questions
select * from categories
select * from userResults
select * from usersExamData
select * from userRegisterData


CREATE PROCEDURE answersheet
    @testId INT
AS
BEGIN
    SELECT
        ued.testId,
        concat(urd.firstname,' ',urd.lastname) as fullName,
        urd.userId,
        e.exam_name,
        c.category_name,
        questions.question_id,
        questions.question_desc,
        e.question_mark,
        questions.option_1,
        questions.option_2,
        questions.option_3,
        questions.option_4,
        questions.correctAnswer,
        ued.answer,
        ur.total_marksObtained,
        ur.exam_total,
         CASE
            WHEN ur.pass_flag = 1 THEN 'Pass'
            ELSE 'Fail'
        END as PassOrFail,
		ur.attemptedAt
    FROM
        usersExamData AS ued
        JOIN userRegisterData AS urd ON ued.userId = urd.userId
        JOIN exam AS e ON ued.exam_id = e.exam_id
        JOIN Categories AS c ON e.category_id = c.category_id
        JOIN questions  ON ued.question_id = questions.question_id
        JOIN userResults AS ur ON ued.testId = ur.testId
                                AND ued.userId = ur.userId
                                AND ued.exam_id = ur.exam_id
                                AND ued.category_id = ur.category_id
    WHERE
        ued.testId = @testId;
END


exec answersheet @testId=1;





exec InsertUserResult @testId=1,@userId=2,@examId=1;
exec InsertUserResult @testId=2, @userId=2,@examId=2;
exec InsertUserResult @testId=3,@userId=2,@examId=3;
exec InsertUserResult @testId=4,@userId=3,@examId=2;
exec InsertUserResult @testId=5, @userId=3,@examId=1;
exec InsertUserResult @testId=6,@userId=4,@examId=1;
exec InsertUserResult @testId=7,@userId=4,@examId=1;
exec InsertUserResult @testId=8,@userId=4,@examId=1;
exec InsertUserResult @testId=9,@userId=5,@examId=1;

exec InsertUserResult @testId=10,@userId=5,@examId=3;
exec InsertUserResult @testId=11,@userId=6,@examId=3;
exec InsertUserResult @testId=12,@userId=7,@examId=3;
exec InsertUserResult @testId=13,@userId=8,@examId=6;
exec InsertUserResult @testId=14,@userId=9,@examId=6;
exec InsertUserResult @testId=15,@userId=10,@examId=6;
exec InsertUserResult @testId=16,@userId=11,@examId=6;
exec InsertUserResult @testId=17,@userId=11,@examId=5;
exec InsertUserResult @testId=18,@userId=13,@examId=5;
exec InsertUserResult @testId=19,@userId=15,@examId=5;
exec InsertUserResult @testId=20,@userId=17,@examId=3;
exec InsertUserResult @testId=21,@userId=19,@examId=3;


select * from userResults

select * from userRegisterData

select * from usersExamData

create procedure CreateTestID
as 
begin
select Top 1 (testId+1) as testId from usersExamData order by testId desc;
end;

exec CreateTestID


select * from ExamImages