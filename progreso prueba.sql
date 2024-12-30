--1--

create table peliculas (
id integer primary key,
nombre varchar (255),
anno integer
)
;
create table tags (
id integer primary key,
tag varchar (32)
)
;

create table peliculas_y_tags (
pelis_id integer references peliculas(id) on delete cascade,
tags_id integer references tags(id) on delete cascade
);

select * from peliculas_y_tags
select * from tags
select * from peliculas

alter table peliculas_y_tags
add primary key (pelis_id, tags_id)
;

--2--
insert into peliculas (id, nombre, anno) values 
(1, 'El gato volador', 1985),
(2, 'Beetlejuice', 1988),
(3, 'El joven manos de tijera', 1990),
(4, 'El Camino', 2019),
(5, 'Need for Speed', 2014);

insert into tags (id, tag) values
(1, 'Horror'),
(2, 'Aventura'),
(3, 'Emocionante'),
(4, 'Drama'),
(5, 'Inspirador');

insert into peliculas_y_tags (pelis_id, tags_id) values
(1, 2),
(1, 3),
(1, 5),
(2, 1),
(2, 4);

--3--
Select p.nombre, coalesce(count(pyt.tags_id),0) as conteo_tags
from peliculas as p
left join peliculas_y_tags pyt on p.id = pyt.pelis_id
left join tags t on t.id = pyt.tags_id 
group by p.nombre
;

--4--

create table preguntas (
id int primary key,
pregunta varchar (255),
respuesta_correcta varchar
)
;
create table usuarios (
id int primary key,
nombre varchar (255),
edad int
)
;
create table respuestas (
id int primary key,
respuesta varchar (255),
usuario_id int references usuarios(id) on delete cascade,
pregunta_id int references preguntas(id) on delete cascade
)
;

--5--

insert into usuarios (id, nombre, edad) values
(1, 'Fabio', 14),
(2, 'Daniel', 20),
(3, 'Joaquín', 18),
(4, 'Martina', 18),
(5, 'Valentina', 15);

insert into preguntas (id, pregunta, respuesta_correcta) values
(1, '¿Cuál es la capital de Francia?', 'París'),
(2, '¿Cuántos continentes existen en el mundo?', '7'),
(3, '¿En qué año se llegó a la Luna por primera vez?', '1969'),
(4, '¿Quién pintó la Mona Lisa?', 'Leonardo da Vinci'),
(5, '¿Qué elemento químico tiene el símbolo O?', 'Oxígeno');

insert into respuestas (id, respuesta, usuario_id, pregunta_id) values
(1, 'París', 2, 1),
(2, '7', 2, 2),
(3, '1960', 2, 3),
(4, 'Machiavelo', 2, 4),
(5, 'Carbono', 2, 5),
(6, 'París', 5, 1),
(7, '6', 5, 2),
(8, '1970', 5, 3),
(9, 'Leonardo da Voce', 5, 4),
(10, 'Uranio', 5, 5),
(11, 'Eiffel', 1, 1),
(12, '6', 1, 2),
(13, '2000', 1, 3),
(14, 'Cícero', 1, 4),
(15, 'Uranio', 1, 5),
(16, 'Frencia', 3, 1),
(17, '5', 3, 2),
(18, '1980', 3, 3),
(19, 'El Papa', 3, 4),
(20, 'Uranio', 3, 5),
(21, 'Eiffel', 4, 1),
(22, '3', 4, 2),
(23, '1980', 4, 3),
(24, 'El Papa', 4, 4),
(25, 'Orgón', 4, 5);

--6--
select u.nombre, count(r.respuesta) total_respuestas_correctas
from usuarios u
join respuestas r on r.usuario_id = u.id
right join preguntas p on r.pregunta_id = p.id
where r.respuesta = p.respuesta_correcta
group by u.nombre;

--7--
select p.pregunta, count(r.usuario_id) usuarios_que_respondieron_correctamente
from preguntas p
left join respuestas r on r.respuesta = p.respuesta_correcta
group by p.pregunta
;

--8--
delete from usuarios
where id = 1
;

select * from respuestas;

--si no estaba cascade al principio--
alter table respuestas drop constraint usuarios_id;
alter table respuestas drop constraint pregunta_id;

alter table respuestas
add constraint usuarios_id references usuario(id) on delete cascade;

alter table respuestas 
add constraint pregunta_id references preguntas(id) on delete cascade
--si no estaba cascade al principio--

--9--
--cambiar los datos porque habían menores de 18 para añadir la condición--
update usuarios
set edad = 18
where edad <18;

alter table usuarios
add constraint edad check (edad >=18);

insert into usuarios (id, nombre, edad) values
(6, 'Carlota', 16);

--10--
alter table usuarios
add email varchar (50) unique
;

insert into usuarios (id, nombre, edad, email) values
(6, 'Carla', 21, 'sabory@mailto.com'),
(7, 'Josefa', 19, 'sabory@mailto.com');

select * from preguntas;
select * from usuarios;
select * from respuestas;