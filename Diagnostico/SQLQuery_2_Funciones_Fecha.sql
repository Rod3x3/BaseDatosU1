--Is not
--Date part
--Date Name
--Datediff

--Funciones De Fecha

--Seleccionar los años, dias, meses y cuatrimestres 
use Northwind

SELECT GETDATE()

SELECT DATEPART(YEAR,'2024-06-06') as 'Año',
DATEPART(MONTH,'2024-06-06') as 'mes',
DATEPART(QUARTER,'2024-06-06') as 'Cuatrimestre',
DATEPART(WEEK,'2024-06-06') as 'Semana',
DATEPART(DAY,'2024-06-06') as 'Dia',
DATEPART(WEEKDAY,'2024-06-06') as 'Dia Del Semana',
DATEPART(YEAR,'2024-06-06') as 'Año 2'

SELECT DATEPART(YEAR, OrderDate) as 'Año',
DATEPART(MONTH, OrderDate) as 'mes',
DATEPART(QUARTER, OrderDate) as 'Cuatrimestre',
DATEPART(WEEK, OrderDate) as 'Semana',
DATEPART(DAY, OrderDate) as 'Dia',
DATEPART(WEEKDAY, OrderDate) as 'Dia Del Semana',
DATEPART(YEAR, OrderDate) as 'Año 2'
FROM ORDERS 

--Funcion que devuekve alguna parte de una fecha

--Funcion que regresa el nombre de un dia, semana
SELECT DATENAME(MONTH,getdate()) as mes 
set LANGUAGE spanish

SELECT DATENAME(MONTH,getdate()) as mes, DATENAME(WEEKDAY, getdate()) as dia

SELECT DATEDIFF(year,'1983-04-06',getdate()) as 'Tiempo De Vejes'

--seleccionar los dias trascurridos entre las fecha del pedido y la fecha de entrega
SELECT orderid,  DATEDIFF(day, OrderDate, ShippedDate) as 'Dias trancurridos' FROM ORDERs







