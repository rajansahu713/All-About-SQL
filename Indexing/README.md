# Indexing Part 1

This file contains SQL scripts for creating tables, indexes, and functions to generate and analyze data in a PostgreSQL database.

## Contents

### User Table
- **Table Creation**: Creates a `users` table with columns `id`, `email`, and `name`.
- **Index Check**: Queries the indexes on the `users` table.

### Product Table
- **Table Creation**: Creates a `products` table with columns `id`, `type`, `category`, and `price`.
- **Index Creation**: Creates an index on the `category` and `price` columns of the `products` table.

### Functions
- **Random Product Type**: Generates a random product type.
- **Random Category**: Generates a random category based on the product type.
- **Random Price**: Generates a random price based on the product type.
- **Generate Products**: Generates a specified number of random products and inserts them into the `products` table.

### Data Generation
- **Generate 10,000 Products**: Calls the `generate_products` function to insert 10,000 random products into the `products` table.

### Query Analysis
- **Explain Analyze**: Analyzes queries to check if they are taking advantage of the index on the `products` table.

## Usage

1. **Create Tables**: Run the scripts to create the `users` and `products` tables.
2. **Create Indexes**: Run the script to create the index on the `products` table.
3. **Create Functions**: Run the scripts to create the functions for generating random data.
4. **Generate Data**: Call the `generate_products` function to insert random data into the `products` table.
5. **Analyze Queries**: Use `EXPLAIN ANALYZE` to check the performance of queries on the `products` table.

This script helps in understanding the creation and usage of indexes in PostgreSQL, as well as generating and analyzing large datasets.