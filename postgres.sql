-- DROP DATABASE postgres;

-- CREATE DATABASE postgres
--     WITH 
--     OWNER = postgres
--     ENCODING = 'UTF8'
--     LC_COLLATE = 'en_US.UTF-8'
--     LC_CTYPE = 'en_US.UTF-8'
--     TABLESPACE = pg_default
--     CONNECTION LIMIT = -1;

-- COMMENT ON DATABASE postgres
--     IS 'default administrative connection database';

CREATE TYPE ethnicity_option AS ENUM('Branco', 'Negro', 'Amarelo', 'Pardo', 'Indígena');

CREATE TABLE IF NOT EXISTS roles (
	id SERIAL PRIMARY KEY,
	role VARCHAR(80) NOT NULL
);

CREATE TABLE IF NOT EXISTS users (
	id SERIAL PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	phone VARCHAR(20) NOT NULL,
	email VARCHAR(100) NOT NULL UNIQUE,
	birthday DATE NOT NULL,
	weightKg INT NOT NULL,
	ethnicity ethnicity_option,
	role_id INT NOT NULL,
    CONSTRAINT fk_role FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE SET NULL
);

INSERT INTO roles (role) VALUES
    ('programador'),
    ('designer');

INSERT INTO users (name, phone, email, birthday, weightKg, ethnicity, role_id) VALUES
    ('Bill Gates', '5541999008877', 'admin@test.com.br', '1980-03-15', '98', 'Branco', 1),
    ('Steve Jobs', '5571988002233', 'user@test.com', '1992-08-23', '75', 'Negro', 2);

CREATE TABLE IF NOT EXISTS adresses (
	id SERIAL PRIMARY KEY,
	adress VARCHAR(100) NOT NULL,
	number INT NOT NULL,
	complement VARCHAR(100) NOT NULL,
	cep VARCHAR(10) NOT NULL,
	city VARCHAR(100) NOT NULL,
	state VARCHAR(100) NOT NULL,
	user_id INT NOT NULL,
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
);

INSERT INTO adresses (adress, number, complement, cep, city, state, user_id) VALUES
	('Av. Rio Iraí', 423, 'Casa dos fundos', '85289-800', 'Londrina', 'Paraná', 2),
	('Rua do Ó', 3467, 'Casa B', '75269-700', 'Florianópolis', 'Santa Catarina', 2),
	('Rua do Piruí', 789, 'Ap 307', '80280-000', 'Camaçari', 'Bahia', 1);