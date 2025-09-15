SELECT  TOP 5 
          c.CustomerID,
          c.CompanyName,
          SUM(od.UnitPrice * od.Quantity) AS totalBUY
FROM Customers c 
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN [Order Details] od  ON o.OrderID=od.OrderID
GROUP By c.CustomerID , c.CompanyName
ORDER BY totalBUY DESC;