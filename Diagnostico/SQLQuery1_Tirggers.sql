--Sintaxis 
--Create trigger nombre_trigger
--on nombre tabla
--after insert,delete,update
--as
--begin
---Codigo
--end

create database pruebatriggersg3;
go

use pruebatriggersg3;

create table tabla1(
id int not null primary key,
nombre varchar(50) not null
);
go

--Triggers

--Trigger que verifica el evento que se ejecuto
create trigger tg_verificar_insercion
on tabla1
after insert
as
begin
print 'se ejecuto en evento insert en la tabla1'
end;

 insert into tabla1
 values(1,'Nombre1')

create trigger tg_verificar_delete
on tabla1
after delete
as
begin
print 'se ejecuto en evento delete en la tabla1'
end;

delete tabla1
where id=1

insert into tabla1
 values(1,'Nombre1')

 create trigger tg_verificar_update
on tabla1
after update
as
begin
print 'se ejecuto en evento update en la tabla1'
end;

update tabla1 
set nombre = 'Nombre Nuevo'
where id = 1;

drop trigger tg_verificar_insercion

create trigger verificar_contenido_inserted
on tabla1
after insert
as 
begin
--ver los datos de la tabla inserted
select * from inserted;
end

insert into tabla1
values(4,'Nombre4'),(5,'Nombre5')

select * from tabla1

use Northwind

create or alter trigger verificar_insertd_categorias
on categories
after insert
as
begin
select categoryid,categoryname,[description] from inserted;
end

insert into categories (categoryname,description)
values ('categoriaNueva','Prueba Triggers')

create or alter trigger verificar_delete1_categorias
on categories
after update
as
begin 
  select categoryid,categoryname,[description] from inserted;
  select categoryid,categoryname,[description] from [deleted];
end

update categories
set categoryname = 'CategoriaOtra',
[description] = 'Si esta bien'
where categoryid = 9

drop trigger verificar_delete1_categorias

create trigger verificar_inserted_deleted1
on categories
after insert, update, delete
as
begin
if exists(select 1 from inserted) and not exists(select 1 from deleted)
begin
print('Existenten datos en la tabla insert,se ejecuto un insert')
end
if exists(select 1 from deleted) and not exists(select 1 from inserted)
begin
print('Existenten datos en la tabla deleted,se ejecuto un deleted')
end
else if exists(select 1 from deleted) and  exists(select 1 from inserted)
begin
print('Existenten datos en la tabla update,se ejecuto un update')
end
end;

insert into categories (categoryname,[description])
values ('categoria10','Pinpon')

drop trigger verificar_inserted_deleted

--Crear un trigger en la base de datos pruebatriggers, para
--la tabla empleados, este trigger debe evitar que se inserten o modifiquen salarios mayores a 50000

use pruebatriggersg3;

create table empleado(
id int not null primary key,
nombre varchar(50) not null,
salario money not null
)

create or alter trigger verificar_salario
on empleado
after insert, update
as
begin
if exists(select 1 from inserted) and not exists(select 1 from deleted)
begin
declare @salarioNuevo money
set @salarioNuevo = (select salario from inserted)
if @salarioNuevo > 50000
begin
raiserror('El salario es mayor a 50 mil y no esta permitido',16,1)
rollback transaction;
end
end
end;

--Crear un trigger que permita gestionar una venta en la cual se debe analizar
--las existencias del producto vendido, bajo las siguientes condiciones:
--1) Verificar si la existencia es suficiente, si la existencia no es suficiente cancelar la instruccion
--2)Si es suficiente ,agregar a la venta y disminuir el stock del producto
--Nota utilizar base de datos Norwhind

use Northwind  
create or alter trigger gt_existencias_producto_vendido
on OrderDetails
after insert, delete
as
begin

end