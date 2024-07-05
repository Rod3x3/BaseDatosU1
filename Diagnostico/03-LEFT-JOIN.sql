--crear base de datos para demostrar el uso del left join

create database pruebajoins

--Utilizamos la base de datos 

use pruebajoins

--crear la tabla categorias

create table categoria(
categoriaid  int not null IDENTITY(1,1),
nombre VARCHAR(50) not null DEFAULT 'No categoria'
CONSTRAINT pk_categoria
PRIMARY key(categoriaid)
)

create table producto(
    productoid int not null IDENTITY(1,1),
    nombre VARCHAR(50) not null,
    existencia int not null,
    precio money not null,
    categoriaid int,
    CONSTRAINT pk_producto
    PRIMARY KEY(productoid),
    CONSTRAINT unico_nombre
    unique(nombre),
    CONSTRAINT fk_producto_categoria
    FOREIGN KEY (categoriaid)
    REFERENCES categorias(categoriaid)
)

--Agregar registros a la tabla

INSERT into categorias(nombre)
values('LB'),
      ('Lacteos'),
      ('Ropa'),
      ('Bebidas'),
      ('Carnes Frias')

      SELECT * From categorias

      insert into producto(nombre, existencia, precio, categoriaid)
      values('Refrigerador',3,10000.0,1),
            ('Estufa',3,9000.04,1),
            ('Crema',2,10.5,2),
            ('Yogurt',3,13.45,2)

SELECT * from producto 
             
             SELECT * from producto as p 
             INNER JOIN categorias as c 
             on p.categoriaid = c.categoriaid;

             --Consulta utilizando left join
              SELECT * from categorias as c
             LEFT JOIN producto as p 
             on p.categoriaid = c.categoriaid;

             --seleeccionar las categorias que no tiene asignadas productos
               SELECT * from categorias as c
             LEFT JOIN producto as p 
             on p.categoriaid = c.categoriaid
             WHERE p.productoid is not null

            --Otro ejemplo con Left Join
               SELECT c.categoriaid, c.nombre from categorias as c
             LEFT JOIN producto as p 
             on p.categoriaid = c.categoriaid
             WHERE p.productoid is  null

            --Ocupar Rigth Join
            select * from  producto as c 
            RIGHT JOIN categorias as p  on 
            p.categoriaid = c.categoriaid

            --Full Join
            select * from  producto as c 
            full JOIN categorias as p  on 
            p.categoriaid = c.categoriaid
   
         --crear una base de datos llamada ejerciciosjoin 
         --crear unata tabla que se llame empleados tomando como base la tabla employes 
         --llenar la tabla con una consulta a la tabla employes
         --Agregar  nuevos datos a la tabla empleados por lo menos dos
         --Actualizar la tabla empleados con los nuevos registros la cual se llenara en una nueva tabla llaamda dim_producto

         --Ejercicio 
--1.-crear una base de datos llamada ejercicio join 
create database ejerciciojoins;
use ejerciciojoins;

--2.-crear unna tabla llamada empleados tomando como base la tabla employees de nortwhind (no tomar todos los datos)
select * from northwind .dbo.employees;

select top 0 employeeid as 'empleadoid',
       CONCAT(firstname,' ',lastname) as 'nombrecompleto',
       title as 'titulo',
       hiredate as 'fechacontratacion'
into ejerciciojoins.dbo.empleados
from northwind.dbo.employees;

select * from ejerciciojoins.dbo.empleados


         --Tercer paso
         insert into ejerciciojoins.dbo.empleados(nombrecompleto,titulo,fechacontratacion)
         SELECT 
         CONCAT(FirstName,'',LastName) as  'Nombre Completo',
         title as 'titulo',
         hiredate as 'Fecha Contratacion'
         from  Northwind.dbo.Employees

         select top 0 *
         into  ejerciciojoins.dbo.dimeempleados
         from ejerciciojoins.dbo.empleados

         select * from dimeempleados

         SELECT * from empleados