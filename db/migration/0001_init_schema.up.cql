CREATE TABLE IF NOT EXISTS todos (
    id UUID PRIMARY KEY,
    title TEXT,
    description TEXT,
    completed BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);