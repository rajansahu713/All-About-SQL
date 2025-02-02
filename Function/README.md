## Beginner SQL Functions
This file contains several beginner-level SQL functions written in PL/pgSQL. Each function demonstrates different aspects of SQL function creation and usage.

### Functions
#### 1. `without_declear_variable`
This function demonstrates how to use parameters without declaring variables.

* Function Definition: `CREATE or REPLACE FUNCTION without_declear_variable(VARCHAR, INTEGER, INTEGER) RETURNS VARCHAR`
* Usage: `SELECT * from without_declear_variable('software', 3, 3)`;
#### 2. `fn_mid`
This function shows how to declare aliases for parameters and use them inside the function.

* Function Definition: `CREATE or REPLACE FUNCTION fn_mid(VARCHAR, INTEGER, INTEGER) RETURNS VARCHAR`
* Usage: `SELECT * FROM fn_mid('software', 1, 5);`
### 3. `fn_mid_parameter`
This function returns a substring based on the given start and end positions.

* Function Definition: `CREATE or REPLACE FUNCTION fn_mid_parameter(word VARCHAR, start_pos INTEGER, end_pos INTEGER) RETURNS VARCHAR`
* Usage: `SELECT * from fn_mid_parameter('software', 2, 2);`
#### 4. `fnMakeFull`
This function demonstrates the use of IF ELSE statements in a function.

* Function Definition: `CREATE or REPLACE FUNCTION fnMakeFull(firstName VARCHAR, lastName VARCHAR) RETURNS VARCHAR`
* Usage: `SELECT * from fnMakeFull('Rajan', NULL);`
#### 5. `SwapTwo`
This function swaps two numbers.

* Function Definition: `CREATE or REPLACE FUNCTION SwapTwo(inout num1 int, inout num2 int)`
* Usage: `SELECT * from SwapTwo(30, 50);`
#### 6. `fnMean`
This function calculates the mean of a given array and demonstrates the use of a FOR LOOP.

* Function Definition: `CREATE or REPLACE FUNCTION fnMean(NUMERIC[]) RETURNS NUMERIC`
* Usage: `SELECT * from fnMean(ARRAY[10, 20, 40, 50, 40]);`
#### 7. `GetAuthor`
This function demonstrates the use of a WHERE clause in a function and returns the value.

* Function Definition: `CREATE or REPLACE FUNCTION GetAuthor(author_id INTEGER) RETURNS TABLE(id INTEGER, name TEXT)`
* Usage: `SELECT * FROM GetAuthor(1);`
#### 8. `addTWO`
This function adds two numbers and returns the value.

* Function Definition: `CREATE or REPLACE FUNCTION addTWO(num1 INTEGER, num2 INTEGER) RETURNS NUMERIC`
* Usage: `SELECT * from addTWO(4, 6);`
