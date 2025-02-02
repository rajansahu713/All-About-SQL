------------- This function show how to use parameter with out declaring the variable ----
CREATE or REPLACE FUNCTION without_declear_variable(VARCHAR, INTEGER, INTEGER)
RETURNS VARCHAR
as
$$
BEGIN
    return substring($1, $2,$3);
END;
$$
LANGUAGE PLPGSQL;

SELECT * from without_declear_variable('software',3,3)

---------- this function how to declear alias for the parameter and use it inside the function ----
CREATE or REPLACE FUNCTION fn_mid(VARCHAR, INTEGER, INTEGER)
RETURNS VARCHAR
as
$$
DECLARE 
    word ALIAS FOR $1;
    startpos ALIAS FOR $2;
    cnt ALIAS FOR $3;
BEGIN
    return substring(word, startpos,cnt);
END;
$$
LANGUAGE PLPGSQL;

select * FROM fn_mid('software', 1,5)

----- This is use to return string which will come under the given position (start_pos, end_pos) ----
CREATE or REPLACE FUNCTION fn_mid_parameter(word VARCHAR,start_pos INTEGER,end_pos INTEGER)
RETURNS VARCHAR
as
$$
BEGIN
    return substring(word, startPos, end_pos);
END;
$$
LANGUAGE PLPGSQL;

SELECT * from fn_mid_parameter('software',2,2)


-------- This use to demostrate the use of if else in function ----
CREATE or REPLACE FUNCTION fnMakeFull(firstName VARCHAR, lastName VARCHAR)
RETURNS VARCHAR
as
$$
BEGIN

    if firstName is NULL and lastName is NULL THEN
        return NULL;
    
    ELSEIF firstName is NULL and lastName is not NULL THEN
        return lastName;
    
    ELSEIF firstName is not NULL and lastName is  NULL THEN
        return firstName;

    else 
        return firstName || ' ' || lastName;
    end if;

END;
$$
LANGUAGE PLPGSQL;

SELECT * from fnmakefull('Rajan', null)

----------- This is use to swap the two number ----
CREATE or REPLACE FUNCTION SwapTwo(inout num1 int, inout num2 int)
as
$$
begin 
    select num1, num2 into num2, num1;
end;
$$
LANGUAGE PLPGSQL;

SELECT * from swaptwo(30, 50)

------------- This is use to find the mean of the given array and how to use for loop ----
create or REPLACE FUNCTION fnMean(NUMERIC[])
returns NUMERIC
as
$$
DECLARE 
    total NUMERIC := 0;
    val NUMERIC;
    cnt int :=0;
    n_array alias for $1;
begin
    foreach val in array n_array
    LOOP
        total := total + val;
        cnt := cnt +1;
    end LOOP;

    return total/cnt;
end;
$$
LANGUAGE PLPGSQL;

select * from fnMean(Array[10, 20,40,50,40])

-----------  This how to use where clause in function and return the value ----
DROP FUNCTION GetAuthor; 
CREATE or REPLACE FUNCTION GetAuthor(author_id INTEGER)
RETURNS table(
    id INTEGER,
    name TEXT
)
AS
$$
BEGIN
    RETURN query
    select au.id, au.name from author au where au.id = author_id;
end;
$$
LANGUAGE PLPGSQL;

SELECT * FROM GetAuthor(1)
 
---------  This is use to add two number and return the value ---
CREATE or REPLACE FUNCTION addTWO(num1 INTEGER, num2 INTEGER)
returns NUMERIC
as 
$$
BEGIN
    return num1 + num2;
end;
$$
LANGUAGE PLPGSQL;

select * from addtwo(4,6)