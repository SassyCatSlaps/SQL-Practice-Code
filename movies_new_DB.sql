-- new dB creation
CREATE DATABASE MoviesDB;

-- use new database as the current database || optional to comment out after setting
USE MoviesDB;

-- "Actors" tbl + pk col Actor_ID, Actor_Name, and Director_ID
CREATE TABLE Actors (
Actor_ID INT NOT NULL PRIMARY KEY,
Actor_Name VARCHAR(70) NOT NULL,
Director_ID INT NOT NULL
);

-- "Directors" tbl + pk col for Director_ID, Director_Name, and Movie_Name
CREATE TABLE Directors (
Director_ID INT NOT NULL PRIMARY KEY,
Director_Name VARCHAR(70) NOT NULL,
Movie_Name VARCHAR(100) NOT NULL
);

-- vals for "Actors" tbl
INSERT INTO Actors (Actor_ID, Actor_Name, Director_ID)
VALUES
(1, 'Toshiro Mifune', 1),
(2, 'Ken Takakura', 2),
(3, 'Takashi Shimura', 3),
(4, 'Haruo Nakajima', 4),
(5, 'Bunta Sugawara', 5);

-- vals for "Directors" tbl
INSERT INTO Directors (Director_ID, Director_Name, Movie_Name)
VALUES
(1, 'Akira Kurosawa', 'Seven Samurai'),
(2, 'Junya Sato', 'Manhunt'),
(3, 'Hiroshi Inagaki', 'Samurai Trilogy'),
(4, 'Ishiro Honda', 'Godzilla'),
(5, 'Kinji Fukasaku', 'Battles Without Honor and Humanity');

-- fk assigned to "Actors" tbl  -  i.e. Director_ID = fk to Directors tbl
ALTER TABLE Actors ADD CONSTRAINT FK_DirectorID FOREIGN KEY (Director_ID)
REFERENCES Directors(Director_ID);

-- explicit join to query both tbls
SELECT n.Actor_Name, d.Director_Name, d.Movie_Name
FROM Actors n
INNER JOIN Directors d ON n.Director_ID = d.Director_ID;
