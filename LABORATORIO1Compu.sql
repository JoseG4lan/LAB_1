-- Crear y usar la DB
CREATE DATABASE FIXO_SA;
USE FIXO_SA;

-- Creacion de tablas y sus relaciones usando foreign key
CREATE TABLE direccion(
	idDireccion INT PRIMARY KEY,
    Direccion VARCHAR(45),
    Ciudad VARCHAR(45),
    Pais VARCHAR(45)
);
CREATE TABLE cliente(
	idCliente INT PRIMARY KEY,
    Nombre VARCHAR(45),
    Apellido VARCHAR(45),
    Edad INT(11),
    Direccion_idDireccion INT(11),
    FOREIGN KEY (Direccion_idDireccion) REFERENCES direccion(idDireccion)
);
CREATE TABLE categoria(
	idCategoria INT PRIMARY KEY,
    Nombre VARCHAR(45)
);
CREATE TABLE peliculas1(
	idPeliculas INT PRIMARY KEY,
    Nombre VARCHAR(45),
    Duracion INT(11),
    Descripcion TEXT,
    Año INT (11),
    Categoria_idCategoria INT(11),
    FOREIGN KEY (Categoria_idCategoria) REFERENCES categoria(idCategoria) ON DELETE CASCADE
);
CREATE TABLE inventario(
	idCopiasPeliculas INT PRIMARY KEY,
    Peliculas_idPeliculas INT(11),
    FOREIGN KEY (Peliculas_idPeliculas) REFERENCES peliculas(idPeliculas),
    Disponible TINYINT(1)
);
CREATE TABLE renta(
	idRenta INT PRIMARY KEY,
    Fecha_renta DATE,
    Fecha_entrega DATE,
    Inventario_idCopiasPeliculas INT(11),
    Cliente_idCliente INT(11),
    FOREIGN KEY (Inventario_idCopiasPeliculas) REFERENCES inventario(idCopiasPeliculas),
    FOREIGN KEY (Cliente_idCliente) REFERENCES cliente(idCliente)
);

-- Insertar datos en las tablas
INSERT INTO direccion (idDireccion,Direccion,Ciudad,Pais) VALUES
(1,"km 25 Carretera a El Salvador","Guatemala","Guatemala"),
(2,"Martin Linges vei 33, 1364","Oslo","Noruega"),
(3,"Queens Rd, Clifton Bristol BS8 1RL","Bristol","Inglaterra"),
(4,"220 Saint George's Drive Northeast","Calgary","Canadá"),
(5,"Skólastígur 4, 600","Akureyri","Islandia");
INSERT INTO cliente (idCliente,Nombre,Apellido,Edad,Direccion_idDireccion) VALUES
(1,"Juliana","Vega",34,1),
(2,"Jakob","Olsen",55,3),
(3,"Robert","Jackson",24,5),
(4,"Noah","Trembley",28,4),
(5,"Margrét","Ólafsdóttir",19,2);
INSERT INTO categoria (idCategoria,Nombre) VALUES
(1,"Accion"),
(2,"Comedia"),
(3,"Romance"),
(4,"Terror"),
(5,"Policiaco");
INSERT INTO peliculas1 (idPeliculas,Nombre,Duracion,Descripcion,Año,Categoria_idCategoria) VALUES
(1,"POKEMON1","80","Comedia animada",2000,2),
(2,"Kingsman","120","Organizacion secreta contra gobierno",2016,1),
(3,"Perdida","150","Investigacion esposa perdida",2014,5),
(4,"365 dias","100","Conquista a mujer secuestrada en un año",2020,3),
(5,"El Telefono Negro","100","Niño secuestrado",2021,4);
INSERT INTO inventario (idCopiasPeliculas,Peliculas_idPeliculas,Disponible) VALUES
(1,1,8),
(2,2,1),
(3,3,4),
(4,4,0),
(5,5,6);
INSERT INTO renta (idRenta,Fecha_renta,Fecha_entrega,Inventario_idCopiasPeliculas,Cliente_idCliente) VALUES
(1,"2025-05-09","2025-05-26",1,1),
(2,"2024-12-13","2024-12-23",2,2),
(3,"2025-01-02","2025-01-29",3,3),
(4,"2025-01-30","2025-02-14",4,4),
(5,"2025-03-01","2025-03-02",5,5);

-- Consulta nombres iguales a Juliana
SELECT * FROM cliente WHERE Nombre = "Juliana";
SELECT * FROM peliculas WHERE Nombre = "Juliana";

-- Eliminacion de peliculas con nombre POKEMON1
DELETE FROM peliculas1 WHERE Nombre = "POKEMON1";

-- Ordenar categorias de manera ascendente
SELECT * FROM categoria ORDER BY idCategoria ASC;

-- Ordenar años de manera descendente
SELECT * FROM peliculas1 ORDER BY Año DESC;

-- Adicion de dos tablas
SELECT cliente.Apellido, cliente.Nombre, renta.Fecha_renta, renta.Fecha_entrega FROM cliente
JOIN renta ON  cliente.idCliente = renta.Cliente_idCliente;