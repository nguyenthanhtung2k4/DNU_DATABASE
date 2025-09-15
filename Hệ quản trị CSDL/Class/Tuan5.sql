/*Bài tập 1: Lấy tên sản phẩm và tên danh mục 
Duyệt qua tất cả các sản phẩm trong bảng Products, in ra tên sản phẩm (ProductName) và tên danh mục (CategoryName).*/
-- Bài tập 1: Lấy tên sản phẩm và tên danh mục

-- Kiểm tra dữ liệu trong bảng
SELECT * FROM Products;
SELECT * FROM Categories;

-- Khai báo con trỏ
DECLARE products_cursor CURSOR FOR 
SELECT p.ProductName, c.CategoryName
FROM Products p
INNER JOIN Categories c ON p.CategoryID = c.CategoryID;

-- Khai báo biến để lưu giá trị
DECLARE @ProductName NVARCHAR(50);
DECLARE @CategoryName NVARCHAR(50);

-- Mở con trỏ
OPEN products_cursor;

-- Lấy giá trị đầu tiên
FETCH NEXT FROM products_cursor INTO @ProductName, @CategoryName;

-- Lặp qua con trỏ
WHILE @@FETCH_STATUS = 0 --  kiểm tra trạng thái con trỏ
BEGIN
    PRINT 'Product Name: ' + @ProductName 
    print ', Category Name: ' + @CategoryName;
    FETCH NEXT FROM products_cursor INTO @ProductName, @CategoryName;
END;

-- Đóng con trỏ và giải phóng tài nguyên
CLOSE products_cursor;
DEALLOCATE products_cursor;

/*Bài tập 2: Tính tổng doanh thu từng đơn hàng 
Duyệt qua bảng Order Details, tính tổng doanh thu của từng đơn hàng dựa trên công thức:
Doanh thu = UnitPrice * Quantity * (1 - Discount)
Lưu kết quả vào bảng tạm (#OrderRevenue).*/
GO;
CREATE FUNCTION total_order ()
RETURNS TABLE 
AS 
RETURN 
(   
    SELECT 
        od.OrderID, 
        SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS TotalRevenue
    FROM 
        [Order Details] od
    GROUP BY 
        od.OrderID
)
GO;
SELECT * FROM total_order(); 
/*Bài tập 3: Cập nhật trạng thái đơn hàng 
Kiểm tra các đơn hàng trong bảng Orders có trạng thái "Shipped". Nếu thời gian giao hàng lớn hơn 30 ngày so với ngày đặt hàng, cập nhật trạng thái thành "Delayed".*/


/*Bài tập 4: Xóa sản phẩm không có đơn hàng 
Xóa các sản phẩm trong bảng Products mà không có mặt trong bất kỳ đơn hàng nào trong bảng Order Details.*/


/*Bài tập 5: Tổng số lượng sản phẩm bán ra theo tháng
Tính tổng số lượng sản phẩm bán ra theo tháng và lưu vào bảng MonthlySales.*/