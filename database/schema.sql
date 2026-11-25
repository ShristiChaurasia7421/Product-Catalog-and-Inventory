-- Product Catalog & Inventory schema (MySQL 8)

CREATE DATABASE IF NOT EXISTS catalog_db
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE catalog_db;

-- users table 
CREATE TABLE IF NOT EXISTS users(
    id             INT AUTO_INCREMENT PRIMARY KEY,
    email          VARCHAR(255) NOT NULL UNIQUE,
    password_hash  VARCHAR(255) NOT NULL,
    role           ENUM('admin','staff','viewer') NOT NULL DEFAULT 'viewer',
    created_at     TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- categories table 
CREATE TABLE IF NOT EXISTS categories(
    id           INT AUTO_INCREMENT PRIMARY KEY, 
    name         VARCHAR(100) NOT NULL UNIQUE,
    created_at   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- products table
CREATE TABLE IF NOT EXISTS products(
    id             INT AUTO_INCREMENT PRIMARY KEY, 
    name           VARCHAR(255) NOT NULL,
    description    VARCHAR(255),
    price          DECIMAL(10,2) NOT NULL,
    stock          INT NOT NULL DEFAULT 0,
    sku            VARCHAR(64) NOT NULL UNIQUE,
    category_id    INT NOT NULL,
    created_at     TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at     TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

 -- creates indexes

  INDEX idx_products_name (name),
  INDEX idx_products_price (price),
  INDEX idx_products_category(category_id),

 FOREIGN KEY (category_id) REFERENCES categories(id)

);
