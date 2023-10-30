/* UYELER */
SELECT * FROM uyeler

/* �ye ekleme */
USE library_management
INSERT INTO uyeler VALUES('Hakan Berke','Icellioglu','0','7','5466017490','hakanicellioglu@gmail.com')
/* �ye g�ncelleme */
USE library_management
UPDATE uyeler SET adresNo=9 WHERE uyeNo=10


/* �yelerin sadece �Sehir� bilgisini alfabetik olarak listelemek i�in gerekli SQL ifadesini yaz�n�z. */
SELECT adresler.sehir
FROM adresler
INNER JOIN uyeler ON adresler.adresNo = uyeler.adresNo 
ORDER BY sehir ASC;

/* uyeNo k���kten b�y��e(artan) s�ralama */
SELECT *
FROM uyeler
ORDER BY uyeNo ASC

/* Kayseri�de ikamet eden ve telefonu i�erisinde 6 i�eren �yeleri listelemek */
SELECT * FROM uyeler WHERE adresNo=(SELECT adresNo FROM adresler WHERE sehir='Kayseri') AND telefon LIKE '%6%'
  
/* Eski�ehir�de ya�ayan �yelerin say�s�n� bulmak i�in gerekli SQL ifadesini yaz�n�z */
SELECT COUNT(*) FROM uyeler WHERE adresNo=(SELECT adresNo FROM adresler WHERE sehir='Eski�ehir')


/* ADRESLER */
SELECT * FROM adresler

USE library_management
INSERT INTO adresler VALUES('Mustafa �im�ek','Alpaslan',50,'Kayseri','38030','T�rkiye')

/* EMANET */
SELECT * FROM emanet 
USE library_management
INSERT INTO emanet VALUES(6057479360,10,3,'2023-03-21',NULL) 
/* 2020 y�l�nda yap�lan emanet say�s�n� bulmak i�in gerekli SQL ifadesini yaz�n�z. */
SELECT COUNT(*) FROM emanet WHERE emanet_Tarihi>='2020-01-01' AND emanet_Tarihi<='2020-12-31';

/* Emanet verilen kitaplar�, emanet alan �yelerin ad ve soyad bilgisini listelemek i�in gerekli SQL ifadesini yaz�n�z. */
SELECT kitaplar.kitapAd AS Kitap, uyeler.uyeAd AS �sim, uyeler.uyeSoyad AS Soyisim
FROM kitaplar
INNER JOIN emanet ON kitaplar.isbn= emanet.isbn
INNER JOIN uyeler ON emanet.uyeNo = uyeler.uyeNo;


/* KUTUPHANE */
/* KITAPLAR */
SELECT * FROM kitaplar

USE library_management
INSERT INTO kitaplar VALUES(6057479360, 'Fesle�en', '2021-10-05' , 208)


/* Ocak 2023 �ten sonra emanet al�nan kitaplar */
SELECT * FROM kitaplar WHERE isbn=(SELECT isbn FROM emanet WHERE emanet_Tarihi>='2023-01-01')


/* �Yay�nTarihi� 3 ya��ndan b�y�k olan kitaplar�n yazar bilgisini listelemek i�in gerekli SQL ifadesini yaz�n�z*/
SELECT * FROM Kitaplar WHERE yayinTarih < DATEADD(YEAR, -3, GETDATE());

/* YAZARLAR */
/* KATEGORILER */
/* KITAP KUTUPHANE */
SELECT * FROM kutuphane
/* KITAP KATEGORI */
/* KITAP YAZAR */