USE galeri
/* Tablolar */
SELECT * FROM Alim
SELECT * FROM Satis
SELECT * FROM Musteri
SELECT * FROM Arac

INSERT INTO Alim VALUES(6,4,'2023-03-21',150000)

/* 1. Soru: Satýþ yapýlan müþterilerin isimlerini listelemek için gerekli SQL ifadesini yazýnýz. */
SELECT Madi From Musteri WHERE Mno IN(SELECT Mno FROM Satis)

/* 2. Soru: Hangi müþteriden hangi aracýn alýndýðýný listelemek için gerekli SQL ifadesini yazýnýz. */
SELECT M.Madi+' '+Msoyadi AS Kiþi,AR.Marka FROM Alim A
JOIN Arac AR ON AR.aracNo=A.aracNo
JOIN Musteri M ON M.Mno=A.Mno

/* 3. Soru: Her bir müþteriden alýnan araçlarýn sayýsýný listelemek için gerekli SQL ifadesini yazýnýz. */
SELECT Musteri.Mno, Musteri.Madi, COUNT(Alim.aracNo) AS AracSayisi
FROM Musteri
JOIN Alim ON Musteri.Mno= Alim.Mno
GROUP BY Musteri.Mno,Musteri.Madi 

/* 4. Soru: Satýlan araçlarýn marka ve modelini bulmak için gerekli SQL ifadesini yazýnýz. */
SELECT Marka, Model FROM Arac
JOIN Satis S ON S.aracNo=Arac.aracNo

/* 5. Soru: Toplam satýþ ve toplam alým tutarlarýný ve bunlarýn farkýný bulmak için gerekli SQL ifadesini yazýnýz. */
SELECT SUM(S.satis_fiyat)-SUM(A.alim_fiyati) AS Fark FROM Musteri M
JOIN Satis S ON S.Mno=M.Mno
JOIN Alim A ON A.Mno=M.Mno

/* 6. Soru: Hiç satýþý yapýlmamýþ araçlarý listelemek için gerekli SQL ifadesini yazýnýz. */
SELECT * FROM Arac WHERE aracNo NOT IN(SELECT aracNo FROM Satis)

/* 7. Soru: Her aracýn ortalama satýþ tutarýný bulmak için gerekli SQL ifadesini yazýnýz. */
SELECT A.Marka,AVG(satis_fiyat) FROM Arac A
JOIN Satis S ON S.aracNo=A.aracNo
GROUP BY A.Marka

/* 8. Soru: Alýmý ve satýþý yapýlan tüm araçlarýn marka, model ve alým-satýþ sayýsýný listelemek için gerekli SQL ifadesiniz yazýnýz */
SELECT AR.Marka, AR.Model, COUNT(DISTINCT A.aracNo) AS AlimSayisi, COUNT(DISTINCT S.aracNo) AS SatisSayisi
FROM Arac AR
LEFT JOIN Alim A ON A.aracNo = AR.aracNo
LEFT JOIN Satis S ON S.aracNo = AR.aracNo
GROUP BY AR.Marka, AR.Model;

/* 9. Soru: 200000’den fazla tutara satýlan araçlarý kimlerin hangi aracý aldýðýný bulmak için gerekli SQL ifadesini yazýnýz. */
SELECT M.Madi+' '+M.Msoyadi AS Kiþi, AR.Marka, AR.Model, S.satis_fiyat AS Fiyat FROM Satis S
JOIN Arac AR ON AR.aracNo=S.aracNo
JOIN Musteri M ON M.Mno=S.Mno
WHERE satis_fiyat>200000

/* 10. Soru: Tokatta bulunan müþterilere satýþý yapýlan araçlarý listelemek için gerekli SQL ifadesini yazýnýz. */
SELECT * FROM Arac WHERE aracNo IN(SELECT aracNo FROM Satis WHERE Mno IN(SELECT Mno FROM Musteri WHERE Madres LIKE '%Tokat%'))
