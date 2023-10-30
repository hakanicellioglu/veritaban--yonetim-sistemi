/* UYELER */
SELECT * FROM uyeler

/* Üye ekleme */
USE library_management
INSERT INTO uyeler VALUES('Hakan Berke','Icellioglu','0','7','5466017490','hakanicellioglu@gmail.com')
/* Üye güncelleme */
USE library_management
UPDATE uyeler SET adresNo=9 WHERE uyeNo=10


/* Üyelerin sadece “Sehir” bilgisini alfabetik olarak listelemek için gerekli SQL ifadesini yazýnýz. */
SELECT adresler.sehir
FROM adresler
INNER JOIN uyeler ON adresler.adresNo = uyeler.adresNo 
ORDER BY sehir ASC;

/* uyeNo küçükten büyüðe(artan) sýralama */
SELECT *
FROM uyeler
ORDER BY uyeNo ASC

/* Kayseri’de ikamet eden ve telefonu içerisinde 6 içeren üyeleri listelemek */
SELECT * FROM uyeler WHERE adresNo=(SELECT adresNo FROM adresler WHERE sehir='Kayseri') AND telefon LIKE '%6%'
  
/* Eskiþehir’de yaþayan üyelerin sayýsýný bulmak için gerekli SQL ifadesini yazýnýz */
SELECT COUNT(*) FROM uyeler WHERE adresNo=(SELECT adresNo FROM adresler WHERE sehir='Eskiþehir')


/* ADRESLER */
SELECT * FROM adresler

USE library_management
INSERT INTO adresler VALUES('Mustafa Þimþek','Alpaslan',50,'Kayseri','38030','Türkiye')

/* EMANET */
SELECT * FROM emanet 
USE library_management
INSERT INTO emanet VALUES(6057479360,10,3,'2023-03-21',NULL) 
/* 2020 yýlýnda yapýlan emanet sayýsýný bulmak için gerekli SQL ifadesini yazýnýz. */
SELECT COUNT(*) FROM emanet WHERE emanet_Tarihi>='2020-01-01' AND emanet_Tarihi<='2020-12-31';

/* Emanet verilen kitaplarý, emanet alan üyelerin ad ve soyad bilgisini listelemek için gerekli SQL ifadesini yazýnýz. */
SELECT kitaplar.kitapAd AS Kitap, uyeler.uyeAd AS Ýsim, uyeler.uyeSoyad AS Soyisim
FROM kitaplar
INNER JOIN emanet ON kitaplar.isbn= emanet.isbn
INNER JOIN uyeler ON emanet.uyeNo = uyeler.uyeNo;


/* KUTUPHANE */
/* KITAPLAR */
SELECT * FROM kitaplar

USE library_management
INSERT INTO kitaplar VALUES(6057479360, 'Fesleðen', '2021-10-05' , 208)


/* Ocak 2023 ‘ten sonra emanet alýnan kitaplar */
SELECT * FROM kitaplar WHERE isbn=(SELECT isbn FROM emanet WHERE emanet_Tarihi>='2023-01-01')


/* “YayýnTarihi” 3 yaþýndan büyük olan kitaplarýn yazar bilgisini listelemek için gerekli SQL ifadesini yazýnýz*/
SELECT * FROM Kitaplar WHERE yayinTarih < DATEADD(YEAR, -3, GETDATE());

/* YAZARLAR */
/* KATEGORILER */
/* KITAP KUTUPHANE */
SELECT * FROM kutuphane
/* KITAP KATEGORI */
/* KITAP YAZAR */