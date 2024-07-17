--MERGE INTO <target table> AS TGT
--USING <SOURCE TABLE> AS SRC  
--  ON <merge predicate>
--WHEN MATCHED [AND <predicate>] -- two clauses allowed:  
--  THEN <action> -- one with UPDATE one with DELETE
--WHEN NOT MATCHED [BY TARGET] [AND <predicate>] -- one clause allowed:  
--  THEN INSERT... –- if indicated, action must be INSERT
--WHEN NOT MATCHED BY SOURCE [AND <predicate>] -- two clauses allowed:  
--  THEN <action>; -- one with UPDATE one with DELETE

create database escuelita;
go

use escuelita;

go

CREATE TABLE StudentsC1(
    StudentID       INT
    ,StudentName    VARCHAR(50)
    ,StudentStatus  BIT
);

go

INSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(1,'Axel Romero',1)
INSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(2,'Sofía Mora',1)
INSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(3,'Rogelio Rojas',0)
INSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(4,'Mariana Rosas',1)
INSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(5,'Roman Zavaleta',1);

go

CREATE TABLE StudentsC2(
    StudentID       INT
    ,StudentName    VARCHAR(50)
    ,StudentStatus  BIT
);

go

INSERT INTO StudentsC2(StudentID, StudentName, StudentStatus) VALUES(1,'Axel Romero Rendón',1)
INSERT INTO StudentsC2(StudentID, StudentName, StudentStatus) VALUES(2,'Sofía Mora Ríos',0)
INSERT INTO StudentsC2(StudentID, StudentName, StudentStatus) VALUES(6,'Mario Gonzalez Pae',1)
INSERT INTO StudentsC2(StudentID, StudentName, StudentStatus) VALUES(7,'Alberto García Morales',1);

go

select * from StudentsC1
select * from StudentsC2

select * from
StudentsC1 as c1 
left join StudentsC2 as c2
on c1.StudentID = c2.StudentID
where c2.StudentID is null;

select * from 
StudentsC1 as c1 
inner join 
StudentsC2 as c2
on c1.StudentID = c2.StudentID

go

--crear un store procedure que inserte y actualicew la tabla Student 2 mediante los datos de Student 1 
--Utilizando consultas utilizando left y inner join 

create or alter proc spu_carga_incremental_Students
as
begin
begin transaction

begin try
      --Se insertan estudiantes nuevos
	  Insert into StudentsC2 (StudentID,StudentName,StudentStatus)

      select c1.StudentID, c1.StudentName, c1.StudentStatus 
	  from StudentsC1 as c1 
      left join StudentsC2 as c2
      on c1.StudentID = c2.StudentID
      where c2.StudentID is null;

	  --Se actualizan los datos que hayan cambiado en student 1
	  update c2
	  set c2.StudentName = c1.StudentName,
	  c2.StudentStatus = c1.StudentStatus
	  from 
      StudentsC1 as c1 
      inner join 
      StudentsC2 as c2
      on c1.StudentID = c2.StudentID

	  commit transaction;

end try
begin catch
ROLLBACK TRANSACTION
declare @mensajeError nvarchar(max)
set @mensajeError = ERROR_MESSAGE()
print @mensajeError
end catch;
end;

go

exec spu_carga_incremental_Students

truncate table Studentsc1
truncate table Studentsc2

go

--crear un store procedure que inserte y actualicew la tabla Student 2 mediante los datos de Student 1 
--Utilizando consultas utilizando un Merge

create or alter proc spu_carga_incremental_Students_merge
as
begin
begin transaction

begin try
         merge into Studentsc2 as tgt
		 using(
		 Select StudentID, StudentName, StudentStatus 
	     from StudentsC1 
		 )as src
		 on (
		 tgt.StudentID = src.StudentID
		 )
		 --for update
		 when matched then
		 update
		 set tgt.StudentName = src.StudentName,
		     tgt.StudentStatus = src.StudentStatus
	    --for insert
		when not matched then
		insert(StudentID,StudentName,StudentStatus)
		values(src.StudentID,StudentName,StudentStatus);

		commit transaction
end try
begin catch
ROLLBACK TRANSACTION
declare @mensajeError nvarchar(max)
set @mensajeError = ERROR_MESSAGE()
print @mensajeError
end catch;
end;

exec spu_carga_incremental_Students_merge