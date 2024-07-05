# Requerimientos

Requerimientos
Una empresa encargada de las ventas de diferentes productos desea crear una base de datos que controle los proveedores, clientes, empleados y ordenes de compra para los proveedores se necesita almacenar un numero de control el nombre de la empresa dirección teléfono de contacto, contacto, email  del contacto y pagina web para los clientes se desea almacenar numero de nómina, nombre completo, rfc, curp, salario(El salario máximo es de 65000) para las ordenes de compra se necesita almacenar la fecha de creación de la orden el empleado que la realizo , el cliente que la vende, la fecha de entrega y los diferentes productos que se le venden para esto el producto debe almacenar un numero de control y una descripción, status , existencia y un precio La compra siempre debe tener un precio de venta que se obtiene del precio unitario del producto 

# Diagrma E-R

# Diagrama Relacional
![DIAGRAMA RELACIONAL](./IMG/Ejercio1_BD.png)


# Creacion BD con lenguaje SQL-LDD
```SQL
--Crear base de datos
create database dbVENTAS;
use dbVENTAS;
create table CLIENTE(
Cliente_id int not null identity(1,1),
RFC VARCHAR(20) NOT NULL,
CURP VARCHAR(18) NOT NULL,
NOMBRE VARCHAR(50) NOT NULL,
APELLIDO_P VARCHAR(50) NOT NULL,
APELLIDO_M VARCHAR(50) NOT NULL,
CONSTRAINT PK_CLIENTE
PRIMARY KEY(Cliente_id),
constraint unico_RFC
unique(RFC),
CONSTRAINT Unico_CURP
unique(CURP));

insert into CLIENTE (RFC, CURP, NOMBRE, APELLIDO_P, APELLIDO_M) values('gjfef','wjdsskal','pepito','robles','perez')
select* from CLIENTE

create table contactoProveedor(
contactoid int not null identity (1,1),
provedorid int not null,
nombres varchar(50) not null,
apellido1 varchar(50) not null,
apellido2 varchar(50) not null,
constraint pk_contactoproveedor
primary key (contactoid)
)

create table proveedor(
proveedorid int not null identity(1,1),
nombreempresa varchar(50) not null,
rfc varchar(20) not null,
calle varchar(30) not null,
colonia varchar(50) not null,
cp int not null,
paginaweb varchar(80)
constraint pk_proveedor
primary key(proveedorid),
constraint unico_nombreEmpresa
unique (nombreempresa),
constraint unico_rfc2
unique (rfc),
)

alter table contactoProveedor
add constraint fk_contactoProveedor_proveedor
foreign key(proveedorid)
references proveedor(proveedorid)

create table empleado(
empleadoid int not null identity(1,1),
nombre varchar (50) not null,
APELLIDO_P VARCHAR(50) NOT NULL,
APELLIDO_M VARCHAR(50) NOT NULL,
rfc varchar(20) not null,
curp varchar(18) not null,
numeroExterno int,
calle varchar(50) not null,
salario money not null,
numeronomina int not null,
constraint pk_empleado
primary key(empleadoid),
constraint unico_rfc_empleado
unique(rfc),
constraint unico_curp_empleado
unique(curp),
constraint chk_salario
check(salario>=0.0 and salario<=100000),
-- check (salario between 0.1 and 1000000)
constraint unico_nomina_empleado
unique(numeronomina)
)

create table telefonoproveedor(
telefonoid int not null,
proveedorid int not null,
numerotelefono varchar (15),
constraint pk_telefono_proveedor
primary key (telefonoid,proveedorid),
constraint fk_telefonoprov_proveedor
foreign key (proveedorid)
references proveedor(proveedorid)
on delete cascade 
on update�cascade�
)

create table producto(
numerocontrol int not null identity(1,1),
descripcion varchar(50) not null,
precio money not null,
[status] int not null,
existencia int not null,
proveedorid int not null,
constraint pk_producto
primary key (numerocontrol),
constraint unico_descripcion
unique(descripcion),
constraint chk_precio
--precio>=1 and precio<=200000
check(precio between 1 and 200000),
constraint chk_status
--status in(0,1)
check([status] = 1 or [status] = 0),
constraint chk_existencia
check(existencia>0),
constraint fk_producto_proveedor
foreign key (proveedorid)
references proveedor(proveedorid)
)

create table ordencompra(
numeroorden int not null identity(1,1),
fechacompra date not null,
fechaentrega date not null,
clienteid int not null,
empleadoid int not null,
constraint pk_ordencompra
primary key(numeroorden),
constraint fk_ordencompra_cliente
foreign key (clienteid)
references CLIENTE(Cliente_id),
constraint fk_ordencompra_empleado
foreign key (empleadoid)
references empleado(empleadoid)

)

create table detalleCompra(
productoid int not null,
numeroorden int not null,
cantidad int not null,
preciocompra money not null,
constraint pk_detallecompra
primary key (productoid,numeroorden),
constraint fk_ordencompra_producto
foreign key (productoid)
references producto (numerocontrol),
constraint fk_ordencompra_compra
foreign key (numeroorden)
references ordencompra(numeroorden)
)
```
# Llenar base de datos con lenguaje SQL-LMD
```SQL
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
```


