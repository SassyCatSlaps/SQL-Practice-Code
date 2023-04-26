
-- SCHOOL DB ASSIGNMENT

/*** -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		Complete these actions:
1. Using SSMS, create a “School” database.
2. Create a “Classes” table, with the following columns:
	a. Class_ID (primary key)
	b. Class_Name
3. Create a “Students” table, with the following columns:
a. Student_ID (primary key)
b. Student_Name
4. Create an “Instructors” table, with the following columns:
	a. Instructor_ID (primary key)
	b. Instructor_Name
5. Within the Students table, add the following foreign keys:
	a. Class_ID
	b. Instructor_ID
NOTE: To add the foreign keys, first add the column to the table and allow NULL values. 
Then you can use an additional ALTER TABLE to add the foreign key constraint.
6. Populate the Classes table with two classes:
	a. Software Developer Boot Camp
	b. C# Boot Camp
7. Populate the Students table with six student names of your choosing.
8. Populate the Instructors table with two Instructor names of your choosing.
9. Within the Student table, assign values to the Class_ID foreign key (i.e. assign half the students to one class and the other half to the other class).
10. Within the Students table, assign values to the Instructor_ID foreign key (i.e. assign one of the Instructors to half the students and the other Instructor to the other half of the students).
11. Run a query to display all Instructor names.
12. Run a query to display all student names in alphabetical order.
13. Run a query that displays all classes, with the students and Instructors assigned to each.
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ***/


-- 1. Open SQL Server Management Studio (SSMS) and connect to your database server.
-- 2. Create a new database called "School":
CREATE DATABASE School;

-- 3. Create a "Classes" table with the following columns:
--		a. Class_ID (primary key) || b. Class_Name
USE School;
GO

CREATE TABLE Classes (
	Class_ID INT NOT NULL PRIMARY KEY,
	Class_Name VARCHAR(50) NOT NULL
);

-- 4. Create a "Students" table with the following columns:
		-- a. Student_ID (primary key) ||  b. Student_Name ||  a. Class_ID  ||  b. Instructor_ID

CREATE TABLE Students (
	Student_ID INT NOT NULL PRIMARY KEY,
	Student_Name VARCHAR(50) NOT NULL,
	Class_ID INT NULL,
	Instructor_ID INT NULL
);

-- 5. Create an "Instructors" table with the following columns:
		-- a. Instructor_ID (primary key) || b. Instructor_Name
CREATE TABLE Instructors (
	Instructor_ID INT NOT NULL PRIMARY KEY,
	Instructor_Name VARCHAR(50) NOT NULL
);

-- 6. Populate the Classes table with two classes:
		-- a. Software Development ||  b. C# and .Net Framework
INSERT INTO Classes (Class_ID, Class_Name)
VALUES 
	(1, 'Software Development'), (2, 'C# and .Net Framework');

-- 7. Populate the Students table with six student names of your choosing:
INSERT INTO Students (Student_ID, Student_Name)
VALUES
	(1, 'Ana'),
	(2, 'Boris'),
	(3, 'Ceca'),
	(4, 'Dusan'),
	(5, 'Eva'),
	(6, 'Filip');

-- 8. Populate the Instructors table with two Instructor names of your choosing:
INSERT INTO Instructors (Instructor_ID, Instructor_Name)
VALUES
	(1, 'Janko'), (2, 'Katarina');

/* 9. Within the Student table, assign values to the Class_ID foreign key 
(i.e. assign half the students to one class and the other half to the other class): */
UPDATE Students
SET Class_ID = 1
WHERE Student_ID IN (1, 2, 3);

UPDATE Students
SET Class_ID = 2
WHERE Student_ID IN (4, 5, 6);

/* 10. Within the Students table, assign values to the Instructor_ID foreign key
(i.e. assign one of the Instructors to half the students and the other Instructor to the other half of the students): */
UPDATE Students
SET Instructor_ID = 1
WHERE Student_ID IN (1, 2, 3);

UPDATE Students
SET Instructor_ID = 2
WHERE Student_ID IN (4, 5, 6);

-- 11. Run a query to display all Instructor names:
SELECT Instructor_Name
FROM Instructors;

-- 12. Run a query to display all student names in alphabetical order (use ASC aka ascending):
SELECT Student_Name
FROM Students
ORDER BY Student_ID ASC;

-- 13. Run a query that displays all classes, with the students and Instructors assigned to each:
SELECT
	c.Class_Name,
	s.Student_Name,
	i.Instructor_Name
FROM Classes c
LEFT JOIN Students s ON c.Class_ID = s.Class_ID
LEFT JOIN Instructors i ON s.Instructor_ID = i.Instructor_ID;