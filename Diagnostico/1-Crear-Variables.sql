declare @x INT
set @x=10

print 'El valor de x es: '+ cast(@x as VARCHAR)

if @x >=0
BEGIN
print 'El numero es positivo'
END
ELSE
BEGIN
PRINT 'El numero es negativo'
END

DECLARE @i as INT set @i=1
while (@i<=10)
BEGIN
print cast (@i as VARCHAR)
set @i=@i+1
end

use Northwind

--Crear S-P

create PROCEDURE Procedure_Ciclo
as

declare @x INT
set @x=10

print 'El valor de x es: '+ cast(@x as VARCHAR)

if @x >=0
BEGIN
print 'El numero es positivo'
END
ELSE
BEGIN
PRINT 'El numero es negativo'
END

DECLARE @i as INT set @i=1
while (@i<=10)
BEGIN
print cast (@i as VARCHAR)
set @i=@i+1
end

select c.CompanyName as 'nombre del cliente',
sum(od.Quantity * od.UnitPrice) as total 
from Customers as c 
inner join Orders as o 
on c.CustomerID = o.CustomerID
inner join [Order Details] as od 
on od.OrderID = o.OrderID
where DATEPART (year,o.OrderDate) = 1996
group by c.CompanyName;

create or alter PROC sp_ventasCliente
--parametros
@year as int as BETWEEN
select c.CompanyName as 'nombre del cliente',
sum(od.Quantity * od.UnitPrice) as total 
from Customers as c 
inner join Orders as o 
on c.CustomerID = o.CustomerID
inner join [Order Details] as od 
on od.OrderID = o.OrderID
where DATEPART (year,o.OrderDate) = @year
group by c.CompanyName
end

EXEC sp_ventasCliente 1997

--realizar un store procedure que muestre un reporte de ventas por cliente y producto
--por un rango de fechas 

--Ejercicio 2 realizar un store procedure que inserte un cliente nuevo .
create or alter PROCEDURE agregar_cliente

AS
@CustomerID, nchar(5),
@CompanyName, nvarchar(40),
@ContactName, nvarchar(30) = null,
@ContactTitle, nvarchar(30) = null,
@Address, nvarchar(60) = null,
@City, nvarchar(15) = null,
@Region, nvarchar(15) = null,
@PostalCode, nvarchar(10) = null,
@Country, nvarchar(15) = null,
@Phone, nvarchar(24) = null,
@Fax, nvarchar(24) = null
BEGIN
INSERT INTO [dbo].[Customers]
           ([@CustomerID],
           [@CompanyName],
            [@ContactName],
            [@ContactTitle],
            [@Address],
            [@City],
            [@Region],
            [@PostalCode],
            [@Country],
            [@Phone],
            [@Fax])
     VALUES( @CustomerID,
           @CompanyName,
            @ContactName,
            @ContactTitle,
            @Address,
            @City,
            @Region,
            @PostalCode,
            @Country,
            @Phone,
            @Fax)
END;