# E-Commerce PostgreSQL Database 🛒

A complete relational database schema and sample queries for an e-commerce platform, built using **PostgreSQL**. 

## 📂 Database Schema Overview

The database consists of the following core tables and relationships:
* **`users`**: Stores user account details (username, email, password, and creation timestamp).
* **`products`**: Manages store products (name, description, price, stock, and timestamp).
* **`categories`**: Organizes products into different sections/categories.
* **`product_categories`**: A join table managing the Many-to-Many relationship between products and categories.
* **`reviews`**: Stores user ratings and comments for specific products (with a unique constraint per user-product pair).
* **`orders`**: Tracks customer orders and their current status (e.g., pending).
* **`order_items`**: Manages individual items, quantities, and prices associated with each order.

---

## 🚀 Getting Started

### Prerequisites
* [PostgreSQL](https://www.postgresql.org/) installed on your machine.
* [pgAdmin 4](https://www.pgadmin.org/) or any preferred SQL client.

### Installation & Execution
1. Open your PostgreSQL client (like pgAdmin 4) and create a new database.
2. Open the **Query Tool** for your database.
3. Copy and run the contents of the `schema.sql` file. The script safely drops existing tables using `CASCADE` and recreates the full schema along with initial sample data and test queries.

---

## 📝 Example Query (Inner Join)
The project includes sample queries to fetch relational data, such as mapping products to their respective categories:

```sql
SELECT p.name AS product_name, c.name AS category_name
FROM products p
JOIN product_categories pc ON p.id = pc.product_id
JOIN categories c ON c.id = pc.category_id;
