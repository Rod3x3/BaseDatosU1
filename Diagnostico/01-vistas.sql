create database vistasPractica

use vistasPractica

--crear una vista ded esta consulta

CREATE or ALTER  VIEW view_categorias_productos
as

SELECT c.CategoryName as 'Nombre Categoria',
p.ProductName as 'Nombre Producto',
p.UnitPrice as 'Precio',
p.UnitsInStock as 'Existencia'
FROM
Northwind.dbo.Categories as c
INNER JOIN Northwind.dbo.Products as p 
on c.CategoryID = P.CategoryID

SELECT *,(precio * existencia) as 'precio inventario' FROM view_categorias_productos 
WHERE [Nombre Categoria] in ('Beverages','Condiments')
ORDER by [Nombre Categoria] DESC

--seleccionar la suma del precio del inventario agrupado por categoria 

SELECT [Nombre Categoria] as 'Categoria', SUM(Precio * Existencia) as '´Suma del precio del inventario' FROM view_categorias_productos
ORDER BY [Nombre Categoria]

