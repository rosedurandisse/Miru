DROP DATABASE IF EXISTS miru_db;

CREATE DATABASE miru_db;

\c miru_db;

CREATE TABLE activity (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    name TEXT UNIQUE NOT NULL,
    description TEXT,
    street_address TEXT NOT NULL,
    city TEXT NOT NULL,
    state TEXT NOT NULL,
    zip_code INT NOT NULL,
    category TEXT NOT NULL,
    image TEXT
);

CREATE TABLE comments (
    id SERIAL PRIMARY KEY,
    activity_id INT,
    name TEXT,
    comment TEXT,
    FOREIGN KEY (activity_id) REFERENCES activity(id)
);

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    email varchar(255) UNIQUE NOT NULL,
    password varchar(255) NOT Null
   
);

CREATE TABLE favorites (
	id SERIAL PRIMARY KEY,
	user_id INT NOT NULL,
	activity_id INT NOT NULL,
	UNIQUE (user_id, activity_id),
	FOREIGN KEY (activity_id) REFERENCES activity(id),
	FOREIGN KEY (user_id) REFERENCES users(id)
);

