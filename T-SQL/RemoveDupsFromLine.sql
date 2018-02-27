
SELECT Line , MAX(ListOrder) as Expr1
INTO tempTable FROM Line GROUP BY Line

GO

DELETE FROM Line

GO

INSERT INTO Line (Line,  ListOrder, Agency)
SELECT Line, Expr1, 'All' FROM tempTable

GO

DROP TABLE tempTable
