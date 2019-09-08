CREATE SCHEMA IF NOT EXISTS app;

CREATE TABLE genre
(
    id SERIAL PRIMARY KEY,
    type varchar NOT NULL
);

CREATE TABLE persons
(
    id SERIAL PRIMARY KEY,
    name varchar(20) NOT NULL,
    age integer,
    address varchar,
    phone bigint
);

CREATE TABLE books
(
    id SERIAL PRIMARY KEY,
    person_id INTEGER REFERENCES persons(id),
    title varchar NOT NULL,
    price INTEGER NOT NULL,
    genre_id INTEGER REFERENCES genre(id),
    publication_date DATE
);

CREATE TABLE app.fitness
(
    id SERIAL PRIMARY KEY,
    person_id INTEGER REFERENCES persons(id),
    height INTEGER,
    weight INTEGER
);
