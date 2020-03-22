if not exists(
SELECT name from sys.databases
	WHERE name = 'Note_App')
	Begin
	CREATE DATABASE Note_App;
	
    SELECT 'Database not found. Database Created';
	
	end
	go
	
	IF object_id(N'sys.databases.Note_App', N'Note_App') is not null
	use Note_App;

use Note_App;
IF object_id(N'dbo.Usuarios', N'dbo.Usuarios') is null
BEGIN
select 'La tabla no existe. Se creará la tabla Usuarios';
CREATE TABLE dbo.Usuarios 
(UsuarioId int identity(1,1) PRIMARY KEY NOT NULL,
Usr_Nombre nvarchar(50) NOT NULL,
Usr_Correo nvarchar(100) NOT NULL,
Usr_Pass nvarchar(255) NOT NULL,
Usr_TokenRecuperacion varchar(255) NOT NULL,
Usr_RecibirAvisos bit NOT NULL)


ALTER TABLE dbo.Usuarios
   ADD CONSTRAINT UK_Usuarios UNIQUE (Usr_Nombre)
end

IF object_id(N'dbo.Sessions', N'dbo.Sessions') is null
BEGIN
select 'La tabla no existe. Se creará la tabla Sesiones'; 
CREATE TABLE dbo.Sesiones
(SesionId int PRIMARY KEY identity(1,1) NOT NULL,
Sess_Fecha datetime NOT NULL,
Sess_UsuarioId int NOT NULL)
End
ALTER TABLE dbo.Sesiones
   ADD CONSTRAINT FK_Usuarios_Sesiones FOREIGN KEY (Sess_UsuarioId)
      REFERENCES dbo.Usuarios (UsuarioId)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION;

go

IF object_id(N'dbo.Categorias', N'Categorias') is null
BEGIN
select 'La tabla no existe. Se creará la tabla Categorias'; 
CREATE TABLE dbo.Categorias
(CategoriaId smallint PRIMARY KEY identity(1,1) NOT NULL,
Cat_Nombre nvarchar(150) NOT NULL,
Cat_UsuarioId int NOT NULL);
End
ALTER TABLE dbo.Categorias
   ADD CONSTRAINT FK_Categorias_User FOREIGN KEY (Cat_UsuarioId)
      REFERENCES dbo.Usuarios (UsuarioId)
      ON DELETE CASCADE
      ON UPDATE CASCADE;
go

ALTER TABLE Categorias
   ADD CONSTRAINT UK_Categorias UNIQUE (Cat_Nombre);
   go

IF object_id(N'dbo.SubCategorias', N'SubCategorias') is null
BEGIN
select 'La tabla no existe. Se creará la tabla SubCategorias'; 
CREATE TABLE dbo.SubCategorias
(SCat_CategoriaId smallint NOT NULL,
SCat_SubCategoriaId smallint NOT NULL);
End

ALTER TABLE dbo.SubCategorias
   ADD CONSTRAINT PK_Subcategorias PRIMARY KEY (SCat_CategoriaId, SCat_SubCategoriaId);
	  go

ALTER TABLE dbo.SubCategorias
   ADD CONSTRAINT FK_Categorias_Categorias FOREIGN KEY (SCat_CategoriaId)
      REFERENCES dbo.Categorias (CategoriaId)
      ON DELETE no action
      ON UPDATE no action;
go

ALTER TABLE dbo.SubCategorias
   ADD CONSTRAINT FK_Categorias_Subcategorias FOREIGN KEY (SCat_SubCategoriaId)
      REFERENCES dbo.Categorias (CategoriaId)
      ON DELETE CASCADE
      ON UPDATE CASCADE;
go
	  

IF object_id(N'dbo.Notas', N'Notas') is null
BEGIN
select 'La tabla no existe. Se creará la tabla Notas'; 
CREATE TABLE dbo.Notas
(NotaId smallint PRIMARY KEY identity(1,1) NOT NULL,
Note_Titulo nvarchar(50) NOT NULL,
Note_Contenido ntext NULL,
Note_FechaAviso datetime NOT NULL,
Note_FechaRepetir datetime NOT NULL,
Note_Prioridad nvarchar(40) CHECK( Note_Prioridad in ('Urgente','Prioritario', 'Comun')) NULL,
Note_CategoriaId smallint NOT NULL,
Note_UsuarioId int NOT NULL,
Note_Avisar bit NOT NULL,
Note_TiempoRepeticion tinyint NULL);
END

ALTER TABLE dbo.Notas
   ADD CONSTRAINT FK_Notas_Categories FOREIGN KEY (Note_CategoriaId)
      REFERENCES dbo.Categorias (CategoriaId)
      ON DELETE CASCADE
      ON UPDATE CASCADE;
GO
	  
ALTER TABLE dbo.Notas
   ADD CONSTRAINT FK_Notas_Usuarios FOREIGN KEY (Note_UsuarioId)
      REFERENCES dbo.Usuarios (UsuarioId)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION;
GO

ALTER TABLE Notas
   ADD CONSTRAINT UK_Notas UNIQUE (Note_Titulo);
   go

IF object_id(N'dbo.Ficheros', N'Ficheros') is null
BEGIN
select 'La tabla no existe. Se creará la tabla Ficheros'; 
CREATE TABLE dbo.Ficheros
(FicheroId tinyint PRIMARY KEY identity(1,1) not null,
File_TituloFichero nvarchar(50) not null,
File_NotaId smallint not null,
File_Formato nvarchar(5) CHECK (File_Formato in ('png','jpg','jpeg','gif','mp3','ooc','pdf','doc')) NOT NULL,
Fil_URL nvarchar(255) not null);
end

ALTER TABLE dbo.Ficheros
   ADD CONSTRAINT UK_Ficheros UNIQUE (File_TituloFichero);
   go

IF object_id(N'dbo.Colores', N'Colores') is null
BEGIN
select 'La tabla no existe. Se creará la tabla Colores'; 
CREATE TABLE dbo.Colores
(ColorId int PRIMARY KEY identity(1,1) NOT NULL,
Colr_Referencia nvarchar(12) CHECK ( Colr_Referencia in ('Categoria','Nota')) NOT NULL,
Colr_Hexadecimal nvarchar(7) NOT NULL
 );
END


IF object_id(N'dbo.Categorias_Colores', N'Categorias_Colores') is null
BEGIN
select 'La tabla no existe. Se creará la tabla Categorias_Colores'; 
CREATE TABLE dbo.Categorias_Colores
(CC_ColorId int NOT NULL,
CC_CategoriaId smallint NOT NULL);
End

ALTER TABLE dbo.Categorias_Colores
   ADD CONSTRAINT PK_Categorias_Colores Primary KEY (CC_ColorId, CC_CategoriaId);
	  go

ALTER TABLE dbo.Categorias_Colores
   ADD CONSTRAINT FK_CatCol_Categorias FOREIGN KEY (CC_CategoriaId)
      REFERENCES dbo.Categorias (CategoriaId)
      ON DELETE cascade
      ON UPDATE cascade;
go

ALTER TABLE dbo.Categorias_Colores
   ADD CONSTRAINT FK_CatCol_Colores FOREIGN KEY (CC_ColorId)
      REFERENCES dbo.Colores (ColorId)
      ON DELETE cascade
      ON UPDATE cascade;
go

IF object_id(N'dbo.Notas_Colores', N'Notas_Colores') is null
BEGIN
select 'La tabla no existe. Se creará la tabla Notas_Colores'; 
CREATE TABLE dbo.Notas_Colores
(NC_ColorId int NOT NULL,
NC_NotaId smallint NOT NULL);
End

ALTER TABLE dbo.Notas_Colores
   ADD CONSTRAINT PK_Notas_Colores Primary KEY (NC_ColorId, NC_NotaId);
	  go

ALTER TABLE dbo.Notas_Colores
   ADD CONSTRAINT FK_NotCol_Notas FOREIGN KEY (NC_NotaId)
      REFERENCES dbo.Notas (NotaId)
      ON DELETE cascade
      ON UPDATE cascade;
go

ALTER TABLE dbo.Notas_Colores
   ADD CONSTRAINT FK_NotCol_Colores FOREIGN KEY (NC_ColorId)
      REFERENCES dbo.Colores (ColorId)
      ON DELETE cascade
      ON UPDATE cascade;
go

