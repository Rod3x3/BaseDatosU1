use Northwind

create or alter proc sp_ventas_proveedor
@year int, @month int, @day int
as
begin
select s.CompanyName, sum(od.UnitPrice * od.Quantity) as inporte from 
Suppliers as s
inner join Products as p
on s.SupplierID = P.SupplierID
inner join [Order Details] as od
on p.ProductID = od.ProductID
inner join Orders as o
on o.OrderID = od.OrderID
where datepart(year,o.OrderDate) = @year
and DATEPART(MONTH,o.OrderDate) = @month
and DatePart(DAY, o.OrderDate) = @day
group by s.CompanyName
order by s.CompanyName;
end

go

exec sp_ventas_proveedor 1996,07,04

exec sp_ventas_proveedor @day=04, @year=1996, @month = 07

select COUNT(*), o.ShipCountry from Orders as o
where  datepart(year,o.OrderDate) = 1997
group by o.OrderID
select * from Orders










