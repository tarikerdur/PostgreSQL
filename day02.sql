/*
  SQL KOMUTLARI GRUPLARA AYRILIR :

  1.(Data Definition Language - DDL) Veri Tanimlama Dili
  CREATE	: Tablo oluşturur.
  DROP		: Tabloyu siler.
  ALTER		: Tabloyu günceller.
  
  2.(Data Manipulation Language - DML) Veri Kullanma Dili
  INSERT	: Tabloya veri ekler
  DELETE	: Tablodaki verileri siler
  UPDATE	: Tablodaki verileri günceller

  3.(Data Query Language - DQL) Veri Sorgulama Dili
  SELECT	: Tablodaki verileri listeler. 
*/

-- talebeler isminde tablo oluşturalım

CREATE TABLE talebeler (
ogrenci_tc char(11), --size'i belli olan String'ler icin "char" kullaniliyor.
ogrenci_isim varchar(20), --size'i belli olmayan String'ler icin "varchar" kullaniliyor.
not_ort real, -- "real" data type using for decimal numbers.
kayit_tarihi date -- "date" data tyoe using for dates. YYYY-MM-dd
);

-- talebeler tablosundaki verileri listeleyelim.
SELECT * FROM talebeler;

-- talebeler tablosuna veri ekleyelim.
INSERT INTO talebeler VALUES('12345678910' , 'Ahmet'  , 72.5 , '2020-02-14');
INSERT INTO talebeler VALUES('25487312546' , 'Mehmet' , 80.5 , '2021-05-16');
INSERT INTO talebeler VALUES('29374282193' , 'Veli'   , 86.4 , '2022-02-25');
-- insert (ENG)	==> yerleştirmek (TR)
-- into (ENG)	==> içine (TR)
-- values (ENG)	==> değerler (TR)

-- simdi tekrar talebeler tablosundaki verileri listeleyelim.
SELECT * FROM talebeler;

-- talebeler tablosunu silelim.
DROP TABLE talebeler; -- drop (ENG) == birakmak (TR)

/*
==========================================================================================
*/

-- ogretmenler isminde tablo olusturalim.
CREATE TABLE ogretmenler(
ogretmen_ismi varchar(15),
bransi varchar(25),
mezuniyet_derecesi varchar(20),
tel_no char(11),
maas int -- Instructor has prefered to use "int". I don't know why we didn't use "real" data type for "salary".
);

-- ogretmenler tablosuna veri girisi yapalim.
INSERT INTO ogretmenler VALUES('Ali','Matematik','Lisans','05726487352',15000);
INSERT INTO ogretmenler VALUES('Erdem','Edebiyat','Lisans','05268439102',13000);
INSERT INTO ogretmenler VALUES('Hasim','Tarih','Yukseklisans','05613254512',20000);
INSERT INTO ogretmenler VALUES('Aylin','Geometri','Lisans','05314138562',18000);

INSERT INTO ogretmenler VALUES('Kubra','Yazilim','Lisans','05467256312',30000);

INSERT INTO ogretmenler VALUES('Burak','Cografya','Yukseklisans','056431973258',35000); -- size kisminda belirtilen degerden daha
-- fazla uzunlukta deger girilirse pgAdmin ERROR verir. ==> (ERROR:  value too long for type character(11))


-- ogretmenler tablosundaki verileri listeleyelim.
SELECT * FROM ogretmenler;

-- ogretmenler tablosunu silelim.
DROP TABLE ogretmenler;


/*===================================== SELECT =======================================================
SELECT * FROM tablo_adi ==> * Tüm sutunlardaki verileri listeler
DQL Grubundan ==> SELECT komutu ile 'Tablodaki İstedigimiz Sütundaki Verileri Listeleyebiliriz'
Syntax:
-------
SELECT sutun_adi FROM tablo_adi; ==> Sadece belirtilen sutundaki verileri listeler
========================================================================================================*/

CREATE TABLE ogrenciler(
id int,
isim varchar(40),
adres varchar(100),
sinav_notu int
);

INSERT INTO ogrenciler VALUES(120, 'Ali Can', 'Ankara', 75);
INSERT INTO ogrenciler VALUES(121, 'Veli Mert', 'Trabzon', 85);
INSERT INTO ogrenciler VALUES(122, 'Ayşe Tan', 'Bursa', 65);
INSERT INTO ogrenciler VALUES(123, 'Derya Soylu', 'Istanbul', 95);
INSERT INTO ogrenciler VALUES(124, 'Yavuz Bal', 'Ankara', 85);
INSERT INTO ogrenciler VALUES(125, 'Emre Gül', 'Hatay', 90);
INSERT INTO ogrenciler VALUES(126, 'Harun Reşit', 'Isparta', 100);

-- SORU 1: ogrenciler tablosunun tum sutunlarındaki verileri listeleyiniz
SELECT * FROM ogrenciler;

-- SORU 2: ogrenciler tablosundaki 'isim' sutunundaki verileri listeleyiniz
SELECT isim FROM ogrenciler;

-- SORU 3: ogrenciler tablosundaki 'adres' sutunundaki verileri listeleyiniz
SELECT adres FROM ogrenciler;

-- SORU 4: ogrenciler tablosundaki 'sinav_notu' sutunundaki verileri listeleyiniz
SELECT sinav_notu FROM ogrenciler;

-- SORU 5: ogrenciler tablosundaki 'isim' ve 'sinav_notu' sutunundaki verileri listeleyiniz
SELECT isim, sinav_notu FROM ogrenciler;

-- WHERE komutu şart operatorudur. Mesela sinav_notu 80'den büyük olan öğrenciler gibi.
-- SORU 6: ogrenciler tablosundaki sinav_notu 80'den büyük olan öğrencilerin tüm bilgilerini listeleyelim.
SELECT * FROM ogrenciler WHERE sinav_notu > 80;

-- SORU 7: ogrenciler tablosundaki adres'i 'Ankara' olan ögrencilerin tüm bilgilerini listeleyelim.
SELECT * FROM ogrenciler WHERE adres = 'Ankara';

-- SORU 8: ogrenciler tablosundaki sinav_notu 85 ve adres'i 'Ankara' olan öğrenci isim'ini listeleyelim.
SELECT isim FROM ogrenciler WHERE sinav_notu = 85 AND adres = 'Ankara'; -- AND ==> ve

-- SORU 9: ogrenciler tablosundaki sinav_notu 65 veya 85 olan ogrencilerin tüm bilgilerini listeleyelim.
SELECT * FROM ogrenciler WHERE sinav_notu = 65 OR sinav_notu = 85; -- OR ==> veya
-- 9. sorunun 2. cozum yolu : ==> IN komutu
/*
Birden fazla ifade ile tanimlayabilecegimiz durumlari IN komutu ile yazabiliriz.
Ayni value'da birden fazla sart tanimlamak istersek IN komutu kullanabiliriz.
*/
SELECT * FROM ogrenciler WHERE sinav_notu IN (65, 85);

-- SORU 10: ogrenciler tablosundaki sinav_notu 65 veya 85 olmayan ogrencilerin tüm bilgilerini listeleyelim.
-- NOT IN komutu, yazdigimiz sartin disindaki datalari bize return eder.
SELECT * FROM ogrenciler WHERE sinav_notu NOT IN (65, 85);

-- SORU 11: ogrenciler tablosunda sinav_notu 65 ve 85 arasında olan ogrencilerin tüm bilgilerini listeleyelim.
SELECT * FROM ogrenciler WHERE sinav_notu >= 65 AND sinav_notu <= 85;
-- 11. sorunun 2. cozum yolu : ==> BETWEEN komutu
/*
BETWEEN komutu, verilen iki sartin arasindaki degerleri belirtmek icin kullanilir.
*/
SELECT * FROM ogrenciler WHERE sinav_notu BETWEEN 65 AND 85;

-- SORU 12: ogrenciler tablosunda sinav_notu 75 ve 90 arasında olmayan ögrencilerin isim'ini ve sinav_notu listeleyelim.
SELECT isim, sinav_notu FROM ogrenciler WHERE sinav_notu NOT BETWEEN 75 AND 90;
