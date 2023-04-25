/*select statement that will produce a “DivideByZero” error.
	Ascode is being parsed, prog will recognize error and look to instructions placed between
	“Begin Catch” & “End Catch” keywords for what to do next. 
	we have instructed it to provide user w/ error code + description that specifies
	the exact issue – using some functions that are built into SQL Server.
	w/o the try/catch block the error message produced would be meaningless and unhelful to user */
BEGIN TRY
	SELECT 1000/0 AS Result;
END TRY

BEGIN CATCH
	SELECT
	ERROR_NUMBER() AS [Error_Code],
	ERROR_PROCEDURE() AS [Invalid_Proc],
	ERROR_MESsAGE() AS [Error_Details];
END CATCH



-- Here is a stored procedure that requires a parameter
-- first half of the statement on the first line will create the stored procedure as usual: @EmplID nvarchar(30)
	/*-- N in NVARCHAR means uNicode. It is the same as VARCHAR except it uses Unicode 
	NVARCHAR is most commonly used to allow the storage of character data that is a mixture of English and other languages.
	The second half on the first line, beginning with the “@” sign is declaring the parameter which has been given the meaningful name of “@EmpID.” 
	A variable is a special keyword that can be thought of like a “container” that will hold the passed-in data. 
	A parameter is the required data that must be passed-in as the stored procedure is being executed. 
	The variable serves as a “marker” that points directly to specific place within comp’s memory where the data is actually being remembered 
	The stored procedure will use the “marker” to retrieve the correct data from the computer’s memory 
	so that the stored procedure will now have access to the data and complete the rest of the instructions */

CREATE PROC dbo.uspGetEmployeeRecords @EmplID nvarchar(30)
AS
SELECT * FROM tblEmployees.Portland
WHERE EmpKey = @EmplIDGOEXEC dbo.uspGetEmployeeRecords @EmpID = '98002zd89'
GO
EXEC dbo.uspGetEmployeeRecords @EmplID = '98002zd89'


--this is still using adventureworks db


CREATE PROC dbo.uspGetAddress2 @City nvarchar(30)
AS

SELECT * FROM Person.Address
WHERE City LIKE @City + '%'
GO

EXEC dbo.uspGetAddress2 @City = 'New'



--passing parameters assignment in adventureworks2017
--creating a stored proc where multi parameters are passed & each declaration is separated with a comma ' , '

CREATE PROC dbo.uspGetAddress3 @City nvarchar(30), @PostalCode nvarchar(10)
AS
SELECT * FROM Person.Address
WHERE City LIKE @City + '%' AND PostalCode LIKE @PostalCode
GO
EXEC dbo.uspGetAddress3 @City='New', @PostalCode='[98]%'


 -- pass information out of a stored procedure as well (as opposed to just in)
 
 CREATE PROC dbo.uspGetAddress4 @CityName nvarchar(30) OUTPUT
 AS
 SELECT City FROM Person.Address
 WHERE AddressID = 38 AND PostalCode = 48226
 GO
 DECLARE @CityName nvarchar(30)
 EXEC dbo.uspGetAddress4 @CityName = @CityName OUTPUT
 PRINT @CityName



-- SQL SERVER SELECT DISTINCT CHALLENGE

SELECT * FROM Production.Product

SELECT DISTINCT ProductNumber, Name
FROM Production.Product;


-- SQL SERVER SELECT TOP CLAUSE CHALLENGE

		/* SYNTAX = 
		SELECT TOP number|percent column_name(s)
		FROM
		table_name
		WHERE condition;

		e.g. -
		SELECT TOP 3 * FROM Person.Person 
		SELECT TOP 50 PERCENT * FROM Production.Location
		*/

		SELECT TOP 50 PERCENT * FROM Production.Location



-- SQL MIN/MAX CHALLENGE
	
		/* SYNTAX = 
			SELECT MIN(column_name)
			FROM table_name
			WHERE condition;

			SELECT MAX(column_name)
			FROM table_name
			WHERE codition;

			find the lowest point in ReorderPoint

			SELECT MIN(ReorderPoint) AS SmallestReorderPoint
			FROM Production.Product;
		*/

		SELECT MIN(ReorderPoint) AS SmallestReorderPoint
		FROM Production.Product;


		SELECT * FROM HumanResources.EmployeePayHistory

		SELECT MAX(Rate) AS LargestRate
		FROM HumanResources.EmployeePayHistory


-- SQL LIKE CHALLENGE

			/*
			The LIKE operator is used in a WHERE clause to search for a specified pattern in a column
			There are two wildcards often used in conjunction with the LIKE operator:
			  The percent sign (%) represents zero, one, or multiple characters
			  The underscore sign (_) represents one, single character

		Here are some examples showing different LIKE operators with '%' and '_' wildcards:
			WHERE CustomerName LIKE 'a%'	Finds any values that start with "a"
			WHERE CustomerName LIKE '%a'	Finds any values that end with "a"
			WHERE CustomerName LIKE '%or%'	Finds any values that have "or" in any position
			WHERE CustomerName LIKE '_r%'	Finds any values that have "r" in the second position
			WHERE CustomerName LIKE 'a_%'	Finds any values that start with "a" and are at least 2 characters in length
			WHERE CustomerName LIKE 'a__%'	Finds any values that start with "a" and are at least 3 characters in length
			WHERE ContactName LIKE 'a%o'	Finds any values that start with "a" and ends with "o"
			
			SYNTAX =
			SELECT column1, column2, ...
			FROM table_name
			WHERE columnN LIKE pattern;

					SELECT * FROM Person.Person 

		--the following statement selects all people with a FirstName ending with "e":

			SELECT * FROM Person.Person
			WHERE FirstName LIKE '%a';

		--the following statement selects all people with a FirstName starting with "d":

			SELECT * FROM Person.Person
			WHERE FirstName LIKE 'd%';

		--the following statement selects all people with a FirstName that have an "a" in the second position:
			
			SELECT * FROM Person.Person
			WHERE FirstName LIKE '_a%';
		
		--the following SQL statement selects all people with a LastName that starts with "a" and ends with "n":

			SELECT * FROM Person.Person
			WHERE LastName LIKE 'a%n';
			*/ 

-- SQL WILDCARD CHALLENGE
-- wildcard characters are used with the LIKE operator

/* 
										**Wildcard Characters in SQL Server**
	Symbol				Description													Example
	%		Represents zero or more characters							bl% finds bl, black, blue, and blob
	_		Represents a single character								h_t finds hot, hat, and hit
	[]		Represents any single character within the brackets			h[oa]t finds hot and hat, but not hit
	^		Represents any character not in the brackets				h[^oa]t finds hit, but not hot and hat
	-		Represents any single character within the specified range	c[a-b]t finds cat and cbt

*/

		-- SYNTAX Example:

		-- SELECT * FROM HumanResources.Employee

		--the following SQL statement selects all people with jobtitle containing the pattern "es": 

		SELECT * FROM HumanResources.Employee
		WHERE JobTitle LIKE '%eng%';
		-- the following is using the [charlist] Wildcard + the % WC || the followingvstatement selects all employees w/ a jobtitle starting with "v", "d", or "t":

		SELECT * FROM HumanResources.Employee
		WHERE JobTitle LIKE '[vdt]%';



-- SQL BETWEEN CHALLENGE
-- The BETWEEN operator selects values within a given range. The values can be numbers, text, or dates.
-- The BETWEEN operator is inclusive: begin and end values are included. 

			/*

			SYNTAX = 
			SELECT column_name(s)
			FROM table_name
			WHERE column_name BETWEEN value1 AND value2;

			*/
	-- the following SQL statement selects all products with a price between 4 and 8:	

		SELECT * FROM Production.BillOfMaterials
		WHERE PerAssemblyQty BETWEEN 4 AND 8;