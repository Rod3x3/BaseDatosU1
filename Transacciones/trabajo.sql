--Actualice los preciosos de los productos y guardarlos en una tabla de historicos de precios 
--debe llevar un id el id del producto que se modifico el precio que se modifico el precio nuevo y la fecha de modificacion

use Northwind


select * from Products

create table HistoricosPrecios (
    id int not null identity(1,1) primary key,
    ProductID int,
    precioA money,
    precioN money,
    fechaM date,
    constraint fk_ProductID
        foreign key (ProductID) references Products(ProductID)
);

go

create or alter procedure spu_actualizar_info_productos
@ProductID int,
@UnitPrice money
as
begin
    begin transaction;

    begin try

        declare @precioAnterior money;
        select @precioAnterior = UnitPrice from Products where ProductID = @ProductID;

        update Products set UnitPrice = @UnitPrice where ProductID = @ProductID;

        insert into HistoricosPrecios (ProductID, precioA, precioN, fechaM)
        values (@ProductID, @precioAnterior, @UnitPrice, getdate());

        commit transaction;
    end try
    begin catch
        rollback transaction;
        declare @mensajeError nvarchar(max);
        set @mensajeError = ERROR_MESSAGE();
        print @mensajeError;
    end catch;
end;


go

exec spu_actualizar_info_productos 4, 25

Select * from Products
where  ProductID = 4


--(22)


select * from HistoricosPrecios