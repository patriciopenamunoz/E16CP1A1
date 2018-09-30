-- Crear una base de datos llamada call_list
CREATE DATABASE call_list;

-- En la base de datos recien creada, crear la tabla users con los campos id
-- (clave primaria), first_name, email.
CREATE TABLE users(
  id INTEGER PRIMARY KEY,
  first_name VARCHAR(65),
  email VARCHAR(65));

-- Ingresar un usuario, llamado Carlos (el resto de los datos deben
-- inventarlos).
INSERT INTO users VALUES(1, 'Carlos', 'pperez@dog.com');

-- Ingresar un usuario, llamada Laura (el resto de los datos deben
-- inventarlos).
INSERT INTO users VALUES(2, 'Laura', 'lluz@dog.com');

-- Crear una tabla llamada calls con los campos id (clave primaria),
-- phone, date, user_id (foreign key relacionado a users).
CREATE TABLE calls(
  id SERIAL PRIMARY KEY,
  phone VARCHAR(20),
  date DATE,
  user_id INTEGER REFERENCES users(id));

-- Agregar a la tabla users el campo last_name.
ALTER TABLE users ADD COLUMN last_name VARCHAR(65);

-- Ingresar el apellido del usuario Carlos.
UPDATE users SET last_name = 'Peréz' WHERE id = 1;

-- Ingresar el apellido del usuario Laura.
UPDATE users SET last_name = 'Luz' WHERE id = 2;

-- Ingresar 6 llamadas asociadas al usuario Laura.
INSERT INTO calls(phone, date, user_id) VALUES
  ('+56 9 4525 3241', to_date('01-09-2000', 'DD-MM-YYYY'), 2),
  ('+56 9 8423 4584', to_date('15-09-2012', 'DD-MM-YYYY'), 2),
  ('+56 9 9784 2468', to_date('12-05-2018', 'DD-MM-YYYY'), 2),
  ('+56 9 9784 2468', to_date('20-06-2018', 'DD-MM-YYYY'), 2),
  ('+56 9 1894 6654', to_date('10-07-2018', 'DD-MM-YYYY'), 2),
  ('+56 9 1894 6654', to_date('11-07-2018', 'DD-MM-YYYY'), 2);

-- Ingresar 4 llamadas asociadas al usuario Carlos.
INSERT INTO calls(phone, date, user_id) VALUES
  ('+56 9 1612 2541', to_date('02-04-2018', 'DD-MM-YYYY'), 1),
  ('+56 9 1612 2541', to_date('25-04-2018', 'DD-MM-YYYY'), 1),
  ('+56 9 1612 2541', to_date('13-05-2018', 'DD-MM-YYYY'), 1),
  ('+56 9 1612 2541', to_date('23-06-2018', 'DD-MM-YYYY'), 1);

-- Crear un nuevo usuario.
INSERT INTO users VALUES(3, 'Mariana', 'pperez@dog.com', 'Reyes');

-- Seleccionar la cantidad de llamados de cada uno de los usuarios
-- (nombre de usuario y cantidad de llamadas).
SELECT users.first_name, users.last_name, COUNT(*)
FROM users
INNER JOIN calls ON(users.id = calls.user_id)
GROUP BY users.first_name, users.last_name;

-- Seleccionar los llamados del usuario llamado Carlos ordenados por
-- fecha en orden descendente.
SELECT calls.date, users.first_name, users.last_name, calls.phone
FROM users
INNER JOIN calls ON(users.id = calls.user_id)
WHERE users.id = 1
ORDER BY calls.date ASC;
