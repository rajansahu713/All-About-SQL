--- Creating a User Table ---

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE,
    name VARCHAR(255)
    
);

--- To check the indexes in the users table ---

select *
from pg_indexes
where tablename = 'users'


--- Creating a Product Table ---
create table products (
    id SERIAL PRIMARY KEY,
    type VARCHAR,
    category varchar(255),
    price INT
)

--- Creating indexing for the product table ---
CREATE INDEX idx_product_category_price ON products(category, price);



-- Lets start creating some functions to generate 10000 records in products table---

-- Function to get random product type --
CREATE OR REPLACE FUNCTION random_product_type()
RETURNS VARCHAR AS $$
DECLARE
    types VARCHAR[] := ARRAY['Electronics', 'Clothing', 'Books', 'Food', 'Sports', 'Home', 'Beauty', 'Toys'];
BEGIN
    RETURN types[floor(random() * array_length(types, 1) + 1)];
END;
$$ LANGUAGE plpgsql;

-- Function to get random category based on type ---
CREATE OR REPLACE FUNCTION random_category(p_type VARCHAR)
RETURNS VARCHAR AS $$
DECLARE
    categories VARCHAR[];
BEGIN
    CASE p_type
        WHEN 'Electronics' THEN
            categories := ARRAY['Phones', 'Laptops', 'Tablets', 'Cameras', 'Accessories'];
        WHEN 'Clothing' THEN
            categories := ARRAY['Shirts', 'Pants', 'Dresses', 'Shoes', 'Jackets'];
        WHEN 'Books' THEN
            categories := ARRAY['Fiction', 'Non-Fiction', 'Science', 'History', 'Comics'];
        WHEN 'Food' THEN
            categories := ARRAY['Snacks', 'Beverages', 'Dairy', 'Fruits', 'Vegetables'];
        WHEN 'Sports' THEN
            categories := ARRAY['Football', 'Basketball', 'Tennis', 'Swimming', 'Fitness'];
        WHEN 'Home' THEN
            categories := ARRAY['Furniture', 'Decor', 'Kitchen', 'Bath', 'Garden'];
        WHEN 'Beauty' THEN
            categories := ARRAY['Skincare', 'Makeup', 'Haircare', 'Fragrance', 'Tools'];
        WHEN 'Toys' THEN
            categories := ARRAY['Action Figures', 'Board Games', 'Dolls', 'Educational', 'Outdoor'];
        ELSE
            categories := ARRAY['Other'];
    END CASE;
    
    RETURN categories[floor(random() * array_length(categories, 1) + 1)];
END;
$$ LANGUAGE plpgsql;

-- Function to get random price based on type ---
CREATE OR REPLACE FUNCTION random_price(p_type VARCHAR)
RETURNS INTEGER AS $$
BEGIN
    CASE p_type
        WHEN 'Electronics' THEN
            RETURN floor(random() * (2000 - 100 + 1) + 100);
        WHEN 'Clothing' THEN
            RETURN floor(random() * (200 - 20 + 1) + 20);    
        WHEN 'Books' THEN
            RETURN floor(random() * (100 - 10 + 1) + 10);     
        WHEN 'Food' THEN
            RETURN floor(random() * (50 - 5 + 1) + 5);   
        WHEN 'Sports' THEN
            RETURN floor(random() * (500 - 20 + 1) + 20);    
        WHEN 'Home' THEN
            RETURN floor(random() * (1000 - 50 + 1) + 50);   
        WHEN 'Beauty' THEN
            RETURN floor(random() * (200 - 10 + 1) + 10);     
        WHEN 'Toys' THEN
            RETURN floor(random() * (100 - 10 + 1) + 10);     
        ELSE
            RETURN floor(random() * 100 + 1);  
    END CASE;
END;
$$ LANGUAGE plpgsql;

-- This function will generate random products based on the number of records provided ---
CREATE OR REPLACE FUNCTION generate_products(num_records INTEGER)
RETURNS VOID AS $$
DECLARE
    p_type VARCHAR;
BEGIN
    FOR i IN 1..num_records LOOP
        p_type := random_product_type();
        INSERT INTO products (type, category, price)
        VALUES (
            p_type,
            random_category(p_type),
            random_price(p_type)
        );
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- Generate 10000 records ---
SELECT generate_products(10000);

---- Analyzing the query to check the query plan and to check weather it is taking advntage of index or not ----
EXPLAIN ANALYZE SELECT * FROM products WHERE category = 'electronics' AND price > 100;

EXPLAIN ANALYSE SELECT * FROM products WHERE category = 'electronics';

EXPLAIN ANALYSE SELECT * FROM products WHERE price > 150;

select count(*) from products