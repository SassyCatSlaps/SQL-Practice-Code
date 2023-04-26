
--PAYROLL MANAGEMENT SYSTEM TUTORIAL  ||  practice creating a dB for a Payroll Management System
-- The database will contain an “Employee” table, a “Salary” table, a “Job” table and a “Payroll” table


--create payroll dB
CREATE DATABASE db_payroll;
-- connect tro the payroll db
USE db_payroll;

-- create tables within the dB

CREATE TABLE employee (
	employee_id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	job_id INT NOT NULL,
	first_Name VARCHAR(50) NOT NULL,
	last_Name VARCHAR(50) NOT NULL,
	date_of_Hire DATE
);

CREATE TABLE job (
	job_ID INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	job_Title VARCHAR(50) NOT NULL,
	job_Dept VARCHAR(50) NOT NULL,
	salary_ID INT NOT NULL
);

CREATE TABLE salary (
	salary_ID INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	hourly_Rate MONEY NOT NULL
);

CREATE TABLE payroll (
	payroll_Date DATE NOT NULL,
	employee_ID INT NOT NULL,
	hours_Worked INT NOT NULL
);

-- add the foreign key relationships to the employee, payroll and job tables:
ALTER TABLE employee
ADD FOREIGN KEY (job_ID) REFERENCES job(job_ID);

ALTER TABLE payroll
ADD FOREIGN KEY (employee_ID) REFERENCES employee(employee_ID);

ALTER TABLE job
ADD FOREIGN KEY (salary_ID) REFERENCES salary(salary_ID);

-- populate each table with data starting with the salary table and the hourly_rate column:
INSERT INTO salary VALUES
(19.50),
(20.00),
(20.50),
(21.00),
(21.50);

-- printing all data from the salary tbl so I can see the pk vals for each hourlyrate to make filling out the next table easier
-- SELECT * FROM salary;
	/*----	 do not have to provide the job_ID values because the IDENTITY
		property will assign the values and we don’t have to provide the column names 
		since we are providing data for each expected column.
		the data I provide for the fk (salary_ID column) must match a value in the salary_ID column of the salary table. 
		If I were to try to input a row with a salary_ID of 6, an error would be thrown because of the foreign key constraint----*/

INSERT INTO job VALUES
('AR Director', 'Accounting', 2),
('HR Director', 'Human Resources', 4),
('Developer', 'IT', 5),
('Customer Service Manager', 'Operations', 3),
('Sales Manager', 'Sales and Marketing', 1);

-- print contents of the job table so I can see the job_IDs which is needed to populate the employee table.
-- SELECT * FROM job;

-- add data to the employee table using the job_IDs from the job table
-- first integer provided for this table is a fkey and not the pkey as that will be automatically generated
INSERT INTO employee VALUES
(1, 'Sam', 'Smith', '2018-11-28'),
(4, 'Amanda', 'James', '2020-04-01'),
(3, 'David', 'McGrath', '2021-12-11'),
(2, 'Valerie', 'Ringer', '2014-07-31'),
(5, 'Andrea', 'Antivilo', '2019-02-04');

-- print employee tbl so I can see the employee_IDs to populate the payroll tbl
-- SELECT * FROM employee;

-- add data to the payroll table
INSERT INTO payroll VALUES
('2023-06-07', 1, 40),
('2023-06-07', 2, 25),
('2023-06-07', 3, 38),
('2023-06-07', 4, 22),
('2023-06-07', 5, 34);

-- query to see all the data in dB together  ||  note: I made employee_id & job_id lowercase on the employee table ONLY
SELECT * FROM employee
		INNER JOIN payroll ON employee.employee_id = payroll.employee_ID
		INNER JOIN job ON employee.job_id = job.job_ID
		INNER JOIN salary ON job.salary_ID = salary.salary_ID;

	-- I can use the tables and columns within the dB to determine the total pay for each employee in a payroll period. 
	-- create aliases to make the data easier to read when it is returned (the aliases are things like 'Hours:' Last Name:' etc.):
SELECT  employee.first_Name AS 'First Name:',
		employee.last_Name AS 'Last Name:',
		payroll.hours_Worked AS 'Hours:',
		salary.hourly_Rate AS 'Rate:',
		payroll.hours_Worked*salary.hourly_Rate AS 'Total Pay:'
		FROM employee
		INNER JOIN payroll ON employee.employee_id = payroll.employee_ID
		INNER JOIN job ON employee.job_id = job.job_ID
		INNER JOIN salary ON job.salary_ID = salary.salary_ID;



-- START PAYROLL DATABASE OPTIONAL CHALLENGE

	/* ----------------------------------
	Add a “deductions” table to dB that can be used to determine 
	amount of tax or other withholdings that would be deducted from each employee’s pay.

	-- The code below creates a "deductions" table with columns for the 
	deduction ID, employee ID, deduction type (e.g. "taxes" or "insurance"), and deduction amount.
	It also adds a fk constraint on the "employee_ID" column that references the "employee" table, 
	which ensures that each deduction is associated with a valid employee.
	
	-- can then use this table to calculate the total pay for each employee after deductions, 
	by subtracting the sum of their deductions from their gross pay (the total pay calculated in the previous query).
	---------------------------------- */

CREATE TABLE deductions (
	deduction_ID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	employee_ID INT NOT NULL,
	deduction_Type VARCHAR(50) NOT NULL,
	deduction_Amount MONEY NOT NULL
);

ALTER TABLE deductions
ADD FOREIGN KEY (employee_ID) REFERENCES employee(employee_id);

-- some fake data to insert
INSERT INTO deductions(employee_ID, deduction_Type, deduction_Amount)
VALUES
	(1, 'Health Insurance', 100.00),
	(1, '401k Contribution', 50.00),
	(2, 'Health Insurance', 75.00),
	(2, 'Garnishment', 25.00),
	(3, '401k Contribution', 100.00),
	(4, 'Child Support', 75.00),
	(5, 'Health Insurance', 100.00),
	(5, 'Garnishment', 50.00);

-- SELECT * FROM deductions;

-- join this table with the previous query to calculate the total pay for each employee after deductions:
/*  
-- In this query, I use a LEFT JOIN to join the "deductions" table with the previous query on the "employee_ID" column.
-- I then use the SUM() function to sum up the total amount of deductions for each employee. 
-- Lastly, I subtract the sum of deductions from the gross pay to calculate the total pay for each employee after deductions. 
-- The GROUP BY clause is used to group the results by employee to ensure that the deductions are correctly summed up for each employee.

-- This query will return a table that shows the first name, last name, hours worked, rate, gross pay, total deductions, & total pay after deductions for each employee.
*/

SELECT
	employee.first_Name AS 'First Name:',
	employee.last_Name AS 'Last Name:',
	payroll.hours_Worked AS 'Hours:',
	salary.hourly_Rate AS 'Rate:',
	payroll.hours_Worked*salary.hourly_Rate AS 'Gross Pay:',
	SUM(deductions.deduction_Amount) AS 'Total Deductions:',
	(payroll.hours_Worked*salary.hourly_Rate) - SUM(deductions.deduction_Amount) AS 'Total Pay After Deductions:'
FROM employee
INNER JOIN payroll ON employee.employee_id = payroll.employee_ID
INNER JOIN job ON employee.job_id = job.job_ID
INNER JOIN salary ON job.salary_ID = salary.salary_ID
LEFT JOIN deductions ON employee.employee_id = deductions.employee_ID
GROUP BY employee.first_Name, employee.last_Name, payroll.hours_Worked, salary.hourly_Rate

/*------------------------------------------------------------------------------------------------------------
Test code that doesnt do anything

SELECT 
    employee.first_Name AS 'First Name:',
    employee.last_Name AS 'Last Name:',
    payroll.hours_Worked AS 'Hours:',
    salary.hourly_Rate AS 'Rate:',
    payroll.hours_Worked*salary.hourly_Rate AS 'Total Pay:',
    deductions.deduction_Amount AS 'Deductions:',
    payroll.hours_Worked*salary.hourly_Rate - deductions.deduction_Amount AS 'Total after Deductions:'
FROM 
    employee
    INNER JOIN payroll ON employee.employee_id = payroll.employee_ID
    INNER JOIN job ON employee.job_id = job.job_ID
    INNER JOIN salary ON job.salary_ID = salary.salary_ID
    INNER JOIN deductions ON deductions.employee_ID = employee.employee_id
	-----------------------------------------------------------------------------------------------------------*/

/*SELECT SUM(deduction_Amount) as total_deductions
FROM deductions;*/

-- END PAYROLL DB CHALLENGE