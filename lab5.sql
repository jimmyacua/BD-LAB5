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

	set @cantC = (
		select count(*)
		from Estudiante e join Empadronado_En em on e.Cedula = em.CedEstudiante
		where e.Cedula = @ced
	)

	return @cantC
	end
go
select  dbo.TotalCarrerasEstudiante('111222333') as numCarreras

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

--PARTE OPCIONAL

--3f:

--i)
go
create procedure TotCarrerasEst
	@ced char(9)
	as
	declare @nc int
	set @nc = ( select count(*)
	from Estudiante e join Empadronado_En em on e.Cedula = em.CedEstudiante
	where e.Cedula = @ced
	)	
	print @nc
	return @nc
go

drop procedure TotCarrerasEst

EXEC TotCarrerasEst @ced = '111222333'


--ii)
go
create function getCarreras() 
returns @carreras table(
	ced char(9),
	carreras int
)
as 
begin
	insert into @carreras
	select distinct e.Cedula, count(*)
	from Estudiante e join Empadronado_En em on e.Cedula = em.CedEstudiante
	group by e.Cedula
	return
end
go

select * from getCarreras()