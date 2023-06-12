INSERT INTO userRegisterData (firstname, lastname, email, mobile, gender, password, role, registeredAt)
VALUES
    ('Aarav', 'Kumar', 'aarav@gmail.com', '9876543210', 'Male', 'password', 'User', GETDATE()),
    ('Aanya', 'Patel', 'aanya@gmail.com', '9876543211', 'Female', 'password', 'User', GETDATE()),
    ('Advait', 'Sharma', 'advait@gmail.com', '9876543212', 'Male', 'password', 'User', GETDATE()),
    ('Amaira', 'Verma', 'amaira@gmail.com', '9876543213', 'Female', 'password', 'User', GETDATE()),
    ('Anaya', 'Gupta', 'anaya@gmail.com', '9876543214', 'Female', 'password', 'User', GETDATE()),
    ('Arjun', 'Singh', 'arjun@gmail.com', '9876543215', 'Male', 'password', 'User', GETDATE()),
    ('Avani', 'Mishra', 'avani@gmail.com', '9876543216', 'Female', 'password', 'User', GETDATE()),
    ('Dhruv', 'Joshi', 'dhruv@gmail.com', '9876543217', 'Male', 'password', 'User', GETDATE()),
    ('Esha', 'Shah', 'esha@gmail.com', '9876543218', 'Female', 'password', 'User', GETDATE()),
    ('Ishaan', 'Desai', 'ishaan@gmail.com', '9876543219', 'Male', 'password', 'User', GETDATE()),
    ('Kavya', 'Rao', 'kavya@gmail.com', '9876543220', 'Female', 'password', 'User', GETDATE()),
    ('Krish', 'Gupta', 'krish@gmail.com', '9876543221', 'Male', 'password', 'User', GETDATE()),
    ('Mira', 'Patil', 'mira@gmail.com', '9876543222', 'Female', 'password', 'User', GETDATE()),
    ('Reyansh', 'Kumar', 'reyansh@gmail.com', '9876543223', 'Male', 'password', 'User', GETDATE()),
    ('Riya', 'Chopra', 'riya@gmail.com', '9876543224', 'Female', 'password', 'User', GETDATE()),
    ('Rudra', 'Sharma', 'rudra@gmail.com', '9876543225', 'Male', 'password', 'User', GETDATE()),
    ('Samaira', 'Malhotra', 'samaira@gmail.com', '9876543226', 'Female', 'password', 'User', GETDATE()),
    ('Shlok', 'Shah', 'shlok@gmail.com', '9876543227', 'Male', 'password', 'User', GETDATE()),
    ('Tanvi', 'Gupta', 'tanvi@gmail.com', '9876543228', 'Female', 'password', 'User', GETDATE()),
    ('Vihaan', 'Patel', 'vihaan@gmail.com', '9876543229', 'Male', 'password', 'User', GETDATE());


	select * from userRegisterData

INSERT INTO Categories (category_name, category_desc)
VALUES
    ('Programming Languages', 'This category includes programming languages such as Java, C++, Python.'),
    ('Aptitude', 'This category includes aptitude questions on various topics.'),
    ('Operating Systems', 'This category includes questions related to operating systems concepts.');

select * from Categories;

INSERT INTO exam (exam_name,category_id, exam_description, exam_duration, question_mark, exam_totalquestion, exampass_percent)
VALUES
    ('Python', 1,'This is a Python exam', 60, 5, 10, 30),
    ('Java',1, 'This is a Java exam', 60, 5, 8, 30),
    ('C#', 1,'This is a C# exam', 60, 5, 6, 30),
    ('Quantitative Aptitude',2, 'This is an Quantitative Aptitude exam', 30, 5, 10, 30),
    ('DBMS',1, 'This is a DBMS exam', 45, 5, 12, 30),
    ('Operating System',3, 'This is an Operating System exam', 45, 5, 8, 30);


	INSERT INTO questions (exam_id,category_id, question_desc, option_1, option_2, option_3, option_4, correctAnswer)
VALUES
    (1,1, 'What is the output of the following Python code?\n\nx = 5\nprint(x + 3)', '5', '8', '3', 'Error', 2),
    (1, 1,'Which of the following data types is not supported in Python?', 'int', 'float', 'string', 'list', 4),
    (1,1, 'What is the result of the following expression in Python?\n\n5 > 3 and 2 < 4', 'True', 'False', 'Error', 'None of the above', 1),
    (1,1, 'What is the correct way to declare a variable in Python?', 'var x = 5', 'int x = 5', 'x = 5', 'x := 5', 3),
    (1,1, 'What is the output of the following Python code?\n\nfruits = ["apple", "banana", "cherry"]\nprint(len(fruits))', '0', '3', '5', 'Error', 2),
    (1,1, 'What is the output of the following Python code?\n\nx = 10\ny = 5\nprint(x % y)', '2', '0', '1', '5', 2),
    (1,1, 'Which of the following is a built-in Python function to get the length of a string?', 'length()', 'count()', 'size()', 'len()', 3),
    (1,1, 'What will be the result of the following expression in Python?\n\n3 ** 2', '6', '9', '3', '0', 1),
    (1,1, 'Which of the following is a correct way to write a comment in Python?', '# This is a comment', '// This is a comment', '/* This is a comment */', '<!-- This is a comment -->', 1),
    (1,1, 'What is the output of the following Python code?\n\nfruits = ["apple", "banana", "cherry"]\nprint(fruits[1])', 'apple', 'banana', 'cherry', 'IndexError', 2);



	INSERT INTO questions (exam_id,category_id, question_desc, option_1, option_2, option_3, option_4, correctAnswer)
VALUES
    (2,1, 'What is the output of the following Java code?\n\nint x = 5;\nSystem.out.println(x + 3);', '5', '8', '3', 'Error', 2),
    (2, 1,'Which of the following is NOT a valid Java identifier?', 'myVariable', '_myVariable', '1stVariable', 'myVariable1', 3),
    (2,1, 'What is the result of the following expression in Java?\n\n5 > 3 && 2 < 4', 'true', 'false', 'Error', 'None of the above', 1),
    (2,1, 'Which keyword is used to declare a variable that does not change its value?', 'final', 'static', 'private', 'new', 1),
    (2,1, 'What is the output of the following Java code?\n\nString text = "Hello";\nSystem.out.println(text.length());', '0', '5', 'Error', 'None of the above', 2),
    (2,1, 'What is the output of the following Java code?\n\nint x = 10;\nint y = 5;\nSystem.out.println(x % y);', '2', '0', '1', '5', 2),
    (2,1, 'Which of the following is a built-in Java method to find the length of a string?', 'length()', 'count()', 'size()', 'len()', 1),
    (2,1, 'What will be the result of the following expression in Java?\n\nMath.pow(3, 2)', '6', '9', '3', '0', 2);

INSERT INTO questions (exam_id,category_id, question_desc, option_1, option_2, option_3, option_4, correctAnswer)
VALUES
    (3,1, 'What is the output of the following C# code?\n\nint x = 5;\nConsole.WriteLine(x + 3);', '5', '8', '3', 'Error', 2),
    (3,1, 'Which of the following is NOT a valid data type in C#?', 'int', 'float', 'string', 'char[]', 4),
    (3,1, 'What is the result of the following expression in C#?\n\n5 > 3 && 2 < 4', 'true', 'false', 'Error', 'None of the above', 1),
    (3,1, 'Which keyword is used to declare a variable that cannot be modified?', 'final', 'static', 'const', 'readonly', 3),
    (3,1, 'What is the output of the following C# code?\n\nstring text = "Hello";\nConsole.WriteLine(text.Length);', '0', '5', 'Error', 'None of the above', 2),
    (3,1, 'What is the purpose of the "using" statement in C#?', 'To include a namespace', 'To define a class', 'To create an object', 'To perform file I/O operations', 1);


INSERT INTO questions (exam_id,category_id, question_desc, option_1, option_2, option_3, option_4, correctAnswer)
VALUES
    (4,2, 'A train running at the speed of 60 km/hr crosses a pole in 9 seconds. What is the length of the train?', '120 meters', '180 meters', '324 meters', '150 meters', 1),
    (4, 2, 'A man spends 35% of his salary on rent, 20% on groceries, 15% on utilities, and the remaining amount of $900 on other expenses. What is his monthly salary?', '$3,000', '$3,500', '$4,000', '$5,000', 3),
    (4,2,  'A boat covers a distance of 30 kilometers downstream in 2 hours. To cover the same distance upstream, it takes 5 hours. What is the speed of the boat in still water?', '5 km/hr', '6 km/hr', '7 km/hr', '8 km/hr', 2),
    (4,2,  'The sum of two consecutive even numbers is 38. What are the numbers?', '18 and 20', '19 and 21', '20 and 22', '21 and 23', 3),
    (4,2,  'If 5x + 3y = 12 and 2x - y = 5, what is the value of x?', '3', '4', '5', '6', 2),
    (4,2,  'The ratio of the number of boys to the number of girls in a class is 3:2. If there are 20 girls in the class, how many boys are there?', '10', '12', '15', '18', 4),
    (4,2,  'A sum of money becomes $4,800 after 2 years at 8% per annum compounded annually. What was the principal amount?', '$4,000', '$4,200', '$4,400', '$4,600', 1),
    (4,2,  'The average of 5 consecutive even numbers is 24. What is the largest of these numbers?', '24', '26', '28', '30', 4),
    (4,2,  'If the perimeter of a square is 40 cm, what is the area of the square?', '100 cm²', '144 cm²', '196 cm²', '400 cm²', 3),
    (4,2,  'A fruit seller sells mangoes at $15 per dozen. How many mangoes can he buy for $90?', '4 dozen', '5 dozen', '6 dozen', '7 dozen', 3);


INSERT INTO questions (exam_id,category_id, question_desc, option_1, option_2, option_3, option_4, correctAnswer)
VALUES
    (5,1, 'Which of the following is not a type of database model?', 'Relational Model', 'Hierarchical Model', 'Network Model', 'Linear Model', 4),
    (5,1, 'In a relational database, what is a primary key used for?', 'To uniquely identify a record in a table', 'To establish relationships between tables', 'To sort records in a table', 'To define the data types of table columns', 1),
    (5,1, 'What is the purpose of an index in a database?', 'To optimize query performance', 'To enforce data integrity', 'To provide backup and recovery', 'To manage user permissions', 1),
    (5,1, 'Which SQL keyword is used to retrieve data from a database?', 'SELECT', 'INSERT', 'UPDATE', 'DELETE', 1),
    (5,1, 'What is the process of combining columns from different tables in a database called?', 'Join', 'Filter', 'Group', 'Sort', 1),
    (5,1, 'What is the purpose of the GROUP BY clause in SQL?', 'To group rows based on a specified column', 'To sort rows in ascending order', 'To filter rows based on a condition', 'To perform mathematical calculations on columns', 1),
    (5,1, 'Which of the following is an example of a database management system?', 'MySQL', 'Java', 'Python', 'HTML', 1),
    (5,1, 'What is the result of the natural join operation between two tables?', 'It combines rows from both tables based on matching values in specified columns', 'It returns the intersection of rows between two tables', 'It returns the union of rows between two tables', 'It returns the difference of rows between two tables', 1),
    (5,1, 'What is the purpose of the COMMIT statement in a database?', 'To save changes permanently', 'To roll back changes made in a transaction', 'To retrieve data from a database', 'To update records in a table', 1),
    (5,1, 'Which of the following is an example of a non-relational database?', 'MongoDB', 'Oracle', 'SQL Server', 'MySQL', 1),
    (5,1, 'What is the maximum number of tables that can be included in a single SQL query?', 'No limit', '256', '1024', 'Depends on the database management system', 1),
    (5,1, 'Which SQL keyword is used to add new rows to a database table?', 'INSERT', 'SELECT', 'UPDATE', 'DELETE', 1);

	

	INSERT INTO questions (exam_id,category_id, question_desc, option_1, option_2, option_3, option_4, correctAnswer)
VALUES
    (6,3, 'What is the primary function of an operating system?', 'Manage hardware resources and provide services to applications', 'Execute application programs', 'Control peripheral devices', 'Store and retrieve data from memory', 1),
    (6,3, 'What is the purpose of virtual memory in an operating system?', 'To provide a large address space for applications', 'To store frequently accessed files', 'To reduce the size of RAM', 'To manage network connections', 1),
    (6,3, 'What is a deadlock in operating system?', 'A situation where two or more processes are unable to proceed', 'An error that occurs when accessing a file', 'A system crash due to insufficient memory', 'A device failure in the system', 1),
    (6,3, 'What is the role of a scheduler in an operating system?', 'To determine which process should execute next', 'To manage system memory', 'To control input and output operations', 'To handle file system operations', 1),
    (6,3, 'What is the purpose of a file system in an operating system?', 'To organize and manage files on storage devices', 'To execute application programs', 'To control network connections', 'To allocate system resources', 1),
    (6,3, 'What is a process in the context of operating systems?', 'An executing instance of a program', 'A collection of files in the file system', 'A physical component of a computer', 'A user account in the system', 1),
    (6,3, 'What is the difference between multiprogramming and multitasking?', 'Multiprogramming allows multiple programs to run simultaneously, while multitasking allows multiple tasks or processes to run simultaneously', 'Multiprogramming and multitasking are the same thing', 'Multiprogramming is used in single-user systems, while multitasking is used in multi-user systems', 'Multiprogramming is faster than multitasking', 1),
    (6,3, 'What is a shell in the context of operating systems?', 'A command-line interface to interact with the operating system', 'A protective layer that isolates the kernel from user programs', 'A hardware component that stores program instructions', 'A system utility for managing files and directories', 1);

select * from questions

INSERT INTO usersExamData (userId, exam_id,category_id, question_id, answer, attemptedAt)
VALUES
    (2, 1,1, 1, 1, GETDATE()),
    (2, 1, 1,2, NULL, GETDATE()),
    (2, 1,1, 3, 3, GETDATE()),
    (2, 1,1, 4, NULL, GETDATE()),
    (2, 1,1, 5, 2, GETDATE()),
	(2, 1,1, 6, 2, GETDATE()),
    (2, 1,1, 7, 3, GETDATE()),
    (2, 1,1, 8, 1, GETDATE()),
    (2, 1,1, 9, 1, GETDATE()),
    (2, 1,1, 10, 2, GETDATE());

	INSERT INTO usersExamData (userId, exam_id,category_id, question_id, answer, attemptedAt)
VALUES
    (2, 2,1, 11, NULL, GETDATE()),
    (2, 2,1, 12, 3, GETDATE()),
    (2, 2,1, 13, 2, GETDATE()),
    (2, 2,1, 14, 1, GETDATE()),
    (2, 2,1, 15, 2, GETDATE()),
    (2, 2,1, 16, 2, GETDATE()),
    (2, 2,1, 17, 1, GETDATE()),
	(2, 2,1, 18, 2, GETDATE());

	INSERT INTO usersExamData (userId, exam_id,category_id ,question_id, answer, attemptedAt)
VALUES
    (2, 3,1, 19, 3, GETDATE()),
    (2, 3,1, 20, NULL, GETDATE()),
    (2, 3,1, 21, 2, GETDATE()),
    (2, 3,1, 22, NULL, GETDATE()),
    (2, 3,1, 23, 4, GETDATE()),
    (2, 3,1, 24, 1, GETDATE());


	
	INSERT INTO usersExamData (userId, exam_id,category_id, question_id, answer, attemptedAt)
VALUES
    (3, 2,1, 11, NULL, GETDATE()),
    (3, 2,1, 12, 1, GETDATE()),
    (3, 2,1, 13, 3, GETDATE()),
    (3, 2,1, 14, 4, GETDATE()),
    (3, 2,1, 15, 2, GETDATE()),
    (3, 2,1, 16, 1, GETDATE()),
    (3, 2,1, 17, 1, GETDATE()),
	(3, 2,1, 18, 2, GETDATE());


	
INSERT INTO usersExamData (userId, exam_id,category_id, question_id, answer, attemptedAt)
VALUES
    (3, 1,1, 1, 2, GETDATE()),
    (3, 1,1, 2, NULL, GETDATE()),
    (3, 1,1, 3, 3, GETDATE()),
    (3, 1,1, 4, 1, GETDATE()),
    (3, 1,1, 5, 2, GETDATE()),
	(3, 1,1, 6, 2, GETDATE()),
    (3, 1,1, 7, 3, GETDATE()),
    (3, 1,1, 8, 1, GETDATE()),
    (3, 1,1, 9, 1, GETDATE()),
    (3, 1,1, 10, 2, GETDATE());



		
INSERT INTO usersExamData (userId, exam_id,category_id, question_id, answer, attemptedAt)
VALUES
    (4, 1,1, 1, 2, GETDATE()),
    (4, 1,1, 2, 1, GETDATE()),
    (4, 1,1, 3, 3, GETDATE()),
    (4, 1,1, 4, 1, GETDATE()),
    (4, 1,1, 5, 3, GETDATE()),
	(4, 1,1, 6, 2, GETDATE()),
    (4, 1,1, 7, 4, GETDATE()),
    (4, 1,1, 8, 1, GETDATE()),
    (4, 1,1, 9, 1, GETDATE()),
    (4, 1,1, 10, 2, GETDATE());

		
INSERT INTO usersExamData (userId, exam_id,category_id, question_id, answer, attemptedAt)
VALUES
    (5, 1,1, 1, 2, GETDATE()),
    (5, 1,1, 2, NULL, GETDATE()),
    (5, 1,1, 3, NULL, GETDATE()),
    (5, 1,1, 4, 2, GETDATE()),
    (5, 1,1, 5, 2, GETDATE()),
	(5, 1,1, 6, 2, GETDATE()),
    (5, 1,1, 7, 4, GETDATE()),
    (5, 1,1, 8, 4, GETDATE()),
    (5, 1,1, 9, 4, GETDATE()),
    (5, 1,1, 10, 4, GETDATE());


		
INSERT INTO usersExamData (userId, exam_id,category_id, question_id, answer, attemptedAt)
VALUES
    (5, 3,1, 19, 2, GETDATE()),
    (5, 3,1, 20, 4, GETDATE()),
    (5, 3,1, 21, 1, GETDATE()),
    (5, 3,1, 22, 3, GETDATE()),
    (5, 3,1, 23, 2, GETDATE()),
	 (5, 3,1, 24, 1, GETDATE());

	
INSERT INTO usersExamData (userId, exam_id,category_id, question_id, answer, attemptedAt)
VALUES
    (6, 3,1, 19, 2, GETDATE()),
    (6, 3,1, 20, 3, GETDATE()),
    (6, 3,1, 21, 1, GETDATE()),
    (6, 3,1, 22, 2, GETDATE()),
    (6, 3,1, 23, 2, GETDATE()),
	 (6, 3,1, 24, 1, GETDATE());


	
INSERT INTO usersExamData (userId, exam_id,category_id, question_id, answer, attemptedAt)
VALUES
    (7, 3,1, 19, 1, GETDATE()),
    (7, 3,1, 20, 2, GETDATE()),
    (7, 3,1, 21, 1, GETDATE()),
    (7, 3,1, 22, 2, GETDATE()),
    (7, 3,1, 23, 2, GETDATE()),
	 (7, 3,1, 24, 1, GETDATE());

select * from exam
	 	
INSERT INTO usersExamData (userId, exam_id,category_id, question_id, answer, attemptedAt)
VALUES
    (8, 6,3, 47, 1, GETDATE()),
    (8, 6,3, 48, 1, GETDATE()),
    (8, 6,3, 49, 1, GETDATE()),
    (8, 6,3, 50, 1, GETDATE()),
    (8, 6,3, 51, 2, GETDATE()),
	 (8, 6,3, 52, 1, GETDATE()),
	 (8, 6,3, 53, 1, GETDATE()),
	 (8, 6,3, 54, 1, GETDATE());

	  	
INSERT INTO usersExamData (userId, exam_id,category_id, question_id, answer, attemptedAt)
VALUES
    (9, 6,3, 47, 1, GETDATE()),
    (9, 6,3, 48, 2, GETDATE()),
    (9, 6,3, 49, 1, GETDATE()),
    (9, 6,3, 50, 1, GETDATE()),
    (9, 6,3, 51, 2, GETDATE()),
	 (9, 6,3, 52, 2, GETDATE()),
	 (9, 6,3, 53, 1, GETDATE()),
	 (9, 6,3, 54, 1, GETDATE());


	 	  	
INSERT INTO usersExamData (userId, exam_id,category_id, question_id, answer, attemptedAt)
VALUES
    (10, 6,3, 47, 1, GETDATE()),
    (10, 6,3, 48, 2, GETDATE()),
    (10, 6,3, 49, 2, GETDATE()),
    (10, 6,3, 50, 2, GETDATE()),
    (10, 6,3, 51, 2, GETDATE()),
	 (10, 6,3, 52, 2, GETDATE()),
	 (10, 6,3, 53, 1, GETDATE()),
	 (10, 6,3, 54, 2, GETDATE());
	

		 	  	
INSERT INTO usersExamData (userId, exam_id,category_id, question_id, answer, attemptedAt)
VALUES
    (11, 6,3, 47, 1, GETDATE()),
    (11, 6,3, 48, 1, GETDATE()),
    (11, 6,3, 49, 1, GETDATE()),
    (11, 6,3, 50, 1, GETDATE()),
    (11, 6,3, 51, 2, GETDATE()),
	 (11, 6,3, 52, 2, GETDATE()),
	 (11, 6,3, 53, 1, GETDATE()),
	 (11, 6,3, 54, 2, GETDATE())
	

INSERT INTO usersExamData (userId, exam_id,category_id, question_id, answer, attemptedAt)
VALUES
    (11, 5,1, 35, 1, GETDATE()),
    (11, 5,1,  36, 1, GETDATE()),
    (11, 5,1,  37, 1, GETDATE()),
    (11, 5,1,  38, 1, GETDATE()),
    (11, 5,1,  39, 2, GETDATE()),
	 (11, 5,1,  40, 2, GETDATE()),
	 (11, 5,1,  41, 1, GETDATE()),
	 (11, 5,1,  42, 1, GETDATE()),
	 (11, 5,1,  43, 1, GETDATE()),
	 (11, 5,1,  44, 1, GETDATE()),
	 	 (11, 5,1,  45, 2, GETDATE()),
		  (11, 5,1,  46, 1, GETDATE());





			 	  	
INSERT INTO usersExamData (userId, exam_id,category_id, question_id, answer, attemptedAt)
VALUES
    (13, 5,1,  35, 1, GETDATE()),
    (13, 5,1,  36, 1, GETDATE()),
    (13, 5,1,  37, 1, GETDATE()),
    (13, 5,1,  38, 1, GETDATE()),
    (13, 5,1,  39, 2, GETDATE()),
	 (13, 5,1,  40, 2, GETDATE()),
	 (13, 5,1,  41, 1, GETDATE()),
	 (13, 5,1,  42, 1, GETDATE()),
	 (13, 5,1,  43, 1, GETDATE()),
	 (13, 5,1,  44, 1, GETDATE()),
	 	 (13, 5,1, 45, 1, GETDATE()),
		  (13, 5,1,  46, 1, GETDATE());

	

			 	  	
INSERT INTO usersExamData (userId, exam_id,category_id, question_id, answer, attemptedAt)
VALUES
    (15, 5,1,  35, 1, GETDATE()),
    (15, 5, 1, 36, 2, GETDATE()),
    (15, 5,1,  37, 1, GETDATE()),
    (15, 5,1,  38, 1, GETDATE()),
    (15, 5,1,  39, 2, GETDATE()),
	 (15, 5,1,  40, 2, GETDATE()),
	 (15, 5,1,  41, 1, GETDATE()),
	 (15, 5,1,  42, 1, GETDATE()),
	 (15, 5,1,  43, 1, GETDATE()),
	 (15, 5,1,  44, 1, GETDATE()),
	 	 (15, 5,1,  45, 2, GETDATE()),
		  (15, 5,1,  46, 1, GETDATE());


		  	
INSERT INTO usersExamData (userId, exam_id,category_id, question_id, answer, attemptedAt)
VALUES
    (17, 3,1, 19, 2, GETDATE()),
    (17, 3,1,  20, 4, GETDATE()),
    (17, 3,1,  21, 1, GETDATE()),
    (17, 3,1,  22, 3, GETDATE()),
    (17, 3,1,  23, 2, GETDATE()),
	 (17, 3,1,  24, 1, GETDATE());


	 	
INSERT INTO usersExamData (userId, exam_id,category_id, question_id, answer, attemptedAt)
VALUES
    (19, 3,1,  19, 1, GETDATE()),
    (19, 3,1,  20, 2, GETDATE()),
    (19, 3,1,  21, 3, GETDATE()),
    (19, 3,1,  22, 2, GETDATE()),
    (19, 3,1,  23, 2, GETDATE()),
	 (19, 3,1,  24, 1, GETDATE());

		 