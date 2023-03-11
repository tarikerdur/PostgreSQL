create table memurlar
(
id int,
isim varchar(20),
soyisim varchar(25),
maas int,
sicil_notu int
);

insert into memurlar values(1,'Ali','Ozturk',50000,100);
insert into memurlar values(2,'Adem','Tan',40000,90);
insert into memurlar values(3,'Halit','Ozyıldızlı',35000,85);
insert into memurlar values(4,'Hasan','Oz',45000,95);
insert into memurlar values(5,'Recep','Cicek',30000,80);
insert into memurlar values(6,'Harun','Sever',20000,70);
insert into memurlar values(7,'Hatice','Tarkan',25000,75);
insert into memurlar values(8,'Poyraz','Yuzbası',10000,60);
insert into memurlar values(9,'Ayse','Karlı',15000,65);
insert into memurlar values(10,'Adem','Akmaz',9000,55);


-- SORU 1: memurlar tablosunda id'si 5'den buyuk olan,
-- ilk 2 veriyi listeleyiniz
-- 1. yol
SELECT * FROM memurlar WHERE id > 5 LIMIT 2;
-- 2. yol -- fetch (ENG) == gidip getirmek (TR)
SELECT * FROM memurlar WHERE id > 5 FETCH NEXT 2 ROW ONLY;

-- SORU 2: memurlar tablosunda sicil_notu'i en yuksek 3 kisinin bilgilerini listeleyiniz
-- 1. yol
SELECT * FROM memurlar ORDER BY sicil_notu DESC LIMIT 3;
-- 2. yol -- fetch (ENG) == gidip getirmek (TR)
SELECT * FROM memurlar ORDER BY sicil_notu DESC FETCH NEXT 3 ROW ONLY;

--SORU 3: memurlar tablosunda maas'i en dusuk 2 kisinin bilgilerini listeleyiniz
SELECT * FROM memurlar ORDER BY maas LIMIT 2;
SELECT * FROM memurlar ORDER BY maas FETCH NEXT 2 ROW ONLY;

-- SORU 4: memurlar tablosunda sicil_notu en yuksek 3.4.5. kişilerin bilgilerini listeleyiniz
SELECT * FROM memurlar ORDER BY sicil_notu DESC OFFSET 2 LIMIT 3;
SELECT * FROM memurlar ORDER BY sicil_notu DESC OFFSET 2 FETCH NEXT 3 ROW ONLY;

-- SORU 5: memurlar tablosunda soyisim'i en uzun ilk 2 kisinin bilgilerini listeleyiniz
SELECT * FROM memurlar ORDER BY LENGTH(soyisim) DESC LIMIT 2;
SELECT * FROM memurlar ORDER BY LENGTH(soyisim) DESC FETCH NEXT 2 ROW ONLY;


CREATE TABLE calisanlar 
(
isim VARCHAR(50), 
sehir VARCHAR(50), 
maas int, 
isyeri VARCHAR(20)
);
INSERT INTO calisanlar VALUES('Ali Seker', 'Istanbul', 2500, 'Vakko');
INSERT INTO calisanlar VALUES('Ayse Gul', 'Istanbul', 1500, 'LCWaikiki');
INSERT INTO calisanlar VALUES('Veli Yilmaz', 'Ankara', 3000, 'Vakko');
INSERT INTO calisanlar VALUES('Veli Yilmaz', 'Ankara', 7000, 'Adidas');
INSERT INTO calisanlar VALUES('Nisa Can', 'Ankara', 1500, 'Pierre Cardin');
INSERT INTO calisanlar VALUES('Fatma Yasa', 'Bursa', 2500, 'Vakko');


CREATE TABLE markalar
(
marka_id int, 
marka_isim VARCHAR(20), 
calisan_sayisi int
);
INSERT INTO markalar VALUES(100, 'Vakko', 12000);
INSERT INTO markalar VALUES(101, 'Pierre Cardin', 18000);
INSERT INTO markalar VALUES(102, 'Adidas', 10000);
INSERT INTO markalar VALUES(103, 'LCWaikiki', 21000);



-- SORU 1 : Çalisan sayisi 15.000’den cok olan 'isyeri' lerini,
-- calisanlarin 'isim' lerini ve 'maas' larini listeleyin.
SELECT isyeri, isim, maas
FROM calisanlar
WHERE isyeri
IN (SELECT marka_isim FROM markalar WHERE calisan_sayisi > 15000);

-- SORU 2 : marka id'si 101'den buyuk olan 'isyeri' lerini,
--calisanlarin 'isim' lerini, 'maas' larini ve 'sehir' lerini listeleyiniz 
SELECT isyeri, isim, maas, sehir
FROM calisanlar
WHERE isyeri 
IN(SELECT marka_isim FROM markalar WHERE marka_id > 101);

-- SORU 3: markalar tablosundaki marka_isim'ini, calisan_sayisi'ni 
--ve o markalara ait toplam maas'ı listeleyiniz
SELECT marka_isim, calisan_sayisi,
(SELECT SUM(maas) FROM calisanlar WHERE markalar.marka_isim = isyeri)
-- marka ismi ile işyeri ismiyle aynı olanların maaşlarını topla dedik.
AS toplam_maas
FROM markalar;

-- SORU 4: markalar tablosundaki marka_isim'ini, calisan_sayisi'ni 
-- ve o markalara ait max ve min maas'ı listeleyiniz 
SELECT 
marka_isim,
calisan_sayisi,
	(SELECT MAX(maas)
	FROM calisanlar
	WHERE marka_isim=isyeri)
AS max_maas,
	(SELECT MIN(maas)
	FROM calisanlar
	WHERE marka_isim=isyeri)
AS min_maas
FROM markalar;

select * from calisanlar;

create table kitaplar
(
kitap_id int,
kitap_isim varchar(30)
);

insert into kitaplar values (100, 'intibah');
insert into kitaplar values (200, 'Araba Sevdası');
insert into kitaplar values (300, 'Mai ve Siyah');
insert into kitaplar values (400, 'Eylül');
insert into kitaplar values (500, 'Mürebbiye');
insert into kitaplar values (600, 'Handan');



create table yazarlar
(
yazar_isim varchar(30),
kitap_id int
);

insert into yazarlar values ('Namık Kemal', 100);
insert into yazarlar values ('Recaizade Mahmut Ekrem', 200);
insert into yazarlar values ('Halit Ziya', 300);
insert into yazarlar values ('Mehmet Rauf', 400);
insert into yazarlar values ('Hüseyin Rahmi Gürpınar', 500);
insert into yazarlar values ('Yakup Kadri Karaosmanoğlu', 700);

-- SORU 1: Tüm kitap_isim'lerini ve bu kitapları yazan yazar_isim'lerini listeleyiniz.
SELECT kitap_isim, yazar_isim
FROM kitaplar
LEFT JOIN yazarlar
ON kitaplar.kitap_id = yazarlar.kitap_id;

-- SORU 2: Tüm yazar_isim'lerini ve yazarların kitap_isim'lerini listeleyiniz.
SELECT yazar_isim, kitap_isim
FROM kitaplar
RIGHT JOIN yazarlar
ON kitaplar.kitap_id = yazarlar.kitap_id;


-- SORU 3: Her iki tabloda kitap_id'si ORTAK OLAN verilerin kitap_isim 
-- ve yazar_isim'lerini listeleyiniz.
-- INNER JOIN kesişim kümelerini retrieve eder.
-- INNER JOIN'in sağına ya da soluna hangi tabloyu yazdığımızın bir önemi yok.
SELECT kitap_isim, yazar_isim
FROM kitaplar
INNER JOIN yazarlar
ON kitaplar.kitap_id = yazarlar.kitap_id;

-- SORU 4: Tüm kitap_isim'lerini ve tüm yazar_isim'lerini listeleyiniz
-- 1. YOL
SELECT kitap_isim, yazar_isim FROM kitaplar
LEFT JOIN yazarlar ON kitaplar.kitap_id = yazarlar.kitap_id

UNION

SELECT kitap_isim, yazar_isim FROM kitaplar
RIGHT JOIN yazarlar ON kitaplar.kitap_id = yazarlar.kitap_id;

-- 2. YOL
SELECT kitap_isim, yazar_isim FROM kitaplar
FULL JOIN yazarlar ON kitaplar.kitap_id = yazarlar.kitap_id;