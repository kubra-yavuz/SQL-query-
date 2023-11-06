-- 1. Product isimlerini (`ProductName`) ve birim başına miktar (`QuantityPerUnit`) değerlerini almak için sorgu yazın.
Select product_name, quantity_per_unit from products;

-- 2. Ürün Numaralarını (`ProductID`) ve Product isimlerini (`ProductName`) değerlerini almak için sorgu yazın. Artık satılmayan ürünleri (`Discontinued`) filtreleyiniz.
Select product_id, product_name from products
where discontinued =1;

-- 3. Durdurulan Ürün Listesini, Ürün kimliği ve ismi (`ProductID`, `ProductName`) değerleriyle almak için bir sorgu yazın.
Select product_id, product_name, discontinued from products
where discontinued =1;

-- 4. Ürünlerin maliyeti 20'dan az olan Ürün listesini (`ProductID`, `ProductName`, `UnitPrice`) almak için bir sorgu yazın.
Select product_id, product_name, unit_price from products where unit_price<20;

-- 5. Ürünlerin maliyetinin 15 ile 25 arasında olduğu Ürün listesini (`ProductID`, `ProductName`, `UnitPrice`) almak için bir sorgu yazın.
Select product_id, product_name, unit_price from products where unit_price between 15 AND 25;

-- 6. Ürün listesinin (`ProductName`, `UnitsOnOrder`, `UnitsInStock`) stoğun siparişteki miktardan az olduğunu almak için bir sorgu yazın.
Select product_name, units_on_order, units_in_stock from products where units_in_stock < units_on_order;

-- 7. İsmi `a` ile başlayan ürünleri listeleyeniz.
Select * from products where lower (product_name) like 'a%';

-- 8. İsmi `i` ile biten ürünleri listeleyeniz.
Select * from products where lower (product_name) like '%i';

-- 9. Ürün birim fiyatlarına %18’lik KDV ekleyerek listesini almak (ProductName, UnitPrice, UnitPriceKDV) için bir sorgu yazın.
Select product_name, unit_price, (unit_price * 1.18) AS UnitPriceKDV from products;

-- 10. Fiyatı 30 dan büyük kaç ürün var?
--select unit_price from products where unit_price>30;
Select count (*) unit_price from products where unit_price>30;

-- 11. Ürünlerin adını tamamen küçültüp fiyat sırasına göre tersten listele
Select lower (product_name) AS productname , unit_price from products  
Order by unit_price DESC;

-- 12. Çalışanların ad ve soyadlarını yanyana gelecek şekilde yazdır
Select (first_name || ' ' || last_name) AS AdSoyad from employees;

-- 13. Region alanı NULL olan kaç tedarikçim var?
Select Count (*) from suppliers where region is null;

-- 14. a.Null olmayanlar?
Select Count (*) from suppliers where region is not null;

-- 15. Ürün adlarının hepsinin soluna TR koy ve büyük olarak ekrana yazdır.
Select ('TR' || ' '|| UPPER (product_name)) AS TR from products;

-- 16. a.Fiyatı 20den küçük ürünlerin adının başına TR ekle
Select ('TR' || ' '|| product_name) AS TR , unit_price from products where unit_price<20;

-- 17. En pahalı ürünün listesini (`ProductName` , `UnitPrice`) almak için bir sorgu yazın.
Select  product_name, unit_price from products 
Where unit_price = (Select MAX (unit_price) from products);

-- 18. En pahalı on ürünün Ürün listesini (`ProductName` , `UnitPrice`) almak için bir sorgu yazın.
Select product_name, unit_price FROM products 
ORDER BY unit_price DESC LIMIT 10;

-- 19. Ürünlerin ortalama fiyatının üzerindeki Ürün listesini (`ProductName` , `UnitPrice`) almak için bir sorgu yazın.
Select  product_name, unit_price from products
where unit_price > (select AVG (unit_price) FROM products);

-- 20. Stokta olan ürünler satıldığında elde edilen miktar ne kadardır.
--a.Satıştan kazanılan toplam miktar 
Select SUM (unit_price * units_in_stock) as miktar from products;

--b.Satılan ürün miktarı
Select SUM (units_in_stock) as toplam from products;

-- 21. Mevcut ve Durdurulan ürünlerin sayılarını almak için bir sorgu yazın.
select product_name,discontinued,units_in_stock from products
where units_in_stock >0 And discontinued =1;

SELECT COUNT(*) AS total_count, product_name FROM products
WHERE units_in_stock > 0 AND discontinued = 1
GROUP BY product_name;

-- Devam eden ve durdurulan ürünler
select discontinued, count(*) from products
group by discontinued;

-- 22. Ürünleri kategori isimleriyle birlikte almak için bir sorgu yazın.
Select products.product_name ,categories.category_name from products
INNER JOIN categories ON categories. category_id = products.category_id;

SELECT P.CATEGORY_NAME, P.PRODUCT_NAME, 
FROM PRODUCTS P
JOIN CATEGORIES C ON P.CATEGORYID = C.CATEGORYID;

-- 23. Ürünlerin kategorilerine göre fiyat ortalamasını almak için bir sorgu yazın.
SELECT category_id, AVG(unit_price) AS average_price FROM products
GROUP BY category_id;

-- 24. En pahalı ürünümün adı, fiyatı ve kategorisinin adı nedir?
Select  p.product_name, p.unit_price, c.category_name from products p
INNER JOIN categories c ON c. category_id = p.category_id
Where unit_price = (Select MAX (unit_price) from products);

-- 25. En çok satılan ürününün adı, kategorisinin adı ve tedarikçisinin adı
Select  p.product_name,  c.category_name, s.company_name from products p
JOIN categories c ON c. category_id = p.category_id 
JOIN suppliers s ON s.supplier_id = p.supplier_id
Where units_on_order = (Select MAX (units_on_order) from products);

-- 26. Stokta bulunmayan ürünlerin ürün listesiyle birlikte tedarikçilerin ismi ve iletişim numarasını (`ProductID`, `ProductName`, `CompanyName`, `Phone`) almak için bir sorgu yazın.
select p.product_id, p.product_name,s.company_name, s.phone from products p
inner join suppliers s on s.supplier_id =p.supplier_id
where units_in_stock = 0

-- 27. 1998 yılı mart ayındaki siparişlerimin adresi, siparişi alan çalışanın adı, çalışanın soyadı
SELECT o.ship_address, o.order_date, e.first_name, e.last_name
FROM orders o
INNER JOIN employees e ON o.employee_id = e.employee_id
WHERE o.order_date >= '1998-02-28' AND o.order_date <= '1998-04-01';

-- 28. 1997 yılı şubat ayında kaç siparişim var?
select SUM(quantity) as "1997 Siparis" from orders o
inner join order_details od on od.order_id = o.order_id
where date_part('year', order_date) = 1997 and date_part('month', order_date) = 2

-- 29. London şehrinden 1998 yılında kaç siparişim var?
select ship_city, SUM(quantity) as "1998 Siparis" from orders o
inner join order_details od on od.order_id = o.order_id
where date_part('year', order_date) = 1998 AND ship_city = 'London'
group by o.ship_city 

-- 30. 1997 yılında sipariş veren müşterilerimin contactname ve telefon numarası
select c.contact_name, c.phone, o.order_date from orders o
inner join customers c on c.customer_id = o.customer_id
inner join order_details od on o.order_id = od.order_id
where date_part('year', order_date) = 1997 
group by c.contact_name, c.phone, o.order_date

-- 31. Taşıma ücreti 40 üzeri olan siparişlerim
select * from orders
where freight >40;

-- 32. Taşıma ücreti 40 ve üzeri olan siparişlerimin şehri, müşterisinin adı
select o.ship_city, c.contact_name,o.freight from orders o
inner join customers c on c.customer_id = o.customer_id
where freight >40;

-- 33. 1997 yılında verilen siparişlerin tarihi, şehri, çalışan adı -soyadı ( ad soyad birleşik olacak ve büyük harf),
select o.order_date, o.ship_city, UPPER(e.first_name || ' ' || e.last_name) AS "Ad Soyad" from orders o
inner join employees e on e.employee_id = o.employee_id
where date_part('year', order_date) = 1997 

-- 34. 1997 yılında sipariş veren müşterilerin contactname i, ve telefon numaraları ( telefon formatı 2223322 gibi olmalı )
Select c.contact_name,regexp_replace(c.phone, '[^0-9]', '', 'g')  AS TELEFON  From orders o
inner join customers c ON c.customer_id = o.customer_id
Where date_part('year',o.order_date) = 1997 
Group By c.contact_name, c.phone

-- 35. Sipariş tarihi, müşteri contact name, çalışan ad, çalışan soyad
Select o.order_date, c.contact_name, e.first_name, e.last_name from orders o
inner join employees e on e.employee_id = o.employee_id
inner join customers c on c.customer_id = o.customer_id

-- 36. Geciken siparişlerim?
select * from orders
where required_date < shipped_date

-- 37. Geciken siparişlerimin tarihi, müşterisinin adı
select o.order_date, c.contact_name from orders o
inner join customers c on c.customer_id = o.customer_id
where required_date < shipped_date

-- 38. 10248 nolu siparişte satılan ürünlerin adı, kategorisinin adı, adedi
select od.order_id, p.product_name, c.category_name, od.quantity  from order_details od
inner join products p on p.product_id = od.product_id
inner join categories c on c.category_id = p.category_id
where od.order_id = 10248;

-- 39. 10248 nolu siparişin ürünlerinin adı , tedarikçi adı
select od.order_id, p.product_name, s.contact_name as "Tedarikçi Adı" from order_details od
inner join products p on p.product_id =od.product_id
inner join suppliers s on s.supplier_id = p.supplier_id
where od.order_id = 10248;

-- 40. 3 numaralı ID ye sahip çalışanın 1997 yılında sattığı ürünlerin adı ve adeti
select o.employee_id, o.order_date, p.product_name, od.quantity from products p
inner join order_details od on od.product_id =p.product_id
inner join orders o ON od.order_id = o.order_id
Where date_part('year',o.order_date) = 1997 and employee_id =3

-- 41. 1997 yılında bir defasinda en çok satış yapan çalışanımın ID,Ad soyad
select o.employee_id, e.first_name, e.last_name, max(quantity) from employees e
inner join orders o on o.employee_id =e.employee_id
inner join order_details od ON od.order_id = o.order_id
Where date_part('year',o.order_date) = 1997 
group by o.employee_id, e.first_name, e.last_name
order by max(quantity) DESC limit 1

-- 42. 1997 yılında en çok satış yapan çalışanımın ID,Ad soyad ****
select o.employee_id, e.first_name, e.last_name, sum(quantity) as "Toplam Satış" from employees e
inner join orders o on o.employee_id =e.employee_id
inner join order_details od ON od.order_id = o.order_id
Where date_part('year',o.order_date) = 1997 
group by o.employee_id, e.first_name, e.last_name
order by sum(quantity) DESC limit 1

-- 43. En pahalı ürünümün adı,fiyatı ve kategorisin adı nedir?
select p.product_name, p.unit_price, c.category_name, max(unit_price) as "Fiyat" from products p
inner join categories c on c.category_id =p.category_id
group by p.product_name, p.unit_price, c.category_name
order by max(unit_price) DESC limit 1

-- 44. Siparişi alan personelin adı,soyadı, sipariş tarihi, sipariş ID. Sıralama sipariş tarihine göre
select e.first_name, e.last_name, o.order_id, o.order_date from orders o
inner join employees e on o.employee_id =e.employee_id
order by order_date

-- 45. SON 5 siparişimin ortalama fiyatı ve order_id nedir?
select o.order_id, avg(od.unit_price*od.quantity) as Ortalama from orders o
inner join order_details od on od.order_id =o.order_id
group by o.order_id
order by order_date DESC limit 5

-- 46. Ocak ayında satılan ürünlerimin adı, kategorisinin adı ve toplam satış miktarı nedir?
SELECT o.order_date, p.product_name, c.category_name, sum(od.unit_price*od.quantity) as "Toplam Satış Miktarı" FROM order_details od
INNER JOIN products p ON p.product_id = od.product_id
INNER JOIN categories c ON p.category_id = p.category_id
inner join orders o ON od.order_id = o.order_id
where date_part('month', order_date) = 1
group by p.product_name, c.category_name,o.order_date

-- 47. Ortalama satış miktarımın üzerindeki satışlarım nelerdir?
SELECT order_id, quantity, round(ortalama_satis,3) as "Ortalama Satış" FROM order_details,
(SELECT AVG(quantity) as ortalama_satis FROM order_details)
WHERE quantity > ortalama_satis;

-- 48. En çok satılan ürünümün(adet bazında) adı, kategorisinin adı ve tedarikçisinin adı
Select  p.product_name,  c.category_name, s.company_name from products p
JOIN categories c ON c. category_id = p.category_id 
JOIN suppliers s ON s.supplier_id = p.supplier_id
Where units_on_order = (Select MAX (units_on_order) from products);

-- 49. Kaç ülkeden müşterim var?
SELECT COUNT(DISTINCT country) AS customer_count
FROM customers;

-- 50. 3 numaralı ID ye sahip çalışan (employee) son Ocak ayından BUGÜNE toplamda ne kadarlık ürün sattı?

-- 51. 10248 nolu siparişte satılan ürünlerin adı, kategorisinin adı, adedi
select od.order_id, p.product_name, c.category_name, od.quantity  from order_details od
inner join products p on p.product_id = od.product_id
inner join categories c on c.category_id = p.category_id
where od.order_id = 10248;

-- 52. 10248 nolu siparişin ürünlerinin adı , tedarikçi adı
select od.order_id, p.product_name, s.contact_name as "Tedarikçi Adı" from order_details od
inner join products p on p.product_id =od.product_id
inner join suppliers s on s.supplier_id = p.supplier_id
where od.order_id = 10248;

-- 53. 3 numaralı ID ye sahip çalışanın 1997 yılında sattığı ürünlerin adı ve adeti
select o.employee_id, o.order_date, p.product_name, od.quantity from products p
inner join order_details od on od.product_id =p.product_id
inner join orders o ON od.order_id = o.order_id
Where date_part('year',o.order_date) = 1997 and employee_id =3

-- 54. 1997 yılında bir defasinda en çok satış yapan çalışanımın ID,Ad soyad
select o.employee_id, e.first_name, e.last_name, max(quantity) from employees e
inner join orders o on o.employee_id =e.employee_id
inner join order_details od ON od.order_id = o.order_id
Where date_part('year',o.order_date) = 1997 
group by o.employee_id, e.first_name, e.last_name
order by max(quantity) DESC limit 1

-- 55. 1997 yılında en çok satış yapan çalışanımın ID,Ad soyad ****
select o.employee_id, e.first_name, e.last_name, sum(quantity) as "Toplam Satış" from employees e
inner join orders o on o.employee_id =e.employee_id
inner join order_details od ON od.order_id = o.order_id
Where date_part('year',o.order_date) = 1997 
group by o.employee_id, e.first_name, e.last_name
order by sum(quantity) DESC limit 1

-- 56. En pahalı ürünümün adı,fiyatı ve kategorisin adı nedir?
select p.product_name, p.unit_price, c.category_name, max(unit_price) as "Fiyat" from products p
inner join categories c on c.category_id =p.category_id
group by p.product_name, p.unit_price, c.category_name
order by max(unit_price) DESC limit 1

-- 57. Siparişi alan personelin adı,soyadı, sipariş tarihi, sipariş ID. Sıralama sipariş tarihine göre
select e.first_name, e.last_name, o.order_id, o.order_date from orders o
inner join employees e on o.employee_id =e.employee_id
order by order_date

-- 58. SON 5 siparişimin ortalama fiyatı ve orderid nedir?
select o.order_id, avg(od.unit_price*od.quantity) as Ortalama from orders o
inner join order_details od on od.order_id =o.order_id
group by o.order_id
order by order_date DESC limit 5

-- 59. Ocak ayında satılan ürünlerimin adı ve kategorisinin adı ve toplam satış miktarı nedir?
SELECT o.order_date, p.product_name, c.category_name, sum(od.unit_price*od.quantity) as "Toplam Satış Miktarı" FROM order_details od
INNER JOIN products p ON p.product_id = od.product_id
INNER JOIN categories c ON p.category_id = p.category_id
inner join orders o ON od.order_id = o.order_id
where date_part('month', order_date) = 1
group by p.product_name, c.category_name,o.order_date

-- 60. Ortalama satış miktarımın üzerindeki satışlarım nelerdir?
SELECT order_id, quantity, round(ortalama_satis,3) as "Ortalama Satış" FROM order_details,
(SELECT AVG(quantity) as ortalama_satis FROM order_details)
WHERE quantity > ortalama_satis;

-- 61. En çok satılan ürünümün(adet bazında) adı, kategorisinin adı ve tedarikçisinin adı
select c.category_name, t.contact_name from products p
inner join suppliers t on t.supplier_id = p.supplier_id
inner join categories c on c.category_id = p.category_id
group by c.category_name, t.contact_name

-- 62. Kaç ülkeden müşterim var
select  country from customers
group by country

-- 63. Hangi ülkeden kaç müşterimiz var
select country, count(*)as "müşteri sayısı" from customers
group by country

-- 64. 3 numaralı ID ye sahip çalışan (employee) son Ocak ayından BUGÜNE toplamda ne kadarlık ürün sattı?
select sum(p.unit_price) from products p
inner join order_details od on od.product_id = p.product_id
inner join orders o on o.order_id = od.order_id
where employee_id = 3 and date_part('month', o.order_date)=1 and o.order_date <= current_date


-- 65. 10 numaralı ID ye sahip ürünümden son 3 ayda ne kadarlık ciro sağladım?
select sum(p.unit_price) as "toplam ciro" from products p
inner join order_details od on od.product_id = p.product_id
inner join orders o on o.order_id = od.order_id
where p.product_id = 10 and o.order_date >= (current_date - INTERVAL '3 months');


-- 66. Hangi çalışan şimdiye kadar toplam kaç sipariş almış..?
select e.first_name, e.last_name, sum(od.quantity) from employees e
inner join orders o on o.employee_id = e.employee_id
inner join order_details od on od.order_id = o.order_id
group by e.first_name, e.last_name;

-- 67. 91 müşterim var. Sadece 89’u sipariş vermiş. Sipariş vermeyen 2 kişiyi bulun
select c.customer_id, c.contact_name from orders o 
right join customers c on c.customer_id = o.customer_id 
where order_id is null

-- 68. Brazil’de bulunan müşterilerin Şirket Adı, TemsilciAdi, Adres, Şehir, Ülke bilgileri
select company_name, contact_name, address, city, country from customers
where country = 'Brazil';


-- 69. Brezilya’da olmayan müşteriler
select * from customers
where country <> 'Brazil';

-- 70. Ülkesi (Country) YA Spain, Ya France, Ya da Germany olan müşteriler
select * from customers
where country IN ('Spain','France','Germany');

-- 71. Faks numarasını bilmediğim müşteriler
select * from customers
where fax is null

-- 72. Londra’da ya da Paris’de bulunan müşterilerim
select * from customers
where city IN ('London','Paris')

-- 73. Hem Mexico D.F’da ikamet eden HEM DE ContactTitle bilgisi ‘owner’ olan müşteriler
select * from customers
where city = 'México D.F.' And contact_title = 'Owner';

-- 74. C ile başlayan ürünlerimin isimleri ve fiyatları
select product_name, unit_price from products
where product_name LIKE 'C%';

-- 75. Adı (FirstName) ‘A’ harfiyle başlayan çalışanların (Employees); Ad, Soyad ve Doğum Tarihleri
select first_name, last_name,birth_date from employees
where first_name LIKE 'A%';

-- 76. İsminde ‘RESTAURANT’ geçen müşterilerimin şirket adları
select * from customers
where company_name LIKE '%Restaurant%'

-- 77. 50$ ile 100$ arasında bulunan tüm ürünlerin adları ve fiyatları
select product_name, unit_price from products
where unit_price Between '50' and '100';

-- 78. 1 temmuz 1996 ile 31 Aralık 1996 tarihleri arasındaki siparişlerin (Orders), SiparişID (OrderID) ve SiparişTarihi (OrderDate) bilgileri
select order_id, order_date from orders
where order_date Between '1996-07-01' AND '1996-12-31';

-- 79. Ülkesi (Country) YA Spain, Ya France, Ya da Germany olan müşteriler
select * from customers
where country IN ('Spain','France','Germany');

-- 80. Faks numarasını bilmediğim müşteriler
select * from customers
where fax is null

-- 81. Müşterilerimi ülkeye göre sıralıyorum:
select * from customers
order by country asc

-- 82. Ürünlerimi en pahalıdan en ucuza doğru sıralama, sonuç olarak ürün adı ve fiyatını istiyoruz
select product_name, unit_price from products
order by unit_price DESC

-- 83. Ürünlerimi en pahalıdan en ucuza doğru sıralasın, ama stoklarını küçükten-büyüğe doğru göstersin sonuç olarak ürün adı ve fiyatını istiyoruz
select product_name, unit_price, units_in_stock from products
order by unit_price DESC, units_in_stock asc

-- 84. 1 Numaralı kategoride kaç ürün vardır..?
select count(*) from products
where category_id=1

-- 85. Kaç farklı ülkeye ihracat yapıyorum..?
select count(distinct country) as "İhracat yapılan ülke sayısı" from customers


