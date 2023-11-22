USE galeri
/* Tablolar */
SELECT * FROM Alim
SELECT * FROM Satis
SELECT * FROM Musteri
SELECT * FROM Arac

INSERT INTO Alim VALUES(6,4,'2023-03-21',150000)

/* 1. Soru: Sat�� yap�lan m��terilerin isimlerini listelemek i�in gerekli SQL ifadesini yaz�n�z. */
SELECT Madi From Musteri WHERE Mno IN(SELECT Mno FROM Satis)

/* 2. Soru: Hangi m��teriden hangi arac�n al�nd���n� listelemek i�in gerekli SQL ifadesini yaz�n�z. */
SELECT M.Madi+' '+Msoyadi AS Ki�i,AR.Marka FROM Alim A
JOIN Arac AR ON AR.aracNo=A.aracNo
JOIN Musteri M ON M.Mno=A.Mno

/* 3. Soru: Her bir m��teriden al�nan ara�lar�n say�s�n� listelemek i�in gerekli SQL ifadesini yaz�n�z. */
SELECT Musteri.Mno, Musteri.Madi, COUNT(Alim.aracNo) AS AracSayisi
FROM Musteri
JOIN Alim ON Musteri.Mno= Alim.Mno
GROUP BY Musteri.Mno,Musteri.Madi 

/* 4. Soru: Sat�lan ara�lar�n marka ve modelini bulmak i�in gerekli SQL ifadesini yaz�n�z. */
SELECT Marka, Model FROM Arac
JOIN Satis S ON S.aracNo=Arac.aracNo

/* 5. Soru: Toplam sat�� ve toplam al�m tutarlar�n� ve bunlar�n fark�n� bulmak i�in gerekli SQL ifadesini yaz�n�z. */
SELECT SUM(S.satis_fiyat)-SUM(A.alim_fiyati) AS Fark FROM Musteri M
JOIN Satis S ON S.Mno=M.Mno
JOIN Alim A ON A.Mno=M.Mno

/* 6. Soru: Hi� sat��� yap�lmam�� ara�lar� listelemek i�in gerekli SQL ifadesini yaz�n�z. */
SELECT * FROM Arac WHERE aracNo NOT IN(SELECT aracNo FROM Satis)

/* 7. Soru: Her arac�n ortalama sat�� tutar�n� bulmak i�in gerekli SQL ifadesini yaz�n�z. */
SELECT A.Marka,AVG(satis_fiyat) FROM Arac A
JOIN Satis S ON S.aracNo=A.aracNo
GROUP BY A.Marka

/* 8. Soru: Al�m� ve sat��� yap�lan t�m ara�lar�n marka, model ve al�m-sat�� say�s�n� listelemek i�in gerekli SQL ifadesiniz yaz�n�z */
SELECT AR.Marka, AR.Model, COUNT(DISTINCT A.aracNo) AS AlimSayisi, COUNT(DISTINCT S.aracNo) AS SatisSayisi
FROM Arac AR
LEFT JOIN Alim A ON A.aracNo = AR.aracNo
LEFT JOIN Satis S ON S.aracNo = AR.aracNo
GROUP BY AR.Marka, AR.Model;

/* 9. Soru: 200000�den fazla tutara sat�lan ara�lar� kimlerin hangi arac� ald���n� bulmak i�in gerekli SQL ifadesini yaz�n�z. */
SELECT M.Madi+' '+M.Msoyadi AS Ki�i, AR.Marka, AR.Model, S.satis_fiyat AS Fiyat FROM Satis S
JOIN Arac AR ON AR.aracNo=S.aracNo
JOIN Musteri M ON M.Mno=S.Mno
WHERE satis_fiyat>200000

/* 10. Soru: Tokatta bulunan m��terilere sat��� yap�lan ara�lar� listelemek i�in gerekli SQL ifadesini yaz�n�z. */
SELECT * FROM Arac WHERE aracNo IN(SELECT aracNo FROM Satis WHERE Mno IN(SELECT Mno FROM Musteri WHERE Madres LIKE '%Tokat%'))
