-- Create a Table which name as "students".
CREATE TABLE students(
id SMALLINT,
name VARCHAR(50),
address VARCHAR(100),
mark SMALLINT
);

-- Add student to student database.
-- INSERT keyword provides us to add data into the database.
INSERT INTO students VALUES(120,'Ali Can','Ankara',70);
INSERT INTO students VALUES('121','Veli Han', 'Trabzon', 75); -- int columns'a tek tirnak icinde value girebiliriz.
INSERT INTO students VALUES(122,'Ayse Tan','Bursa',85);
INSERT INTO students VALUES(123,'Mary Star','Istanbul',95);
INSERT INTO students VALUES(124,'Terry Star','Ankara',95);
INSERT INTO students VALUES(125,'Herry Star','Hatay',95);
INSERT INTO students VALUES(126,'Sally Otar','Izmır',100);

-- students tablosundaki tum verileri çağırınız.
SELECT * FROM students;

-- Soru 1: students tablosundaki id ve name sütunlarını çağırınız.
SELECT id, name FROM students;

-- Soru 2: mark 85 üzeri olan öğrenci bilgilerinin tamamını çağırınız.
SELECT * FROM students WHERE mark > 85;

-- Soru 3: address'i Ankara olan öğrencilerin isimlerini çağırınız.
SELECT name FROM students WHERE address = 'Ankara';

-- Soru 4: mark 85 üzeri ve adresi Ankara olan öğrenci isimlerini çağırınız.
SELECT name FROM students WHERE mark > 85 AND address = 'Ankara';

-- Soru 5: mark 95 veya 70 olan üğrencilerin tüm bilgilerini çağırınız.
-- 1. way
SELECT * FROM students WHERE mark = 95 OR mark = 70;
-- 2. way ==> IN
SELECT * FROM students WHERE mark IN(95,70);


-- Soru 6: mark 75 ve 95 arasında olan öğrencilerin isimlerini çağırınız.
-- 1. way
SELECT name FROM students WHERE mark >= 75 AND mark <= 95;
-- 2. way ==> BETWEEN
SELECT name FROM students WHERE mark BETWEEN 75 AND 95; -- bounds inclusive

-- Soru 7: id'si 122 ve 125 arasında olmayan öğrencilerin adreslerini yazdırınız.
-- 1. way
SELECT address FROM students WHERE id < 122 OR id > 125;
-- 2. way ==> NOT BETWEEN
SELECT address FROM students WHERE id NOT BETWEEN 122 AND 125; -- bounds inclusive
-- 3. WAY ==> NOT IN
SELECT address FROM students WHERE id NOT IN (122,123,124,125);

-- Soru 8: address'i 'Hatay' olan satırı siliniz.
DELETE FROM students WHERE address = 'Hatay';

-- Soru 9: name'i 'Ali Can' ve 'Veli Han' olan satırları(record/row) siliniz.
-- 1. way
DELETE FROM students WHERE name = 'Ali Can' OR name = 'Veli Han';
-- 2. way
DELETE FROM students WHERE name IN('Ali Can','Veli Han','Sally Otar');

-- Tum satirlari sil.
DELETE FROM students; -- Tum satirlari siler ama table silinmez. Icinde data olmayan bir tablomuz olmus olur.

-- Soru 10: id'si 123'ten büyük olan satırları siliniz.
DELETE FROM students WHERE id > 123;

TRUNCATE students; -- Tum satirlari geri getirilemeyecek sekilde siler. WHERE ile kullanilamaz.
-- truncate (ENG) == kesmek (TR)

DROP TABLE students; -- student table'ini siliniz.



