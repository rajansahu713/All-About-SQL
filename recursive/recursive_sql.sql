---- Example 1 -----

WITH RECURSIVE numbers AS (
    SELECT 1 AS num  -- Anchor query: start with 1
    UNION ALL
    SELECT num + 1   -- Recursive query: add 1 to the previous number
    FROM numbers
    WHERE num < 10   -- Termination condition: stop at 10
)
SELECT * FROM numbers;
----------------------------------------------------------------------

---- Example 2 ----
CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    manager_id INT NULL
);

--- modifying the employing table --=
ALTER TABLE employees
ADD CONSTRAINT fk_manager
FOREIGN KEY (manager_id)
REFERENCES employees (emp_id)
ON DELETE SET NULL;

--- inserting records ---
INSERT INTO employees (name, manager_id) VALUES
('Alice', NULL),
('Bob', 1),
('Pankaj', 1),
('Rahul', 3);

--- final query ---
WITH RECURSIVE employee_hierarchy AS (
    SELECT emp_id, name, manager_id
    FROM employees
    WHERE name = 'Alice'  -- Start with Alice
    UNION ALL
    SELECT e.emp_id, e.name, e.manager_id
    FROM employees e
    JOIN employee_hierarchy eh ON e.manager_id = eh.emp_id
)
SELECT * FROM employee_hierarchy;
---------------------------------------------------------------------


--- Example 3 ---
WITH RECURSIVE factorials AS (
    SELECT 1 AS n, 1 AS fact  -- Anchor: 1! = 1
    UNION ALL
    SELECT n + 1, fact * (n + 1)  -- Recursive: multiply current fact by next number
    FROM factorials
    WHERE n < 5  -- Terminate after 5!
)
SELECT * FROM factorials;
---------------------------------------------------------

--- Example 4 ------------
CREATE TABLE graph (
    src INT,
    dest INT,
    cost INT
);

--- inserting records to graph table ----
INSERT INTO graph (src, dest, cost) VALUES
(1, 2, 1),
(2, 3, 1),
(3, 4, 1),
(1, 4, 10);

--- final query to get shorts path from 1 to 4
WITH RECURSIVE shortest_path AS (
    SELECT src, dest, cost, ARRAY[src] AS path
    FROM graph
    WHERE src = 1  -- Start at node 1
    UNION ALL
    SELECT g.src, g.dest, sp.cost + g.cost, path || g.dest
    FROM graph g
    JOIN shortest_path sp ON g.src = sp.dest
    WHERE NOT g.dest = ANY(path)  -- Avoid cycles
)
SELECT path, cost
FROM shortest_path
WHERE dest = 4
ORDER BY cost ASC
LIMIT 1;
------------------------------------------------------


---- Example 5 --------
CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    parent_id INT NULL
);

INSERT INTO categories (name, parent_id) VALUES
('Electronics', NULL),
('Mobiles', 1),
('Smartphones', 2),
('Laptops', 1),
('Gaming Laptops', 4);


WITH RECURSIVE category_tree AS (
    SELECT id, name, parent_id
    FROM categories
    WHERE name = 'Electronics'  -- Start with Electronics
    UNION ALL
    SELECT c.id, c.name, c.parent_id
    FROM categories c
    JOIN category_tree ct ON c.parent_id = ct.id
)
SELECT * FROM category_tree;
-----------------------------------------------




