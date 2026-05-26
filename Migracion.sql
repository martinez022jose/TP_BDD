USE [GD1C2026]
GO
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'Pirulo_Viajes')
    EXEC('CREATE SCHEMA Pirulo_Viajes');
GO

DROP TABLE IF EXISTS Pirulo_Viajes.Detalle_Venta_Excursiones;
DROP TABLE IF EXISTS Pirulo_Viajes.Detalle_Venta_Vuelos;
DROP TABLE IF EXISTS Pirulo_Viajes.Detalle_Venta_Hospedajes;
DROP TABLE IF EXISTS Pirulo_Viajes.Detalle_Excursion_Propuesta;
DROP TABLE IF EXISTS Pirulo_Viajes.Detalle_Hospedaje_Propuesta;
DROP TABLE IF EXISTS Pirulo_Viajes.Detalle_Vuelo_Propuesta;
DROP TABLE IF EXISTS Pirulo_Viajes.Detalle_Solicitud;
DROP TABLE IF EXISTS Pirulo_Viajes.Detalle_Encuesta; --check
DROP TABLE IF EXISTS Pirulo_Viajes.Venta; --Check
DROP TABLE IF EXISTS Pirulo_Viajes.Propuesta;
DROP TABLE IF EXISTS Pirulo_Viajes.Solicitud_Cotizacion; 
DROP TABLE IF EXISTS Pirulo_Viajes.Encuesta;
DROP TABLE IF EXISTS Pirulo_Viajes.Habitacion;
DROP TABLE IF EXISTS Pirulo_Viajes.Vuelo;
DROP TABLE IF EXISTS Pirulo_Viajes.Excursion;
DROP TABLE IF EXISTS Pirulo_Viajes.Hospedaje;
DROP TABLE IF EXISTS Pirulo_Viajes.Agente; --Check
DROP TABLE IF EXISTS Pirulo_Viajes.Agencia; --Check
DROP TABLE IF EXISTS Pirulo_Viajes.Cliente; --Check
DROP TABLE IF EXISTS Pirulo_Viajes.Aeropuerto;
DROP TABLE IF EXISTS Pirulo_Viajes.Aerolinea; -- Check
DROP TABLE IF EXISTS Pirulo_Viajes.Proveedor; --check
DROP TABLE IF EXISTS Pirulo_Viajes.Medio_Pago; --Check
DROP TABLE IF EXISTS Pirulo_Viajes.Canal_Venta; --Check
DROP TABLE IF EXISTS Pirulo_Viajes.Aspecto; --Check
DROP TABLE IF EXISTS Pirulo_Viajes.Estado; --Check
DROP TABLE IF EXISTS Pirulo_Viajes.Alianza; --Check
GO

-------------------CREATE------------------

CREATE TABLE Pirulo_Viajes.Alianza (
    alianza_id int IDENTITY(1,1) NOT NULL,
    alianza_nombre nvarchar(255) NOT NULL,
    CONSTRAINT PK_Alianza PRIMARY KEY (alianza_id)
);

CREATE TABLE Pirulo_Viajes.Medio_Pago (    
    Medio_Pago_Id int IDENTITY(1,1) NOT NULL,   
    Medio_Pago_Descripcion varchar(255) NOT NULL,   
	CONSTRAINT PK_Medio_Pago PRIMARY KEY (Medio_Pago_Id)
);

CREATE TABLE Pirulo_Viajes.Canal_Venta (    
    Canal_Venta_Id int IDENTITY(1,1) NOT NULL,   
    Canal_Venta_Descripcion varchar(255) NOT NULL,   
	CONSTRAINT PK_Canal_Venta PRIMARY KEY (Canal_Venta_Id)
);

CREATE TABLE Pirulo_Viajes.Aspecto (    
    Aspecto_Id int IDENTITY(1,1) NOT NULL,   
    Aspecto_Descripcion varchar(255) NOT NULL,   
	CONSTRAINT PK_Aspecto PRIMARY KEY (Aspecto_Id)
);

CREATE TABLE Pirulo_Viajes.Estado (    
    Estado_Id int IDENTITY(1,1) NOT NULL,   
    Estado_Descripcion varchar(255) NOT NULL,   
	CONSTRAINT PK_Estado PRIMARY KEY (Estado_Id)
);

CREATE TABLE Pirulo_Viajes.Agencia (
    agencia_numero bigint NOT NULL,
    agencia_direccion nvarchar(255) NULL,
    agencia_telefono nvarchar(255) NULL,
    agencia_mail nvarchar(255) NULL,
    agencia_localidad nvarchar(255) NULL,
    agencia_provincia nvarchar(255) NULL, -- Mantenido el error de tipeo de la imagen
    
    -- Configuración de la Clave Primaria (PK)
    CONSTRAINT PK_Agencia PRIMARY KEY (agencia_numero)
);

CREATE TABLE Pirulo_Viajes.Agente (
    Agente_Legajo bigint NOT NULL,
    Agente_Nombre nvarchar(255) NULL,
    Agente_Apellido nvarchar(255) NULL,
    Agente_Dni nvarchar(255) NULL,
    Agente_Fecha_Nac date NULL,
    Agente_Telefono nvarchar(255) NULL,
    Agente_Mail nvarchar(255) NULL,
    Agente_Direccion nvarchar(255) NULL,
    Agente_Localidad nvarchar(255) NULL,
    Agente_Provincia nvarchar(255) NULL,
    Agente_agencia bigint NOT NULL, 
    
    CONSTRAINT PK_Agente PRIMARY KEY (Agente_Legajo),
    CONSTRAINT FK_Agente_Agencia FOREIGN KEY (Agente_agencia) REFERENCES Pirulo_Viajes.Agencia(agencia_numero)
);


CREATE TABLE Pirulo_Viajes.Venta (
    venta_numero bigint NOT NULL,
    venta_fecha date NOT NULL,
    venta_canal int NOT NULL, 
    Venta_Subtotal decimal(18,2) NOT NULL,
    Venta_Descuento decimal(18,2) NOT NULL,
    Venta_Total decimal(18,2) NOT NULL,
    venta_medio_pago int NOT NULL,
    venta_cliente int NULL,   
    venta_agente int NULL, 
    
    CONSTRAINT PK_Venta PRIMARY KEY (venta_numero),
    CONSTRAINT FK_Venta_Medio_Pago FOREIGN KEY (venta_medio_pago) REFERENCES Pirulo_Viajes.Medio_Pago(medio_pago_id),
    CONSTRAINT FK_Venta_Canal_Venta FOREIGN KEY (venta_canal) REFERENCES Pirulo_Viajes.Canal_Venta(canal_venta_id)
    

    -- , CONSTRAINT FK_Venta_Cliente FOREIGN KEY (venta_cliente) REFERENCES Pirulo_Viajes.Cliente(cliente_id)
    -- , CONSTRAINT FK_Venta_Agente FOREIGN KEY (venta_agent) REFERENCES Pirulo_Viajes.Agente(agente_id)
);

CREATE TABLE Pirulo_Viajes.Detalle_encuesta (
    detalle_encuesta_codigo_encuesta bigint NOT NULL,
    detalle_encuesta_aspecto int NOT NULL,
    detalle_encuesta_puntaje int NOT NULL,
    
    CONSTRAINT PK_Detalle_Encuesta PRIMARY KEY (detalle_encuesta_codigo_encuesta, detalle_encuesta_aspecto),
    --CONSTRAINT FK_Detalle_Encuesta_Cabecera FOREIGN KEY (detalle_encuesta_codigo_encuesta) REFERENCES Pirulo_Viajes.Encuesta(encuesta_codigo_encuesta),
    CONSTRAINT FK_Detalle_Encuesta_Aspecto FOREIGN KEY (detalle_encuesta_aspecto) REFERENCES Pirulo_Viajes.Aspecto(Aspecto_Id)
);

CREATE TABLE Pirulo_Viajes.Cliente (
    cliente_id int IDENTITY(1,1) NOT NULL,
    Cliente_Nombre nvarchar(255) NULL,
    Cliente_Apellido nvarchar(255) NULL,
    Cliente_Dni nvarchar(255) NULL,
    Cliente_Tel nvarchar(255) NULL,
    Cliente_Mail nvarchar(255) NULL,
    Cliente_Direccion nvarchar(255) NULL,
    Cliente_Fecha_Nac date NULL,
    Cliente_Localidad nvarchar(255) NULL,
    Cliente_Provincia nvarchar(255) NULL,
    
    CONSTRAINT PK_Cliente PRIMARY KEY (cliente_id)
);

CREATE TABLE Pirulo_Viajes.Proveedor (
    Proveedor_id int IDENTITY(1,1) NOT NULL,
    Proveedor_Nombre nvarchar(255) NULL,
    Proveedor_Mail nvarchar(255) NULL,
    Proveedor_Telefono nvarchar(255) NULL,
    
    CONSTRAINT PK_Proveedor PRIMARY KEY (Proveedor_id)
);

CREATE TABLE Pirulo_Viajes.Aerolinea (
    aerolinea_codigo nvarchar(255) NOT NULL,
    aerolinea_nombre nvarchar(255) NULL,
    aerolinea_pais nvarchar(255) NULL,
    aerolinea_alianza_id int NOT NULL,     
    
    CONSTRAINT PK_Aerolinea PRIMARY KEY (aerolinea_codigo),
    CONSTRAINT FK_Aerolinea_Alianza FOREIGN KEY (aerolinea_alianza_id) REFERENCES Pirulo_Viajes.Alianza(alianza_id)
);

CREATE TABLE Pirulo_Viajes.Hospedaje (
    hospedaje_id int IDENTITY(1,1) NOT NULL,
    Hospedaje_Nombre nvarchar(255) NOT NULL,
    Hospedaje_Ciudad nvarchar(255) NULL,
    Hospedaje_Pais nvarchar(255) NULL,
    Hospedaje_Direccion nvarchar(255) NULL,
    Hospedaje_Desayuno bit NULL,
    Hospedaje_Check_In nvarchar(50) NULL,
    Hospedaje_Check_out nvarchar(50) NULL,
    
    CONSTRAINT PK_Hospedaje PRIMARY KEY (hospedaje_id)
);

CREATE TABLE Pirulo_Viajes.Habitacion (
    habitacion_id int IDENTITY(1,1) NOT NULL,           
    habitacion_hospedaje_id int NOT NULL,  
    Habitacion_Nombre_tipo nvarchar(255) NULL,
    Habitacion_Precio decimal(18,2) NULL,
    Habitacion_Descripcion nvarchar(max) NULL,
    
   
    CONSTRAINT PK_Habitacion PRIMARY KEY (habitacion_id, habitacion_hospedaje_id),
    CONSTRAINT FK_Habitacion_Hospedaje FOREIGN KEY (habitacion_hospedaje_id) REFERENCES Pirulo_Viajes.Hospedaje(hospedaje_id)
);





------------------------INSERT
INSERT INTO Pirulo_Viajes.Alianza (alianza_nombre)
SELECT DISTINCT Aerolinea_Alianza
FROM [GD1C2026].[gd_esquema].[Maestra]
WHERE Aerolinea_Alianza IS NOT NULL;

INSERT INTO Pirulo_Viajes.Aspecto (Aspecto_Descripcion)
SELECT DISTINCT Aspecto_Aspecto
FROM [GD1C2026].[gd_esquema].[Maestra]
WHERE Aspecto_Aspecto IS NOT NULL;

INSERT INTO Pirulo_Viajes.Estado (Estado_Descripcion)
SELECT DISTINCT Propuesta_Estado
FROM [GD1C2026].[gd_esquema].[Maestra]
WHERE Propuesta_Estado IS NOT NULL;

INSERT INTO Pirulo_Viajes.Medio_Pago (Medio_Pago_Descripcion)
SELECT DISTINCT Venta_Medio_Pago 
FROM [GD1C2026].[gd_esquema].[Maestra]
WHERE Venta_Medio_Pago IS NOT NULL;

INSERT INTO Pirulo_Viajes.Canal_Venta (Canal_Venta_Descripcion)
SELECT DISTINCT Venta_Canal_Venta
FROM [GD1C2026].[gd_esquema].[Maestra]
WHERE Venta_Canal_Venta IS NOT NULL;

INSERT INTO Pirulo_Viajes.Venta (
    venta_numero,
    venta_fecha,
    venta_canal,
    Venta_Subtotal,
    Venta_Descuento,
    Venta_Total,
    venta_medio_pago,
    venta_cliente,
    venta_agente
)
SELECT DISTINCT 
    M.Venta_Nro_Venta,
    M.Venta_Fecha_Venta,
    CV.Canal_Venta_Id,
    M.Venta_Subtotal,
    M.Venta_Descuento,
    M.Venta_Importe_Total,
    MP.Medio_Pago_Id,
	NULL,
	NULL
FROM [GD1C2026].[gd_esquema].[Maestra] M
INNER JOIN Pirulo_Viajes.Medio_Pago MP 
    ON M.Venta_Medio_Pago = MP.Medio_Pago_Descripcion
INNER JOIN Pirulo_Viajes.Canal_Venta CV 
	ON M.Venta_Canal_Venta = CV.Canal_Venta_Descripcion
WHERE M.Venta_Nro_Venta IS NOT NULL;

INSERT INTO Pirulo_Viajes.Detalle_encuesta (
    detalle_encuesta_codigo_encuesta, 
    detalle_encuesta_aspecto,  
    detalle_encuesta_puntaje
)
SELECT 
	distinct 
    M.Encuesta_Codigo_Encuesta,      
    A.Aspecto_Id,           
    M.Detalle_Encuesta_Puntaje 
FROM [GD1C2026].[gd_esquema].[Maestra] M
INNER JOIN Pirulo_Viajes.Aspecto A 
    ON A.Aspecto_Descripcion = M.Aspecto_Aspecto
WHERE M.Encuesta_Codigo_Encuesta IS NOT NULL 
  AND M.Detalle_Encuesta_Puntaje IS NOT NULL;

INSERT INTO Pirulo_Viajes.Agencia (
    agencia_numero,
    agencia_direccion,
    agencia_telefono,
    agencia_mail,
    agencia_localidad,
    agencia_provincia 
)
SELECT DISTINCT 
    Agencia_Nro_Agencia, 
    Agencia_Direccion,
    Agencia_Telefono, 
    Agencia_Mail,
    Agencia_Localidad, 
    Agencia_Provincia
FROM [GD1C2026].[gd_esquema].[Maestra]
WHERE Agencia_Nro_Agencia IS NOT NULL;

INSERT INTO Pirulo_Viajes.Agente (
    Agente_Legajo,
    Agente_Nombre,
    Agente_Apellido,
    Agente_Dni,
    Agente_Fecha_Nac,
    Agente_Telefono,
    Agente_Mail,
    Agente_Direccion,
    Agente_Localidad,
    Agente_Provincia,
    Agente_agencia    
)
SELECT DISTINCT 
    Agente_Legajo, 
    Agente_Nombre,
    Agente_Apellido, 
    Agente_Dni, 
    Agente_Fecha_Nac, 
    Agente_Telefono, 
    Agente_Mail,
    Agente_Direccion,
    Agente_Localidad, 
    Agente_Provincia, 
    Agencia_Nro_Agencia
FROM [GD1C2026].[gd_esquema].[Maestra]
WHERE Agente_Legajo IS NOT NULL;

INSERT INTO Pirulo_Viajes.Cliente (
    Cliente_Nombre,
    Cliente_Apellido,
    Cliente_Dni,
    Cliente_Tel,
    Cliente_Mail,
    Cliente_Direccion,
    Cliente_Fecha_Nac,
    Cliente_Localidad,
    Cliente_Provincia
)
SELECT DISTINCT 
    Cliente_Nombre,
    Cliente_Apellido,
    Cliente_Dni,
    Cliente_Tel,
    Cliente_Mail,
    Cliente_Direccion,
    Cliente_Fecha_Nac,
    Cliente_Localidad,
    Cliente_Provincia
FROM [GD1C2026].[gd_esquema].[Maestra]
WHERE Cliente_Dni IS NOT NULL;

INSERT INTO Pirulo_Viajes.Proveedor (
    Proveedor_Nombre,
    Proveedor_Mail,
    Proveedor_Telefono
)
SELECT DISTINCT 
    Proveedor_Nombre,
    Proveedor_Mail,
    Proveedor_Telefono
FROM [GD1C2026].[gd_esquema].[Maestra]
WHERE Proveedor_Nombre IS NOT NULL;

INSERT INTO Pirulo_Viajes.Aerolinea (
    aerolinea_codigo,
    aerolinea_nombre,
    aerolinea_pais,
    aerolinea_alianza_id
)
SELECT DISTINCT 
    M.Aerolinea_Codigo, 
    M.Aerolinea_Nombre, 
    M.Aerolinea_Pais,
    A.alianza_id    
FROM [GD1C2026].[gd_esquema].[Maestra] M
INNER JOIN Pirulo_Viajes.Alianza A 
    ON A.alianza_nombre = M.Aerolinea_Alianza
WHERE M.Aerolinea_Codigo IS NOT NULL;

INSERT INTO Pirulo_Viajes.Hospedaje (
    Hospedaje_Nombre, 
    Hospedaje_Ciudad, 
    Hospedaje_Pais, 
    Hospedaje_Direccion, 
    Hospedaje_Desayuno, 
    Hospedaje_Check_In, 
    Hospedaje_Check_out
)
SELECT DISTINCT 
    Hospedaje_Nombre, 
    Hospedaje_Ciudad, 
    Hospedaje_Pais, 
    Hospedaje_Direccion, 
    Hospedaje_Incluye_Desayuno, 
    Hospedaje_Check_In, 
    Hospedaje_Check_Out
FROM [GD1C2026].[gd_esquema].[Maestra]
WHERE Hospedaje_Nombre IS NOT NULL;

INSERT INTO Pirulo_Viajes.Habitacion (
    habitacion_hospedaje_id,  
    Habitacion_Nombre_tipo,   
    Habitacion_Precio,        
    Habitacion_Descripcion    
)
SELECT DISTINCT 
    H.hospedaje_id,           
    M.Habitacion_Nombre,      
    M.Habitacion_Precio_Noche, 
    M.Habitacion_Descripcion   
FROM [GD1C2026].[gd_esquema].[Maestra] M
INNER JOIN Pirulo_Viajes.Hospedaje H 
    ON H.Hospedaje_Nombre = M.Hospedaje_Nombre
WHERE M.Hospedaje_Nombre IS NOT NULL;


 


