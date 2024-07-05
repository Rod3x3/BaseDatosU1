create database repasojoins1;

use repasojoins1

create table proveedor(
    provid int not null IDENTITY(1,1),
    nombre VARCHAR(50) not null,
    limite_credito money not null,
    CONSTRAINT pk_proveedor
    PRIMARY KEY(provid)
)

create table producto(
    proid int not null IDENTITY(1,1),
    nombre VARCHAR(100) not null,
    existencia int not null,
    precio money not null,
    proveedor int,
    CONSTRAINT pk_producto
    PRIMARY KEY(proid),
    CONSTRAINT fk_producto_proveedor
    FOREIGN KEY(proveedor)
    REFERENCES proveedor(provid)
)

delete producto

--Insertar en las tablas

insert into proveedor (nombre, limite_credito)
VALUES('Proveedor1',100000),
      ('Proveedor2',200000),
      ('Proveedor3',300000),
      ('Proveedor4',400000),
      ('Proveedor5',500000)

      insert into producto (nombre, existencia, precio, proveedor)
VALUES('Producto11',34,45.6,1),
      ('Producto12',34,45.6,1),
      ('Producto13',34,45.6,1),
      ('Producto14',34,45.6,1),
      ('Producto15',34,45.6,1)
      
      select * from proveedor

      SELECT * from producto

      --seleccionar todos los productos que tiene proovedor 

     select pr.nombre as 'nombre_producto', pr.precio as 'precio',
     pr.existencia as 'existencia', p.nombre as 'provedor'
     from proveedor as p
     inner join 
     producto as pr 
     on p.provid = pr.proveedor

     --Consulta Left Join mostrar todos los provedores y sus respectivos productos

     select pr.proid,   pr.nombre as 'nombre_producto', pr.precio as 'precio',
     pr.existencia as 'existencia',p.provid, p.nombre as 'provedor'
     from proveedor as p
     LEFT join 
     producto as pr 
     on p.provid = pr.proveedor

     UPDATE proveedor 
     set nombre = 'Provedor5'
     WHERE provid = 5;

     SELECT * FROM proveedor

    insert INTO proveedor (nombre, limite_credito)
    VALUES ('Proveedor6',600000)

 delete from proveedor
 where provid = 7

 UPDATE proveedor
 set nombre='Proveedor6'
 where provid= 6
      
      --Utilizando rigth join
     select pr.proid,   pr.nombre as 'nombre_producto', pr.precio as 'precio',
     pr.existencia as 'existencia',p.provid, p.nombre as 'provedor'
     from proveedor as p
     RIGHT join 
     producto as pr 
     on p.provid = pr.proveedor

     insert into producto(nombre,precio,existencia,proveedor)
     VALUES('producto5',78.8,22,null)

     --full join
     select pr.proid,   pr.nombre as 'nombre_producto', pr.precio as 'precio',
     pr.existencia as 'existencia',p.provid, p.nombre as 'provedor'
     from proveedor as p
     FULL join 
     producto as pr 
     on p.provid = pr.proveedor

     --seleccionar a todos los provedores  que no tiene asignados productos
     select p.provid as 'Numero Provedor', p.nombre as 'Provedor'
     from proveedor as p
     LEFT join 
     producto as pr 
     on p.provid = pr.proveedor
     WHERE pr.proid is null

     --seleccionar todos los productos que no tienen provedor
     
     

