/*
SORU 2:
insanlar isminde bir tablo oluşturunuz. 
isim, soyisim sutunları olsun.
isim sutununun data tipi varchar(20) olsun.
soyisim sutununun data tipi varchar(30) olsun. 

isim sutununda PRİMARY KEY kısıtlaması olsun. Kısıtlamanın isimi pr_ks olsun.
soyisim sutununda UNIQUE kısıtlaması olsun. Kısıtlamanın ismi uni_ks olsun.
*/

CREATE TABLE insanlar (
isim varchar(20), -- kisitlama ismini kendimiz verirken kisitlamayi sutun isimlerinin yaninda yazmiyoruz.
soyisim varchar(30), -- kisitlama ismini kendimiz verirken kisitlamayi sutun isimlerinin yaninda yazmiyoruz.

-- SYNTAX ===> CONSTRAINT <custom name> <kisitlama turu> (<column name>)
CONSTRAINT pr_ks PRIMARY KEY(isim), --kisitlamamizin ismini kendimiz belirledik.
CONSTRAINT uni_ks UNIQUE(soyisim)
);
/*
primary key - unique farki ==> unique 'null' value kabul eder. pk kabul etmez.
*/

INSERT INTO insanlar VALUES ('Harun','Tan');
INSERT INTO insanlar VALUES ('Azra','Can');
INSERT INTO insanlar VALUES ('Harun','Kan');	-- PRIMARY KEY nedeniyle ERROR verir.
INSERT INTO insanlar VALUES (null,'Er');		-- PRIMARY KEY null kabul etmez ERROR verir.
INSERT INTO insanlar VALUES ('Kudret', 'Can');	-- UNIQUE sebebiyle ERROR VERIR

/*
SORU 3: hayvanlar isminde bir tablo oluşturunuz. 
isim, cins sutunları olsun.
isim sutununun data tipi varchar(20) olsun.
cins sutununun data tipi varchar(25) olsun.

isim ve cins sutunları birlesiminden bir PRIMARY KEY kısıtlaması olsun. (Composite Primary Key)
*/

CREATE TABLE hayvanlar(
isim varchar(20),
cins varchar(20),

CONSTRAINT com_pr_ks PRIMARY KEY(isim,cins) -- composite pk olarak belirledigimiz columnlar bir butun olarak dusunulmelidir.
	--Tek tek degil birlesiminin aynisi var mi yok mu ona bakilmalidir.
);



INSERT INTO hayvanlar VALUES ('Findik','Sus Kopegi');
INSERT INTO hayvanlar VALUES ('Findik','Coban Kopegi');
INSERT INTO hayvanlar VALUES ('Duman','Sus Kopegi');

INSERT INTO hayvanlar VALUES ('Findik','Sus Kopegi');	-- Composite Primary Key sebebiyle ERROR verdi.

/*
NOT	>>> CONSTRAINT'leri sutun isimlerinin altinda belirtmenin bize sagladigi benefit;
	1-	Constraint ismini kendimiz belirliyoruz.
	2-	Composite Primary Key yapmamiza imkan veriyor. (1 tabloda sadece 1 Primary Key bulunur kuralini esnetmis oluyoruz.)
			Composite Primary Key : 2 sutunun birlesiminden bir Primary Key olusturulmasina denir.
*/


create table emekciler
(
id char(5) PRIMARY KEY,   ---> UNIQUE + NOT NULL
isim varchar(50) UNIQUE,
maas int NOT NULL -- not null icin pgAdmin'de Constraint ismi tanimlanmaz.
);

insert into emekciler values(10002, 'Mehmet Yılmaz', 12000);
insert into emekciler values(10008, null, 5000);
insert into emekciler values(10010, null,5000);
insert into emekciler values(10020, null, 5000);
insert into emekciler values(10004, 'Veli Han', 5000);
insert into emekciler values(10005, 'Mustafa Ali', 5000);
insert into emekciler values(10006, 'Canan Yaş', null);		-- not null constraint'i nedeniyle error verir.
insert into emekciler values(10003, 'CAN', 5000);
insert into emekciler values(10007, 'CAN', 5000);			-- unique constraint'i nedeniyle error verır.
insert into emekciler values(10009, 'Cem', '');				-- int data türüne '' ile veri giremeyiz.
insert into emekciler values('', 'osman', 2000);
insert into emekciler values('', 'osman can', 2000);  		-- Primary Key --> unique olması lazım
insert into emekciler values('', 'veli can', 6000);   		-- Primary Key --> unique olması lazım
insert into emekciler values(10002, 'ayse Yılmaz', 12000);  -- Primary Key --> unique olması lazım
insert into emekciler values(null, 'filiz', 12000);			-- Primary Key --> not null olması lazım

select * from emekciler;


/*----------------------------FOREIGN KEY---------------------------------------------------

	FOREIGN KEY --> Başka bir tablodaki PRİMARY KEY'i referans göstermek için kullanılır. 
	Böylelikle, tablolar arasında parent-child ilişkisi oluşur.
	
	FOREIGN KEY'in bulundugu tablo Child tablodur.
	PRIMARY KEY'in bulundugu tablo ise Parent tablodur.

	FOREIGN KEY KISITLAMASI SAYESİNDE:
	---------------------------------
	
	1-) parent tabloda olmayan primary key ile child tabloya veri girişi yapılamaz
	(child tablo null deger kabul eder)

	2-) child tablodaki veri silinmeden parent tablodaki veri silinemez

	3-) child tablo silinmeden parent tablo silinemez
----------------------------------------------------------------------------------------------*/
create table hastaneler
(
hastane_adi varchar(30),
adres varchar(30),
alan_kodu int,
CONSTRAINT pk PRIMARY KEY(hastane_adi)
);
insert into hastaneler values('Meddem', 'Isparta', '0246');
insert into hastaneler values('Sifa', 'Ankara', '0236');
insert into hastaneler values('Davraz', 'Istanbul', '0216');
insert into hastaneler values('Deva', 'Antalya', '0242');


create table doktorlar
(
gorev_yeri varchar(30),
doktor_adi varchar(30),
diploma_no int,
brans_adı varchar(30),
	
CONSTRAINT fk FOREIGN KEY(gorev_yeri) REFERENCES hastaneler(hastane_adi) --foreign key olarak gorev yerini sectik.
	--baska bir tablo olan hastaneler tablosundaki hastane adi'ni referans gosterdik.
	--Bu sayede parent child iliskisi kurmus olduk.
);
insert into doktorlar values('Meddem', 'Hasan Bal', '123456', 'psikiyatri');
insert into doktorlar values('Sifa', 'Vedat Sen', '123865', 'pediatri');
insert into doktorlar values('Davraz', 'Huseyin Oz', '123568', 'noroloji');
insert into doktorlar values('Deva', 'Ahmet Kar', '123852', 'dahiliye');
insert into doktorlar values('Meddem', 'Hakan Kar', '123369', 'dermatoloji');
insert into doktorlar values('Sifa', 'Ramiz Kara', '123147', 'anestezi');
insert into doktorlar values('Davraz', 'Okan Pul', '123147', 'ortopedi');

SELECT * FROM doktorlar;

--SORU 1: doktorlar tablosuna gorev_yeri 'Meddem' olan veri girişi yapınız
INSERT INTO doktorlar VALUES ('Meddem', 'Hakki Oz',159624,'noroloji');

--SORU 2: .doktorlar tablosuna gorev_yeri 'Okmeydanı' olan veri girişi yapınız.
-- parent tabloda olmayan primary key ile child tabloya veri girisi yapilamaz.
INSERT INTO doktorlar VALUES ('Okmeydani','Hatice Kar',145796,'ortopedi');

--SORU 3: doktorlar tablosuna gorev_yeri null olan veri girişi yapınız
INSERT INTO doktorlar VALUES (null,'Hasan Dal', 148627,'noroloji');

-- SORU 4: hastaneler tablosundaki hastane_adi 'Meddem' olan veriyi siliniz. 
DELETE FROM hastaneler WHERE hastane_adi = 'Meddem';
-- child tablodaki 'Meddem' verileri silinmeden. Parent tablodaki 'Meddem' verisi silinemez.

--SORU 5: doktorlar tablosundaki gorev_yeri 'Meddem' olan verileri siliniz
DELETE FROM doktorlar WHERE gorev_yeri = 'Meddem';

-- SORU 6: hastaneler tablosundaki hastane_adi 'Meddem' olan veriyi siliniz.
-- Artik parent'ta silebiliriz cunku child table'daki tum 'Meddem' datalarini sildik.
DELETE FROM hastaneler WHERE hastane_adi = 'Meddem';

-- SORU 7: hastaneler tablosunu siliniz. 
--> child tablo silinmeden parent tablo silinemez
DROP TABLE hastaneler;  -- bu sebeple bu kod error verir

-- SORU 8: doktorlar tablosunu siliniz 
DROP TABLE doktorlar;

-- SORU 7: hastaneler tablosunu siliniz. 
DROP TABLE hastaneler;

SELECT * FROM doktorlar;

