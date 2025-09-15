/*Hàm trả về giá trị vô hướng
Bài tập 1: Tính giá trị chiết khấu của một đơn hàng 
Tạo một hàm nhận OrderID làm tham số và trả về tổng giá trị chiết khấu.*/

/*Bài tập 2: Kiểm tra số lượng sản phẩm trong kho 
Tạo một hàm nhận ProductID làm tham số và trả về số lượng sản phẩm hiện có trong kho.

/*Bài tập 3: Tính doanh thu của một đơn hàng 
Tạo một hàm nhận OrderID làm tham số và trả về tổng doanh thu của đơn hàng.*/

/*Bài tập 4: Kiểm tra trạng thái giao hàng 
Tạo một hàm nhận OrderID làm tham số và trả về trạng thái giao hàng:
•	Delivered nếu ShippedDate khác NULL.
•	Pending nếu ngược lại.*/


/*Bài tập 5: Tính tổng số lượng sản phẩm bán được cho một khách hàng
Tạo một hàm nhận CustomerID làm tham số và trả về tổng số lượng sản phẩm mà khách hàng đã mua.*/--Hàm người dùng định nghĩa
--Bài tập 1: Kiểm tra khách hàng có phải VIP hay không 
--Tạo một hàm nhận CustomerID làm tham số và trả về trạng thái VIP nếu tổng doanh thu của khách hàng vượt quá 50,000, ngược lại trả về Regular.
-- Tạo hàm kiểm tra khách hàng VIP
*/

SELECT  * FROM Customers
SELECT  * FROM [Order Details]
SELECT  * FROM [Orders]

SELECT 
c.CustomerID,
Sum(od.Quantity*od.UnitPrice)as totals
FROM Orders  o
   JOIN [Order Details] od ON o.OrderID = od.OrderID
   JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY o.OrderID,c.CustomerID
HAVING Sum(od.Quantity*od.UnitPrice)>=5000
ORDER BY totals




GO;
CREATE FUNCTION VIP(@CustomerID NVARCHAR(50))
RETURNS NVARCHAR(50)
AS 
BEGIN
    DECLARE @TotalSpent DECIMAL(18, 2);
    DECLARE @VIPStatus NVARCHAR(50);

    -- Tính tổng doanh số của khách hàng
    SELECT @TotalSpent = SUM(od.Quantity * od.UnitPrice)
    FROM Orders o
    JOIN [Order Details] od ON o.OrderID = od.OrderID
    WHERE o.CustomerID = @CustomerID;

    -- Xác định trạng thái VIP
    IF @TotalSpent >= 5000
        SET @VIPStatus = 'VIP';
    ELSE
        SET @VIPStatus = 'Regular';

    RETURN @VIPStatus;
END;
GO;

-- Gọi hàm để kiểm tra trạng thái VIP của khách hàng
SELECT CustomerID, dbo.VIP(CustomerID) AS VIPStatus
FROM Customers;


--Bài tập 2: Tính tuổi của nhân viên 
--Tạo một hàm nhận EmployeeID làm tham số và trả về tuổi của nhân viên.
GO
CREATE FUNCTION getAge(@EmployeeID int) RETURNS INT
AS
BEGIN
    DECLARE @Age INT;
    SELECT @Age = DATEDIFF(YEAR, e.BirthDate, GETDATE())
    FROM Employees e
    WHERE e.EmployeeID = @EmployeeID
    RETURN @Age;
END ;


go;
--  thực thi   code 
SELECT dbo.getAge(1);
--Bài tập 3: Tính số lượng sản phẩm bán ra theo loại 
--Tạo một hàm nhận CategoryID làm tham số và trả về tổng số lượng sản phẩm bán ra thuộc loại đó.
go;
select  * from  Orders 
--Bài tập 4: Kiểm tra hiệu suất của nhân viên bán hàng 
--Tạo một hàm nhận EmployeeID làm tham số và trả về tổng doanh thu mà nhân viên đó xử lý.
