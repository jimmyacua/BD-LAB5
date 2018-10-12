use DB_B50060;

select * from Carrera


--3a:
go
Create procedure EmpadronarEdtudiante
	@cod varchar(10),
	@ced char(9)
	as
	insert into Empadronado_En(CedEstudiante, CodCarrera)
	values(@ced, @cod);
go
EXEC EmpadronarEdtudiante @cod='420201', @ced='111222333' --//	en	desorden	

select * from Empadronado_En

--3b:
go
create procedure DesempadronarEstudiante
	@cod varchar(10),
	@ced char(9)
	as
	delete from Empadronado_En
	where @ced = CedEstudiante and @cod = CodCarrera;
go
EXEC DesempadronarEstudiante @cod='420201', @ced='111222333' --//	en	desorden


--3c:
go
create function TotalCarrerasEstudiante(
	@ced char(9))
	returns int
	as begin
	declare @cantC int 

	set @cantC =

	return @cantC
	end
go
select  TotalCarrerasEstudiante