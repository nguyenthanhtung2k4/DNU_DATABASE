
SELECT
          YEAR(o.OrderDate) As  YearOrder,
          MONTH(o.OrderDate) As  MonthOrder,
          CONCAT(Format(AVG(od.UnitPrice * od.Quantity),'###.###'), ' VND') AS TB_MONTH
          
FROM Orders o
JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY YEAR(o.OrderDate),MONTH(o.OrderDate)
HAVING    AVG(od.UnitPrice * od.Quantity)>700
ORDER BY YearOrder,MonthOrder;