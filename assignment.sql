-- 4th question, Display days as comma separated for each training. 

create database task;
drop database if exists task;

create schema public
drop schema public cascade;

CREATE SEQUENCE session_id_seq;
drop sequence session_id_seq;

CREATE TABLE public.sessions (
	TrainingID  INT DEFAULT nextval('session_id_seq') ,
	Training varchar(255)  not NULL,
	ClassRoom varchar(255) not NULL,
	StartTime TIME not NULL,
	Duration time not NULL,
	Wk varchar(255) not NULL
);

SELECT * FROM public.sessions;
DROP TABLE public.sessions;

-- Find out the current value of the sequence
SELECT last_value FROM session_id_seq;

-- Reset the sequence if its current value is greater than 1
-- Otherwise, do nothing
ALTER SEQUENCE session_id_seq RESTART WITH 1;


SELECT last_value FROM session_id_seq;

INSERT INTO public.sessions ( Training, ClassRoom, StartTime, Duration, Wk)
VALUES('SQL SERVER','Silver-Room','10:00', '02:00', 'M');
INSERT INTO public.sessions ( Training, ClassRoom, StartTime, Duration, Wk)
VALUES('SQL SERVER','Silver-Room','10:00', '02:00', 'W');
INSERT INTO public.sessions ( Training, ClassRoom, StartTime, Duration, Wk)
VALUES('SQL SERVER','Silver-Room','10:00', '02:00', 'T');
INSERT INTO public.sessions ( Training, ClassRoom, StartTime, Duration, Wk)
VALUES('SQL SERVER','Silver-Room','10:00', '02:00', 'F');
INSERT INTO public.sessions ( Training,ClassRoom, StartTime, Duration, Wk)
VALUES('ASP.NET','Cloud-Room','11:00', '1:45', 'F');
INSERT INTO public.sessions ( Training,ClassRoom, StartTime, Duration, Wk)
VALUES('ASP.NET','Cloud-Room','11:00', '1:45', 'M');
INSERT INTO public.sessions ( Training,ClassRoom, StartTime, Duration, Wk)
VALUES('ASP.NET','Cloud-Room','11:00', '1:45', 'TH');

	
	
	SELECT
    Training,
    ClassRoom,
    TO_CHAR(StartTime, 'HH24:MI') AS StartTime,
    TO_CHAR(Duration, 'HH24:MI') AS Duration,
    STRING_AGG(Wk, ',') AS Weeks
FROM
    sessions
GROUP BY
    Training,
    ClassRoom,
    StartTime,
    Duration
ORDER BY   TRAINING Desc;
 --   CASE
   --     WHEN Training = 'ASP.NET' THEN 2
     --   WHEN Training = 'SQL SERVER' THEN 1
       -- ELSE 3
  
	END;

	
-- 8th question,

 Sample Input - 2024-01-26

 SELECT TO_CHAR(DATE_TRUNC('month',  select TO_TIMESTAMP( '2024-02-01') - INTERVAL '1 year'), 'DD/MM/YY') AS LastYearFirstDate;

 select TO_TIMESTAMP( '2024-02-01', 'YY/MM/DD');
 
 -- SELECT TO_TIMESTAMP('2023-02-01', 'YYYY-MM-DD');

 SELECT TO_CHAR(DATE_TRUNC('month', CURRENT_DATE - INTERVAL '1 year') + INTERVAL '1 month - 1 day', 'DD/MM/YY') AS LastYearLastDate;

 -- SELECT 
   -- CONCAT('01/01/', EXTRACT(YEAR FROM CURRENT_DATE) - 1) AS LastYearFirstDate,
	
--   CONCAT('31/01/', EXTRACT(YEAR FROM CURRENT_DATE) - 1) AS LastYearLastDate;
   
  
SELECT 
    TO_CHAR(DATE(CURRENT_DATE - INTERVAL '1 year'), 'DD/MM/YY') AS LastYearFirstDate,
    TO_CHAR(DATE(DATE(CURRENT_DATE - INTERVAL '1 year') + INTERVAL '1 month - 1 day'), 'DD/MM/YY') AS LastYearLastDate;



-- 12th question 

-- Write a query that shows employee name, manager and the managers manager name.



create schema worker
drop schema worker cascade;

CREATE TABLE worker.employee (
    EmpID SERIAL,
    EmpName VARCHAR(255),
    ReportsTo INT,
    Manager VARCHAR(255),
    ManagersManager VARCHAR(255)
);

drop table worker.employee;
select * from worker.employee;


INSERT INTO worker.employee( EmpName, ReportsTo, Manager , ManagersManager)
VALUES('Jacob',NULL,'','');
INSERT INTO worker.employee( EmpName, ReportsTo, Manager , ManagersManager)
VALUES('Rui',NULL,'', '');
INSERT INTO worker.employee( EmpName, ReportsTo, Manager , ManagersManager)
VALUES('Jacobson',NULL,'', '');	
INSERT INTO worker.employee( EmpName, ReportsTo, Manager , ManagersManager)
VALUES('Jess',1,'', '');	
INSERT INTO worker.employee( EmpName, ReportsTo, Manager , ManagersManager)
VALUES('Steve',1,'', '');
INSERT INTO worker.employee( EmpName, ReportsTo, Manager , ManagersManager)
VALUES('Bob',1,'', '');	
INSERT INTO worker.employee( EmpName, ReportsTo, Manager , ManagersManager)
VALUES('Smith',2,'', '');	
INSERT INTO worker.employee( EmpName, ReportsTo, Manager , ManagersManager)
VALUES('Bobbey',2,'', '');	
INSERT INTO worker.employee( EmpName, ReportsTo, Manager , ManagersManager)
VALUES('Steffi',3,'', '');	
INSERT INTO worker.employee( EmpName, ReportsTo, Manager , ManagersManager)
VALUES('Bracha',3,'', '');
INSERT INTO worker.employee( EmpName, ReportsTo, Manager , ManagersManager)
VALUES('John',5,'', '');
INSERT INTO worker.employee( EmpName, ReportsTo, Manager , ManagersManager)
VALUES('Micheal',6,'', '');
INSERT INTO worker.employee( EmpName, ReportsTo, Manager , ManagersManager)
VALUES('Paul',6,'', '');
INSERT INTO worker.employee( EmpName, ReportsTo, Manager , ManagersManager)
VALUES('Johnson',7,'', '');
INSERT INTO worker.employee( EmpName, ReportsTo, Manager , ManagersManager)
VALUES('Mic',8,'', '');
INSERT INTO worker.employee( EmpName, ReportsTo, Manager , ManagersManager)
VALUES('Stev',8,'', '');
INSERT INTO worker.employee( EmpName, ReportsTo, Manager , ManagersManager)
VALUES('Paulson',9,'','');
INSERT INTO worker.employee( EmpName, ReportsTo, Manager , ManagersManager)
VALUES('Jessica',10, '','');

SELECT * FROM WORKER.EMPLOYEE;

SELECT
    e1.EmpName AS Employee,
    e2.EmpName AS Manager,
    e3.EmpName AS ManagersManager
FROM
    worker.employee e1
LEFT JOIN
    worker.employee e2 ON e1.ReportsTo = e2.EmpID 
LEFT JOIN 

   worker.employee e3 ON e2.ReportsTo = e3.EmpID
where e1.EmpID = 18;
	
	


   




-- 16th question,Remove leading and trailing commas from a string

create schema cable
drop schema cable cascade;
 
 
CREATE TABLE cable.text (
    Id SERIAL,
    Val TEXT,
    NewVal TEXT default ''
);
DROP TABLE cable.text;

SELECT * FROM cable.text;


INSERT INTO cable.text(val,newVal) values(',,Pawan','');
INSERT INTO cable.text(val,newVal) values(',Pawan,,,,,' ,'');
INSERT INTO cable.text(val,newVal) values(',' ,'');
INSERT INTO cable.text(val,newVal) values(',,Hello,' ,'');
INSERT INTO cable.text(val,newVal) values('a,a,b,c,,,,,,,,' ,'');
INSERT INTO cable.text(val,newVal) values(NULL ,'');
INSERT INTO cable.text(val,newVal) values('' ,'');

SELECT * FROM cable.text;

SELECT
    Id,
    val,
    NULLIF(TRIM(BOTH ',' FROM val), '') AS newVal
FROM
    cable.text;
	
	
	
-- 20th question,  Find out the extension of the file names present in a table.	


create schema arrange
drop schema cable cascade;

CREATE TABLE arrange.book (
    Id SERIAL ,
    fName text,
    Extension VARCHAR(20)
);

SELECT * from arrange.book;

DROP table arrange.book;

INSERT INTO arrange.book(fName,Extension)
VALUES('f1.xlsx','');
INSERT INTO arrange.book(fName,Extension)
VALUES('file2.doc','');
INSERT INTO arrange.book(fName,Extension)
VALUES('fl.h','');
INSERT INTO arrange.book(fName,Extension)
VALUES('testfile.abcxyz','');
INSERT INTO arrange.book(fName,Extension)
VALUES('t...est..file.abcxyz','');

-- ALTER TABLE arrange.book
-- ALTER COLUMN Extension TYPE character varying(20);

-- UPDATE arrange.book
-- SET Extension = CASE
   -- WHEN POSITION('.' IN REVERSE(fName)) > 0 THEN 
     --   REVERSE(SUBSTRING(REVERSE(fName) FROM 1 FOR POSITION('.' IN REVERSE(fName))))
     -- ELSE ''
-- END;
-- SELECT 
--    fName,
  --  CASE 
   --     WHEN POSITION('.' IN fName) > 0 THEN 
     --       RIGHT(fName, LENGTH(fName) - POSITION('.' IN fName))
      --  ELSE ''
   -- END AS Extension
--FROM 
  --  arrange.book;
  
  -- SELECT fName, Extension FROM arrange.book;

SELECT 
    fName, 
    SUBSTRING(fName FROM '\.[^.]*$') AS extension
FROM 
    (VALUES 
        ('f1.xlsx'), 
        ('file2.doc'), 
        ('fl.h'), 
        ('testfile.abcxyz'), 
        ('t...est..file.abcxyz')
    ) AS arrange_book(fName);

               




-- 20,8




-- CREATE TABLE arrange.char_counts (
    --charx CHAR,
  --  charx_counts INT
-- );
-- select * from arrange.char_counts;

-- drop table arrange.char_counts;
 
-- 3rd question 



CREATE TABLE arrange.char_counts (
    character CHAR PRIMARY KEY,
    count INT
);

-- Insert the character counts into the table

SELECT 
    character,
    COUNT(character)
FROM 
    unnest(string_to_array('aaaaaabbbbbccccc', NULL)) AS characters(character)
GROUP BY 
    character;

 
-- 5th question 


CREATE TABLE arrange.example_table (
    ID INT
);

INSERT INTO arrange.example_table (ID)
VALUES (1), (2), (2), (3), (3), (3);

select * from arrange.example_table;

drop table arrange.example_table;
 
DELETE FROM arrange.example_table
WHERE ctid NOT IN (
    SELECT MIN(ctid)
    FROM arrange.example_table
    GROUP BY ID
);

 
 





