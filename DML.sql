SET search_path TO demo, public;

-- A. Insert a new student member of the society.
INSERT INTO student (sno, sname, semail)VALUES
(11, 'Bob Williams', 'bob.williams@gmail.com');
SELECT * FROM student;

-- B. Insert a new examination for the coming year.
INSERT INTO exam(excode, extitle, exlocation, exdate, extime)VALUES
('A011', 'Programming 3', '110', '11-11-2025', '16:00');
SELECT * FROM exam;

-- C. Delete a student.
INSERT INTO cancel (eno, excode, sno, cdate, cuser)
SELECT eno, excode, sno, '2025-04-10 15:00:00', 'admin'
FROM entry
WHERE sno = 2;
DELETE FROM entry
WHERE sno = 2;
DELETE FROM student
WHERE sno = 2;
SELECT * FROM cancel WHERE sno = 2;

-- D. Delete an examination.
SELECT *
FROM entry
WHERE excode = 'A010'
AND eno NOT IN (SELECT eno FROM cancel);
DELETE FROM exam WHERE excode = 'A010';
SELECT * FROM exam WHERE excode = 'A010';

-- E. Insert an examination entry.
INSERT INTO entry (eno, excode, sno, egrade) VALUES
(11, 'A011', 11, 84.0);
SELECT * FROM entry WHERE eno = 11;

-- F. Update an entry.
UPDATE entry SET excode = 'A003' WHERE eno = 11;
UPDATE entry SET sno = 5 WHERE eno = 11;
UPDATE entry SET egrade = 52.0 WHERE eno = 11;
SELECT * FROM entry WHERE eno = 11;

-- G. Produce a table showing examination timetable for given student.
SELECT
    s.sname,
    ex.excode,
    ex.extitle,
    ex.exlocation,
    ex.exdate,
    ex.extime
FROM entry e
JOIN student s ON e.sno = s.sno
JOIN exam ex ON e.excode = ex.excode
WHERE s.sno = 4
ORDER BY ex.exdate;

-- H. Produce a table showing results for each examination.
SELECT
    e.excode,
    ex.extitle,
    s.sname,
    CASE
        WHEN e.egrade IS NULL THEN 'Not taken'
        WHEN e.egrade >= 70 THEN 'Distinction'
        WHEN e.egrade >= 50 THEN 'Pass'
        ELSE 'Fail'
    END AS result
FROM entry e
JOIN student s ON e.sno = s.sno
JOIN exam ex ON e.excode = ex.excode
ORDER BY e.excode, s.sname;

-- I. Produce a table showing results for a given examination.
SELECT
    e.excode,
    ex.extitle,
    s.sname,
    CASE
        WHEN e.egrade IS NULL THEN 'Not taken'
        WHEN e.egrade >= 70 THEN 'Distinction'
        WHEN e.egrade >= 50 THEN 'Pass'
        ELSE 'Fail'
    END AS result
FROM entry e
JOIN student s ON e.sno = s.sno
JOIN exam ex ON e.excode = ex.excode
WHERE e.excode = 'A001'
ORDER BY s.sname;