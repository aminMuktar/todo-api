-- Use the keyspace
USE todoapp;

-- Drop the todos table
DROP TABLE IF EXISTS todos;
DROP TABLE IF EXISTS users;

-- Drop the keyspace
DROP KEYSPACE IF EXISTS todoapp;
