/*
student_info adında bir table oluşturunuz.
student_id(PRIMARY KEY), student_name(UNIQUE), student_age(NOT NULL) ve student_dob adında sütunlar oluşturunuz.
Sütunlara uygun data tipleri ve belirtilen constraint'leri atayınız.
student_age sütunu 0-20 arası dışında değer alamaz.
student_name sütunu küçük harf karakter alamaz.
*/

CREATE TABLE student_info(
student_id smallint PRIMARY KEY,
student_name varchar(50) UNIQUE,
student_age smallint NOT NULL,
student_dob date,

CONSTRAINT age_between_0_20 CHECK (student_age BETWEEN 15 AND 20),
CONSTRAINT name_uppercase CHECK (student_name = UPPER(student_name))
);


SELECT * FROM student_info ORDER BY student_id ASC;


--Tüm sütunlara veri girerek 2 record oluşturunuz:

INSERT INTO student_info VALUES (101  , 'ALİ CAN'	, 15, '12-09-2007');
INSERT INTO student_info VALUES (102  , 'VELİ HAN'	, 16, '03-01-2007');
INSERT INTO student_info VALUES (103  , 'AYSE TAN'	, 17, '03-Sep-2006');
INSERT INTO student_info VALUES (104  , 'KEMAL KUZU', 15, null);
INSERT INTO student_info VALUES ('105', 'TOM HANKS'	, 20, '12-Sep-2003');
INSERT INTO student_info VALUES ('106', 'ANGELINA JULIE', 15, '12-Sep-2013');
INSERT INTO student_info VALUES ('107', 'BRAD PITT'	, 16, '10-Aug-2021');


SELECT * FROM student_info ORDER BY student_id ASC;


-- Spesifik iki sütuna veri giriniz:
INSERT INTO student_info(student_id, student_age) VALUES (108,17);
INSERT INTO student_info(student_id, student_age, student_name) VALUES (109,19,'JOHN DOE');


-- student_id değeri 108 olan satırın student_name değerini 'LEO OCEAN' olarak güncelleyin.
UPDATE student_info
SET student_name = 'LEO OCEAN'
WHERE student_id = 108;

-- John Doe, student_dob sütununu 11-Dec-1997 değeriyle değiştiriniz.
UPDATE student_info
SET student_dob='11-Dec-1997'
WHERE student_name='JOHN DOE';

--105 id'li dob hücresini 11-Apr-1996 değerine ve name hücresini MARK TWAIN değerine güncelle.
UPDATE student_info
SET student_dob = '11-Apr-1996', student_name = 'MARK TWAIN'
WHERE student_id = 105;

--id'si 106'dan küçük tüm student_dob değerlerini 01-Aug-2021'e güncelle.
UPDATE student_info
SET student_dob = '01-Aug-2021'
WHERE student_id < 106;

--Tüm student_age değerlerini en yüksek student_age değerine güncelleyin.
UPDATE student_info
SET student_age = (SELECT MAX(student_age) FROM student_info);

--Tüm student_dob değerlerini en düşük student_dob değerine güncelleyin.
UPDATE student_info
SET student_dob = (SELECT MIN(student_dob) FROM student_info);


SELECT * FROM student_info ORDER BY student_id ASC;


CREATE TABLE workers
(
worker_id SMALLINT,
worker_name VARCHAR(50),
worker_salary SMALLINT,
CONSTRAINT worker_id_pk PRIMARY KEY(worker_id)
);
INSERT INTO workers VALUES(101, 'Ali Can', 12000);
INSERT INTO workers VALUES(102, 'Veli Han', 2000);
INSERT INTO workers VALUES(103, 'Ayse Kan', 7000);
INSERT INTO workers VALUES(104, 'Angie Ocean', 8500);

--Veli Han'ın salary değerini en yüksek salary değerinin %20 DÜŞÜĞÜNE yükseltin.
UPDATE workers
SET worker_salary = (SELECT MAX(worker_salary) FROM workers)*0.8
WHERE worker_name='Veli Han';

--Ali Can'ın salary değerini en düşük salary değerinin %30 FAZLASINA düşürün.
UPDATE workers
SET worker_salary = (SELECT MIN(worker_salary) FROM workers)*1.3
WHERE worker_name = 'Ali Can';

-- Ortalama salary değerinden düşük olan salary değerlerini 1000 artırın.
UPDATE workers
SET worker_salary = worker_salary + 1000
WHERE worker_salary < (SELECT AVG(worker_salary) FROM workers);

--Ortalama salary değerinden düşük salary değerlerine ortalama salary değeri atayın.
UPDATE workers
SET worker_salary = (SELECT round(AVG(worker_salary)) FROM workers)
WHERE worker_salary < (SELECT AVG(worker_salary) FROM workers);


CREATE TABLE people
(
ssn INT,
name VARCHAR(50),
address VARCHAR(80)
);

INSERT INTO people VALUES(123456789, 'Mark Star', 'Florida');
INSERT INTO people VALUES(234567890, 'Angie Way', 'Virginia');
INSERT INTO people VALUES(345678901, 'Maryy Tien', 'New Jersey');
INSERT INTO people(ssn, address) VALUES(456789012, 'Michigan');
INSERT INTO people(ssn, address) VALUES(567890123, 'California');
INSERT INTO people(ssn, name) VALUES(567890123, 'California');

-- null name değerlerini "To be inserted later" değerine güncelleyin.
UPDATE people
SET name = 'To be inserted later'
WHERE name IS NULL; -- = null kullanmayın is null ya da not null şeklinde belirtilecek.

-- null address değerlerini "To be inserted later" değerine güncelleyin.
UPDATE people
SET address = 'To be inserted later'
WHERE address IS NULL; -- = null kullanmayın is null ya da not null şeklinde belirtilecek.

-- İsimsiz recordları silin.
DELETE FROM people
WHERE name = 'To be inserted later';

-- ssn değeri 123456789'dan büyük ve 345678901'den küçük olan recordları sil.
DELETE FROM people
WHERE ssn > 123456789 AND ssn < 345678901;
	-- between kullanırsak bound'lar dahil kabul edileceği için
	-- BETWEEN kullanmayacağız ---> "WHERE ssn BETWEEN (123456789,345678901)"

--address değeri NULL olmayan tüm recordları silin.
DELETE FROM people
WHERE address IS NOT NULL;

--address değeri Michigan olmayan recordları siliniz.
DELETE FROM people
WHERE address <> 'Michigan'; -- !=, <> bu ikisi de eşit değildir anlamına gelir.

CREATE TABLE workers
(
    id SMALLINT,
    name VARCHAR(50),
    salary SMALLINT,
    CONSTRAINT id4_pk PRIMARY KEY(id)
);
INSERT INTO workers VALUES(10001, 'Ali Can', 12000);
INSERT INTO workers VALUES(10002, 'Veli Han', 2000);
INSERT INTO workers VALUES(10003, 'Mary Star', 7000);
INSERT INTO workers VALUES(10004, 'Angie Ocean', 8500);
INSERT INTO workers VALUES(10005, 'John Doe', null);

-- En düşük ve en büyük salary değerlerine sahip recordları çağırın.
SELECT * FROM workers
WHERE salary
	IN ((SELECT MIN(salary)FROM workers),
		(SELECT MAX(salary) FROM workers));

--En düşük salary değerini bulun.
SELECT MIN(salary) AS minimum_salary FROM workers;

--Record sayısını(adetini) bulun.
SELECT COUNT(*) FROM workers;


-- null salary recordu sil
DELETE FROM workers WHERE salary is null;

-- SQL Interview Question: Write a code which can reads the most second high salary.
-- 1. way (not recommended)
SELECT MAX(salary) AS ikinci_en_yüksek_salary
FROM workers
WHERE salary < (SELECT MAX(salary)FROM workers);

-- 2. way (recommended way)
SELECT * FROM workers
ORDER BY salary DESC
OFFSET 1
LIMIT 1;

-- 3. way
SELECT * FROM workers
ORDER BY salary DESC
OFFSET 1
FETCH NEXT 1 ROW ONLY;


SELECT * FROM workers order by salary desc;


CREATE TABLE employees
(
  id CHAR(9),
  name VARCHAR(50),
  state VARCHAR(50),
  salary SMALLINT,
  company VARCHAR(20)
);

INSERT INTO employees VALUES(123456789, 'John Walker', 'Florida', 2500, 'IBM');
INSERT INTO employees VALUES(234567890, 'Brad Pitt', 'Florida', 1500, 'APPLE');
INSERT INTO employees VALUES(345678901, 'Eddie Murphy', 'Texas', 3000, 'IBM');
INSERT INTO employees VALUES(456789012, 'Eddie Murphy', 'Virginia', 1000, 'GOOGLE');
INSERT INTO employees VALUES(567890123, 'Eddie Murphy', 'Texas', 7000, 'MICROSOFT');
INSERT INTO employees VALUES(456789012, 'Brad Pitt', 'Texas', 1500, 'GOOGLE');
INSERT INTO employees VALUES(123456710, 'Mark Stone', 'Pennsylvania', 2500, 'IBM');

SELECT * FROM employees;

CREATE TABLE companies
(
  company_id CHAR(9),
  company VARCHAR(20),
  number_of_employees SMALLINT
);

INSERT INTO companies VALUES(100, 'IBM', 12000);
INSERT INTO companies VALUES(101, 'GOOGLE', 18000);
INSERT INTO companies VALUES(102, 'MICROSOFT', 10000);
INSERT INTO companies VALUES(103, 'APPLE', 21000);

SELECT * FROM employees;
SELECT * FROM companies;

-- number_of_employees değeri 15000'den büyük olan name ve company değerlerini çağırın.
SELECT name,company FROM employees 
WHERE company 
IN (SELECT company FROM companies 
    WHERE number_of_employees > 15000);