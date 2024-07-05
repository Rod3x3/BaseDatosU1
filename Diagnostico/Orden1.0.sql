--Consultas simples(Consultas a una sola tabla)
use Northwind;

---Selecionar todos los customers (Clientes)
select * from Customers

--Proyeccion
select  CustomerID, CompanyName, City, Country
from Customers

--Seleciona los primeros 10 registros
select top 10  CustomerID, CompanyName, City, Country
from Customers

--Alias de columna
--contry as pais
--contry pais
--contry 'pais'
--- contry as 'pais'
-- contry as 'pais de las maravillas'

select  CustomerID as 'numero cliente',
CompanyName NombreEmpresa, City as 'ciudad', Country 'pais'
from Customers

select * from Customers

--Alias de tablas


select Customers.CustomerID,Customers.CompanyName,Customers.City,Customers.Country
from Customers

select  c.CustomerID, c.CompanyName, c.City, c.Country
from Customers as c

select  c.CustomerID, c.CompanyName, c.City, c.Country
from Customers c

--Campo calculado

select * ,(p.UnitPrice*p.UnitsInStock) as 'Costo inventario'
from Products as p

select ProductName as 'Nombre producto',
UnitsInStock
 as 'Existencia',
UnitPrice as 'Precio Unitario',
(p.UnitPrice * p.UnitsInStock) as 'Costo inventario'
from Products as p

--Filtar datos
--Clausa where y operadores relacionales
/*
        < -> Menor que
		> -> Mayor que
		<= -> Menor o igual
		>= -> Mayor o igual
		<> -> Diferente
		!= -> Diferente
		= -> igual a
*/

select * from Customers

-- Selecionar todos los clientes de alemania

select *
from Customers
where Country = 'Germany'


-- Selecionar todos los productos que tengan un Stock mayor a 20
--mostrando solamente el nombre del producto, el precio y la existencia
Select p.ProductName as 'Nombre del producto',
p.UnitPrice as 'Precio',
p.UnitsInStock as 'Existencia'
from Products as p
where p.UnitsInStock >= 20
order by 'Nombre del producto'; --Desc desendente o asc Aendente

/*Selecionar todos clientes ordenados de forma acendente por pais y dentro del pais ordenados de forma desentende por ciudad
*/

select p.Country as 'Pais', p.City as 'ciudad'
from Customers as p
where p.Country = 'Germany'
order by Country , City desc --mia

select * from Customers as c
where Country = 'Germany'
