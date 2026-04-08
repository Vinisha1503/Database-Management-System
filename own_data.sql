SET search_path TO demo, public;

-- Exam table details
INSERT INTO exam(excode, extitle, exlocation, exdate, extime)VALUES
('A001', 'Computing Principles', '101', '01-11-2025', '09:00'), -- Code, Exam, Location, Date, Time
('A002', 'Database Systems', '102', '02-11-2025', '10:00'),
('A003', 'Mathematics 1', '103', '03-11-2025', '11:00'),
('A004', 'Mathematics 2', '104', '04-11-2025', '12:00'),
('A005', 'Web-Based Programming', '105', '05-11-2025', '13:00'),
('A006', 'Programming 1', '106', '06-11-2025', '14:00'),
('A007', 'Systems Development', '107', '07-11-2025', '15:00'),
('A008', 'Data Science', '108', '08-11-2025', '16:00'),
('A009', 'Information Retrieval', '109', '09-11-2025', '17:00'),
('A010', 'Programming 2', '110', '10-11-2025', '18:00');
SELECT * FROM exam;

-- Student table details
INSERT INTO student(sno, sname, semail)VALUES
(1, 'Anna Lambert', 'anna.lambert@gmail.com'), -- Unique ID, Name, Email
(2, 'Dave Patel', 'dave.patel@gmail.com'),
(3, 'Chloe Davidson', 'chloe.davidson@gmail.com'),
(4, 'Daniell Won', 'daniell.won@gmail.com'),
(5, 'Ethan Jones', 'ethan.jones@gmail.com'),
(6, 'John Smith', 'john.smith@gmail.com'),
(7, 'Georgia Ray', 'georgia.ray@gmail.com'),
(8, 'Kimberly Kim', 'kimberly.kim@gmail.com'),
(9, 'Iby Jones', 'iby.jones@gmail.com'),
(10, 'Jessica Smithy', 'jessica.smithy@gmail.com');
SELECT * FROM student;

-- Entry table details
INSERT INTO entry(eno, excode, sno, egrade)VALUES
(1, 'A001', 1, 27.0), -- Fail
(2, 'A002', 2, 91.0), -- Distinction
(3, 'A003', 3, 53.0), -- Pass
(4, 'A004', 4, NULL), -- Not taken
(5, 'A005', 5, 43.0),
(6, 'A006', 6, 93.0),
(7, 'A007', 7, NULL),
(8, 'A008', 8, 53.0),
(9, 'A009', 9, 86.5),
(10, 'A010', 10, 50.0);
SELECT * FROM entry;

-- Manually for testing cancel table
INSERT INTO cancel (eno, excode, sno, cdate, cuser) VALUES
(1, 'A001', 1, '2025-04-10 12:30:00', 'Anna Lambert'),
(2, 'A002', 2, '2025-04-10 11:15:00', 'Dave Patel');
SELECT * FROM cancel;

