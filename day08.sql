/*=================  LIKE  =================
LIKE ==> Gibi anlamına gelir. 
ILIKE => Büyük harf küçük harf fark etmeksizin anlamına gelir. (Ignore case sensitive)
Örnek:
-----
'A' ile baslayan verileri listele
'n' ile biten verileri listele
ikinci harfi 'e' olan verileri listele  
örneklerindeki işlemler için LIKE komutu kullanılır.
LIKE, sorgulama yaparken belirli pattern'leri kullanmamıza olanak verir. 
Pattern:
-------
% ==> Sıfır veya daha fazla karakteri belirtir.
_ ==> Tek bir karakteri belirtir.
Syntax:
------
SELECT * FROM tablo_adi
WHERE sutun_adi like PATTERN
=============================================
*/
CREATE TABLE musteriler 
(
id int UNIQUE,
isim varchar(50) NOT NULL,
maas int
);

INSERT INTO musteriler (id, isim, maas) VALUES (1001, 'Ali', 100000);  
INSERT INTO musteriler (id, isim, maas) VALUES (1002, 'Ayse', 57500);  
INSERT INTO musteriler (id, isim, maas) VALUES (1003, 'Feride', 71000);
INSERT INTO musteriler (id, isim, maas) VALUES (1004, 'Fatma', 42000);  
INSERT INTO musteriler (id, isim, maas) VALUES (1005, 'Kasim', 44000);
INSERT INTO musteriler (id, isim, maas) VALUES (1006, 'ahmet', 82000);

--SORU 1: isim'i 'A' harfi ile baslayan musterilerin tum bilgilerini listeleyiniz
SELECT * FROM musteriler
WHERE isim LIKE 'A%';


--SORU 2: isim'i 'a' harfi ile baslayan musterilerin tum bilgilerini listeleyiniz
SELECT * FROM musteriler
WHERE isim LIKE 'a%';

--SORU 3: isim'i buyuk harf kucuk harf gözetmeksizin 'A' ile baslayan tum bilgileri listeleyiniz
-- NOT: buyuk harf kucuk harf gozetmeksizin listelemek istersek ILIKE kullanırız
SELECT * FROM musteriler
WHERE isim ILIKE 'A%';

--SORU 4: isim'i 'e' harfi ile biten tum bilgileri listeleyiniz
SELECT * FROM musteriler
WHERE isim LIKE '%e';


--SORU 5: isim'i icerisinde 'er' olan tum bilgileri listeleyiniz.
SELECT * FROM musteriler
WHERE isim LIKE '%er%';

--SORU 6: isim'i 5 harfli olup son 4 harfi 'atma' olan tum bilgileri listeleyiniz.
SELECT * FROM musteriler
WHERE isim LIKE '_atma';

--SORU 7: isim'in 2. harfi 'a' olan tum bilgileri listeleyiniz.
SELECT * FROM musteriler
WHERE isim LIKE '_a%';

--SORU 8: isim'in 3. harfi 's' olan tum bilgileri listeleyiniz.
SELECT * FROM musteriler
WHERE isim LIKE '__s%';

--SORU 9: isim'in 3. harfi 's' olup 4 harfli tum bilgileri listeleyiniz.
SELECT * FROM musteriler
WHERE isim LIKE '__s_';


--SORU 10: isim'in ilk harfi 'F' olup en az 4 harfli tum bilgileri listeleyiniz.
SELECT * FROM musteriler
WHERE isim LIKE 'F___%';

--SORU 11: isim'in ikinci harfi 'a' olup, 4.harfi 'm' olan en az 4 harfli tum bilgilerini listeleyiniz.
SELECT * FROM musteriler
WHERE isim LIKE '_a_m%';

--SORU 12: isim'i icerisinde 'i' olmayan tum bilgileri listeleyiniz.
SELECT * FROM musteriler
WHERE isim NOT LIKE '%i%';
/*
==================  REGEXP_LIKE  ===========================
   REGEXP_LIKE: Gibi anlamına gelir. Daha karmaşık sorgulama işlemi için kullanılabilir.
		   ~ isareti ile ifade edilir.
		   ~* isareti ignore case sensitivedir.
    	Syntax:
    	--------
	SELECT * FROM tablo_adi
	WHERE sutun_adi ~ [PATTERN]
===============================================================
*/
create table exercises
(
id int UNIQUE,
kelime varchar(50) NOT NULL, 
harf_sayisi int
);

INSERT INTO exercises VALUES (1001, 'hot', 3);  
INSERT INTO exercises VALUES (1002, 'hat', 3);  
INSERT INTO exercises VALUES (1003, 'hit', 3);  
INSERT INTO exercises VALUES (1004, 'hbt', 3);  
INSERT INTO exercises VALUES (1008, 'hct', 3);  
INSERT INTO exercises VALUES (1005, 'adem', 4);  
INSERT INTO exercises VALUES (1006, 'selim', 5);  
INSERT INTO exercises VALUES (1007, 'yusuf', 5);
INSERT INTO exercises VALUES (1009, 'hAt', 3); 

-- SORU 1 : ilk harfi 'h', son harfi 't' olup, 2. harfi 'a' veya 'i' olan 3 harfli kelimelerin tum bilgilerini listeleyiniz.
SELECT * FROM exercises
WHERE kelime ~ 'h[ai]t';

-- SORU 2 : ilk harfi 'h', son harfi 't' olup, 2. harfi 'a' veya 'i' olan 3 harfli kelimeleri
-- buyuk harf kucuk harf gözetmeksizin tum bilgilerini listeleyiniz.
-- NOT: buyuk harf kucuk harf gozetmeksizin listelemek istersek ~* kullaniriz.
SELECT * FROM exercises
WHERE kelime ~* 'h[a]t';

-- SORU 3 : ilk harfi 'h', son harfi 't' olup, 2.harfi 'a' ile 'k' arasinda olan 3 harfli kelimelerin tum bilgilerini listeleyiniz
-- [a-k] --> tire isareti arasinda anlaminda kullaniliyor.
SELECT * FROM exercises
WHERE kelime ~ 'h[a-k]t';

-- SORU 4 : ilk harfi 'a' veya 's' ile baslayan kelimelerin tum bilgilerini listeleyiniz
-- ^ isareti "ile baslayan" anlamina geliyor
SELECT * FROM exercises
WHERE kelime ~ '^[as]';

-- SORU 5 : son harfi 'm' veya 'f' ile biten kelimelerin tum bilgilerini listeleyiniz.
-- $ isareti "biten" anlaminda kullaniliyor.
SELECT * FROM exercises
WHERE kelime ~ '[mf]$';

-- SORU 6 : son harfi 'm' veya 'f' ile bitmeyen kelimelerin tum bilgilerini listeleyiniz.
-- !~ "regexp_like olmayan/benzemeyen" anlamina geliyor.
SELECT * FROM exercises
WHERE kelime !~ '[mf]$';


/*
TRANSACTİON: Verileri silinmeye karsı korur
Tabloya ekledigimiz verileri silinmeye karsı korumak istiyorsak TRANSACTİON islemi kullanılır
Begin		: Transaction'ı baslatmak icin kullanılır
Savepoint	: Verileri silinmeye karsı save eder
Rollback	: Silinen verileri geri getirir
Commit		: Transaction'ı sonlandırmak icin kullanılır
*/

CREATE TABLE evraklar (
id int,
onem_derecesi varchar(40),
konusu varchar(100)
);

BEGIN; -- Transaction'ı başlattık

INSERT INTO evraklar VALUES (100, 'Çok Önemli', 'Sağlık');
INSERT INTO evraklar VALUES (101, 'Çok Önemli', 'Maliye');
INSERT INTO evraklar VALUES (102, 'Çok Önemli', 'Nüfus');
INSERT INTO evraklar VALUES (103, 'Çok Önemli', 'Mezuniyet');

SAVEPOINT x; -- bu aşamada kayıt yaptık

INSERT INTO evraklar VALUES (104, 'Önemsiz', 'Apartman Makbuzu');
INSERT INTO evraklar VALUES (105, 'Önemsiz', 'Su Faturası');


select * from evraklar;

delete from evraklar; -- Tüm veriyi sildik

ROLLBACK TO x; -- x savepointimize geri döndük silinenleri kurtardık

COMMIT; -- transaction'ı sonlandırdık. eğer sonlandırmazsak pgAdmin error verir.
delete from evraklar; -- Transactiondan çıktıktan sonra delete dersek verileri geri getiremeyiz.

-- NOT: commit işleminden sonra yani transaction işlemi sonlandırıldıktan sonra
-- delete from evraklar; koduyla evraklar tablosundaki tum verileri silerseniz
-- artık o veriler geri gelmez.
-- çünkü transaction işlemi sonlandırılmıştır.

/*
        UPPER - LOWER - INITCAP - DISTINCT 
        ------------------------------
UPPER ==> Sütunudaki verileri Büyük Harf ile listeler.
Syntax:
select UPPER(Sutun_adi) from tablo_adi;

LOWER ==> Sütunudaki verileri Küçük Harf ile listeler.
Syntax:
select LOWER(Sutun_adi) from tablo_adi;

INITCAP ==> Sütunudaki verileri ilk Harfi Büyük Diger Harfleri Küçük listeler.
Syntax:
select INITCAP(Sutun_adi) from tablo_adi;

DISTINCT ==> Sütunudaki verileri tekrarsız listeler.
Syntax:
select DISTINCT(Sutun_adi) from tablo_adi;
*/

CREATE TABLE ornek(
isim varchar(20),
soyisim varchar(25)
);

insert into ornek values('Hasan','YAN');
insert into ornek values('Veli','TURK');
insert into ornek values('Ramiz','KARA');
insert into ornek values('Elif','GUL');
insert into ornek values('Hasan','VURAL');

SELECT * FROM ornek; 

-- SORU 1: isim sutununu buyuk harflerle listeleyiniz
SELECT UPPER(isim) FROM ornek; 

-- SORU 2: isim sutununu kucuk harflerle listeleyiniz
SELECT LOWER(isim) FROM ornek;

-- SORU 3: soyisim sutununu ilk harfi buyuk diger harfleri kücük listeleyiniz
SELECT INITCAP(soyisim) FROM ornek;

-- SORU 4: isim sutununu buyuk harflerle, soyisim sutununu kucuk harflerle listeleyiniz
SELECT UPPER(isim), LOWER(soyisim) FROM ornek;

-- SORU 5: isim sutununu tekrarsız listeleyiniz
SELECT DISTINCT(isim) FROM ornek;


/*
    IS NULL - IS NOT NULL
IS NULL ==> null olan verileri getirir
IS NOT NULL ==> null olmayan verileri getirir
*/

create table denemeler
(
id char(9),
isim varchar(50),
adres varchar(50)
);

insert into denemeler values(123456789,'Ali','Istanbul');
insert into denemeler values(159753284,'Veli','Ankara');
insert into denemeler values(741258963,'Mine','Izmir');
insert into denemeler values(963278452,null,'Ankara');

SELECT * FROM denemeler;

-- SORU 1: isim sutununda null olan verileri listeleyiniz
SELECT * FROM denemeler WHERE isim IS NULL;

-- SORU 2: isim sutununda null olmayan verileri listeleyiniz
SELECT * FROM denemeler WHERE isim IS NOT NULL;