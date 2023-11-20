create database galeri;
/* Tablo Ekleme */
use galeri;
create table Musteri(
Mno int not null identity(1,1) primary key,
Madi nvarchar(30),
Msoyadi nvarchar(30),
Madres nvarchar(100),
Mtelefon int
);

create table Arac(
aracNo int not null identity(1,1) primary key,
Model nvarchar(30),
Marka nvarchar(30),
Plaka nvarchar(100),
Fiyat DOUBLE PRECISION 
);

create table Satis(
satis_no int not null identity(1,1) primary key,
Mno int constraint "satis_mno" foreign key (Mno)
references Musteri(Mno),
aracNo int foreign key (aracNo) references Arac(aracNo),
satis_tarihi datetime,
satis_fiyat DOUBLE PRECISION 
);

create table Alim(
alim_no int not null identity(1,1) primary key,
Mno int foreign key (Mno) references Musteri(Mno),
aracNo int foreign key (aracNo) references Arac(aracNo),
alim_tarihi datetime,
alim_fiyati DOUBLE PRECISION 
);

/* Veri Ekleme */
insert into Musteri values ('Turgut','Özseven','Turhal/Tokat',12164);
insert into Musteri values ('Mustafa','Çaðlayan','Meram/Konya',46524);
insert into Musteri values ('Ahmet','Kara','Zile/Tokat',47237);
insert into Musteri values ('Murat','Beyaz','Turhal/Tokat',385235);
insert into Musteri values ('Elif','Kurt','Beþiktaþ/Ýstanbul',9487);
insert into Musteri values ('Ayþe','Uçar','Taþova/Amasya',48739);
insert into Musteri values ('Bülent','Ayar','Turhal/Tokat',23237);
INSERT INTO Musteri VALUES('Hakan Berke','Antakya/Hatay',541606);

insert into Arac values ('2004','Fiat Marea','38 VTYS 3838',100000);
insert into Arac values ('2020','Renault Megane','38 VTYS 3839',110000);
insert into Arac values ('2010','Ford Focus','38  VTYS 3840',120000);
insert into Arac values ('2023','Volkswagen Golf','38  VTYS 3841',250000);
insert into Arac values ('2000','Opel Astra','38  VTYS 3842',82000);


insert into Satis values (1,1,'2022-05-04',170000);
insert into Satis values (4,5,'2020-06-01',115000);
insert into Satis values (7,4,'2023-06-15',270000);
insert into Satis values (2,1,'2010-07-02',17500);

INSERT INTO Alim VALUES(3,1,'2022-05-04',190000);
INSERT INTO Alim VALUES(6,1,'2020-06-01',525000);
INSERT INTO Alim VALUES(2,5,'2023-06-15',370000);
INSERT INTO Alim VALUES(1,2,'2010-07-02',17500);
INSERT INTO Alim VALUES(5,3,'2021-08-22',156800);

/* Tablo Getirme */

SELECT * FROM Arac;
SELECT * FROM Musteri;
SELECT * FROM Satis;
SELECT * FROM Alim;

/* Sorular */

/* 1. soru: 1.	Turgun Özseven’e satılan aracın aynısından başka hangi müşterilere satıldığını bulmak için kullanılacak SQL ifadesiniz yazınız. */
SELECT * FROM Musteri WHERE Mno IN (SELECT Mno FROM Satis WHERE aracNo=(SELECT aracNo FROM Satis WHERE Mno=(SELECT Mno FROM Musteri WHERE Madi='Turgut' AND Msoyadi='Özseven')));

/* 2. soru: Satış yapılan araçların bilgilerini listelemek için gerekli SQL ifadesiniz yazınız. */
SELECT * FROM Arac WHERE aracNo IN(SELECT aracNo FROM Satis);

/* 3. soru: Satış tutarı alım tutarından düşük olan araçları listelemek için gerekli SQL ifadesini yazınız. */
SELECT * FROM Arac WHERE aracNo IN (SELECT s.aracNo FROM Satis s JOIN Alim a ON s.aracNo = a.aracNo WHERE s.satis_fiyat > a.alim_fiyati);

/* 4. soru: Opel marka araç yapılan satışların ve alımların hangi müşterilerle yapıldığını bulmak için gerekli SQL ifadesini yazınız. */
SELECT DISTINCT M.Madi, M.Msoyadi, alim_fiyati, satis_fiyat, AR.Marka 
FROM Musteri M 
JOIN Satis S ON M.Mno = S.Mno
JOIN Alim A ON M.Mno = A.Mno
JOIN Arac AR ON S.aracNo = AR.aracNo OR A.aracNo = AR.aracNo
WHERE AR.marka LIKE '%Opel%';

/* 5. soru: Araç fiyatı 20.000 den yüksek olan araçların hangi fiyata satıldığını bulmak için gerekli SQL ifadesiniz yazınız. */
SELECT aracNo,satis_fiyat FROM Satis WHERE aracNo IN (SELECT aracNo FROM Arac WHERE Fiyat > 20000)


/* case when */
/* 6. soru: Turhal ve Amasya’ya yapılan satışların toplam tutarını azalan 
sırada listelemek için gerekli SQL ifadesiniz yazınız. */
SELECT M.Madres, SUM(S.satis_fiyat) AS toplam
FROM Satis S
JOIN Musteri M ON M.Mno = S.Mno
WHERE M.Madres LIKE '%Turhal%' OR M.Madres LIKE '%Amasya%'
GROUP BY M.Madres
ORDER BY toplam DESC;

select A.Madres2,SUM(S.satis_fiyat) AS toplam
FROM Satis S
JOIN Musteri M ON M.Mno = S.Mno
join (select CASE
    WHEN Madres like '%Turhal%' THEN 'Turhal'
    WHEN Madres like '%Amasya%' THEN 'Amasya'
    ELSE ''
END AS Madres2, Mno from Musteri where Madres LIKE '%Turhal%' OR Madres LIKE '%Amasya%' )  A on A.Mno = M.Mno
GROUP BY A.Madres2
ORDER BY toplam DESC;

/* 7. soru: Satış veya alım yapılmayan müşterilerin bilgilerini listelemek için gerekli SQL ifadesiniz yazınız. */
SELECT * FROM Musteri WHERE Mno NOT IN(SELECT Mno FROM Satis) AND Mno NOT IN(SELECT Mno FROM Alim)

/* 8. soru: 5.ve 6. Ayda yapılan satışların kimlere yapıldığını bulmak için gerekli SQL ifadesiniz yazınız. */
SELECT M.Mno, M.Madi, M.Msoyadi, S.satis_tarihi
FROM Musteri M
JOIN Satis S ON M.Mno = S.Mno
WHERE MONTH(S.satis_tarihi) IN (5, 6);

/* 9. soru: Aynı marka araç alan müşterileri ve aldığı araç markasını listelemek için gerekli SQL ifadesiniz yazınız. */
SELECT M.Madi+' '+M.Msoyadi AS Kisi, A.Marka FROM Musteri M
JOIN Satis S ON S.Mno=M.Mno
JOIN Arac A ON S.aracNo = A.aracNo
WHERE A.aracNO IN(SELECT aracNo FROM Satis S
JOIN Musteri M ON S.Mno=M.Mno
GROUP BY aracNo HAVING COUNT(*) > 1);


/* 10. soru: En yüksek fiyata satılan aracın marka, fiyat ve kime satıldığı bilgisini listelemek için gerekli SQL ifadesiniz yazınız. */
SELECT A.Marka AS Marka, A.fiyat AS Fiyat, M.Madi+' '+M.Msoyadi AS Kişi FROM Satis S
JOIN Arac A ON S.aracNo=A.aracNo
JOIN Musteri M ON S.Mno = M.Mno
WHERE satis_fiyat = (SELECT MAX(satis_fiyat) FROM Satis)
