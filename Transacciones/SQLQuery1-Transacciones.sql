
--Las transacciones son fundamentales para asegurar la consistencia y la integridad de los datos

--Tracciones: Es una unidad de trabajo que se ejecuta de manera exitosa o no se ejecuta en absoluto

--Begin Transaction: Inicia una nueva transaccion
--Commit Transaction: Confirma todos los cambios realizados durante la transaccion
--Roll Back Transaction: Revierte todos los cambios realizados durante la transaccion

use Northwind

select * from Categories

begin transaction

insert into Categories(CategoryName, Description)
values ('Categoria11','Los remediales')

rollback transaction 

commit transaction
