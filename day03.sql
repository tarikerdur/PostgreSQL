/*==========================DELETE==================================
DML Grubundan ==> DELETE komutu Tablodaki Verileri Siler.
Syntax:
------
DELETE FROM tablo_adi WHERE şart;
=====================================================================*/

create table kursiyerler
(
id int,
isim varchar(20),
adres varchar(15),
sinav_notu int
);

INSERT INTO kursiyerler VALUES(10, 'Arif Can', 'Burdur', 75);
INSERT INTO kursiyerler VALUES(11, 'Vural Tur', 'Trabzon', 95);
INSERT INTO kursiyerler VALUES(12, 'Aylin Tan', 'Bursa', 90);
INSERT INTO kursiyerler VALUES(13, 'Derya Soylu', 'Istanbul', 80);
INSERT INTO kursiyerler VALUES(14, 'Yavuz Bal', 'Ankara', 85);
INSERT INTO kursiyerler VALUES(15, 'Eren Tan', 'Hatay', 90);
INSERT INTO kursiyerler VALUES(16, 'Harun Reşit', 'Isparta', 100);
INSERT INTO kursiyerler VALUES(17, 'Behlül Dana', 'Afyon', 100);

--SORU 1: kursiyerler tablosundaki sinav_notu 75 olan satırı siliniz
DELETE FROM kursiyerler WHERE sinav_notu = 75;

--SORU 2: kursiyerler tablosundaki adres'i 'Trabzon' olan satırı siliniz
DELETE FROM kursiyerler WHERE adres = 'Trabzon';

--SORU 3: kursiyerler tablosundaki isim'i 'Derya Soylu' veya 'Yavuz Bal' olan satırları siliniz
DELETE FROM kursiyerler WHERE isim IN('Derya Soylu','Yavuz Bal'); -- IN
--DELETE FROM kursiyerler WHERE isim ='Derya Soylu' OR isim = 'Yavuz Bal'; --> OR (Not Recommended)

--SORU 4: kursiyerler tablosundaki sinav_notu 100 den küçük olan satırları siliniz
DELETE FROM kursiyerler WHERE sinav_notu < 100;

--SORU 5: kursiyerler tablosundaki tüm verileri siliniz
DELETE FROM kursiyerler;

--SORU 6: kursiyerler tablosunu siliniz
DROP TABLE kursiyerler;




/*==========================UPDATE===========================
DML Grubundan ==> UPDATE komutu Tablodaki Verileri Günceller
Syntax:
------
UPDATE tablo_adi SET sutun_adi=yeni_deger WHERE şart
==============================================================*/

CREATE TABLE film
(
film_no int,
film_ismi varchar(30),
film_turu varchar(30)
);

INSERT INTO film VALUES (100, 'Eyvah Eyvah', 'Komedi');
INSERT INTO film VALUES (200, 'Kurtlar Vadisi', 'Aksiyon');
INSERT INTO film VALUES (300, 'Eltilerin Savasi', 'Komedi');
INSERT INTO film VALUES (400, 'Aile Arasinda', 'Komedi');
INSERT INTO film VALUES (500, 'GORA', 'Bilim Kurgu');
INSERT INTO film VALUES (600, 'Organize Isler', 'Komedi');
INSERT INTO film VALUES (700, 'Babam ve Oglum', 'Dram');


-- SORU 1: film_no'su 300 olan film'in film_ismi'ni 'Recep İvedik' olarak güncelleyeniz.
UPDATE film SET film_ismi='Recep Ivedik' WHERE film_no=300;

-- SORU 2: film tablosundaki tüm film_turu'nu 'Aksiyon' olarak güncelleyeniz.
UPDATE film SET film_turu = 'Aksiyon';

-- SORU 3: film_no'su 100 olan film'in film_ismi'ni 'Cakallarla Dans' , film_turu'nu 'Komedi' olarak güncelleyiniz.
UPDATE film 
SET film_ismi = 'Cakallarla Dans', film_turu = 'Komedi'
WHERE film_no = 100;

-- SORU 4: film_ismi 'Babam ve Oglum' olan film'in
-- film_turu'nu 'Dram' olarak güncelleyiniz.
UPDATE film SET film_turu = 'Dram' WHERE film_ismi='Babam ve Oglum';

-- SORU 5: film tablosundaki 'GORA' olan değeri,
-- 'AROG' olarak güncelleyiniz.
UPDATE film SET film_ismi = 'AROG' WHERE film_ismi = 'GORA';

-- SORU 6: film tablosundaki film_no değeri 300'den büyük olanların,
-- film_no'sunu 1 artırarak güncelleyiniz.
UPDATE film SET film_no = film_no+1 WHERE film_no > 300;


/*============================ALTER==================================
DDL Grubundan==> ALTER komutu tabloyu günceller.

ADD COLUMN ==> yeni sutun ekleyerek tabloda güncellemeler yapar
DROP COLUMN ==> mevcut olan sutunu silerek tabloda güncellemeler yapar
RENAME COLUMN ==> sutunun ismini degistirerek tabloda güncellemeler yapar       
RENAME ==> tablonun ismini degistirerek tabloda güncellemeler yapar

Syntax:
-------
alter table tablo_adi <güncelemek istedigimiz secenek>;
=====================================================================*/

create table arabalar
(
id int,
marka varchar(20),
model varchar(20),
vites varchar(20),
fiyat int
);


insert into arabalar values(1,'Mercedes','C180','Otomatik',900000);
insert into arabalar values(2,'Toyota','Corolla','Otomatik',400000);
insert into arabalar values(3,'Honda','Civic','Otomatik',500000);
insert into arabalar values(4,'Citroen','C3','Manuel',450000);

-- SORU 1: arabalar tablosuna kilometre varchar(10) seklinde yeni sutun ekleyiniz.
ALTER TABLE arabalar ADD COLUMN kilometre varchar(10);

-- SORU 2: arabalar tablosuna  yas int seklinde yeni sutun ekleyiniz
ALTER TABLE arabalar ADD COLUMN yas int;

-- SORU 3: arabalar tablosuna airbag varchar(10) seklinde yeni sutun ekleyiniz default degeri 'mevcut' olsun 
ALTER TABLE arabalar ADD COLUMN airbag varchar(10) DEFAULT 'mevcut';

-- SORU 4: arabalar tablosundan vites sutununu siliniz
ALTER TABLE arabalar DROP COLUMN vites;

-- SORU 5: arabalar tablosundaki fiyat sutununun ismini bedel olarak güncelleyiniz
ALTER TABLE arabalar RENAME COLUMN fiyat TO bedel;

-- SORU 6: arabalar tablosunun ismini galeri olarak güncelleyiniz
ALTER TABLE arabalar RENAME TO galeri;

-- SORU 7: galeri tablosunun ismini arabalar olarak güncelleyiniz
ALTER TABLE galeri RENAME TO arabalar;

SELECT * FROM arabalar;

/*========================CONSTRAINT -- KISITLAMALAR=======================================================
'Constraint'ler gerekirse kullanilir. Mutlaka kullanmak zorundayiz diye bir sey yok.
'Constraint'ler column'a verilir.

1) UNIQUE -->  Bir sütundaki verilerin BENZERSİZ olmasıdır.(2 veya daha fazla null deger kabul eder)
unique constraint'inin null degere karsı zaafı vardır birden fazla null deger kabul eder.
2) NOT NULL --> Bir sütunun NULL içermemesini sağlar
   (NOT NULL kısıtlaması veri türünden hemen sonra yazılır. CONSTRAINT ismi tanımlanmaz.)   

3) PRIMARY KEY --> UNIQUE(BENZERSİZ) + NOT NULL 
   Bir tabloda en fazla bir adet Primary Key olur. 
   iki sutunun birlesiminden bir Primary Key oluşturulmasına ise Composite Primary Key denir.

4) CHECK --> Bir sütunun değer aralığını sınırlamak için kullanılır.

5) FOREIGN KEY --> Başka bir tablodaki PRİMARY KEY'i referans göstermek için kullanılır.
   Böylelikle, tablolar arasında Parent- Child ilişkisi oluşur.
============================================================================================================*/

/*
SORU1: memurlar isminde bir tablo oluşturunuz. 
id, isim, maas, mezuniyet sutunları olsun.
id sutununun data tipi int olsun. PRİMARY KEY kısıtlaması olsun.
isim sutununun data tipi varchar(30) olsun. UNIQUE kısıtlaması olsun.
maas sutununun data tipi int olsun. maas 5000 buyuk olsun.
mezuniyet sutununun data tipi varchar(25) olsun. NOT NULL kısıtlaması olsun.    
*/

CREATE TABLE memurlar(
id int PRIMARY KEY,                 -- UNIQUE(BENZERSİZ) + NOT NULL
isim varchar(30) UNIQUE,            -- UNIQUE(BENZERSİZ) (unique constraintinde istersek null deger girebiliriz.)
maas int CHECK (maas > 5000),       -- CHECK
mezuniyet varchar(25) NOT NULL      -- NOT NULL 
);

INSERT INTO memurlar VALUES(1,'Ali',10000,'Lisans');
INSERT INTO memurlar VALUES(2,'Ahmet',15000,'Yüksek Lisans');
INSERT INTO memurlar VALUES(3,'Altug',20000,'Lisans');
INSERT INTO memurlar VALUES(4,'Elif',18000,'Lisans');

INSERT INTO memurlar VALUES(1,'Zulal',20000,'Lise');             -- PRIMARY KEY SEBEBİYLE ERROR VERİR
INSERT INTO memurlar VALUES(5,'Altug',25000,'Yüksek Lisans');    -- UNIQUE SEBEBİYLE ERROR VERİR
INSERT INTO memurlar VALUES(6,'Hayri',4000,'Lisans');            -- CHECK SEBEBİYLE ERROR VERİR
INSERT INTO memurlar VALUES(7,'Burak',30000,null);               -- NOT NULL SEBEBİYLE ERROR VERİR

SELECT * FROM memurlar;
