USE [GD1C2026]
GO
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'Pirulo_Viajes')
    EXEC('CREATE SCHEMA Pirulo_Viajes');
GO

-- 1. Primero borramos los detalles más profundos (Nivel 4)
DROP TABLE IF EXISTS Pirulo_Viajes.Detalle_Venta_Excursiones;
DROP TABLE IF EXISTS Pirulo_Viajes.Detalle_venta_vuelo;
DROP TABLE IF EXISTS Pirulo_Viajes.Detalle_venta_hospedaje; -- Ojo que en tu lista decía 'Detalle_Venta_Hospedajes' con S
DROP TABLE IF EXISTS Pirulo_Viajes.Detalle_Excursion_Propuesta;
DROP TABLE IF EXISTS Pirulo_Viajes.Detalle_Hospedaje_Propuesta;
DROP TABLE IF EXISTS Pirulo_Viajes.Detalle_Vuelo_Propuesta;
DROP TABLE IF EXISTS Pirulo_Viajes.Detalle_Solicitud;
DROP TABLE IF EXISTS Pirulo_Viajes.Detalle_Encuesta;

-- 2. Borramos las transacciones y entidades intermedias que apuntaban a las maestras (Nivel 3)
DROP TABLE IF EXISTS Pirulo_Viajes.Venta;
DROP TABLE IF EXISTS Pirulo_Viajes.Propuesta;
DROP TABLE IF EXISTS Pirulo_Viajes.Solicitud_Cotizacion; 
DROP TABLE IF EXISTS Pirulo_Viajes.Encuesta;
DROP TABLE IF EXISTS Pirulo_Viajes.Habitacion;
DROP TABLE IF EXISTS Pirulo_Viajes.Vuelo;

-- 3. Borramos las entidades maestras principales (Nivel 2)
DROP TABLE IF EXISTS Pirulo_Viajes.Excursion;
DROP TABLE IF EXISTS Pirulo_Viajes.Hospedaje;
DROP TABLE IF EXISTS Pirulo_Viajes.Agente;
DROP TABLE IF EXISTS Pirulo_Viajes.Agencia;
DROP TABLE IF EXISTS Pirulo_Viajes.Cliente;
DROP TABLE IF EXISTS Pirulo_Viajes.Aeropuerto;

-- 4. Al final de todo, borramos los catálogos base que no dependen de nadie (Nivel 1)
DROP TABLE IF EXISTS Pirulo_Viajes.Aerolinea;
DROP TABLE IF EXISTS Pirulo_Viajes.Proveedor;
DROP TABLE IF EXISTS Pirulo_Viajes.Medio_Pago;
DROP TABLE IF EXISTS Pirulo_Viajes.Canal_Venta;
DROP TABLE IF EXISTS Pirulo_Viajes.Aspecto;
DROP TABLE IF EXISTS Pirulo_Viajes.Estado;
DROP TABLE IF EXISTS Pirulo_Viajes.Alianza;
DROP TABLE IF EXISTS Pirulo_Viajes.Ciudad;
DROP TABLE IF EXISTS Pirulo_Viajes.Pais;
DROP TABLE IF EXISTS Pirulo_Viajes.Localidad;
DROP TABLE IF EXISTS Pirulo_Viajes.Provincia;
GO


DROP TABLE IF EXISTS Pirulo_Viajes.Detalle_Venta_Excursiones; --Check
DROP TABLE IF EXISTS Pirulo_Viajes.Detalle_venta_vuelo; --check
DROP TABLE IF EXISTS Pirulo_Viajes.Detalle_Venta_Hospedajes; --check
DROP TABLE IF EXISTS Pirulo_Viajes.Detalle_Excursion_Propuesta;
DROP TABLE IF EXISTS Pirulo_Viajes.Detalle_Hospedaje_Propuesta;
DROP TABLE IF EXISTS Pirulo_Viajes.Detalle_Vuelo_Propuesta;
DROP TABLE IF EXISTS Pirulo_Viajes.Detalle_Solicitud;
DROP TABLE IF EXISTS Pirulo_Viajes.Detalle_Encuesta; --check
DROP TABLE IF EXISTS Pirulo_Viajes.Venta; --Check
DROP TABLE IF EXISTS Pirulo_Viajes.Propuesta;
DROP TABLE IF EXISTS Pirulo_Viajes.Solicitud_Cotizacion; 
DROP TABLE IF EXISTS Pirulo_Viajes.Encuesta; --check
DROP TABLE IF EXISTS Pirulo_Viajes.Habitacion; --check
DROP TABLE IF EXISTS Pirulo_Viajes.Vuelo;
DROP TABLE IF EXISTS Pirulo_Viajes.Excursion; --check
DROP TABLE IF EXISTS Pirulo_Viajes.Hospedaje; --check
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
DROP TABLE IF EXISTS Pirulo_Viajes.Ciudad; --Check
DROP TABLE IF EXISTS Pirulo_Viajes.Pais; --Check
DROP TABLE IF EXISTS Pirulo_Viajes.Localidad; --Check
DROP TABLE IF EXISTS Pirulo_Viajes.Provincia; --Check
GO
-------------------CREATE------------------

CREATE TABLE Pirulo_Viajes.Alianza (
    alianza_id int IDENTITY(1,1) NOT NULL,
    alianza_nombre nvarchar(255) NOT NULL,
    CONSTRAINT PK_Alianza PRIMARY KEY (alianza_id)
);

CREATE TABLE Pirulo_Viajes.Pais (
    pais_id int IDENTITY(1,1) NOT NULL,
    pais_descripcion nvarchar(255) NOT NULL,
    CONSTRAINT PK_Pais PRIMARY KEY (pais_id)
);

CREATE TABLE Pirulo_Viajes.Ciudad (
    ciudad_id int IDENTITY(1,1) NOT NULL,
    ciudad_descripcion nvarchar(255) NOT NULL,
    ciudad_pais int NOT NULL,
    CONSTRAINT PK_Ciudad PRIMARY KEY (ciudad_id),
    CONSTRAINT FK_Ciudad_Pais FOREIGN KEY (ciudad_pais) REFERENCES Pirulo_Viajes.Pais(pais_id)
);

CREATE TABLE Pirulo_Viajes.Provincia (
    provincia_id int IDENTITY(1,1) NOT NULL,
    provincia_descripcion nvarchar(255) NOT NULL,
    
    CONSTRAINT PK_Provincia PRIMARY KEY (provincia_id)
);

CREATE TABLE Pirulo_Viajes.Localidad (
    localidad_id int IDENTITY(1,1) NOT NULL,
    localidad_descripcion nvarchar(255) NOT NULL,
    localidad_provincia int NOT NULL,
    
    CONSTRAINT PK_Localidad PRIMARY KEY (localidad_id),
    CONSTRAINT FK_Localidad_Provincia FOREIGN KEY (localidad_provincia) REFERENCES Pirulo_Viajes.Provincia(provincia_id)
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
    Cliente_Dni nvarchar(255) NOT NULL,
    Cliente_Tel nvarchar(255) NULL,
    Cliente_Mail nvarchar(255) NULL,
    Cliente_Direccion nvarchar(255) NULL,
    Cliente_Fecha_Nac date NULL,
    Cliente_Localidad int NULL
    
    CONSTRAINT PK_Cliente PRIMARY KEY (cliente_id)
	CONSTRAINT FK_Cliente_Localidad FOREIGN KEY (Cliente_Localidad) REFERENCES Pirulo_Viajes.Localidad(localidad_id)
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

CREATE TABLE Pirulo_Viajes.Excursion (
    excursion_id int IDENTITY(1,1) NOT NULL,
    excursion_proveedor_id int NOT NULL,      
    excursion_nombre nvarchar(255) NULL,
    excursion_descripcion nvarchar(max) NULL,
    excursion_horario nvarchar(50) NULL,
    excursion_duracion int NULL,
    excursion_precio decimal(18,2) NULL,

    CONSTRAINT PK_Excursion PRIMARY KEY (excursion_id),
    CONSTRAINT FK_Excursion_Proveedor FOREIGN KEY (excursion_proveedor_id) REFERENCES Pirulo_Viajes.Proveedor(Proveedor_id)
);

CREATE TABLE Pirulo_Viajes.Detalle_venta_excursiones (
    Detalle_Venta_excursion_id int IDENTITY(1,1) NOT NULL,
    Detalle_Venta_Excursion_Cod_Reserva nvarchar(255) NULL,
    detalle_venta_numero bigint NOT NULL,                 
    detalle_venta_excursion_excursion_id int NOT NULL,
    Detalle_Venta_Excursion_Fecha_Reserva date NULL,
    Detalle_Venta_Excursion_Cant int NULL,
    Detalle_Venta_Excursion_Precio_Unitario decimal(18,2) NULL,
    Detalle_Venta_Excursion_Subtotal decimal(18,2) NULL,
    
    CONSTRAINT PK_Detalle_venta_excursiones PRIMARY KEY (Detalle_Venta_excursion_id),
    CONSTRAINT FK_Detalle_Venta FOREIGN KEY (detalle_venta_numero) REFERENCES Pirulo_Viajes.Venta(venta_numero), 
    CONSTRAINT FK_Detalle_Excursion FOREIGN KEY (detalle_venta_excursion_excursion_id) REFERENCES Pirulo_Viajes.Excursion(excursion_id)
);

CREATE TABLE Pirulo_Viajes.Encuesta (
    encuesta_codigo_encuesta bigint NOT NULL,
    encuesta_fecha_encuesta date NULL,
    encuesta_comentarios nvarchar(max) NULL,
    encuesta_cliente int NOT NULL,          
    encuesta_agente bigint NOT NULL,         
    CONSTRAINT PK_Encuesta PRIMARY KEY (encuesta_codigo_encuesta),
    CONSTRAINT FK_Encuesta_Cliente FOREIGN KEY (encuesta_cliente) REFERENCES Pirulo_Viajes.Cliente(cliente_id),
    CONSTRAINT FK_Encuesta_Agente FOREIGN KEY (encuesta_agente) REFERENCES Pirulo_Viajes.Agente(Agente_Legajo)
);

CREATE TABLE Pirulo_Viajes.Detalle_venta_vuelo (
    Detalle_venta_vuelo_id int IDENTITY(1,1) NOT NULL,
    Detalle_Venta_Vuelo_Cod_Reserva nvarchar(255) NULL,
    detalle_venta_vuelo_venta bigint NOT NULL,       -- FK a tu tabla Venta
    detalle_venta_vuelo_vuelo_id int  NULL,       -- FK a tu tabla Vuelo
    detalle_venta_vuelo_cantidad_pasajes int NULL,
    detalle_venta_vuelo_precio_unitario decimal(18, 2) NULL,
    Detalle_Venta_Vuelo_Subtotal decimal(18, 2) NULL,
    
    CONSTRAINT PK_Detalle_venta_vuelo PRIMARY KEY (Detalle_venta_vuelo_id),
    CONSTRAINT FK_DetalleVuelo_Venta FOREIGN KEY (detalle_venta_vuelo_venta) REFERENCES Pirulo_Viajes.Venta(venta_numero),
    --CONSTRAINT FK_DetalleVuelo_Vuelo FOREIGN KEY (detalle_venta_vuelo_vuelo_id) REFERENCES Pirulo_Viajes.Vuelo(vuelo_id)
);

CREATE TABLE Pirulo_Viajes.Detalle_venta_hospedaje (
    Detalle_Venta_Hospedaje_id int IDENTITY(1,1) NOT NULL,
    Detalle_Venta_Hospedaje_Cod_Reserva nvarchar(255) NULL,
    detalle_venta_hospedaje_venta bigint NOT NULL,   -- FK a tu tabla Venta
    detalle_venta_habitacion_id int NOT NULL, 
	detalle_venta_habitacion_hospedaje_id int NOT NULL,
    Detalle_Venta_Hospedaje_Precio_Unitario decimal(18, 2) NULL,
    Detalle_Venta_Hospedaje_Fecha_Desde date NULL,
    Detalle_Venta_Hospedaje_Fecha_Hasta date NULL,
    Detalle_Venta_Hospedaje_Cantidad int NULL,
    Detalle_Venta_Hospedaje_Subtotal decimal(18, 2) NULL,
    
    CONSTRAINT PK_Detalle_venta_hospedaje PRIMARY KEY (Detalle_Venta_Hospedaje_id),
    CONSTRAINT FK_DetalleHospedaje_Venta FOREIGN KEY (detalle_venta_hospedaje_venta) REFERENCES Pirulo_Viajes.Venta(venta_numero),
    CONSTRAINT FK_DetalleHospedaje_Habitacion FOREIGN KEY (detalle_venta_habitacion_id, detalle_venta_habitacion_hospedaje_id) 
        REFERENCES Pirulo_Viajes.Habitacion(habitacion_id, habitacion_hospedaje_id)
);

CREATE TABLE Pirulo_Viajes.Aeropuerto (
    aeropuerto_codigo nvarchar(10) NOT NULL,
    aeropuerto_descripcion nvarchar(200) NULL,
    aeropuerto_ciudad int NOT NULL, -- FK a la tabla Ciudad que ya poblaste
    
    CONSTRAINT PK_Aeropuerto PRIMARY KEY (aeropuerto_codigo),
    CONSTRAINT FK_Aeropuerto_Ciudad FOREIGN KEY (aeropuerto_ciudad) REFERENCES Pirulo_Viajes.Ciudad(ciudad_id)
);

CREATE TABLE Pirulo_Viajes.Vuelo (
    vuelo_id int IDENTITY(1,1) NOT NULL,
    vuelo_aerolinea_codigo nvarchar(255) NULL, 
    vuelo_aeropuerto_salida nvarchar(10) NOT NULL, 
    vuelo_aeropuerto_llegada nvarchar(10) NOT NULL,
    vuelo_fecha_salida date NULL,
    vuelo_horario_salida nvarchar(50) NULL,
    vuelo_fecha_llegada date NULL,
    vuelo_horario_llegada nvarchar(50) NULL,
    vuelo_duracion int NULL,
    vuelo_precio decimal(18, 2) NULL,
    vuelo_incluye_carry bit NULL,
    vuelo_incluye_valija bit NULL,
    
    CONSTRAINT PK_Vuelo PRIMARY KEY (vuelo_id),
    CONSTRAINT FK_Vuelo_AeropuertoSalida FOREIGN KEY (vuelo_aeropuerto_salida) REFERENCES Pirulo_Viajes.Aeropuerto(aeropuerto_codigo),
    CONSTRAINT FK_Vuelo_AeropuertoLlegada FOREIGN KEY (vuelo_aeropuerto_llegada) REFERENCES Pirulo_Viajes.Aeropuerto(aeropuerto_codigo)
);

------------------------INSERT--------------------
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

INSERT INTO Pirulo_Viajes.Provincia (provincia_descripcion)
SELECT Agencia_Provincia FROM [GD1C2026].[gd_esquema].[Maestra] WHERE Agencia_Provincia IS NOT NULL
UNION
SELECT Agente_Provincia FROM [GD1C2026].[gd_esquema].[Maestra] WHERE Agente_Provincia IS NOT NULL
UNION
SELECT Cliente_Provincia FROM [GD1C2026].[gd_esquema].[Maestra] WHERE Cliente_Provincia IS NOT NULL;


INSERT INTO Pirulo_Viajes.Localidad (localidad_descripcion, localidad_provincia)
SELECT DISTINCT 
    Origen.Localidad_Total, 
    P.provincia_id
FROM (
    SELECT Agencia_Localidad AS Localidad_Total, Agencia_Provincia AS Provincia_Total
    FROM [GD1C2026].[gd_esquema].[Maestra] 
    WHERE Agencia_Localidad IS NOT NULL AND Agencia_Provincia IS NOT NULL
    
    UNION
    
    SELECT Agente_Localidad, Agente_Provincia 
    FROM [GD1C2026].[gd_esquema].[Maestra] 
    WHERE Agente_Localidad IS NOT NULL AND Agente_Provincia IS NOT NULL
    
    UNION
    
    SELECT Cliente_Localidad, Cliente_Provincia 
    FROM [GD1C2026].[gd_esquema].[Maestra] 
    WHERE Cliente_Localidad IS NOT NULL AND Cliente_Provincia IS NOT NULL
) AS Origen
INNER JOIN Pirulo_Viajes.Provincia P 
    ON P.provincia_descripcion = Origen.Provincia_Total;

--Caso particular, se encontro dnis repetidos. Usamos para desempatar el max
INSERT INTO Pirulo_Viajes.Cliente (
    Cliente_Nombre,
    Cliente_Apellido,
    Cliente_Dni,
    Cliente_Tel,
    Cliente_Mail,
    Cliente_Direccion,
    Cliente_Fecha_Nac,
    Cliente_Localidad
)
SELECT DISTINCT 
    max(Cliente_Nombre),
    max(Cliente_Apellido),
    Cliente_Dni,
    max(Cliente_Tel),
    max(Cliente_Mail),
    max(Cliente_Direccion),
    max(Cliente_Fecha_Nac),
    L.localidad_id
FROM [GD1C2026].[gd_esquema].[Maestra] M
INNER JOIN Pirulo_Viajes.Localidad L 
    ON L.localidad_descripcion = M.Cliente_Localidad
INNER JOIN Pirulo_Viajes.Provincia P 
    ON P.provincia_id = L.localidad_provincia AND P.provincia_descripcion = M.Cliente_Provincia
WHERE Cliente_Dni IS NOT NULL
GROUP BY Cliente_Dni,L.localidad_id

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

---------------
INSERT INTO Pirulo_Viajes.Excursion (
    excursion_proveedor_id,
    excursion_nombre,
    excursion_descripcion,
    excursion_horario,
    excursion_duracion,
    excursion_precio
)
SELECT DISTINCT 
	P.Proveedor_id,
    M.Excursion_Nombre,
	M.Excursion_Descripcion,
	M.Excursion_Horario,
	M.Excursion_Duracion,
	M.Excursion_Precio
FROM [GD1C2026].[gd_esquema].[Maestra] M
INNER JOIN Pirulo_Viajes.Proveedor P 
    ON P.Proveedor_Nombre = M.Proveedor_Nombre
WHERE M.Excursion_Nombre IS NOT NULL;


INSERT INTO Pirulo_Viajes.Detalle_venta_excursiones (
    Detalle_Venta_Excursion_Cod_Reserva,
    detalle_venta_numero,
    detalle_venta_excursion_excursion_id,
    Detalle_Venta_Excursion_Fecha_Reserva,
    Detalle_Venta_Excursion_Cant,
    Detalle_Venta_Excursion_Precio_Unitario,
    Detalle_Venta_Excursion_Subtotal
)
SELECT DISTINCT
    M.Detalle_Venta_Excursion_Cod_Reserva,      
    V.venta_numero,                   
    E.excursion_id,                  
    M.Detalle_Venta_Excursion_Fecha_Reserva,       
    M.Detalle_Venta_Excursion_Cant,             
    M.Detalle_Venta_Excursion_Precio_Unitario,              
    M.Detalle_Venta_Excursion_Subtotal 
FROM [GD1C2026].[gd_esquema].[Maestra] M
INNER JOIN Pirulo_Viajes.Excursion E 
    ON E.excursion_nombre = M.Excursion_Nombre
INNER JOIN Pirulo_Viajes.Venta V 
    ON V.venta_numero= M.Venta_Nro_Venta
WHERE M.Detalle_Venta_Excursion_Cod_Reserva IS NOT NULL;


INSERT INTO Pirulo_Viajes.Encuesta (
    encuesta_codigo_encuesta,
    encuesta_fecha_encuesta,
    encuesta_comentarios,
    encuesta_cliente,
    encuesta_agente
)
SELECT 
    M.Encuesta_Codigo_Encuesta,
    MAX(M.Encuesta_Fecha_Encuesta), 
    MAX(M.Encuesta_Comentarios),   
    MAX(C.cliente_id), 
    MAX(M.Agente_Legajo)            
FROM [GD1C2026].[gd_esquema].[Maestra] M
INNER JOIN Pirulo_Viajes.Cliente C 
    ON C.Cliente_Dni = M.Cliente_Dni
WHERE M.Encuesta_Codigo_Encuesta IS NOT NULL
GROUP BY M.Encuesta_Codigo_Encuesta;

--Caso particular, paises con acento, debemos limpiar y tomar el primero
WITH PaisesAgrupados AS (
    SELECT 
        Pais_Original,
        ROW_NUMBER() OVER (
            PARTITION BY REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Pais_Original, 'á', 'a'), 'é', 'e'), 'í', 'i'), 'ó', 'o'), 'ú', 'u')
            ORDER BY Pais_Original DESC
        ) AS Posicion
    FROM (
        SELECT Hospedaje_Pais AS Pais_Original FROM [GD1C2026].[gd_esquema].[Maestra] WHERE Hospedaje_Pais IS NOT NULL
        UNION ALL
        SELECT Aerolinea_Pais FROM [GD1C2026].[gd_esquema].[Maestra] WHERE Aerolinea_Pais IS NOT NULL
    ) AS Unificados
) 
INSERT INTO Pirulo_Viajes.Pais (pais_descripcion)
SELECT Pais_Original
FROM PaisesAgrupados
WHERE Posicion = 1;

-----------------------------------
INSERT INTO Pirulo_Viajes.Ciudad (ciudad_descripcion, ciudad_pais)
SELECT DISTINCT 
    Origen.Ciudad_Texto, 
    P.pais_id
FROM (
    SELECT Hospedaje_Ciudad AS Ciudad_Texto, Hospedaje_Pais  AS Pais_Texto
    FROM [GD1C2026].[gd_esquema].[Maestra] 
    WHERE Hospedaje_Ciudad IS NOT NULL AND Hospedaje_Pais IS NOT NULL
) AS Origen
INNER JOIN Pirulo_Viajes.Pais P 
    ON P.pais_descripcion = Origen.Pais_Texto;

INSERT INTO Pirulo_Viajes.Detalle_venta_vuelo (
    Detalle_Venta_Vuelo_Cod_Reserva,
    detalle_venta_vuelo_venta,
    detalle_venta_vuelo_vuelo_id, 
    detalle_venta_vuelo_cantidad_pasajes,
    detalle_venta_vuelo_precio_unitario,
    Detalle_Venta_Vuelo_Subtotal
)
SELECT 
	distinct
M.Detalle_Venta_Vuelo_Cod_Reserva, 
    V.venta_numero,            
    null,--VU.vuelo_id,            
    M.Detalle_Venta_Vuelo_Cantidad_Pasajes,
    M.Detalle_Venta_Vuelo_Precio_Unitario,
    M.Detalle_Venta_Vuelo_Subtotal --
FROM [GD1C2026].[gd_esquema].[Maestra] M
INNER JOIN Pirulo_Viajes.Venta V 
    ON V.venta_numero = M.Venta_Nro_Venta 
WHERE M.Detalle_Venta_Vuelo_Cod_Reserva IS NOT NULL;
--INNER JOIN Pirulo_Viajes.Vuelo VU 
    --ON VU.vuelo_codigo = M.Vuelo_Codigo       
--WHERE M.Vuelo_Codigo_Reserva IS NOT NULL;

INSERT INTO Pirulo_Viajes.Detalle_venta_hospedaje (
    Detalle_Venta_Hospedaje_Cod_Reserva,
    detalle_venta_hospedaje_venta,
    detalle_venta_habitacion_id,           
    detalle_venta_habitacion_hospedaje_id, --Cambio, traje el hospedaje x pk compuesta
    Detalle_Venta_Hospedaje_Precio_Unitario,
    Detalle_Venta_Hospedaje_Fecha_Desde,
    Detalle_Venta_Hospedaje_Fecha_Hasta,
    Detalle_Venta_Hospedaje_Cantidad,
    Detalle_Venta_Hospedaje_Subtotal)
SELECT DISTINCT
    M.Detalle_Venta_Hospedaje_Cod_Reserva, 
    V.venta_numero, 
    H.habitacion_id, 
    H.habitacion_hospedaje_id, 
    M.Detalle_Venta_Hospedaje_Precio_Unitario,
    M.Detalle_Venta_Hospedaje_Fecha_Desde,
    M.Detalle_Venta_Hospedaje_Fecha_Hasta,
    M.Detalle_Venta_Hospedaje_Cantidad,
    M.Detalle_Venta_Hospedaje_Subtotal
FROM [GD1C2026].[gd_esquema].[Maestra] M
INNER JOIN Pirulo_Viajes.Venta V 
    ON V.venta_numero = M.Venta_Nro_Venta 
INNER JOIN Pirulo_Viajes.Hospedaje HO
    ON HO.hospedaje_nombre = M.Hospedaje_Nombre 

INNER JOIN Pirulo_Viajes.Habitacion H 
    ON H.habitacion_hospedaje_id = HO.hospedaje_id 
    AND H.Habitacion_Nombre_tipo = M.Habitacion_Nombre 
WHERE M.Detalle_Venta_Hospedaje_Cod_Reserva IS NOT NULL;


INSERT INTO Pirulo_Viajes.Pais (pais_descripcion)
VALUES ('País No Especificado');

INSERT INTO Pirulo_Viajes.Ciudad (ciudad_descripcion, ciudad_pais)
VALUES (
    'Ciudad No Especificada', 
    (SELECT pais_id FROM Pirulo_Viajes.Pais WHERE pais_descripcion = 'País No Especificado')
);


INSERT INTO Pirulo_Viajes.Aeropuerto (aeropuerto_codigo, aeropuerto_descripcion, aeropuerto_ciudad)
SELECT DISTINCT 
    base.Aeropuerto_Cod,
    MAX(base.Aeropuerto_Desc),
    ISNULL(MAX(C.ciudad_id), (SELECT ciudad_id FROM Pirulo_Viajes.Ciudad WHERE ciudad_descripcion = 'Ciudad No Especificada'))
FROM (
    -- Aeropuertos de Salida
    SELECT 
        Aeropuerto_Salida_Codigo AS Aeropuerto_Cod, 
        Aeropuerto_Salida_Descripcion AS Aeropuerto_Desc,
        Aeropuerto_Salida_Ciudad AS Ciudad_Texto
    FROM [GD1C2026].[gd_esquema].[Maestra]
    WHERE Aeropuerto_Salida_Codigo IS NOT NULL
    
    UNION
    
    -- Aeropuertos de Llegada
    SELECT 
        Aeropuerto_Llegada_Codigo, 
        Aeropuerto_Llegada_Descripcion,
        Aeropuerto_Llegada_Ciudad
    FROM [GD1C2026].[gd_esquema].[Maestra]
    WHERE Aeropuerto_Llegada_Codigo IS NOT NULL
) AS base
LEFT JOIN Pirulo_Viajes.Ciudad C 
    ON LTRIM(RTRIM(C.ciudad_descripcion)) = LTRIM(RTRIM(base.Ciudad_Texto))
GROUP BY base.Aeropuerto_Cod;

INSERT INTO Pirulo_Viajes.Vuelo (
    vuelo_aerolinea_codigo,   
    vuelo_aeropuerto_salida, 
    vuelo_aeropuerto_llegada, 
    vuelo_fecha_salida,
    vuelo_horario_salida,
    vuelo_fecha_llegada,
    vuelo_horario_llegada,
    vuelo_duracion,
    vuelo_precio,
    vuelo_incluye_carry,      
    vuelo_incluye_valija     
)
SELECT DISTINCT
    M.Aerolinea_Codigo,
    M.Aeropuerto_Salida_Codigo,
    M.Aeropuerto_Llegada_Codigo,
    M.Vuelo_Fecha_Salida,
    M.Vuelo_Horario_Salida,
    M.Vuelo_Fecha_Llegada,
    M.Vuelo_Horario_Llegada,
    M.Vuelo_Duracion,
    M.Vuelo_Precio,
    M.Vuelo_Incluye_Carry,
    M.Vuelo_Incluye_Valija
FROM [GD1C2026].[gd_esquema].[Maestra] M
WHERE M.Aerolinea_Codigo IS NOT NULL 
  AND M.Aeropuerto_Salida_Codigo IS NOT NULL 
  AND M.Aeropuerto_Llegada_Codigo IS NOT NULL;
