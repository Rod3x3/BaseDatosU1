--seleccionar los productos tienen cada categoria
use Northwind

select CategoryID, COUNT(*) from Products

select CategoryID  from Products

SELECT COUNT(*) FROM Products

SELECT CategoryID ,COUNT(*) FROM Products
GROUP BY CategoryID

select c.CategoryName, COUNT(*) AS 'Numero De Producto' from  Categories as C
INNER JOIN Products as P 
on c.CategoryID = P.CategoryID
GROUP BY C.CategoryName;

--Consultar para mostrar todos los productos. con sus categorias y sus precios 
select C.CategoryName, P.ProductName, P.UnitPrice from Categories as c
Inner JOIN Products as P
on C.CategoryID = P.CategoryID

--Consulta para mostrar los nombres de los productos y los nombres de sus provedores
select p.ProductName as 'Nombre Porducto', S.CompanyName as 'Nombre Provedor' from Products as P
INNER JOIN Suppliers as S
on P.SupplierID = S.SupplierID
ORDER BY s.CompanyName
--Seleccionar las ordenes de compra mostrando los nombres de los productos y sus importes
select od.OrderID as 'numero de orden',
p.ProductName as 'nombre del producto',
(od.Quantity * od.UnitPrice) as 'importe'
from 
[Order Details] as od
inner join 
Products as p
on od.ProductID = p.ProductID
where (od.Quantity * od.UnitPrice) <=15000
order by 'importe' DESC
--Mostrar las ordenes de compra y los nombres de loscempleados que las realizaron 
SELECT OrderID as 'numero de orden',  
CONCAT(e.FirstName, e.LastName) as 'full name'
FROM Orders as  O
JOIN Employees as e 
on o.EmployeeID = e.EmployeeID
WHERE YEAR(OrderDate) in ('1996','1999');

--Seleccionar las ordenes mostrando a los clientes a los que se les hicicron las cantidades vendidas y los nombres de los productos

--Ejercicio 1: Obtener el nombre del cliente y el nombre del empleado del representante de ventas de cada pedido.
select O.OrderID,o.OrderDate, c.CompanyName as 'Nombre Cliente', CONCAT(e.FirstName, '', e.LastName ) as 'Nombre Empleado' from Employees as e 
inner join Orders as o on e.EmployeeID = o.EmployeeID
INNER JOIN Customers as c on o.CustomerID = c.CustomerID;

--Ejercicio 2: Mostrar el nombre del producto, el nombre del proveedor y el precio unitario de cada producto.

--Primera Forma
SELECT p.ProductName as 'Nombre del Producto', s.CompanyName as 'Nombre de la compañia', P.UnitPrice as 'Precio Unitario' from Products as p
INNER JOIN Suppliers as s 
on p.SupplierID = s.SupplierID

--Segunda Forma
SELECT p.ProductName, s.CompanyName, p.UnitPrice FROM(
    SELECT SupplierID, ProductName, UnitPrice
    FROM Products
)as p
INNER JOIN Suppliers as s on p.SupplierID = s.SupplierID

--Tercera Forma
SELECT p.ProductName, s.CompanyName, p.UnitPrice FROM(
    SELECT SupplierID, ProductName, UnitPrice
    FROM Products
)as p
INNER JOIN (
    select SupplierID, CompanyName FROM Suppliers
)AS s 
on p.SupplierID = s.SupplierID


--Ejercicio 3: Listar el nombre del cliente, el ID del pedido y la fecha del pedido para cada pedido.

--Primera Forma
SELECT o.OrderID as 'Numero Orden', c.CompanyName as 'Nombre Cliente', o.OrderDate as 'Fecha de orden',
YEAR(o.OrderDate) as 'año de compra', MONTH(o.OrderDate) as 'Mes de compra', DAY(o.OrderDate) as 'Dia de Compra'  FROM  Customers as c 
INNER JOIN  Orders as o 
on  c.CustomerID = o.CustomerID

--Segunda Forma
SELECT o.OrderID as 'Numero Orden', c.CompanyName as 'Nombre Cliente', o.OrderDate as 'Fecha de orden',
YEAR(o.OrderDate) as 'año de compra', MONTH(o.OrderDate) as 'Mes de compra', DAY(o.OrderDate) as 'Dia de Compra' FROM(
    SELECT CustomerID, CompanyName from Customers 
)as c
INNER JOIN (select  CustomerID, OrderID, OrderDate from Orders)
as o on  c.CustomerID = o.CustomerID

--Ejercicio 4: Obtener el nombre del empleado, el título del cargo y el territorio del empleado para cada empleado.

--Primera Forma
SELECT CONCAT(e.FirstName,'',e.LastName) as 'Nombre del Empleado',
e.Title as 'Cargo', t.TerritoryDescription as 'Territorio'
from EmployeeTerritories as et 
INNER join Employees as e 
on  et.EmployeeID = e.EmployeeID INNER join Territories as t
on t.TerritoryID = et.TerritoryID

--Segunda Forma
SELECT CONCAT(e.FirstName,'',e.LastName) as 'Nombre del Empleado',
e.Title as 'Cargo', t.TerritoryDescription as 'Territorio' FROM (
    select  TerritoryID, EmployeeID FROM EmployeeTerritories
)as et 
INNER JOIN (select EmployeeID,  FirstName, LastName, Title from Employees) as e 
on et.EmployeeID = e.EmployeeID
INNER JOIN (select TerritoryID, TerritoryDescription from  Territories)
as t  on t.TerritoryID = et.TerritoryID;

--Reto seleccionar todas las ordenes mostrando el empleado que la realizo, el cliente al que se le vendio el nombre  de los productos, sus categorias 
--El precio que se vendio las unidades vendidas y el importe para enero de 1997 a feb de 1998

--Primera Forma
select CONCAT(FirstName,' ',LastName) as 'nombre del empleado',
c.CompanyName as 'nombre del clente',
p.ProductName as 'nombre del producto',
ca.CategoryName as 'categoria',
od.UnitPrice as 'precio',
od.Quantity as 'cantidad',
(od.UnitPrice*od.Quantity) as 'importe'
from Employees as e 
inner join orders as o
on e.EmployeeID = o.EmployeeID
inner join Customers as c
on o.CustomerID = c.CustomerID
inner join [Order Details] as od
on o.OrderID = od.OrderID
inner join Products as p 
on p.ProductID = od.ProductID
inner join Categories as ca 
on ca.CategoryID = p.CategoryID
where o.OrderDate between '1997-01-01' and '1998-02-28'
and ca.CategoryName in ('Beverages')
order by c.CompanyName

--Cuanto dinero e vendido de la categoria beverages
SELECT * FROM
Categories as C 
INNER JOIN  Products as p 
on  c.CategoryID = p.CategoryID

--Ejercicio 5: Mostrar el nombre del proveedor, el nombre del contacto y el teléfono del contacto para cada proveedor.

--Primera Forma








--Ejercicio 6: Listar el nombre del producto, la categoría del producto y el nombre del proveedor para cada producto.
--Ejercicio 7: Obtener el nombre del cliente, el ID del pedido, el nombre del producto y la cantidad del producto para cada detalle del pedido.
--Ejercicio 8: Obtener el nombre del empleado, el nombre del territorio y la región del territorio para cada empleado que tiene asignado un territorio.
--Ejercicio 9: Mostrar el nombre del cliente, el nombre del transportista y el nombre del país del transportista para cada pedido enviado por un transportista.
--Ejercicio 10: Obtener el nombre del producto, el nombre de la categoría y la descripción de la categoría para cada producto que pertenece a una categoría.


