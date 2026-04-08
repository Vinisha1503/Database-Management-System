SET search_path TO demo, public;

DROP VIEW IF EXISTS exam_results;
DROP TABLE IF EXISTS cancel;
DROP TABLE IF EXISTS entry;
DROP TABLE IF EXISTS student;
DROP TABLE IF EXISTS exam;

-- Exam Table
CREATE TABLE exam (
    excode CHAR(4) PRIMARY KEY,
    extitle VARCHAR(200) UNIQUE,
    exlocation VARCHAR(200),
    exdate DATE CHECK (exdate >= '01-11-2025' AND exdate <= '30-11-2025'),
    extime TIME CHECK (extime >= '09:00' AND extime <= '18:00')
);
COMMENT ON TABLE exam IS 'Data for when exams are held';

-- Student Table
CREATE TABLE student (
    sno INTEGER PRIMARY KEY,
    sname VARCHAR(200),
    semail VARCHAR(200)
);
COMMENT ON TABLE student IS 'Data on students';

-- Entry Table
CREATE TABLE entry (
    eno INTEGER PRIMARY KEY,
    excode CHAR(4),
    sno INTEGER,
    egrade DECIMAL(5,2) CHECK (egrade IS NULL OR (egrade >= 0 AND egrade <= 100)),
    FOREIGN KEY (excode) REFERENCES exam(excode),
    FOREIGN KEY (sno) REFERENCES student(sno)
);
COMMENT ON TABLE entry IS 'Records exams taken by students';

-- Cancel Table
CREATE TABLE cancel (
    eno INTEGER,
    excode CHAR(4),
    sno INTEGER,
    cdate TIMESTAMP,
    cuser VARCHAR(200),
    FOREIGN KEY (eno) REFERENCES entry(eno),
    FOREIGN KEY (excode) REFERENCES exam(excode),
    FOREIGN KEY (sno) REFERENCES student(sno)
);
COMMENT ON TABLE cancel IS 'Log of cancelled exam entries';

-- View for student results
CREATE VIEW exam_results AS
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
COMMENT ON VIEW exam_results IS 'Result obtained by each student for each exam';

-- Function for student deletion
CREATE OR REPLACE FUNCTION cancelled_entries()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO cancel (eno, excode, sno, cdate, cuser)
    SELECT eno, excode, sno, NOW(), 'system'
    FROM entry
    WHERE sno = OLD.sno;

    DELETE FROM entry WHERE sno = OLD.sno;

    RETURN OLD;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION cancelled_entries IS 'Moves into cancel table';

-- Trigger for student deletion
CREATE TRIGGER cancel_on_student_delete
BEFORE DELETE ON student
FOR EACH ROW
EXECUTE FUNCTION cancelled_entries();
COMMENT ON TRIGGER cancel_on_student_delete ON student IS 'Cancels before student is deleted';