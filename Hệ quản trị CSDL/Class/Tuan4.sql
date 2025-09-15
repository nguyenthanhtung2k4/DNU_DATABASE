--4.2: Câu lệnh điều khiển
--SỬ DỤNG IF…ELSE
--Bài 1: Tạo thủ tục kiểm tra xem số lượng sản phẩm (UnitsInStock) có đủ đáp ứng đơn đặt hàng không. 
--Nếu đủ, trả về thông báo "Đủ hàng", nếu không trả về "Không đủ hàng".
CREATE PROCEDURE CheckProductStock1
    @ProductID INT,
    @OrderQuantity INT,
    @ResultMessage NVARCHAR(50) OUTPUT
AS
BEGIN
    -- Khai báo biến lưu trữ số lượng hàng tồn kho
    DECLARE @UnitsInStock INT;

    -- Lấy số lượng hàng tồn kho của sản phẩm
    SELECT @UnitsInStock = UnitsInStock
    FROM Products
    WHERE ProductID = @ProductID;

    -- Kiểm tra điều kiện và gán giá trị cho kết quả
    /*IF @UnitsInStock IS NULL
    BEGIN
        SET @ResultMessage = N'Sản phẩm không tồn tại';
    END
    ELSE */
	IF @UnitsInStock >= @OrderQuantity
    BEGIN
        SET @ResultMessage = N'Đủ hàng';
    END
    ELSE
    BEGIN
        SET @ResultMessage = N'Không đủ hàng';
    END
END;
--  chay chuong trinh
DECLARE @Message Nvarchar(50)
EXEC CheckProductStock
	1,45,@Message
OUTPUT;
PRINT @Message;

/*Bài 2: Tạo thủ tục CheckProductStock để kiểm tra số lượng tồn kho của một sản phẩm (ProductID).
•	Nếu UnitsInStock = 0, trả về thông báo "Hết hàng".
•	Ngược lại, trả về thông báo "Còn hàng".*/
go;
CREATE PROCEDURE ChecproductsStock2
	@ProductId INT,
	@Message NVARCHAR(50)
	AS
BEGIN 
	DECLARE @UnitsInStock INT;
	SELECT  @ProductId=ProductID,@UnitsInStock=UnitsInStock
	FROM Products
	WHERE  @ProductId=ProductID
	IF @UnitsInStock=0
	SET @Message=N'Hết hàng'
	ELSE
	SET @Message=N'Còn hàng'
	END;

SELECT ProductID  FROM Products 
--Bài 3: Viết thủ tục kiểm tra số lượng sản phẩm trong kho. Nếu số lượng (UnitsInStock) nhỏ hơn 20, trả về thông báo "Hàng sắp hết", ngược lại trả về "Hàng còn đủ".

Go;
--Sử dụng While
--Bài 1: Tạo thủ tục in danh sách OrderID của 10 đơn hàng đầu tiên từ bảng Orders sử dụng vòng lặp While.
IF OBJECT_ID('PrinTop10Oders','P') IS NOT NULL
DROP PROCEDURE PrinTop10Oders;
GO
CREATE PROCEDURE PrinTop10Oders
AS
BEGIN
	DECLARE @Counter INT = 1;
	DECLARE @OrderID INT;
	WHILE @Counter <= 10
	BEGIN
	SELECT @OrderID = OrderID
	FROM (SELECT OrderID,ROW_NUMBER()OVER(ORDER BY OrderID)AS RowNum 
	FROM Orders) AS RankedOrders
	WHERE RowNum = @Counter;
	PRINT'OrderID:'+CAST(@OrderID AS NVARCHAR);
	SET @Counter = @Counter +1;
	END;
END;
GO
EXEC PrinTop10Oders;


--Bài 2: Tạo thủ tục DecrementStock để giảm số lượng tồn kho của một sản phẩm cho đến khi đạt mức tối thiểu (MinStock). Tham số đầu vào: @ProductID, @MinStock.


--Bài 3: Hiển thị tên các sản phẩm từ bảng Products sử dụng vòng lặp WHILE.

--Sử dụng Break
--Bài 1: Tạo thủ tục tìm và hiển thị CustomerID của đơn hàng đầu tiên có ngày giao hàng (ShippedDate) là NULL.



--Bài 2: Tạo thủ tục FindFirstOutOfStockProduct để tìm sản phẩm đầu tiên có số lượng tồn kho bằng 0. Dừng kiểm tra ngay khi tìm thấy sản phẩm.

--Bài 3: Tìm và hiển thị sản phẩm đầu tiên có giá bán (UnitPrice) lớn hơn 50.
Go;
CREATE PROCEDURE FirstPriceProduct
AS
BEGIN 
	DECLARE @Index INT=1;
	DECLARE @TotalProducts INT; 
	SELECT @TotalProducts = COUNT(*)
	FROM Products;
	WHILE @Index <= @TotalProducts
	BEGIN 
	IF(SELECT UnitPrice FROM Products WHERE ProductID = @Index) >50
	BEGIN 
	SELECT ProductName, UnitPrice From Products WHERE ProductID = @Index;
	BREAK;
	END;

	SET @Index = @Index+1;
	END;
END;

-- Thực hiện thủ tục
EXEC FirstPriceProduct;


--Sử dụng Continue
--Bài 1:Tạo thủ tục ListLowStockProducts để liệt kê tất cả các sản phẩm có tồn kho dưới 10. Bỏ qua các sản phẩm có tồn kho bằng 0.

--Bài 2: Tạo thủ tục hiển thị tất cả sản phẩm có giá bán (UnitPrice) lớn hơn 50, bỏ qua các sản phẩm giá nhỏ hơn.

--Bài 3: Hiển thị tất cả sản phẩm có số lượng tồn kho (UnitsInStock) lớn hơn 30.

/*4.3 Thủ tục
Bài 1: Tạo thủ tục đơn giản
Yêu cầu: Tạo thủ tục hiển thị danh sách nhân viên (FirstName, LastName) từ bảng Employees.

Bài 2: Tạo thủ tục đơn giản
Yêu cầu: Tạo thủ tục trả về danh sách tên nhân viên (FirstName, LastName) và quốc gia của họ (Country).

Bài 3: Thủ tục với tham số
Yêu cầu: Tạo thủ tục hiển thị danh sách sản phẩm có giá bán (UnitPrice) lớn hơn một giá trị tham số đầu

Bài 4: Thủ tục với tham số
Yêu cầu: Tạo thủ tục hiển thị danh sách sản phẩm trong một danh mục cụ thể (CategoryID).


Bài 5: Thủ tục với tham số
Tạo thủ tục GetOrdersByEmployee để trả về các đơn hàng của một nhân viên (EmployeeID).

Bài 6: Thủ tục với tham số đầu ra
Yêu cầu: Tạo thủ tục trả về tổng số đơn hàng (Orders).


Bài 7: Thủ tục với tham số đầu ra
Yêu cầu: Tạo thủ tục trả về tổng số lượng sản phẩm (UnitsInStock) trong kho.


Bài 8: Thủ tục với giá trị mặc định
Tạo thủ tục GetTopOrders để trả về N đơn hàng gần nhất, với N có giá trị mặc định là 5.


Bài 9: Thủ tục với giá trị mặc định
Yêu cầu: Tạo thủ tục hiển thị danh sách đơn hàng của một nhân viên, với giá trị mặc định cho EmployeeID là 1.


Bài 10: Thủ tục thực hiện cập nhật
Tạo thủ tục UpdateEmployeeAddress để cập nhật địa chỉ của một nhân viên.
*/

