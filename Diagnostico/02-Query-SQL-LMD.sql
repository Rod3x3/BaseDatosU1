select * from [Northwind].dbo.Customers;
go

select * from CLIENTE;
go

--Insetar en la tabla cliente
Insert into CLIENTE (RFC,CURP,NOMBRE,APELLIDO_P,APELLIDO_M)
values('jing19830409X9X','JLHG19830405','Alfreds Futterkiste','xytfdd','futterkiste'),
('alan19830408X8X','ALAN19837814','Alan','Molina','Santiago'),
('victor196408X8X','VIC198378914','Victor','gato','negro'),
('alma19835608X8X','ALM198378914','Alma','poz','ada');
go

select * from CLIENTE

--Elimina la tabla cliente
delete CLIENTE
delete from CLIENTE
--Comando Pra Reiniciar el identity de una tabla
DBCC CHECKIDENT (CLIENTE, RESEED,0);
go

--Crea una tabla apartir de una consulta
select top 0 EmployeeID as 'empleadoid', LastName as 'Apellido', FirstName as 'Primer Nombre', BirthDate as 'FechaNacimiento', 
HireDate as 'FechaContratacion', [Address] as 'Direccion', City as 'Ciudad', Region, PostalCode as 'CodigoPostal', 
Country as 'Pais' into empleado2 from Northwind.dbo.Employees;
go

--Elimar la tabla empelado
drop table empleado2
go
--Selecciona la tabla empleado2
select * from empleado2
go

--Consulta externa 
select top 5 * from Northwind.dbo.[Order Details]
order by OrderID desc
go

--Insertar datos apartir de una conculta

alter table empleado2
add constraint pk_empelado2
primary key(empleadoid)

select * from empleado2

go

insert into empleado2 (empleadoId, Apellido,Primer Nombre,FechaNacimiento,FechaContratacion,Direccion,Ciudad,Region,CodigoPostal,Pais)
select  EmployeeID as 'empleadoid', LastName as 'Apellido', FirstName as 'Primer Nombre', BirthDate as 'FechaNacimiento', 
HireDate as 'FechaContratacion', [Address] as 'Direccion', City as 'Ciudad', Region, PostalCode as 'CodigoPostal', 
Country as 'Pais'  from Northwind.dbo.Employees
go

select * from empleado2;
select * from CLIENTE;
select * from empleado

insert into empleado(nombre,APELLIDO_P,APELLIDO_M,curp,rfc,numeroExterno,calle,salario,numeronomina)
values('Alan','Santiago','Molina','ALM456789','ALMN34355',23,'Calle Infienro',6789.9,12345),
('Yamilet','Mejia','Ranjel','YAH568990','YATH5467',289,'Calle del Hambre',76889.17,97537),
('Moises','Santiago','Isidro','MOI6897','ISI8934',56,'Calle Gordillo',20000,79480)

insert into ordencompra 
values(GETDATE(),'2024-06-10',1,1),
      (GETDATE(),'2024-07-11',3,3)


--Selecciona la fecha del sistema
select  GETDATE()

select * from Northwind.dbo.Products

insert into proveedor
select SupplierID, CompanyName, PostalCode, 'Calle Del Sol', City, 2345, 'ww.prueba.com.mx' as 'Pagina Web'  from Northwind.dbo.Suppliers

select * from proveedor

delete from  proveedor

insert into producto (numerocontrol,descripcion,precio,[status],existencia,proveedorid)
select ProductID, ProductName, UnitPrice,Discontinued, UnitsInStock, SupplierID from Northwind.dbo.Products

select * from ordencompra
select * from detalleCompra

insert into detalleCompra
values (1,2,30,(select precio from producto where numerocontrol =1))

update producto
set precio = 20.2
where numerocontrol = 1

select * from producto
where  numerocontrol = 1

--Seleccionar las ordenes de compra realizadas al producto 1
select *, (cantidad*preciocompra) as importe from detalleCompra 
where productoid =1

--seleccionar el total a pagar de las ordenes que contienen el producto1
select sum(cantidad * preciocompra) as 'total'
from detalleCompra where productoid = 1