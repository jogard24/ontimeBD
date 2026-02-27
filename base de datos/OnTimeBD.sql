create database OntimeBD;
use OntimeBD;


create table datosPersonales (
id int auto_increment primary key,
documento_identidad varchar (50) unique not null,
nombre_completo varchar (100) not null, 
celular varchar (50) not null,
direccion varchar (100) not null,
tipo_sangre varchar (50) not null,
contacto_emergencia varchar (100) not null,
contacto_telefono varchar (50) not null,
fecha_registro timestamp default current_timestamp);

rename table usuario to datosPersonales;

select * from datosPersonales;
show columns from  datosPersonales;

alter table usuario

modify 	column tipo_sangre enum ('a+','a-', 'b+', 'b-', 'o+','o-','ab+','ab-');


create table roles (
id int auto_increment primary key,
nombre varchar (100)  not null, 
descripcion text);

-- relacionar roles y permisos

create table credenciales (
id int auto_increment primary key,
usuario_id int,
usuario varchar (100) unique,
clave varchar (50),
tarjeta_proximidad varchar (100) unique,
rol_id int,
activo boolean default true,
foreign key (usuario_id) references usuario(id),
foreign key(rol_id) references roles (id));

alter table credenciales 
drop column tarjeta_proximidad;

drop table credenciales;

select * from credenciales;


show columns from credenciales;

alter table credenciales
drop column rec_dactilar;

alter table credenciales
add rec_dactilar blob;

create table tarjetaProximidad(
id int auto_increment primary key,
usuario_id int not null,
tarjeta_proximidad varchar (100) unique,
activa boolean default true,
fecha_registro timestamp default current_timestamp,
foreign key (usuario_id) references usuario(id));





CREATE TABLE asistencia (
id INT AUTO_INCREMENT PRIMARY KEY,
empleado_id INT,
tipo_evento ENUM('entrada', 'salida'),
fecha_hora DATETIME DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (empleado_id) REFERENCES usuario(id));

drop table asistencia;

select * from asistencia;

alter table asistencia
rename column empleado_id to usuario_id;

CREATE TABLE permisos (
id INT AUTO_INCREMENT PRIMARY KEY,
empleado_id INT,
motivo TEXT,
fecha_inicio DATE,
fecha_fin DATE,
aprobado BOOLEAN DEFAULT FALSE,
fecha_solicitud TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (empleado_id) REFERENCES usuario(id));



alter table permisos
rename  column empleado_id to usuario_id;

alter table permisos
add column autorizado_por varchar (50) not null;

select * from permisos;


CREATE TABLE reportes_nomina (
id INT AUTO_INCREMENT PRIMARY KEY,
usuario_id INT,
fecha_inicio DATE,
fecha_fin DATE,
total_dias_trabajados INT,
total_horas_trabajadas INT,
total_permisos INT,
fecha_generacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (usuario_id) REFERENCES usuario(id));

drop table reportes_nomina;