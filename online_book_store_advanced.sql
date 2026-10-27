-- ============================================================
-- ONLINE BOOK STORE | ADVANCED SQL DATA ANALYST PROJECT
-- ============================================================

CREATE DATABASE  online_book_store;
USE online_book_store;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS customers;
SET FOREIGN_KEY_CHECKS = 1;

-- 1. TABLE CREATION
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE,
    city VARCHAR(80),
    signup_date DATE NOT NULL
);

CREATE TABLE books (
    book_id INT PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    author VARCHAR(100) NOT NULL,
    genre VARCHAR(60) NOT NULL,
    list_price DECIMAL(10,2) NOT NULL,
    stock_qty INT NOT NULL DEFAULT 0
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL
        CHECK (status IN ('Completed','Shipped','Pending','Cancelled','Returned')),
    payment_method VARCHAR(40),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);


CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    book_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    discount_pct DECIMAL(5,2) NOT NULL DEFAULT 0,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    CHECK (quantity > 0),
    CHECK (discount_pct BETWEEN 0 AND 100)
);

-- COUSTOMER TABLE  DATA
INSERT INTO customers VALUES
(1,'Rahul Sharma','rahul.sharma@example.com','Delhi','2023-11-12'),
(2,'Aman Verma','aman.verma@example.com','Noida','2024-01-08'),
(3,'Priya Singh','priya.singh@example.com','Moradabad','2024-02-14'),
(4,'Neha Gupta','neha.gupta@example.com','Lucknow','2024-03-02'),
(5,'Arjun Mehta','arjun.mehta@example.com','Delhi','2024-04-19'),
(6,'Sneha Khan','sneha.khan@example.com','Meerut','2024-05-22'),
(7,'Vikram Yadav','vikram.yadav@example.com','Noida','2024-06-10'),
(8,'Pooja Agarwal','pooja.agarwal@example.com','Jaipur','2024-07-01'),
(9,'Rohan Das','rohan.das@example.com','Kolkata','2024-08-15'),
(10,'Isha Patel','isha.patel@example.com','Ahmedabad','2024-09-20'),
(11,'Kabir Joshi','kabir.joshi@example.com','Mumbai','2024-10-05'),
(12,'Ananya Roy','ananya.roy@example.com','Delhi','2025-01-11'),
(13,'Dev Malhotra','dev.malhotra@example.com','Pune','2025-02-18'),
(14,'Meera Nair','meera.nair@example.com','Bengaluru','2025-03-09'),
(15,'Aditya Jain','aditya.jain@example.com','Moradabad','2025-04-17');
--BOOK TABLE DATA
INSERT INTO books VALUES
(101,'SQL for Beginners','A. Kumar','Technology',399.00,45),
(102,'Advanced MySQL','R. Mehta','Technology',599.00,22),
(103,'Python Basics','N. Sharma','Technology',449.00,38),
(104,'Data Analytics with Excel','P. Verma','Technology',499.00,30),
(105,'Power BI in Practice','S. Gupta','Technology',649.00,18),
(106,'Rich Dad Poor Dad','Robert Kiyosaki','Finance',299.00,60),
(107,'The Psychology of Money','Morgan Housel','Finance',349.00,40),
(108,'Atomic Habits','James Clear','Self-Help',399.00,50),
(109,'Deep Work','Cal Newport','Self-Help',379.00,28),
(110,'The Alchemist','Paulo Coelho','Fiction',249.00,70),
(111,'Ikigai','Hector Garcia','Self-Help',299.00,35),
(112,'Clean Code','Robert C. Martin','Technology',799.00,12),
(113,'Think and Grow Rich','Napoleon Hill','Finance',279.00,44),
(114,'Harry Potter and the Philosopher''s Stone','J.K. Rowling','Fiction',499.00,25),
(115,'Storytelling with Data','Cole Nussbaumer','Technology',699.00,16);

--ORDER TABLE DATA
INSERT INTO orders VALUES
(1001,1,'2024-01-15','Completed','UPI'),
(1002,2,'2024-02-03','Completed','Card'),
(1003,3,'2024-02-18','Completed','UPI'),
(1004,1,'2024-03-12','Completed','Net Banking'),
(1005,4,'2024-04-05','Completed','UPI'),
(1006,5,'2024-04-22','Shipped','Card'),
(1007,6,'2024-05-14','Completed','UPI'),
(1008,7,'2024-06-08','Cancelled','Card'),
(1009,8,'2024-06-21','Completed','Cash on Delivery'),
(1010,9,'2024-07-10','Completed','UPI'),
(1011,2,'2024-08-19','Completed','Card'),
(1012,10,'2024-09-02','Completed','UPI'),
(1013,11,'2024-10-17','Returned','Card'),
(1014,3,'2024-11-11','Completed','UPI'),
(1015,5,'2024-12-03','Completed','Net Banking'),
(1016,12,'2025-01-14','Completed','UPI'),
(1017,1,'2025-01-28','Completed','Card'),
(1018,13,'2025-02-09','Completed','UPI'),
(1019,14,'2025-02-23','Pending','Card'),
(1020,15,'2025-03-05','Completed','UPI'),
(1021,7,'2025-03-16','Completed','Net Banking'),
(1022,8,'2025-04-04','Completed','UPI'),
(1023,9,'2025-04-18','Shipped','Card'),
(1024,10,'2025-05-07','Completed','UPI'),
(1025,4,'2025-05-22','Completed','Card'),
(1026,6,'2025-06-02','Completed','UPI'),
(1027,11,'2025-06-19','Completed','Net Banking'),
(1028,12,'2025-07-03','Cancelled','UPI'),
(1029,13,'2025-07-21','Completed','Card'),
(1030,14,'2025-08-12','Completed','UPI'),
(1031,15,'2025-09-06','Completed','Cash on Delivery'),
(1032,2,'2025-09-25','Completed','UPI'),
(1033,3,'2025-10-11','Completed','Card'),
(1034,1,'2025-10-19','Completed','UPI');

INSERT INTO order_items VALUES
(1,1001,101,2,399.00,0),(2,1001,106,1,299.00,5),
(3,1002,103,1,449.00,0),(4,1002,108,1,399.00,10),
(5,1003,107,2,349.00,0),(6,1003,111,1,299.00,0),
(7,1004,102,1,599.00,5),(8,1004,104,1,499.00,0),
(9,1005,110,3,249.00,0),(10,1005,113,1,279.00,0),
(11,1006,105,1,649.00,0),(12,1006,112,1,799.00,5),
(13,1007,108,2,399.00,0),(14,1007,109,1,379.00,0),
(15,1008,114,1,499.00,0),
(16,1009,106,2,299.00,0),(17,1009,107,1,349.00,0),
(18,1010,110,2,249.00,5),(19,1010,114,1,499.00,0),
(20,1011,101,1,399.00,0),(21,1011,103,2,449.00,5),
(22,1012,115,1,699.00,0),(23,1012,104,1,499.00,10),
(24,1013,112,1,799.00,0),
(25,1014,107,1,349.00,0),(26,1014,113,2,279.00,0),
(27,1015,105,1,649.00,0),(28,1015,108,1,399.00,0),
(29,1016,102,1,599.00,0),(30,1016,101,1,399.00,0),
(31,1017,103,1,449.00,0),(32,1017,115,1,699.00,5),
(33,1018,112,1,799.00,10),(34,1018,105,1,649.00,0),
(35,1019,109,1,379.00,0),
(36,1020,110,2,249.00,0),(37,1020,111,2,299.00,5),
(38,1021,108,1,399.00,0),(39,1021,107,1,349.00,0),
(40,1022,114,2,499.00,0),(41,1022,110,1,249.00,0),
(42,1023,104,1,499.00,0),(43,1023,115,1,699.00,0),
(44,1024,106,3,299.00,5),(45,1024,113,1,279.00,0),
(46,1025,101,1,399.00,0),(47,1025,102,1,599.00,10),
(48,1026,108,1,399.00,0),(49,1026,109,2,379.00,0),
(50,1027,103,1,449.00,0),(51,1027,105,1,649.00,5),
(52,1028,111,1,299.00,0),
(53,1029,115,1,699.00,0),(54,1029,112,1,799.00,0),
(55,1030,104,1,499.00,0),(56,1030,105,1,649.00,0),
(57,1031,107,2,349.00,0),(58,1031,106,1,299.00,0),
(59,1032,101,1,399.00,0),(60,1032,103,1,449.00,0),
(61,1033,108,1,399.00,5),(62,1033,111,1,299.00,0),
(63,1034,102,1,599.00,0),(64,1034,115,1,699.00,0);

-- Q1: Check duplicate customer emails (should return no rows).
SELECT email, COUNT(*) AS duplicate_count
FROM customers
GROUP BY email
HAVING COUNT(*) > 1;

-- Q2: Find orders without any order items (should return no rows).
SELECT o.order_id
FROM orders o
LEFT JOIN order_items oi ON o.order_id = oi.order_id
WHERE oi.order_id IS NULL;
-- Change the filter if your business defines Shipped orders differently.
-- Q3: Overall KPIs
SELECT
    COUNT(DISTINCT o.order_id) AS valid_orders,
    COUNT(DISTINCT o.customer_id) AS purchasing_customers,
    SUM(oi.quantity) AS books_sold,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_pct / 100)), 2) AS revenue
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.status IN ('Completed','Shipped');

---- Q4: Monthly revenue with month-over-month change (CTE + LAG window function)

WITH monthly_sales AS (
    SELECT
        FORMAT(o.order_date, 'yyyy-MM') AS sales_month,
        SUM(oi.quantity * oi.unit_price * (1 - oi.discount_pct / 100.0)) AS revenue
    FROM orders o
    JOIN order_items oi
        ON oi.order_id = o.order_id
    WHERE o.status IN ('Completed', 'Shipped')
    GROUP BY FORMAT(o.order_date, 'yyyy-MM')
),
monthly_comparison AS (
    SELECT
        sales_month,
        revenue,
        LAG(revenue) OVER (ORDER BY sales_month) AS previous_month_revenue
    FROM monthly_sales
)
SELECT
    sales_month,
    ROUND(revenue, 2) AS revenue,
    ROUND(previous_month_revenue, 2) AS previous_month_revenue,
    ROUND(revenue - previous_month_revenue, 2) AS revenue_change,
    ROUND(
        100.0 * (revenue - previous_month_revenue)
        / NULLIF(previous_month_revenue, 0),
        2
    ) AS growth_pct
FROM monthly_comparison
ORDER BY sales_month;

---- Q5: Top 10 books by revenue (JOIN + GROUP BY + ORDER BY)
SELECT TOP 10
    b.title,
    SUM(oi.quantity) AS units_sold,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM books b
JOIN order_items oi
    ON b.book_id = oi.book_id
JOIN orders o
    ON o.order_id = oi.order_id
WHERE o.status = 'Completed'
GROUP BY b.title
ORDER BY revenue DESC;
-- Q6: Revenue and units by genre
SELECT b.genre,
       SUM(oi.quantity) AS units_sold,
       ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_pct / 100)),2) AS revenue
FROM books b
JOIN order_items oi ON oi.book_id = b.book_id
JOIN orders o ON o.order_id = oi.order_id
WHERE o.status IN ('Completed','Shipped')
GROUP BY b.genre
ORDER BY revenue DESC;

-- Q7: Top 3 books in each genre (CTE + ROW_NUMBER)
WITH book_performance AS (
    SELECT b.genre, b.title,
           SUM(oi.quantity) AS units_sold,
           SUM(oi.quantity * oi.unit_price * (1 - oi.discount_pct / 100)) AS revenue
    FROM books b
    JOIN order_items oi ON oi.book_id = b.book_id
    JOIN orders o ON o.order_id = oi.order_id
    WHERE o.status IN ('Completed','Shipped')
    GROUP BY b.genre, b.book_id, b.title
),
ranked_books AS (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY genre ORDER BY revenue DESC) AS genre_rank
    FROM book_performance
)
SELECT genre, title, units_sold, ROUND(revenue,2) AS revenue, genre_rank
FROM ranked_books
WHERE genre_rank <= 3
ORDER BY genre, genre_rank;

-- Q8: Customers ranked by lifetime spending (CTE + DENSE_RANK)
WITH customer_spending AS (
    SELECT c.customer_id, c.customer_name, c.city,
           SUM(oi.quantity * oi.unit_price * (1 - oi.discount_pct / 100)) AS lifetime_spend,
           COUNT(DISTINCT o.order_id) AS order_count
    FROM customers c
    JOIN orders o ON o.customer_id = c.customer_id
    JOIN order_items oi ON oi.order_id = o.order_id
    WHERE o.status IN ('Completed','Shipped')
    GROUP BY c.customer_id, c.customer_name, c.city
)
SELECT customer_id, customer_name, city, order_count,
       ROUND(lifetime_spend,2) AS lifetime_spend,
       DENSE_RANK() OVER (ORDER BY lifetime_spend DESC) AS spending_rank
FROM customer_spending
ORDER BY spending_rank, customer_name;

-- Q9: Customers who spent more than the average customer spend (subquery)
SELECT customer_totals.customer_id, customer_totals.customer_name,
       ROUND(customer_totals.total_spend,2) AS total_spend
FROM (
    SELECT c.customer_id, c.customer_name,
           SUM(oi.quantity * oi.unit_price * (1 - oi.discount_pct / 100)) AS total_spend
    FROM customers c
    JOIN orders o ON o.customer_id = c.customer_id
    JOIN order_items oi ON oi.order_id = o.order_id
    WHERE o.status IN ('Completed','Shipped')
    GROUP BY c.customer_id, c.customer_name
) AS customer_totals
WHERE customer_totals.total_spend > (
    SELECT AVG(spend_per_customer)
    FROM (
        SELECT o.customer_id,
               SUM(oi.quantity * oi.unit_price * (1 - oi.discount_pct / 100)) AS spend_per_customer
        FROM orders o
        JOIN order_items oi ON oi.order_id = o.order_id
        WHERE o.status IN ('Completed','Shipped')
        GROUP BY o.customer_id
    ) AS average_customer_spend
)
ORDER BY total_spend DESC;

-- Q10: Books priced above their genre's average price (correlated subquery)
SELECT b.book_id, b.title, b.genre, b.list_price
FROM books b
WHERE b.list_price > (
    SELECT AVG(b2.list_price)
    FROM books b2
    WHERE b2.genre = b.genre
)
ORDER BY b.genre, b.list_price DESC;

-- Q11: Repeat customers (more than one valid order) using HAVING
SELECT c.customer_id, c.customer_name,
       COUNT(DISTINCT o.order_id) AS valid_order_count
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
WHERE o.status IN ('Completed','Shipped')
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(DISTINCT o.order_id) > 1
ORDER BY valid_order_count DESC, c.customer_name;

-- Q12: Order value distribution with NTILE quartiles (window function)
WITH order_values AS (
    SELECT o.order_id, o.customer_id, o.order_date,
           SUM(oi.quantity * oi.unit_price * (1 - oi.discount_pct / 100)) AS order_value
    FROM orders o
    JOIN order_items oi ON oi.order_id = o.order_id
    WHERE o.status IN ('Completed','Shipped')
    GROUP BY o.order_id, o.customer_id, o.order_date
)
SELECT order_id, customer_id, order_date, ROUND(order_value,2) AS order_value,
       NTILE(4) OVER (ORDER BY order_value) AS value_quartile
FROM order_values
ORDER BY order_value DESC;

-- Q13: Running cumulative revenue by order date (SUM window frame)
WITH daily_sales AS (
    SELECT o.order_date,
           SUM(oi.quantity * oi.unit_price * (1 - oi.discount_pct / 100)) AS daily_revenue
    FROM orders o
    JOIN order_items oi ON oi.order_id = o.order_id
    WHERE o.status IN ('Completed','Shipped')
    GROUP BY o.order_date
)
SELECT order_date, ROUND(daily_revenue,2) AS daily_revenue,
       ROUND(SUM(daily_revenue) OVER (
           ORDER BY order_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
       ),2) AS cumulative_revenue
FROM daily_sales
ORDER BY order_date;

-- Q14: Sales contribution percentage by genre (CTE + window aggregate)
WITH genre_sales AS (
    SELECT b.genre,
           SUM(oi.quantity * oi.unit_price * (1 - oi.discount_pct / 100)) AS revenue
    FROM books b
    JOIN order_items oi ON oi.book_id = b.book_id
    JOIN orders o ON o.order_id = oi.order_id
    WHERE o.status IN ('Completed','Shipped')
    GROUP BY b.genre
)
SELECT genre, ROUND(revenue,2) AS revenue,
       ROUND(100 * revenue / SUM(revenue) OVER (),2) AS revenue_share_pct
FROM genre_sales
ORDER BY revenue DESC;

-- Q15: Products never sold in a valid order (LEFT JOIN)
SELECT b.book_id, b.title, b.genre, b.stock_qty
FROM books b
LEFT JOIN (
    SELECT DISTINCT oi.book_id
    FROM order_items oi
    JOIN orders o ON o.order_id = oi.order_id
    WHERE o.status IN ('Completed','Shipped')
) sold ON sold.book_id = b.book_id
WHERE sold.book_id IS NULL;

-- Q16: Cancellation and return rate
SELECT
    COUNT(*) AS total_orders,

    SUM(CASE WHEN status = 'Cancelled' THEN 1 ELSE 0 END) AS cancelled_orders,

    SUM(CASE WHEN status = 'Returned' THEN 1 ELSE 0 END) AS returned_orders,

    ROUND(
        100.0 * SUM(CASE WHEN status = 'Cancelled' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS cancellation_rate_pct,

    ROUND(
        100.0 * SUM(CASE WHEN status = 'Returned' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS return_rate_pct

FROM orders;
-- Q17: Payment method performance
SELECT o.payment_method,
       COUNT(DISTINCT o.order_id) AS valid_orders,
       ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_pct / 100)),2) AS revenue
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.status IN ('Completed','Shipped')
GROUP BY o.payment_method
ORDER BY revenue DESC;
-- Q18: Stock risk — books with low inventory (threshold: fewer than 20 copies)
SELECT book_id, title, genre, stock_qty,
       CASE
           WHEN stock_qty < 10 THEN 'Critical'
           WHEN stock_qty < 20 THEN 'Low'
           ELSE 'Sufficient'
       END AS stock_status
FROM books
WHERE stock_qty < 20
ORDER BY stock_qty;

-- Q19: Latest order for each customer (ROW_NUMBER)
WITH customer_orders AS (
    SELECT c.customer_id, c.customer_name, o.order_id, o.order_date, o.status,
           ROW_NUMBER() OVER (PARTITION BY c.customer_id ORDER BY o.order_date DESC, o.order_id DESC) AS rn
    FROM customers c
    JOIN orders o ON o.customer_id = c.customer_id
)
SELECT customer_id, customer_name, order_id, order_date, status
FROM customer_orders
WHERE rn = 1
ORDER BY order_date DESC;

-- Q20: Compare each book's revenue with average revenue per book (CTE + subquery)
WITH book_revenue AS (
    SELECT b.book_id, b.title,
           COALESCE(SUM(CASE WHEN o.status IN ('Completed','Shipped')
               THEN oi.quantity * oi.unit_price * (1 - oi.discount_pct / 100) END),0) AS revenue
    FROM books b
    LEFT JOIN order_items oi ON oi.book_id = b.book_id
    LEFT JOIN orders o ON o.order_id = oi.order_id
    GROUP BY b.book_id, b.title
)
SELECT book_id, title, ROUND(revenue,2) AS revenue,
       ROUND((SELECT AVG(revenue) FROM book_revenue),2) AS avg_book_revenue,
       CASE WHEN revenue > (SELECT AVG(revenue) FROM book_revenue)
            THEN 'Above Average' ELSE 'At/Below Average' END AS performance
FROM book_revenue
ORDER BY revenue DESC;

-- END OF PROJECT
