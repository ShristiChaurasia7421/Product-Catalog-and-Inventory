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
    id              INT AUTO_INCREMENT PRIMARY KEY, 
    title           VARCHAR(255) NOT NULL,
    description     TEXT,
    category_id     INT NOT NULL,
    status          ENUM('active','draft','archived') NOT NULL DEFAULT 'draft',
    created_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

 -- creates indexes

  INDEX idx_products_title (title),
  INDEX idx_products_category(category_id),
  FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- product_variants table

CREATE TABLE IF NOT EXISTS product_variants(
    id            INT AUTO_INCREMENT PRIMARY KEY,
    product_id    INT NOT NULL, 
    sku           VARCHAR(255) NOT NULL UNIQUE, 
    size          VARCHAR(20), 
    colour        VARCHAR(255), 
    price_paise   INT NOT NULL, 
    created_at    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, 
    updated_at     TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- inventory table

CREATE TABLE IF NOT EXISTS inventory(
    id          INT AUTO_INCREMENT PRIMARY KEY, 
    variant_id  INT NOT NULL UNIQUE,        -- variant_id INT NOT NULL --> variant_id INT NOT NULL UNIQUE Should be one inventory row per variant ??
    on_hand     INT NOT NULL DEFAULT 0, 
    committed   INT NOT NULL DEFAULT 0,
    FOREIGN KEY (variant_id) REFERENCES product_variants(id)
);	 



