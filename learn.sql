SELECT customerid, firstname, middlename, lastname, emailid, customerpassword, phoneno, isactive
	FROM public.customer;
	
	
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    manager_id INT
);
Select * from  public.employees;

ALTER TABLE employees
ADD COLUMN employee_name VARCHAR(255);

INSERT INTO employees (employee_id, manager_id, employee_name)
VALUES
    (1, NULL, 'John'),
    (2, 1, 'Alice'),
    (3, 1, 'Bob'),
    (4, 2, 'Charlie'),
	(5, 2, 'David');


Select * from  public.employees;	
-- assignment Recursive CTE

WITH RECURSIVE subordinates AS (
    SELECT employee_id, employee_name, manager_id
    FROM employees
    WHERE manager_id = 2

    UNION ALL

    SELECT e.employee_id, e.employee_name, e.manager_id
    FROM employees e
    INNER JOIN subordinates s ON e.manager_id = s.employee_id
)
SELECT employee_name
FROM subordinates
WHERE manager_id = 2;

********

CREATE TABLE public.productarchive (
	productid int not NULL GENERATED ALWAYS AS IDENTITY,
	productname varchar NULL,
	productprice decimal(18,2) NULL
);

insert into public.productarchive(productname, productprice)
values ('Smart LED TV', 1000.00);
insert into public.productarchive(productname, productprice)
values ('SOFTSPUN Microfiber Cloth', 100.00);

select * from public.productarchive;

-- 26/01/2024

-- Views

CREATE VIEW vw_customer AS
SELECT DISTINCT c.firstname, c.middlename, c.lastname, c.emailid, 
                pa.productname, pa.productprice
FROM customer c
INNER JOIN productarchive pa ON c.customerid = pa.productid;


SELECT definition
FROM pg_views
WHERE viewname = 'vw_customer';




-- Materalized Views(assignment)

CREATE MATERIALIZED VIEW mv_customer AS
SELECT DISTINCT c.firstname, c.middlename, c.lastname, c.emailid, 
                pa.productname, pa.productprice
FROM customer c
LEFT JOIN productarchive pa ON c.customerid = pa.productid with data;
DROP materialized view mv_customer;



REFRESH MATERIALIZED VIEW mv_customer;
SELECT * FROM CUSTOMER;
SELECT * FROM mv_customer;
INSERT INTO public.customer(firstname,middlename,lastname,emailid,customerpassword,phoneno,isactive)
VALUES('John','David','','john@gmail.com',123,458745,true);

INSERT INTO public.customer(firstname,middlename,lastname,emailid,customerpassword,phoneno,isactive)
VALUES('Stephen','','','stephen@gmail.com',143,45878745,true);

INSERT INTO public.customer(firstname,middlename,lastname,emailid,customerpassword,phoneno,isactive)
VALUES('Peter','','','peter@gmail.com',007,123321,true);



-- Numeric Functions (Assignment)

--  ABS()
SELECT ABS(-10), ABS(15.5), ABS(-20.123);

--  ACOS()
SELECT ACOS(0.5), ACOS(0), ACOS(-1);

--  ASIN()
SELECT ASIN(0.5), ASIN(0), ASIN(-1);

--  ATAN()
SELECT ATAN(0.5), ATAN(0), ATAN(-1);

--  ATAN2()
SELECT ATAN2(1, 2), ATAN2(0, 1), ATAN2(-1, -1);

--  CEIL() and CEILING()
SELECT CEIL(2.3), CEIL(-3.8), CEILING(4.6), CEILING(-5.4);

--  COS()
SELECT COS(0), COS(PI()), COS(PI() / 3);

--  COT()
SELECT COT(0), COT(PI() / 4), COT(-PI() / 3);

--  DEGREES()
SELECT DEGREES(PI()), DEGREES(PI() / 2), DEGREES(2 * PI());

--  EXP()
SELECT EXP(1), EXP(2), EXP(0);

--  FLOOR()
SELECT FLOOR(3.8), FLOOR(-2.4), FLOOR(PI());

-- GREATEST()
SELECT GREATEST(2, 4, 6), GREATEST(-1, -3, -5), GREATEST(1.5, 2.5, 0.5);

--  LEAST()
SELECT LEAST(2, 4, 6), LEAST(-1, -3, -5), LEAST(1.5, 2.5, 0.5);

--  LOG() 
SELECT LOG(10), LOG(EXP(1)), LOG(1);


--  MOD()
SELECT MOD(10, 3), MOD(-10, 3), MOD(7, -3);

--  PI()
SELECT PI();

--  POW() and POWER()
SELECT POW(2, 3), POW(10, -2), POWER(3, 2);

--  RADIANS()
SELECT RADIANS(180), RADIANS(90), RADIANS(45);

-- ROUND()
SELECT ROUND(3.8), ROUND(-2.4), ROUND(PI());

--  SIN()
SELECT SIN(0), SIN(PI() / 6), SIN(-PI() / 4);

-- SQRT()
SELECT SQRT(9), SQRT(25), SQRT(2);

 TAN()
SELECT TAN(0), TAN(PI() / 4), TAN(-PI() / 6);



-- upsert

DROP TABLE IF EXISTS public.product_delta;

CREATE TABLE IF NOT EXISTS public.product_delta
(
    productname character varying(100) COLLATE pg_catalog."default",
    productprice numeric(10,2)
)

INSERT INTO public.product_delta (productname, productprice)
VALUES ('Fossil Chronograph White Dial Mens Watch-CH2882', 6000);

INSERT INTO public.product_delta (productname, productprice)
VALUES ('Seiko Analog Blue Dial Mens Watch-SNKP17K1', 14850);

INSERT INTO public.product_delta (productname, productprice)
VALUES ('Titan Black Dial Analog Watch for Men -NR1802SL11', 3000);

INSERT INTO public.product_delta (productname, productprice)
VALUES ('Titan Silver White Dial Analog Watch For Men -NR1733KM03', 1918);

INSERT INTO public.product_delta (productname, productprice)
VALUES ('Casio Analog Black Dial Mens Watch-EFV-100L-1AVUDF', 4897);

select * from public.product_delta;

-- Method 1
INSERT INTO public.product(productname, productype)
SELECT * FROM 
(
	SELECT * FROM public.product_delta
)src ON CONFLICT (productname)
DO UPDATE 
SET productprice = EXCLUDED.productprice



-- Method 2 Assignment

WITH upsert AS (
    UPDATE public.product_delta AS tgt
    SET unit_price = src.unit_price,
        modified_date = NOW()
    FROM product_delta AS src
    WHERE tgt.productname = src.productname
    AND tgt.product_type = src.product_type
    RETURNING src.* 
)

SELECT * FROM upsert;


			  
INSERT INTO product(product_name, product_type, unit_price, modfied_date)
select src.product_name, src.product_type, src.unit_price, now()
from product_delta src
left join product tgt ON src.product_name = tgt.product_name
AND src.product_type = tgt.product_type
where tgt.product_name = NULL
and src.status != 'Y';


