-- SQL: Database'deki verileri yönetmek, sorgulamak ve tasarlamak için kullanılan bir sorgu dilidir.
--		SQL tablolar dataları birbiri ile ilişkili tablolarda depolar. 
-- Database: Birbiriyle ilgili dataların toplandığı yerdir.
/*
		Benefits:
1- Yüksek miktarda veri depolanabilir.
2- Create, Read, Update, Delete (CRUD) operasyonları kolayca yapılır.
3- Data'ya ulaşım kontrollü ve kolaydır.
4- Güvenlidir.

DBMS: DataBase Management System.

	Data Definiton Language
CREATE -> Creates a Table or Database.
DROP ---> Deletes the table.
ALTER --> Updates the table.
			ALTER
		ADD
		DROP
		RENAME COLUMN
		RENAME TO
		

	Data Management Language
INSERT -> Adds data into the Table.
UPDATE -> Updates the data which belongs within the table.
DELETE -> Deletes the data which belongs within the table.

	Data Query Language
SELECT -> Provides us to read and retrieve the data within the table.
*/

CREATE TABLE calisanlar(
id char(4),
isim varchar(15),
soyisim varchar(30),
tel varchar(15),
email varchar(50),
adres varchar(50),
maas int
);

SELECT * FROM calisanlar;
SELECT id, isim FROM calisanlar;

-- Olusturmus oldugumuz bir tablodan yeni bir tablo oluşturmak için
CREATE TABLE maas AS SELECT id, maas FROM calisanlar;
SELECT * FROM maas;

-- SQL tablolar dataları birbiri ile ilişkili tablolarda depolar. 
-- Constraint (Kısıtlama) Parent - Child ilişkisi
-- Primary Key
-- Foreign Key
-- Unique
-- Check
-- NOT NULL

/*
İlişkişi tablolar must have a Primary Key. Primary Key includes NOT NULL and Unique constraints already.
Bir tabloda her satır için tanımlayıcı görevi görür.
3 ways to define a Primary Key.
*/
CREATE TABLE calisanlar1(
id char(4) PRIMARY KEY,		-- 1. yol
isim varchar(15),
soyisim varchar(30),
tel varchar(15)
);

CREATE TABLE calisanlar2(
id char(4),
isim varchar(15),
soyisim varchar(30),
tel varchar(15),
		PRIMARY KEY(id)		-- 2. yol
);

CREATE TABLE calisanlar3(
id char(4),
isim varchar(15),
soyisim varchar(30),
tel varchar(15),
		CONSTRAINT thirdWayOfDefinePrimaryKey PRIMARY KEY (id)	-- 3. yol (burada constraint ismini kendimiz verebiliyoruz.)
);


/*
	FOREIGN KEY
PRIMARY KEY olan tablo ile ilişki oluşturmak için kullanılır.
*/
CREATE TABLE ucret(
id char(4),
maas real, -- real ---> ondalıklı sayılar
		FOREIGN KEY (id) REFERENCES calisanlar1(id)
);


-- Check: Bir alana girilecek değerleri sınırlamak için kullanılır.
-- Unique: Bir sütundaki dataların without repetition(tekrarsız) olmasını sağlar.
-- Not Null: Bir sütunun null value içermemesini yani boş olmamasını sağlar.

CREATE TABLE calisanlar4(
id char(4) PRIMARY KEY,
isim varchar(15) UNIQUE,
soyisim varchar(30),
tel varchar(15),
email varchar(50),
adres varchar(50),
maas int NOT NULL,
CHECK (maas>1000),
UNIQUE (maas,tel)
);

-- sonradan pk oluştur.
ALTER TABLE calisanlar ADD PRIMARY KEY (id);

-- Mevcut pk'yı değiştirmek için önce tablodaki pk'yı kaldırmak ardından yeniden atama yapmak gerekir.
ALTER TABLE calisanlar
DROP CONSTRAINT calisanlar_pkey, -- pk'yı değiştirirken önce silmek istediğimiz constraint key ismini yazıyoruz.
ADD PRIMARY KEY (id); -- sonrasında atama yapıyoruz.

ALTER TABLE calisanlar
ADD UNIQUE (email);


ALTER TABLE calisanlar
ADD CONSTRAINT check_maas CHECK (maas>1000);

-- soyisim sütununa x veya w harfiyle baslayan veri girilmesin
ALTER TABLE calisanlar
ADD CONSTRAINT check_soyisim CHECK (NOT (soyisim LIKE 'x%' OR soyisim LIKE '%w'));

-- Yeni column eklemek için:
-- COLUMN yazmayınca da kabul ediyor.
ALTER TABLE calisanlar
ADD ulke varchar(20);

-- Birden fazla da eklenebiliyor.
ALTER TABLE calisanlar
ADD sehir varchar(20),
ADD posta_kodu char(5);

-- Böyle de sütun silebiliriz.
ALTER TABLE calisanlar
DROP ulke;

-- Sütun adı değiştirme
ALTER TABLE calisanlar
RENAME sehir TO il;

-- Tablo adı değiştirme
ALTER TABLE calisanlar
RENAME TO personel;


-- Modify (MySQL'de olan bi komut ama PostgreSQL'de TYPE/SET olarak kullanıyor)
-- Sütunların özelliklerini değiştirme
ALTER TABLE personel
ALTER COLUMN tel TYPE char(11);

-- Tablo silmek için
DROP TABLE calisanlar4;

CREATE TABLE calisanlar4(
id char(4) PRIMARY KEY,
isim varchar(15) UNIQUE,
soyisim varchar(30),
tel varchar(15),
email varchar(50),
adres varchar(50),
maas int NOT NULL,
CHECK (maas>1000),
UNIQUE (maas,tel)
);

INSERT INTO calisanlar4 VALUES('1234','Tarık','Erdur','05467467049','tarikerdur13@hotmail.com','İzmir',30000);
--Tüm sütunlara veri eklemek için;

INSERT INTO calisanlar4 VALUES('1234','Erol','Evren','05654545454','erol@gmail.com','Ankara',1000);
--Bu eklemeyi kabul etmez. Çünkü maas 1000'den büyük olmalı. Maas sutununda CHECK constraint mevcut

INSERT INTO personel VALUES('1234','Erol','xEvren','05654545454','erol@gmail.com','Ankara',1500);
--Bu eklemeyi kabul etmez. Çünkü soyisim x veya w ile başlayamaz. Soyisim sutununda CHECK constraint mevcut

INSERT INTO calisanlar4 VALUES('1235','Erol','Can','05654545455','erol@gmail.com','Ankara',1600);
--Bu eklemeyi kabul etmez. Çünkü isim sütunu UNIQUE.

INSERT INTO calisanlar4 VALUES('1235','ErolCan','Can','05654545455','erol@gmail.com','Ankara',1600);
--İstediğimiz sütunlara ekleme yapmak için;

INSERT INTO calisanlar4 (isim,soyisim,tel) Values ('Emre','Kaya','0546546986');
--id sütunu primary key olduğu için veri girmemiz zorunlu. Bu insert komutunu kabul etmez

INSERT INTO calisanlar4 (id,isim,soyisim,tel,maas) Values ('1236','Emre','Kaya','02358465654',1700);
INSERT INTO calisanlar4 (maas,isim,soyisim,tel,id) VALUES (1800,'Hasan', 'KayaCan','02358465654','1237');


/*
--DML->UPDATE->Tablodaki verileri güncellemek için kullanırız
--SYNTAX

UPDATE <tablo_adi>
SET <sutun_adi>
*/

UPDATE calisanlar4
SET adres = 'Bogota'
WHERE isim = 'Tarık';



UPDATE calisanlar4
SET adres='Bursa';

--Erol isimli verinin adresini ankara olarak güncelleyiniz
UPDATE calisanlar4
SET adres='Ankara'
WHERE isim='Erol';

--Emre isimli verinin maasını 2000 olarak güncelleyiniz
update calisanlar4
set maas=2000
WHERE isim='Emre';

SELECT * FROM calisanlar4 ORDER BY id;





create table calisanlar(
id char(4),
isim varchar(50),
maas int,
constraint id_pk primary key(id)
);

insert into calisanlar values('1001', 'Ahmet Aslan', 7000);
insert into calisanlar values('1002', 'Mehmet Yılmaz' ,12000);
insert into calisanlar values('1003', 'Meryem ', 7215);
insert into calisanlar values('1004', 'Veli Han', 5000);

create table aileler (
id char(4),
cocuk_sayisi int,
ek_gelir int,
constraint id_fk foreign key(id)references calisanlar(id)
);

insert into aileler values('1001', 4, 2000);
insert into aileler values('1002', 2, 1500);
insert into aileler values('1003', 1, 2200);
insert into aileler values('1004', 3, 2400);


-- Veli Han'ın maaşına %20 zam yapın.
UPDATE calisanlar
SET maas = maas*1.2
WHERE isim='Veli Han';

select * from calisanlar;
select * from aileler;


CREATE TABLE hastaneler
(
id char(5) primary key,
isim char(30),
sehir char(15),
ozel char(1)
);
insert into hastaneler values('H101', 'Aci Madem Hastanesi', 'Istanbul', 'Y');
insert into hastaneler values('H102', 'HasZeki Hastanesi', 'Istanbul', 'N');
insert into hastaneler values('H103', 'Medikol Hastanesi', 'Izmir', 'Y');
insert into hastaneler values('H104', 'Memoryil Hastanesi', 'Ankara', 'Y');


CREATE TABLE hastalar(
kimlik_no CHAR(11) PRIMARY Key,
isim CHAR(50) ,
teshis  CHAR(20)
);
insert INTO hastalar values('12345678901','Ali Can','Gizli Seker');
insert INTO hastalar values('45678901121','Ayse Yilmaz','Hipertansiyon');
insert INTO hastalar values('78901123451','Steve Jobs','Pankreatit');
insert INTO hastalar values('12344321251','Tom Hanks','COVID 19');

create table bolumler(
bolum_id char(5),
bolum_adi char(20)
);

insert into bolumler values('DHL','Dahiliye');
insert into bolumler values('KBB','Kulak Burun Bogaz');
insert into bolumler values('NRJ','Noroloji');
insert into bolumler values('GAST','Gastoroloji');
insert into bolumler values('KARD','Kardioloji');
insert into bolumler values('PSK','Psikiyatri');
insert into bolumler values('GOZ','Goz Hastaliklari');

create table hasta_kayitlar(
kimlik_no char(11) Primary key,
hasta_ismi char(20),
hastane_adi char(50),
bolum_adi char(20),
teshis char(20)
);

insert into hasta_kayitlar values('1111','NO NAME','','','');
insert into hasta_kayitlar values('2222','NO NAME','','','');
insert into hasta_kayitlar values('3333','NO NAME','','','');
insert into hasta_kayitlar values('4444','NO NAME','','','');
insert into hasta_kayitlar values('5555','NO NAME','','','');




	/*
	hasta_kayıtlar tablosundaki ‘3333’ kimlik nolu kaydı aşağıdaki gibi güncelleyiniz.
hasta_isim : ‘Salvadore Dali’ ismi ile
hastane_adi: ‘John Hopins’
bolum_adi: ‘Noroloji’
teshis: ‘Parkinson’
kimlik_no: ‘99991111222’
	*/
UPDATE hasta_kayitlar
SET hasta_ismi = 'Salvadore Dali',
	hastane_adi = 'John Hopins',
	bolum_adi = 'Noroloji',
	teshis = 'Parkinson',
	kimlik_no = '99991111222'
WHERE kimlik_no = '3333';

/*
hasta_kayıtlar tablosundaki ‘1111’ kimlik nolu kaydı aşağıdaki gibi güncelleyiniz.
	hasta_isim : hastalar tablosundaki ‘Ali Can’ ismi ile
	hastane_adi: hastaneler tablosundaki 'H104' bolum_id kodlu hastanenin ismi ile
	bolum_adi: bolumler tablosundaki 'DHL' bolum_id kodlu bolum_adi ile
	teshis: hastalar tablosundaki 'Ali Can' isimli hastanın teshis bilgisi ile
	kimlik_no: hastalar tablosundaki 'Ali Can' isimli hastanın kimlik_no kodu ile
*/

UPDATE hasta_kayitlar
SET hasta_ismi = (SELECT isim FROM hastalar WHERE isim='Ali Can'),
	hastane_adi = (SELECT isim FROM hastaneler WHERE id ='H104'),
	bolum_adi = (SELECT bolum_adi FROM bolumler WHERE bolum_id = 'DHL'),
	teshis = (SELECT teshis FROM hastalar WHERE isim = 'Ali Can'),
	kimlik_no = (SELECT kimlik_no FROM hastalar WHERE isim = 'Ali Can')
WHERE kimlik_no='1111';

select * from hastaneler;
select * from hastalar;
select * from bolumler;
select * from hasta_kayitlar;


/* 						ÖDEVVVVVVVVVVVVVVVVVVVVVVVVVV
    hasta_kayıtlar tablosundaki ‘2222’ kimlik nolu kaydı aşağıdaki gibi güncelleyiniz.
    hasta_isim : hastalar tablosundaki ‘Ayşe Yılmaz’ ismi ile
    hastane_adi: hastaneler tablosundaki 'H103' bolum_id kodlu hastanenin ismi ile
    bolum_adi: bolumler tablosundaki ‘KBB’ bolum_id kodlu bolum_adi ile
    teshis: hastalar tablosundaki ‘Tom Hanks' isimli hastanın teshis bilgisi ile
    kimlik_no: hastalar tablosundaki 'Stevev Job' isimli hastanın kimlik_no kodu ile
*/




------------------- DELETE -----------
--DML->DELETE: Tablodaki verileri silmek için kullanılır
select * from calisanlar4
--SYNTAX;
DELETE FROM tablo_adi;
DELETE FROM calisanlar4; --Tüm verileri sildi
DELETE FROM calisanlar4 WHERE id='1236'
select * from calisanlar
select * from aileler
/*
    İlişkili tablolarda parent tablo'dan direk veri silemeyiz ve tabloyu silemeyiz
Eğer ilişkili tablolardan parent tablodan veri silme ihtimalimiz varsa,
tabloyu oluştururken FOREİGN KEY ataması yaptığımız child tabloya "ON DELETE CASCADE"
komutunu yazmamız gerekir.
    on delete cascade komutu kullanmaz isek önce child tabloyu silmemiz gerekir. Sonrada
parent tabloyu silebiliriz 
    on delete cascade komutu kullandığımız zaman parent table'dan bir veri silersek chile table'dan da silinir
*/
create table calisan(
id char(4),
isim varchar(50),
maas int,
primary key(id)
);

insert into calisan values('1001', 'Ahmet Aslan', 7000);
insert into calisan values('1002', 'Mehmet Yılmaz' ,12000);
insert into calisan values('1003', 'Meryem ', 7215);
insert into calisan values('1004', 'Veli Han', 5000);

create table aileler1 (
id char(4),
cocuk_sayisi int,
ek_gelir int,
foreign key(id)references calisan(id) on delete cascade    
);

insert into aileler1 values('1001', 4, 2000);
insert into aileler1 values('1002', 2, 1500);
insert into aileler1 values('1003', 1, 2200);
insert into aileler1 values('1004', 3, 2400);

select * from calisan; -- Bu tabloyu tamamen sildik
select * from aileler1;

delete from calisan where id = '1001';
drop table calisan cascade; -- Parent tabloyu tamamen databaseden kaldırmak istersek bu şekilde yazarız
