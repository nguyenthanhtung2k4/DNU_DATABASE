/*I. KHUNG NHÌN (VIEW)
Mục tiêu bài thực hành
1.	Tạo View phức tạp với nhiều bảng và các phép tính nâng cao.
2.	Sử dụng View để thực hiện các truy vấn phức tạp.
3.	Thực hành quản lý View: cập nhật và xóa View.
*/
--1: Tạo View hiển thị doanh thu theo từng khách hàng
/*Tạo một View có tên CustomerRevenueView để hiển thị doanh thu của từng khách hàng.
• Bảng liên quan:
- Customers: Chứa thông tin khách hàng.
- Orders: Chứa thông tin các đơn hàng.
- OrderDetails: Chứa thông tin chi tiết các đơn hàng.
Yêu cầu View:
- CustomerID
- CompanyName
- TotalRevenue (tổng doanh thu của khách hàng, tính bằng SUM(Quantity * UnitPrice * (1 - Discount))).*/

CREATE VIEW CustomerRevenueView AS
SELECT
          c.CustomerID,
          c.CompanyName,
          SUM(od.Quantity * od.UnitPrice * (1 - Discount)) AS TotalRevenue
FROM Customers c
JOIN Orders o on  c.CustomerID = o.CustomerID
JOIN [Order Details] od ON od.OrderID = o.OrderID
GROUP BY c.CustomerID , c.CompanyName
--   Xem dữ liệu trong view 
GO
SELECT * FROM CustomerRevenueView

SELECT * FROM [Order Details]
--2: Tạo View hiển thị sản phẩm bán chạy nhất
SELECT * FROM Products
SELECT * FROM [Order Details]
GO
CREATE VIEW TopProductsView AS
SELECT TOP 5
          p.ProductID,
          p.ProductName,
          SUM(od.Quantity) AS TotalSales
FROM  Products p
JOIN [Order Details] od ON od.ProductID = p.ProductID
GROUP BY p.ProductID  , p.ProductName
ORDER BY TotalSales DESC

--  Lay du  lieu View  Top  Procuts
GO
SELECT * FROM TopProductsView


--3: Tạo View hiển thị hiệu suất của nhân viên
SELECT 
          e.EmployeeID,
          e.LastName+' '+e.FirstName AS nameEmaployees,
          -- Tong so ode ban ra  cua tung nhan vien
          SUM(o.OrderID) AS TotalOrder,
          --  tong so so tien ban ra cua tung nhan vien
          SUM(od.Quantity * od.UnitPrice *(1- od.Discount)) AS TotalRevenue

FROM Employees e
JOIN Orders o ON o.EmployeeID = e.EmployeeID
JOIN [Order Details] od ON od.OrderID = o.OrderID
GROUP BY e.EmployeeID , e.LastName, e.FirstName

--3: Tạo View hiển thị hiệu suất của nhân viên
GO
CREATE VIEW EmployeePerformanceView AS
SELECT 
          e.EmployeeID,
          e.LastName+' '+e.FirstName AS EmployeeName,
          -- Tong so ode ban ra  cua tung nhan vien
          COUNT(o.OrderID) AS TotalOrder,
          --  tong so so tien ban ra cua tung nhan vien
          SUM(od.Quantity * od.UnitPrice *(1- od.Discount)) AS TotalRevenue

FROM Employees e
JOIN Orders o ON o.EmployeeID = e.EmployeeID
JOIN [Order Details] od ON od.OrderID = o.OrderID
GROUP BY e.EmployeeID , e.LastName, e.FirstName

--4: Tạo View hiển thị sản phẩm chưa từng được đặt hàng
GO 
CREATE VIEW ProductsNeverOrdered_View AS
SELECT 
    p.ProductID,
    p.ProductName,
    p.CategoryID,
    p.SupplierID	
FROM Products p
JOIN [Order Details] od ON p.ProductID = od.ProductID
WHERE od.ProductID IS NULL


--*Thêm Dữ Liệu vào View
--Các View là bảng ảo, do đó không thể thêm dữ liệu trực tiếp vào một View. 
--Tuy nhiên, có thể thực hiện thêm dữ liệu vào các bảng cơ sở mà View sử dụng, từ đó làm thay đổi kết quả của View.

--*Cập Nhật Dữ Liệu trong View. Không thể trực tiếp cập nhật dữ liệu trong View. 
--Tuy nhiên, có thể cập nhật dữ liệu trong các bảng cơ sở mà View sử dụng, và thay đổi các kết quả hiển thị trong View.
--Ví dụ: Cập nhật số lượng sản phẩm trong một đơn hàng



--*Sửa Đổi (Thay Đổi Cấu Trúc) của View
--Để thay đổi cấu trúc của một View, cần xóa View cũ và tạo lại View với cấu trúc mới.


--*Cập Nhật Dữ Liệu trong View
--Không thể trực tiếp cập nhật dữ liệu trong View. 
--Tuy nhiên, có thể cập nhật dữ liệu trong các bảng cơ sở mà View sử dụng, và thay đổi các kết quả hiển thị trong View.




--5: Sử dụng View đã tạo để trả lời câu hỏi
--*Lấy danh sách các khách hàng có doanh thu lớn hơn $50,000 từ CustomerRevenueView.




--*Lấy danh sách 5 sản phẩm bán chạy nhất từ TopSellingProductsView.

--*Lấy danh sách nhân viên xử lý ít hơn 50 đơn hàng từ EmployeePerformanceView.

--*Lấy danh sách sản phẩm có giá lớn hơn $20 mà chưa từng được đặt hàng từ UnorderedProductsView.



--6: Xóa và cập nhật View
--*Xóa View TopSellingProductsView.

--*Cập nhật View CustomerRevenueView để chỉ hiển thị khách hàng có ít nhất 5 đơn hàng.
GO

ALTER VIEW CustomerRevenueView AS
SELECT
    c.CustomerID,
    c.CompanyName,
    SUM(od.Quantity * od.UnitPrice * (1- od.Discount)) AS TotalRevenue
FROM Customers c
JOIN Orders  o ON c.CustomerID = o.CustomerID
JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID, c.CompanyName
HAVING  COUNT(o.OrderID) >=5;
--  Lay du lieu moi  trong 

--7: Tạo View hiển thị hiệu quả kinh doanh của từng nhân viên bán hàng

--8: Tạo View hiển thị khách hàng có số lượng đơn hàng lớn nhất

--9. Tạo View hiển thị sản phẩm có mức giảm giá cao nhất trong từng đơn hàng

--10: Sử dụng View để phân tích dữ liệu
--*Lấy danh sách nhân viên có doanh thu cao nhất từ SalesPerformanceView.

--*Lấy danh sách 3 khách hàng hàng đầu dựa trên tổng số đơn hàng từ TopCustomersView.


/*II. CHỈ MỤC (INDEX)
1.	Tạo các chỉ mục khác nhau để cải thiện hiệu suất truy vấn.

2.	Thao tác trên chỉ mục: kiểm tra, xóa, và tái tạo chỉ mục.*/

/*Phần 1: Tạo Index
Bài tập 1: Tạo chỉ mục đơn giản. Yêu cầu: Tạo chỉ mục không phân cụm (non-clustered index) trên cột Country của bảng Customers.*/
GO

CREATE NONCLUSTERED INDEX IX_Customers_Country
ON Customers (Country)
--  hủy Index 
DROP  INDEX IX_Customers_Country;

--Bài tập 2: Tạo chỉ mục kết hợp. Yêu cầu: Tạo chỉ mục kết hợp (composite index) trên các cột OrderDate và ShipCountry của bảng Orders để tối ưu hóa truy vấn tìm kiếm theo ngày đặt hàng và quốc gia giao hàng.
GO

CREATE INDEX NONCLUSTERED INDEX IX_OrderDate_ShipCountry
ON Orders (OrderDate, ShipCountry);
--  hủy Index
DROP INDEX IX_OrderDate_ShipCountry;
--Bài tập 3: Tạo chỉ mục với UNIQUE. Yêu cầu: Tạo chỉ mục duy nhất (unique index) trên cột ProductName của bảng Products để đảm bảo tên sản phẩm không bị trùng lặp.

--Bài tập 4: Tạo chỉ mục CLUSTERED. Yêu cầu: Tạo chỉ mục phân cụm (clustered index) trên cột OrderID của bảng Orders để tối ưu hóa các truy vấn tìm kiếm theo khóa chính.

--Phần 2: Các thao tác trên Index
--Bài tập 5: Kiểm tra các chỉ mục hiện tại. Yêu cầu: Sử dụng câu lệnh sau để liệt kê danh sách các chỉ mục đã tạo trong cơ sở dữ liệu.
GO 

SELECT
    OBJECT_NAME(IX.object_id) AS tableName,
    IX.name AS IndexName,
    IX.type_desc AS IndexType,
    IX.is_unique AS IsUnique
FROM sys.indexes IX
WHERE OBJECT_NAME(IX.object_id) IS NOT NULL;
--Bài tập 6: Tái tạo (Rebuild) chỉ mục. Yêu cầu: Tái tạo chỉ mục IX_Customers_Country để tối ưu hóa hiệu suất sau khi dữ liệu thay đổi.
GO 

ALTER INDEX IX_Customers_Country 
ON Customers
Rebuild
--Bài tập 7: Tái tổ chức (Reorganize) chỉ mục.Yêu cầu: Tái tổ chức chỉ mục IX_Orders_OrderDate_ShipCountry để giảm phân mảnh (fragmentation).
ALTER INDEX IX_Orders_OrderDate_ShipCountry
ON Orders
REORGANIZE;
--Bài tập 8: Xóa chỉ mục. Yêu cầu: Xóa chỉ mục IX_Products_ProductName để thực hiện thử nghiệm tốc độ truy vấn khi không có chỉ mục.

--Bài tập 9: Xem mức độ phân mảnh của chỉ mục. Yêu cầu: Kiểm tra mức độ phân mảnh (fragmentation) của tất cả các chỉ mục trên bảng Orders.


--Phần 3: Thử nghiệm và đánh giá hiệu suất
--1.So sánh hiệu suất truy vấn trước và sau khi tạo chỉ mục:
--o Truy vấn không có chỉ mục:

--o Truy vấn có chỉ mục:


--Kiểm tra chỉ mục hiện tại trong cơ sở dữ liệu:


