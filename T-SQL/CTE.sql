-- Using Common Table Expressions

WITH CTE(EmployeeName, empcode, managercode) AS
(
    SELECT EmployeeName,empcode,managercode
    FROM EMP WHERE empcode=8

    UNION ALL

    SELECT e.EmployeeName,e.empcode,e.managercode
    FROM EMP e
    INNER JOIN CTE c ON e.empcode = c.managercode
)
SELECT * FROM CTE