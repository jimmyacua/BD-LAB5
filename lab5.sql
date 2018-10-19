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

--3d:

go
create procedure ActualizarNotaEstudiante
	@ced char(9),
	@sigla char(7),
	@numG int,
	@sem int,
	@año int,
	@nuevaNota int
	as
	update Lleva
	set Nota = @nuevaNota
	where CedEstudiante = @ced and SiglaCurso = @sigla and NumGrupo = @numG and Semestre = @sem
	 and Año = @año
go



EXEC ActualizarNotaEstudiante @ced = '176543219', @sigla = 'ci1310', @numG= 1, 
@sem = 2, @año = 2018, @nuevaNota = 78 

--3e:
go
create procedure ActualizarNotasGrupo
	@sigla char(7),
	@numG int,
	@sem int,
	@año int,
	@nuevaNota int
	as
	update Lleva
	set Nota = @nuevaNota
	where SiglaCurso = @sigla and NumGrupo = @numG and Semestre = @sem
	 and Año = @año
go

EXEC ActualizarNotasGrupo @sigla = 'ci1310', @numG= 1, 
@sem = 2, @año = 2018, @nuevaNota = 10 

select * from Lleva l
where l.SiglaCurso = 'ci1310'