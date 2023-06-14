at
--- Stored Procedure for calculating user results -----------------

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





---Stored Procedure for ExamPass/Fail Statistics

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




---Stored procedure for Counting Students Attempted by Exams Name

CREATE PROCEDURE CountStudentsAttemptedExams
AS
BEGIN
    SELECT e.exam_id, e.exam_name, e.category_id, COUNT(DISTINCT ue.userId) AS StudentsAttempted
    FROM exam e
    LEFT JOIN usersExamData ue ON e.exam_id = ue.exam_id
    GROUP BY e.exam_id, e.exam_name, e.category_id
END



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




---Stored Procedure for Getting Admin User Results Data


CREATE PROCEDURE GetAdminUserResultsData
AS
BEGIN
    SELECT
        ur.userId,
        CONCAT(urd.firstname, ' ', urd.lastname) AS fullName,
        urd.email,
        e.exam_name as examName,
        c.category_name as categoryName,
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



-- Stored Procedure for adding question and incrementing the questions count in exam
DELIMITER //

CREATE PROCEDURE AddQuestionToExam(
  @examId int,
  @categoryId int,
  @questionDesc varchar(max),
  @option1 varchar(500),
  @option2 varchar(500),
  @option3 varchar(500),
  @option4 varchar(500),
  @correctAnswer INT
)
as 
BEGIN
   DECLARE @exam_Id INT;

  -- Insert the question into the questions table
  INSERT INTO questions (exam_id,category_id, option_1, option_2, option_3, option_4, correctAnswer)
  VALUES (@examId,@categoryId,@questionDesc, @option1, @option2, @option3, @option4, @correctAnswer);

 

  -- Increment the totalQuestions count in the exam table
  UPDATE exam
  SET exam_totalquestion = exam_totalquestion + 1
  WHERE exam_id = @examId;

  -- Return the question ID
  SELECT @exam_Id;
END







drop procedure AdminCrudExamData
exec AdminCRUDExamData

update exam set exam_totalquestion=1 where exam_id=1024;
select * from exam




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


 SELECT c.Category_Id, c.Category_Name, e.Exam_Id, e.Exam_Name, e.exam_totalquestion
    FROM Categories c
    INNER JOIN Exam e ON c.Category_Id = e.Category_Id
	group by c.Category_Id,c.Category_Name
	order by c.category_id 

	select * from questions;



