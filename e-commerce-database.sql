-- 1. Users Table
DROP TABLE IF EXISTS users CASCADE;

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

-- 2. Products Table
DROP TABLE IF EXISTS products CASCADE;

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price NUMERIC(10, 2) NOT NULL,
    stock INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT NOW()
);

-- 3. Categories Table
DROP TABLE IF EXISTS categories CASCADE;

CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

-- 4. Product Categories (Join Table)
DROP TABLE IF EXISTS product_categories CASCADE;

CREATE TABLE product_categories (
    product_id INTEGER REFERENCES products(id) ON DELETE CASCADE,
    category_id INTEGER REFERENCES categories(id) ON DELETE CASCADE,
    PRIMARY KEY (product_id, category_id)
);

-- 5. Reviews Table
DROP TABLE IF EXISTS reviews CASCADE;

CREATE TABLE reviews (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    product_id INTEGER REFERENCES products(id) ON DELETE CASCADE,
    rating INTEGER CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT NOW(),
    UNIQUE (user_id, product_id)
);

-- 6. Orders & Order Items Tables
DROP TABLE IF EXISTS orders CASCADE;

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    order_date TIMESTAMP DEFAULT NOW(),
    status VARCHAR(50) DEFAULT 'pending'
);

DROP TABLE IF EXISTS order_items CASCADE;

CREATE TABLE order_items (
    id SERIAL PRIMARY KEY,
    order_id INTEGER REFERENCES orders(id) ON DELETE CASCADE,
    product_id INTEGER REFERENCES products(id) ON DELETE CASCADE,
    quantity INTEGER CHECK (quantity > 0),
    price NUMERIC(10, 2) NOT NULL
);

-- 7. Data Insertion Examples
-- Inserting Categories
INSERT INTO categories (name) VALUES ('Electronics'), ('Books');

-- Inserting Products
INSERT INTO products (name, description, price, stock) 
VALUES ('Laptop', 'High performance laptop', 1200.00, 10),
       ('PostgreSQL Guide', 'Database learning book', 45.50, 25);

-- Linking via Join Table
INSERT INTO product_categories (product_id, category_id) VALUES (1, 1), (2, 2);

-- 8. Example Query: Inner Join
SELECT p.name AS product_name, c.name AS category_name
FROM products p
JOIN product_categories pc ON p.id = pc.product_id
JOIN categories c ON c.id = pc.category_id;