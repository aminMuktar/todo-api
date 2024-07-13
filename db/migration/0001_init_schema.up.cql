CREATE KEYSPACE IF NOT EXISTS todoapp
WITH REPLICATION = {
  'class': 'SimpleStrategy',
  'replication_factor': 3
};

USE todoapp;

CREATE TABLE IF NOT EXISTS todoapp.users (
    user_id UUID PRIMARY KEY,
    username TEXT,
    email TEXT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE IF NOT EXISTS todoapp.todos (
    id UUID,
    user_id UUID,
    title TEXT,
    description TEXT,
    status TEXT,
    created TIMESTAMP,
    updated TIMESTAMP,
    PRIMARY KEY (user_id, id)
);


