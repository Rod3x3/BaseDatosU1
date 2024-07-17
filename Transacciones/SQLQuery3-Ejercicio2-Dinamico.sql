--Store procedure que visualice los resultados
--de cualquier tabla

--select * from [tabla]

use Northwind

go

create or alter proc spu_mostrarTbla
@tabla varchar(50)
as
begin
  declare @query varchar(50)
  set @query = 'Select * from'+(@tabla);
  exec (@query);

  --exec sp_executesql @query
end;

go

create or alter proc spu_mostrarTbla
@tabla varchar(50)
as
begin
  declare @query nvarchar(50)
  set @query = 'Select * from'+(@tabla);
  --exec (@query);

  exec sp_executesql @query
end;





