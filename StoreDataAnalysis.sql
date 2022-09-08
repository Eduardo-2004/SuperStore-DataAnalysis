
-- Find the maximum Quantity sold in a transaction // Encontre a quantidade máxima vendida em uma transação
SELECT MAX(Quantity) 'MaxQuantity', COUNT(*) 'QntTransactions' FROM TR_OrderDetails$

-- Find the unique Products in all the transactions // Encontre os Produtos exclusivos em todas as transações 
SELECT DISTINCT ProductID 
FROM TR_OrderDetails$
ORDER BY ProductID
GO

-- ProductId with MAX(Quantity) 
SELECT ProductID, Quantity 
FROM TR_OrderDetails$ 
WHERE Quantity IN(SELECT MAX(Quantity) FROM TR_OrderDetails$)
ORDER BY ProductID ASC, Quantity DESC 
GO

-- Also, find the unique Properties // Além disso, encontre as propriedades exclusivas
SELECT DISTINCT PropertyID 
FROM TR_OrderDetails$
ORDER BY PropertyID 
GO

-- Find the product category that has maximum products // Encontre a categoria de produto que tem o máximo de produtos

SELECT TOP 1 ProductCategory, COUNT(*) AS 'COUNT'
FROM TR_Products$ 
GROUP BY ProductCategory  
ORDER BY 2 DESC 
GO 

-- Find the state where most stores are present // Encontre o estado onde a maioria das lojas estão presentes
SELECT PropertyState, COUNT(PropertyCity) as 'COUNT' 
FROM TR_PropertyInfo$
GROUP BY PropertyState
ORDER BY 2 DESC
GO

-- Find the top 5 Products ID's that did maximum sales in terms os Quantity // Encontre os 5 IDs de produtos que mais venderam em termos de quantidade
SELECT TOP 5 ProductID, SUM(Quantity) 'QntProd'
FROM TR_OrderDetails$
GROUP BY ProductID
ORDER BY 2 DESC
GO

-- TOP 5 Total Earnings // TOP 5 Ganhos totais                                                                                                                                                                                                                                                                       g MORE DETAILS(PRICE, TotalEarnings)
SELECT TOP 5 O.ProductID,  P.ProductName, P.Price, SUM(O.Quantity) 'QntProd',  (P.Price * SUM(O.Quantity)) AS 'TotalEarnings'
FROM TR_OrderDetails$ AS O 
JOIN TR_Products$ AS P
ON O.ProductID = P.ProductID
GROUP BY O.ProductID, P.ProductName, P.Price
ORDER BY TotalEarnings DESC
GO

-- Similary, find the top 5 Property ID'S that did maximum Quantity // Encontre os 5 principais IDs de propriedades que têm as maiores quantidades (Quantity)
SELECT TOP 5 PropertyID, SUM(Quantity) AS 'QntProd'
FROM TR_OrderDetails$
GROUP BY PropertyID
ORDER BY 2 DESC 
GO

-- Find the top 5 Property ID'S that did maximum Quantity *with the name of PropertyState and PropertyCity* // Encontre os 5 principais IDs de propriedades que têm as maiores quantidades (Quantity) *com o nome de PropertyState e PropertyCity*
SELECT TOP 5 O.PropertyID, I.PropertyState, I.PropertyCity, SUM(O.Quantity) AS 'QntProd'
FROM TR_OrderDetails$ O
JOIN TR_PropertyInfo$ I
ON O.PropertyID = I.[Prop ID]
GROUP BY O.PropertyID, I.PropertyState, I.PropertyCity
ORDER BY 4 DESC
GO

-- Find the Products names that did maximum sales in terms of Quantity // Encontre os nomes dos produtos que fizeram vendas máximas em termos de quantidade
SELECT P.ProductName, O.Quantity 
FROM TR_Products$ AS P 
JOIN TR_OrderDetails$ AS O
ON P.ProductID = O.ProductID
WHERE O.Quantity IN(SELECT MAX(Quantity) FROM TR_OrderDetails$)
GROUP BY P.ProductName, O.Quantity 
GO

-- Find the top 5 Cities that did maximum sales // Encontre as 5 principais cidades que fizeram vendas máximas
SELECT TOP 5 I.PropertyCity, (SUM(O.Quantity) * P.Price) as 'TotalEarnings'
FROM TR_PropertyInfo$ AS I
JOIN TR_OrderDetails$ AS O
ON I.[Prop ID] = O.PropertyID
JOIN TR_Products$ AS P
ON O.ProductID = P.ProductID
GROUP BY I.PropertyCity, P.Price
ORDER BY TotalEarnings DESC 
GO

-- Find the top 5 products in each os the Cities // Encontre os 5 principais produtos em cada uma das Cidades
SELECT TOP 5 I.PropertyCity, P.ProductName,(SUM(O.Quantity) * P.Price) as 'TotalEarnings'
FROM TR_PropertyInfo$ AS I
JOIN TR_OrderDetails$ AS O
ON I.[Prop ID] = O.PropertyID
JOIN TR_Products$ AS P
ON O.ProductID = P.ProductID
WHERE I.PropertyCity = 'Portland'
GROUP BY I.PropertyCity, P.Price, P.ProductName
ORDER BY TotalEarnings DESC 
GO

--Find the top 5 products in each os the States // Encontre os 5 principais produtos em cada um dos Estados
SELECT TOP 5 I.PropertyState, P.ProductName, (SUM(O.Quantity) * P.Price) as 'TotalEarnings'
FROM TR_PropertyInfo$ AS I
JOIN TR_OrderDetails$ AS O
ON I.[Prop ID] = O.PropertyID
JOIN TR_Products$ AS P
ON O.ProductID = P.ProductID
WHERE I.PropertyState = 'California'
GROUP BY I.PropertyState, P.Price, P.ProductName
ORDER BY TotalEarnings DESC 
GO