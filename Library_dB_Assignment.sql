

-- LIBRARY MANAGEMENT SYSTEM PROJECT PART ** ONE ** ASSIGNMENT

-- Below is a breakdown of the image shown on "Step: 340" of TTA SQL course:
/* -------------------------------
Table = LIBRARY BRANCH
Column = BranchID (Primary Key)
Column = BranchName
Column = Address 

Table = BORROWER
Column = CardNo (Primary Key)
Column = Name Address
Column = Phone

Table = BOOK COPIES 
Column = BookID
Column = BranchID
Column = Number_Of_Copies

Table = BOOK LOANS
Column = BookID
Column = BranchID
Column = CardNo
Column = DateOut
Column = DateDue

Table = BOOKS
Column = BookID (Primary Key)
Column = Title
Column = PublisherName

Table = BOOK AUTHORS 
Column = BookID
Column = AuthorName

Table = PUBLISHER
Column = PublisherName (Primary Key)
Column = Address
Column = Phone
------------------------------------- */


/* --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
1. Using SSMS, create a database and tables exactly as laid out above.
	Meaning, create all of the items below as covered in the schema:
		a. Database.
		b. Tables.
		c. Columns.
		d. Primary keys.
		e. Foreign keys.

2. Populate the tables in the database as follows:

a. Insert into the LIBRARY_BRANCH table 6 values of your choosing with the exception that one branch name is “Sharpstown.”
	Create values for the following columns: BranchName and BranchAddress.
b. Insert into the BORROWER table 8 values of your choosing for the following columns: CardNo, Name, Address and Phone.
c. Insert into the PUBLISHER table 10 values of your choosing for the following columns: PublisherName, Address and Phone.
d. Insert into the BOOKS table 20 rows of different books. Ensure to include values in the following columns: Title and PublisherName.
	Assign one of the book titles with the value “The Lost Tribe.” If you need ideas for the other books, Google the top 100 books of all time and pull names from there.
e. Insert into the BOOK_AUTHORS table 10 different author names
	(You may insert a name multiple times with a different BookID, for example, one author may have written multiple books that have different IDs).
f. Insert into the BOOK_COPIES table values for the following columns: Number_of_Copies, BookID, and BranchID. Ensure that if a branch has a book, 
	it has at least two copies of it. (To clarify, the Number_of_Copies column should show two or more for each row).
g. Insert into the BOOK_LOANS table 10 rows including values in the following columns: BookID, BranchID, CardNo, DateOut, DateDue
	(Each BORROWER may have more than one book checked out).
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */

--Create the Library database
CREATE DATABASE Library;

--Use the Library database
USE Library;
GO

--Create the Library Branch table
CREATE TABLE Library_Branch (
    BranchID INT NOT NULL PRIMARY KEY,
    BranchName VARCHAR(260),
    Address VARCHAR(260)	
);

--Create the Borrower table
CREATE TABLE Borrower (
    CardNo INT NOT NULL PRIMARY KEY,
    Name VARCHAR(260),
    Address VARCHAR(260),
    Phone VARCHAR(260)
);

--Create the Publisher table
CREATE TABLE Publisher (
    PublisherName VARCHAR(260) NOT NULL PRIMARY KEY,
    Address VARCHAR(260),
    Phone VARCHAR(260)
);

--Create the Books table
CREATE TABLE Books (
    BookID INT NOT NULL PRIMARY KEY,
    Title VARCHAR(260),
    PublisherName VARCHAR(260),
    FOREIGN KEY (PublisherName) REFERENCES Publisher(PublisherName)
);

--Create the Book_Authors table
CREATE TABLE Book_Authors (
    BookID INT,
    AuthorName VARCHAR(260),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

--Create the Book_Copies table
CREATE TABLE Book_Copies (
    BookID INT,
    BranchID INT,
    Number_of_Copies INT,
    PRIMARY KEY (BookID, BranchID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (BranchID) REFERENCES Library_Branch(BranchID)
);

--Create the Book_Loans table
CREATE TABLE Book_Loans (
    BookID INT,
    BranchID INT,
    CardNo INT,
    DateOut DATETIME,
    DateDue DATETIME,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (BranchID) REFERENCES Library_Branch(BranchID),
    FOREIGN KEY (CardNo) REFERENCES Borrower(CardNo)
);

--Insert data into Library_Branch table
INSERT INTO Library_Branch (BranchID, BranchName, Address)
VALUES
	(1, 'Sharpstown', '123 Main St'),
	(2, 'Upper Main', '456 Market St'),
	(3, 'Lower Main', '789 Broadway'),
	(4, 'Downtown', '246 Fifth Ave'),
	(5, 'West End', '135 Sixth St'),
	(6, 'East End', '24 Elm St');

--Insert data into Borrower table
INSERT INTO Borrower (CardNo, Name, Address, Phone)
VALUES 
	(1, 'John Smith', '123 Main St', '555-1234'),
	(2, 'Jane Doe', '456 Market St', '555-5678'),
	(3, 'Mike Johnson', '789 Broadway', '555-9012'),
	(4, 'Emily Brown', '246 Fifth Ave', '555-3456'),
	(5, 'Chris Lee', '135 Sixth St', '555-7890'),
	(6, 'Anna Kim', '24 Elm St', '555-2345'),
	(7, 'David Lee', '246 Fifth Ave', '555-6789'),
	(8, 'Maria Rodriguez', '789 Broadway', '555-0123');

--Insert data into Publisher table
INSERT INTO Publisher (PublisherName, Address, Phone)
VALUES 
	('Penguin Books', '123 Main St.', '555-1234'),
	('Random House', '456 Central Ave.', '555-2345'),
	('HarperCollins', '789 Elm St.', '555-3456'),
	('Simon & Schuster', '321 Oak St.', '555-4567'),
	('Hachette Book Group', '654 Pine St.', '555-5678'),
	('Macmillan Publishers', '987 Cedar St.', '555-6789'),
	('Oxford University Press', '1111 First St.', '555-7890'),
	('Cambridge University Press', '2222 Second St.', '555-8901'),
	('John Wiley & Sons', '3333 Third St.', '555-9012'),
	('Pearson Education', '4444 Fourth St.', '555-0123');

--Insert into the Books table 20 rows of different books
INSERT INTO Books (BookID, Title)
VALUES
	(1, 'To Kill a Mockingbird'),
	(2, '1984'),
	(3, 'The Catcher in the Rye'),
	(4, 'The Great Gatsby'),
	(5, 'One Hundred Years of Solitude'),
	(6, 'Moby-Dick; or, The Whale'),
	(7, 'War and Peace'),
	(8, 'Invisible Man'),
	(9, 'Beloved'),
	(10, 'The Color Purple'),
	(11, 'The Lord of the Rings'),
	(12, 'The Hobbit'),
	(13, 'The Chronicles of Narnia'),
	(14, 'Pride and Prejudice'),
	(15, 'Jane Eyre'),
	(16, 'Wuthering Heights'),
	(17, 'Frankenstein; or, The Modern Prometheus'),
	(18, 'Dracula'),
	(19, 'The Picture of Dorian Gray'),
	(20, 'The Lost Tribe');

--Insert into the BOOK_AUTHORS table 10 different author names
INSERT INTO Book_Authors (BookID, AuthorName)
VALUES
	(1, 'Harper Lee'),
	(1, 'Truman Capote'),
	(2, 'George Orwell'),
	(3, 'J.D. Salinger'),
	(4, 'F. Scott Fitzgerald'),
	(5, 'Gabriel García Márquez'),
	(6, 'Herman Melville'),
	(7, 'Leo Tolstoy'),
	(8, 'Ralph Ellison'),
	(9, 'Toni Morrison'),
	(10, 'Alice Walker');


--Insert into the BOOK_COPIES table values for the following columns: Number_of_Copies, BookID, and BranchID.
--Ensure that if a branch has a book, it has at least two copies of it
INSERT INTO Book_Copies (Number_of_Copies, BookID, BranchID)
VALUES 
	(2, 1, 1),
	(3, 2, 1),
	(2, 3, 1),
	(2, 4, 1),
	(2, 5, 1),
	(2, 6, 1),
	(2, 7, 2),
	(3, 8, 2),
	(2, 9, 2),
	(2, 10, 2),
	(2, 11, 2),
	(2, 12, 2),
	(2, 13, 3),
	(3, 14, 3),
	(2, 15, 3),
	(2, 16, 3),
	(2, 17, 3),
	(2, 18, 3),
	(2, 19, 4),
	(3, 20, 4);

-- Insert into the BOOK_LOANS table 10 rows including values in the following columns: BookID, BranchID, CardNo, DateOut, DateDue
INSERT INTO Book_Loans (BookID, BranchID, CardNo, DateOut, DateDue)
VALUES 
	(1, 1, 1, '2023-04-25', '2023-05-25'),
	(2, 1, 2, '2023-04-25', '2023-05-25'),
	(3, 1, 3, '2023-04-25', '2023-05-25'),
	(4, 1, 4, '2023-04-25', '2023-05-25'),
	(5, 1, 5, '2023-04-25', '2023-05-25'),
	(6, 1, 6, '2023-04-25', '2023-05-25'),
	(7, 2, 1, '2023-04-25', '2023-05-25'),
	(8, 2, 2, '2023-04-25', '2023-05-25'),
	(9, 2, 3, '2023-04-25', '2023-05-25'),
	(10, 2, 4, '2023-04-25', '2023-05-25');


--LIBRARY MANAGEMENT SYSTEM PROJECT PART ** TWO ** ASSIGNMENT
--Let’s see how each of these tables relate to each other with a query:
/* -------------------------------------------------------------------------------------------------------------------------------
--using a FULL OUTER JOIN on three tables: BOOK_LOANS, BORROWER, AND BOOKS.
	BOOK_LOANS has foreign keys for the primary keys of the BORROWER and BOOKS tables. 
--By using the FULL OUTER JOIN on those three tables, you are able to see which BookID belongs in which branch, 
	the card number of the borrower, the Publisher, the date the book was checked out and the date that it is due.
--Each table has a reference to another table of some sort. Some tables will have more data than another depending 
	on how many library branches there are, how many books each branch has, how many people have obtained library cards, etc. 
---------------------------------------------------------------------------------------------------------------------------------- */

SELECT * FROM ((Book_Loans FULL OUTER JOIN Borrower ON Book_Loans.CardNo =
Borrower.CardNo) FULL OUTER JOIN Books ON Book_Loans.BookID = Books.BookID)

--notice: I may have made an error with the PublisherName column as the query returns NULL for the every field in that column

--Next I'll create some stored procedures so the library managers don't have to keep typing the same queries over and over.


--LIBRARY MANAGEMENT SYSTEM PROJECT PART ** THREE ** ASSIGNMENT

--Using the library database created, create a query that returns all book titles and the authors name.
--To get all book titles and the authors name, I joined the Books and Book_Authors tables on the BookID column
SELECT Books.Title, Book_Authors.AuthorName
FROM Books
JOIN Book_Authors ON Books.BookID = Book_Authors.BookID;



--LIBRARY MANAGEMENT SYSTEM PROJECT PART ** FOUR ** ASSIGNMENT

/* -------------------------------------------------------------------------------------------------------------------
Complete these actions:
1. Create stored procedures that will query for each of the following questions:  
a. How many copies of the book titled "The Lost Tribe" are owned by the library branch whose name is "Sharpstown"?
b. How many copies of the book titled "The Lost Tribe" are owned by each library branch?
c. Retrieve the names of all borrowers who do not have any books checked out. 

PLease note: there are a few ways one could write the code for this
---------------------------------------------------------------------------------------------------------------------- */

--a. How many copies of the book titled "The Lost Tribe" are owned by the library branch whose name is "Sharpstown"?
USE Library;
GO

CREATE PROC dbo.uspGetCopiesOfBookInBranch
    @branchName NVARCHAR(100),
    @bookTitle NVARCHAR(100)
AS
BEGIN
    SELECT COUNT(*) AS CopiesOwned
    FROM Book_Copies BC
    JOIN Books B ON BC.BookId = B.BookId
    JOIN Library_Branch LB ON BC.BranchId = LB.BranchId
    WHERE LB.BranchName = @branchName AND B.Title = @bookTitle
END


--b. How many copies of the book titled "The Lost Tribe" are owned by each library branch?
USE Library;
GO

CREATE PROC dbo.uspGetCopiesOfBookInAllBranches
    @bookTitle NVARCHAR(100)
AS
BEGIN
    SELECT LB.BranchName, COUNT(*) AS CopiesOwned
    FROM Book_Copies BC
    JOIN Books B ON BC.BookId = B.BookId
    JOIN Library_Branch LB ON BC.BranchId = LB.BranchId
    WHERE B.Title = @bookTitle
    GROUP BY LB.BranchName
END

--c. Retrieve the names of all borrowers who do not have any books checked out.
USE Library;
GO

CREATE PROC dbo.uspGetBorrowersWithNoBooksCheckedOut
AS
BEGIN
    SELECT DISTINCT B.Name
    FROM Borrower B
    LEFT JOIN Book_Loans BL ON B.CardNo = BL.CardNo
    WHERE BL.CardNo IS NULL
END