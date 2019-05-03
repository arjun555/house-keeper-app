CREATE DATABASE house_keepers;

CREATE TABLE users(
    id SERIAL PRIMARY KEY,
    email VARCHAR(500),
    password_digest VARCHAR(500),
    account_type VARCHAR(500)
);

CREATE TABLE listings(
    id SERIAL PRIMARY KEY,
    domain_id TEXT,
    tenant_id INTEGER,
    agent_id INTEGER
);

CREATE TABLE tickets(
    id SERIAL PRIMARY KEY,
    listing_id INTEGER,
    user_id INTEGER,
    ticket_status TEXT,
    ticket_type TEXT,
    created_timestamp TEXT,
    completed_timestamp TEXT
);

CREATE TABLE ticket_imgs(
    id SERIAL PRIMARY KEY,
    ticket_id INTEGER,
    img_url TEXT
);