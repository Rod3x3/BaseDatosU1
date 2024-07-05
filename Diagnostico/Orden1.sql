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
order by c.Country,c.city asc

---Elimar valores repetidos en una consulta

--selecionar los paises de los clientes

select Country from Customers
order by 1 asc

select count(distinct country) as 'total'
from Customers

select distinct Country from Customers
order by 1 asc

--- seleciona todos los productos deonde le preco es mayor a 18 o igual
select * from Products as p
where UnitPrice >= 18.0  --order by UnitPrice

select * from Products as p
where UnitPrice != 18.0 

--Seleciona tdos los productos que tengan un precio 
--entre 18 y 25 dolares

select * from Products as P
where  p.UnitPrice between 18 and 25

select * from Products as P
where  p.UnitPrice>= 18 and UnitPrice >= 25 

select * from Products as P
where  p.UnitPrice > 18 and p.UnitPrice > 25 

select * from Products as P
where  p.UnitPrice not between 18 and 25

select * from Products as P
where not  (p.UnitPrice >= 18 and p.UnitPrice <= 25 )



-- Selecionar todos los productos donde el precio sea mayor a 38 y su existencia sea mayor e igual a 22

select UnitPrice as 'Precio', UnitsInStock as 'Unidad'
from Products as p
where UnitPrice > 38 and UnitsInStock >= 22 

--Selecionar todos los clientes de alemaniac and mexico and francia
select * from Customers

select *
from Customers as p
where Country = 'Germany' or Country = 'Mexico' or Country = 'France'

select *
from Customers as p
where Country in ( 'Germany' , 'Mexico' , 'France')

--Selecionar todos los clientes que no tengan region

select * from Customers
where Region is  null


select * from Customers
where Region is not null

--Selecionar todas las ordenes enviadas de julio de 1996 a abril de 1998 para los empleados Buchanan, Leverling y Devolio
select * from Orders

select * from Employees

select FirstName as 'Nombre',
OrderDate as 'Fecha de la orden'
from Employees, Orders
where OrderDate in ('1996-07', '1998-04')

select * from Orders as o
where o.ShippedDate between '1996-07-01' and '1997-04-30' and o.EmployeeID in (5,3,1)

select e.LastName as 'Empleado', o.ShippedDate as 'Fecha de entrega'  from 
Employees as e
inner join Orders as o
on e.EmployeeID = o.EmployeeID
where o.ShippedDate between '1996-07-01' and '1997-04-30' and e.LastName in ('Buchanan', 'Leverling', 'Devolio')

--Seleccionar todas las ordenes enviadas de julio de 1996 a abril de 1998
--Para los empleados buchanan, leverling, davalio (5,3,1)

select * FROM Orders
WHERE
(ShippedDate >= '1996-07-01' and ShippedDate <='1998-04-30')
and EmployeeID in (5,3,1)


select * FROM Orders
WHERE
(ShippedDate >= '1996-07-01' and ShippedDate <='1998-04-30')
and (EmployeeID = 5 or EmployeeID=3 or EmployeeID=1)

select * from Orders
where ShippedDate BETWEEN'1996-07-01' and '1998-04-30'
and EmployeeID in (5,3,1)

--seleccione la fecha actual del sitema
select getdate()

select year(OrderDate) as año from Orders;

--selecciona todas las ordenes de compra para 1996
select OrderID as 'numero orden', OrderDate as 'Fecha Orden', year(OrderDate) as año  from Orders
where  OrderDate BETWEEN '1996-01-01' and '1996-12-31'

select OrderID as 'numero orden', OrderDate as 'Fecha Orden', year(OrderDate) as año  from Orders
where  YEAR(OrderDate) = '1996'

--Seleccionar todas las ordenes de compra mostrando numero de orden ,
--fecha de orden, año, mes y dia de 1996 y 1998

SELECT OrderID as 'numero orden', OrderDate as 'Fecha Orden',YEAR(OrderDate), MONTH(OrderDate) as 'mes', DAY(OrderDate) as 'dia' from Orders
where YEAR(OrderDate) = '1996' or YEAR(OrderDate) = '1998'

SELECT OrderID as 'numero orden', OrderDate as 'Fecha Orden',YEAR(OrderDate), MONTH(OrderDate) as 'mes', DAY(OrderDate) as 'dia' from Orders
where YEAR(OrderDate) in ('1996','1998')

--seleccionar todos los apellidos de los empleados que comiencen con D
SELECT * FROM Employees
WHERE LastName LIKE 'D%'

--seleccionar todos los empleados que su apellido comiencen con DA
SELECT * FROM Employees
WHERE LastName LIKE 'DA%'

--seleccionar todos los empleados que su apellido termine con A
SELECT * FROM Employees
WHERE LastName LIKE '%A'

--seleccionar a tods los empleados que su apellido contenga la letra A
SELECT * FROM Employees
WHERE LastName LIKE '%A%'

--Seleccionar tdos los empleados que su apellido no contega la letra A
SELECT * FROM Employees
WHERE LastName NOT LIKE '%A%'

--Seleccionar todos los empleados que contengan su apellido cualquier letra y una I
SELECT * FROM Employees
WHERE LastName LIKE '%__I%'

--Seleccionar tods los empleados donde su nombre contenga tres caracteres 
--antes contenga la palabra li despues un caracter y finalmente la letra d
SELECT * FROM Employees
WHERE LastName LIKE '%__i_g%'

--Seleccionar los apellidos que comiencen con d o con l
SELECT * FROM Employees
WHERE LastName LIKE '[DL]%'

--Seleccionar todos los empleados en su apellido comiencen con una h o una a
SELECT * FROM Employees
WHERE LastName LIKE '[SC]%'

--Seleccionar todos los empleados que en su apellido contenga una D o L
SELECT * FROM Employees
WHERE LastName LIKE '[DL]%'

--seleccionar tods los empleados que en su apellido contenga la letras entre la A y F
SELECT * FROM Employees
WHERE LastName LIKE '%[A-F]%'

--Seleccionar cuantos empleados contienen en sus apellidos la letra entre la A y la F
SELECT COUNT(*) as 'Total de Empelados' FROM Employees
WHERE LastName LIKE '%[A-F]%'

--seleccionar todos los empleados en donde sus apellidos terminen con CB
SELECT * FROM Employees
WHERE LastName LIKE '[^CB]%'

SELECT * FROM Employees
WHERE LastName LIKE '[CB]%'

--Funciones de agregado group by, having

--joins




