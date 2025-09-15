--1. Liệt kê 5 khách hàng mua hàng nhiều nhất (dựa vào tổng tiền hàng), 
--sắp xếp giảm dần.
SELECT TOP 5
	c.CustomerID,
	c.CompanyName,
	SUM(od.UnitPrice * od.Quantity) AS TotalSpent
FROM Customers c
JOIN Orders o ON c.CustomerID=o.CustomerID
JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID, c.CompanyName
ORDER BY TotalSpent DESC;


--2. Tính doanh thu trung bình hàng tháng của từng năm.
SELECT
	YEAR(o.OrderDate) AS OrderYear,
	MONTH(o.OrderDate) AS OrderMonth,
	AVG(od.UnitPrice * od.Quantity) AS Avgmonth
FROM Orders o
JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY YEAR(o.OrderDate), MONTH(o.OrderDate)
ORDER BY OrderYear, OrderMonth;

--3. Lấy thông tin về các đơn hàng, và tên các sản phẩm 
-- thuộc các đơn hàng chưa được giao cho khách.

/*Hàm 
1. LEN()
Tính độ dài tên các sản phẩm trong bảng Products.*/
SELECT
	ProductName,
	LEN(ProductName) AS Namelength
FROM Products;

--2. UPPER() và LOWER()
-- Chuyển đổi tên các sản phẩm thành chữ hoa và chữ thường.

--3. SUBSTRING()thưởng
-- Lấy 5 ký tự đầu tiên trong tên các sản phẩm.
SELECT
	ProductName,
	SUBSTRING(ProductName, 1, 5) AS FIVECHARS
FROM Products;

--HÀM SỐ HỌC
-- Hàm ABS()
-- Tính giá trị tuyệt đối của sự chênh lệch giữa giá gốc (UnitPrice) 
--và giá chiết khấu trong bảng Order Details.
SELECT
          ProductID,
          UnitPrice,
          ABS(UnitPrice - Discount) AS AdjustedPrice
FROM [Order Details]
ORDER BY AdjustedPrice


-- Hàm ROUND()
--Làm tròn giá sản phẩm đến 2 chữ số thập phân.
SELECT
  ProductID,
  UnitPrice,
  Quantity,
  ROUND(SUM(UnitPrice * Quantity), 2) AS TotalMoney
FROM [Order Details]
GROUP BY ProductID,UnitPrice,Quantity
ORDER BY TotalMoney

--*Hàm tổng hợp 
--1. Tính giá trung bình của các sản phẩm trong bảng Products
SELECT * FROM Products
SELECT 
    AVG(UnitPrice) AS AverageUnitPrice
FROM Products;


--2. Đếm số lượng đơn hàng đã được giao.

 SELECT 
          COUNT(ShippedDate) AS TotalOrders
 FROM Orders
 WHERE ShippedDate IS NOT NULL;

--3. Tính tổng doanh thu của từng đơn hàng.
--* Hàm PIVOT 
--1. Tính tổng doanh thu theo năm và nhân viên

SELECT * FROM Employees
SELECT * FROM Orders
SELECT * FROM [Order Details]


SELECT 
	e.EmployeeID,
	YEAR(o.orderDate) AS YEAR,
	CONCAT(e.LastName, ' ', e.FirstName) AS Name,
	SUM(od.UnitPrice * od.Quantity) AS TotalSpent

FROM Orders o
JOIN Employees e ON o.EmployeeID = e.EmployeeID
JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY YEAR(o.orderDate), e.EmployeeID, e.LastName, e.FirstName
ORDER BY [YEAR]
--2. Đếm số lượng đơn hàng theo trạng thái giao hàng
SELECT * FROM Shippers
SELECT * FROM Orders WHERE ShippedDate IS NULL
--3. Tính tổng số lượng sản phẩm bán ra theo danh mục sản phẩm (Categories)
SELECT * FROM Categories
SELECT * FROM [Order Details]
SELECT *  FROM Products


SELECT TOP 10
          p.ProductName,
	c.CategoryName,
	SUM(od.Quantity) AS TotalQuantity
FROM Products p
JOIN [Order Details] od ON p.ProductID = od.ProductID
JOIN Categories c ON p.CategoryID = c.CategoryID
GROUP BY p.ProductName, c.CategoryName
ORDER BY TotalQuantity DESC
--4. Tính tổng doanh thu theo tháng
SELECT * FROM  [Orders]



SELECT
	YEAR(OrderDate) AS Year,
          MONTH(OrderDate) AS Month,
          SUM(UnitPrice * Quantity) AS TotalSpent
	FROM [Orders] o
	join [Order Details] od  ON o.OrderID = od.OrderID
	GROUP BY YEAR(OrderDate), MONTH(OrderDate)
	-- ORDER BY Year, Month
	ORDER BY TotalSpent DESC




--  Hiện ra tháng  có số tiền cao nhất của từng năm
WITH CTE_TotalSpent AS (
    SELECT 
        YEAR(OrderDate) AS Year,
        MONTH(OrderDate) AS Month,
        SUM(UnitPrice * Quantity) AS TotalSpent,
        ROW_NUMBER() OVER (PARTITION BY YEAR(OrderDate) ORDER BY SUM(UnitPrice * Quantity) DESC) AS Rank
    FROM [Orders] o
    JOIN [Order Details] od ON o.OrderID = od.OrderID
    GROUP BY YEAR(OrderDate), MONTH(OrderDate)
)
SELECT 
    Year, 
    Month, 
    TotalSpent
FROM CTE_TotalSpent
WHERE Rank = 1
ORDER BY Year;

--* Biến toàn cục
--1.Sử dụng biến toàn cục @@ROWCOUNT để kiểm tra số bản ghi được cập nhật trong bảng Orders.
--* Bảng tạm cục bộ
--Tạo một bảng tạm cục bộ lưu thông tin sản phẩm (ProductID, ProductName, UnitPrice) với giá lớn hơn 50 và hiển thị dữ liệu trong bảng.

--* Bảng tạm toàn cục
--Tạo một bảng tạm toàn cục lưu trữ danh sách khách hàng từ Hoa Kỳ.

--*Xử lý NULL với ISNULL
-- Thay thế giá trị NULL trong UnitsOnOrder bằng 0 khi hiển thị thông tin sản phẩm