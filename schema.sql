CREATE DATABASE faker_lab;
USE faker_lab;

CREATE TABLE users (
  email VARCHAR(255) PRIMARY KEY,
  created_at TIMESTAMP DEFAULT NOW()
);
