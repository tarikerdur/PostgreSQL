/*============================= GROUP BY =====================================

    GROUP BY cümleciği bir SELECT ifadesinde satırları, sutunların değerlerine 
    göre özet olarak GRUPLAMAK için kullanılır. 
   
    GROUP BY cümleceği her grup başına bir satır döndürür. 
    
    GROUP BY genelde, AVG(),COUNT(),MAX(),MIN() ve SUM() gibi aggregate 
    fonksiyonları ile birlikte kullanılır.
==============================================================================*/

create table insan(
id int primary key,
isim varchar(20),
soyisim varchar(20),
yas int,
cinsiyet char,
sehir varchar(20),
ulke varchar(20),
maas int
);

insert into insan values(200, 'Oguz', 'Kagan', '46', 'E', 'Berlin', 'Almanya', '32000');
insert into insan values(201, 'Burak', 'Ak', '30', 'E', 'Paris', 'Fransa', '50000');
insert into insan values(202, 'Funda', 'Nar', '30', 'K', 'Berlin', 'Almanya', '42000');
insert into insan values(203, 'Muhammet', 'Bir', '40', 'E', 'Paris', 'Fransa', '36000');
insert into insan values(204, 'Hasan',  'Ozay', '30', 'E', 'Izmir', 'Turkiye', '18000');
insert into insan values(205, 'Fatma', 'Yilmaz', '40', 'K', 'Istanbul', 'Turkiye', '20000');
insert into insan values(206, 'Resul', 'Demir', '35', 'E', 'Ankara', 'Turkiye', '21000');
insert into insan values(207, 'Elif', 'Can', '38', 'K', 'Isparta', 'Turkiye', '19000');
insert into insan values(208, 'Sinan', 'Burc', '32', 'E', 'Londra', 'Ingiltere', '60000');
insert into insan values(209, 'Hamza', 'Kul', '29', 'E', 'Londra', 'Ingiltere', '63000');
insert into insan values(210, 'Aylin', 'Van', '51', 'K', 'Roma', 'Italya', '38000');


-- SORU 1: ulke'lere göre ortalama yas'ı listeleyiniz.
SELECT ulke, round(AVG(yas),2) as Ortalama_Yas FROM insan GROUP BY ulke;

-- SORU 2: ulke'lere göre kaç çalışan olduğunu listeleyiniz.
SELECT ulke, COUNT(isim) FROM insan GROUP BY ulke;

-- SORU 3: cinsiyet'e göre maas ortalamasını listeleyiniz
SELECT cinsiyet, ROUND (AVG(maas0)) FROM insan GROUP BY cinsiyet;

-- SORU 4: insan tablosunu, ulke'lere göre ve sehir'lere göre gruplayarak listeleyiniz
SELECT ulke, sehir FROM INSAN GROUP BY ulke,sehir;

-- SORU 5: ulke'lere göre ve sehir'lere göre çalışan sayısını listeleyiniz.
SELECT ulke, sehir, COUNT(isim) AS calisan_sayisi FROM insan GROUP BY ulke, sehir;

-- SORU 6: ulke'lere göre ve cinsiyet'e göre çalışan sayısını ve yas ortalamasını listeleyiniz.
SELECT ulke, cinsiyet, COUNT(isim) AS calisan_sayisi, round (AVG(yas)) AS yas_ortalamasi
FROM insan
GROUP BY ulke, cinsiyet;

-- SORU 7: maas'ı 30000 den büyük olanların, ulke'lere göre ve cinsiyet'e göre 
-- çalışan sayısını, yas ortalamasını listeleyiniz.
SELECT ulke,
cinsiyet,
COUNT(isim) AS calisan_sayisi,
round (AVG(yas)) AS yas_ortalamasi
FROM insan
WHERE maas>3000
GROUP BY ulke, cinsiyet;

/*
		HAVING :
	1- Şart belirtmek için kullanılır
	2- GROUP BY komutundan sonra yazılır.
	3- WHERE komutundan farkı:
		Gruplama yaptıktan sonra çıkan sonuçta
		şart koşulacaksa HAVING komutu kullanılır.
*/
-- SORU 8: ulke'lere göre yas ortalamasını bulup, yas ortalaması 35'den buyuk olanları listeleyiniz. 
SELECT 	ulke,
		round(AVG(yas)) AS yas_ortalamasi
FROM insan
GROUP BY ulke
HAVING AVG(yas) > 35;

-- SORU 9: ulke'lere göre toplam maası bulup, toplam maas 75000'den buyuk olanları listeleyiniz
SELECT ulke, SUM(maas) AS toplam_maas
FROM insan
GROUP BY ulke
HAVING SUM(maas)>75000;


/*======================== UNION, UNION ALL ============================================
	UNION: İKİ VEYA DAHA FAZLA QUERY'nin SONUC KUMELERİNİ BİRLEŞTİREREK 
	TEK BİR SONUC KUMESİ OLUSTURUR.
	Syntax:
	----------
	SELECT <sutun_adi> FROM <tablo_adi>
	UNION
	SELECT <sutun_adi> FROM <tablo_adi>;

	UNION:         SADECE BENZERSİZ VERİLERİ ALIR 
	UNION ALL:     BENZERLİ VERİLERİ DE ALIR

	NOT:  Birlesik olan Sorgu ifadesinin veri türü diger sorgulardaki
	ifadelerin veri türü ile uyumlu olmalidir.
======================================================================================*/
CREATE TABLE personel 
(
	id int  PRIMARY KEY, 
	isim VARCHAR(50), 
	sehir VARCHAR(50), 
	maas int, 
	sirket VARCHAR(20)
);

INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda'); 
INSERT INTO personel VALUES(345678902, 'Mehmet Ozturk', 'Istanbul', 3500, 'Honda'); 
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');
INSERT INTO personel VALUES(453445611, 'Veli Sahin', 'Ankara', 4500, 'Ford');
INSERT INTO personel VALUES(123456710, 'Hatice Sahin','Bursa', 4200, 'Honda');

	/*
SORU 1: maas'i 4000’den cok olan personel isim'lerini ve  
maas'i 5000’den cok olan sehir'leri gosteren tekrarsız sorguyu yaziniz
	*/
SELECT isim as isim_sehir , maas FROM personel WHERE maas>4000
UNION
SELECT sehir,maas FROM personel WHERE maas>5000;

	/*
  SORU 2: isim'i 'Mehmet Ozturk' olan kisilerin aldigi maas'lari  ve  
  sehir'i 'Istabul' olan personelin maas'larini tekrarsız
  büyükten küçüge dogru siralayarak bir tabloda gosteren sorguyu yaziniz.    
	*/
SELECT isim, maas FROM personel WHERE isim = 'Mehmet Ozturk'
UNION
SELECT sehir, maas FROM personel WHERE sehir = 'Istanbul' ORDER BY maas DESC;
	

-- SORU 3: sirket'i 'Honda', 'Ford' ve 'Tofas' olan 
-- personelin isim'ini tekrarsız listeleyin
SELECT sirket, isim FROM personel WHERE sirket ='Honda'
UNION
SELECT sirket, isim FROM personel WHERE sirket ='Ford'
UNION
SELECT sirket, isim FROM personel WHERE sirket ='Tofas';

-- SORU 4: maas'ı 5000’den az olan personelin isim, maas ve sirket bilgileri ile, 
-- 'Honda' calisani olmayan personelin isim, maas, sirket bilgilerini
-- tekrarsız listeleyen bir sorgu yaziniz.
SELECT isim, maas, sirket FROM personel WHERE maas < 5000
UNION
SELECT isim, maas, sirket FROM personel WHERE NOT sirket='Honda'; -- sirket !='Honda' ----> şeklinde de yazılabilir.

-- SORU 5: isim'i 'Mehmet Ozturk' olanlarin isim'lerini, sehir'lerini ve
-- sehir'i 'Istanbul' olmayanların isim'lerini sehir'lerini tekrarsız listeleyen sorguyu yaziniz.
SELECT isim, sehir FROM personel WHERE isim = 'Mehmet Ozturk'
UNION
SELECT isim, sehir FROM personel WHERE NOT sehir != 'Istanbul'; -- WHERE NOT sehir = 'Istanbul' ----> şeklinde de yazılabilir. 

/* -----------------------------------------------------------------------------
  SORU5: sirket'i 'Honda', 'Ford' ve 'Tofas' olan personelin isim'ini tekrarsız listeleyin
------------------------------------------------------------------------------*/
select sirket, isim from personel where sirket='Honda'
union
select sirket, isim from personel where sirket='Ford'
union
select sirket, isim from personel where sirket='Tofas';

CREATE TABLE personel_bilgi 
(
id int, 
tel char(10) UNIQUE , 
cocuk_sayisi int
); 
   
INSERT INTO personel_bilgi VALUES(123, '5302345678', 5);
INSERT INTO personel_bilgi VALUES(234, '5422345678', 4);
INSERT INTO personel_bilgi VALUES(345, '5354561245', 3); 
INSERT INTO personel_bilgi VALUES(478, '5411452659', 3);
INSERT INTO personel_bilgi VALUES(789, '5551253698', 2);
INSERT INTO personel_bilgi VALUES(344, '5524578574', 2);
INSERT INTO personel_bilgi VALUES(125, '5537488585', 1);

select * from personel_bilgi;

/* -----------------------------------------------------------------------------
  SORU6: id'si 123456789 olan personelin, personel tablosundan sehir ve maas'ini, 
  personel_bilgi tablosundan da id'si 123 olan, personelin tel ve cocuk sayisini tekrarsiz yazdirin  
------------------------------------------------------------------------------*/  
SELECT sehir AS sehir_tel, maas AS maas_cocuksayisi FROM personel WHERE id = '123456789'
UNION
SELECT tel, cocuk_sayisi FROM personel_bilgi WHERE id = 123;
