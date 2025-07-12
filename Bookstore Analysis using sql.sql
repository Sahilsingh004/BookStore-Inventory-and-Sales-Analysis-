/*----------------------------------------   Bookstore Inventory and Sales Analysis     ----------------------------------------------------------------------*/

CREATE DATABASE bookstore;
USE bookstore;

CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(50),
    author VARCHAR(30),
    genre VARCHAR(20),
    price DECIMAL(5,2),
    stock_quantity INT
);

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(100)
);


CREATE TABLE sales (
    sale_id INT AUTO_INCREMENT  PRIMARY KEY,
    book_id INT,
    customer_id INT,
    sale_date DATE,
    quantity INT,
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
) AUTO_INCREMENT = 101;

INSERT INTO books (title, author, genre, price, stock_quantity) VALUES
('Atomic Habits', 'James Clear', 'Self-help', 499.00, 50),
('The Alchemist', 'Paulo Coelho', 'Fiction', 399.00, 30),
('Clean Code', 'Robert C. Martin', 'Programming', 699.00, 20),
('Deep Work','Cal Newport','Self-help',550.00,40),
('Ikigai', 'Héctor García', 'Philosophy', 349.00, 25),
('The Psychology of Money', 'Morgan Housel', 'Finance', 499.00, 35);


INSERT INTO customers (name, city) VALUES
('Aman Sharma', 'Mumbai'),
('Priya Singh', 'Delhi'),
('Rahul Verma', 'Mumbai'),
('Sneha Mehta', 'Mumabi'),
('Karan Thakkar', 'Ahmedabad');


INSERT INTO sales (book_id, customer_id, sale_date, quantity) VALUES
(1, 1, '2025-06-10', 2),
(2, 2, '2025-06-12', 1),
(3, 1, '2025-06-13', 1),
(4, 3, '2025-06-15', 3),
(5, 2, '2025-06-16', 2),
(6, 4, '2025-06-17', 1);

/*Total Quantity Sold per Genre*/
SELECT  genre, 
SUM(quantity) AS total_sold
FROM books JOIN sales USING (book_id)
GROUP BY genre;

 /*Sales by Customer and City*/

SELECT c.name AS customer_name,c.city,
SUM(s.quantity) AS total_books_bought
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
GROUP BY c.name, c.city;

/*Top Selling Books*/
SELECT b.title,b.genre,
SUM(s.quantity) AS total_sold,
RANK() OVER (ORDER BY SUM(s.quantity) DESC) AS sales_rank
FROM sales s
JOIN books b ON s.book_id = b.book_id
GROUP BY b.title, b.genre;


SELECT * FROM sales;
SELECT * FROM Books;
SELECT * FROM customers;




