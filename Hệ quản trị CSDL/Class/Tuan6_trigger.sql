/*Bảng Customers
1. Khi ContactName của một khách hàng thay đổi, 
tự động cập nhật ContactTitle thành "Updated Contact".*/
go;
CREATE TRIGGER UpdateContactTitle
ON Customers
AFTER UPDATE
AS
BEGIN
  IF UPDATE(ContactName)
  BEGIN 
  UPDATE Customers
  SET ContactTitle = 'Updated Contact'
  WHERE CustomerID IN (
       SELECT DISTINCT CustomerID
	   FROM Inserted
	   EXCEPT
	   SELECT DISTINCT CustomerID
	   FROM Deleted
	   );
END
END;

SELECT* FROM Customers

--Xoa Trigger
DROP TRIGGER UpdateContactTitle;
--Kiem tra
UPDATE Customers SET ContactName = 'New Name' WHERE CustomerID = 'ANATR';
SELECT CustomerID, ContactName, ContactTitle FROM Customers WHERE CustomerID = 'ANATR';/*2. Khi bất kỳ cột nào trong Customers thay đổi, ghi log vào bảng CustomerLogs với chi tiết thay đổi.*/ 

/*3. Chặn việc cập nhật thông tin khách hàng nếu có đơn hàng chưa được giao (Orders.ShippedDate IS NULL).*/






/*4. Nếu khách hàng không có đơn hàng nào trong 12 tháng qua, tự động cập nhật ContactTitle thành 'Inactive'.*/
/*
5. Chặn việc cập nhật hoặc thêm khách hàng nếu số điện thoại không có ít nhất 10 ký tự.




BẢNG ORDERS*/
/*1. Khi thêm một đơn hàng mới, ghi lại thông tin đơn hàng vào bảng OrderLog.*/

go;

CREATE TABLE "OrderLog" (
	"OrderID" "int" IDENTITY (1, 1) NOT NULL ,
	"CustomerID" nchar (5) NULL ,
	"EmployeeID" "int" NULL ,
	"OrderDate" "datetime" NULL ,
	"RequiredDate" "datetime" NULL ,
	"ShippedDate" "datetime" NULL ,
	"ShipVia" "int" NULL ,
	"Freight" "money" NULL CONSTRAINT "DF_Orders_Freight" DEFAULT (0),
	"ShipName" nvarchar (40) NULL ,
	"ShipAddress" nvarchar (60) NULL ,
	"ShipCity" nvarchar (15) NULL ,
	"ShipRegion" nvarchar (15) NULL ,
	"ShipPostalCode" nvarchar (10) NULL ,
	"ShipCountry" nvarchar (15) NULL ,
	CONSTRAINT "PK_Orders" PRIMARY KEY  CLUSTERED 
	(
		"OrderID"
	),
	CONSTRAINT "FK_Orders_Customers" FOREIGN KEY 
	(
		"CustomerID"
	) REFERENCES "dbo"."Customers" (
		"CustomerID"
	),
	CONSTRAINT "FK_Orders_Employees" FOREIGN KEY 
	(
		"EmployeeID"
	) REFERENCES "dbo"."Employees" (
		"EmployeeID"
	),
	CONSTRAINT "FK_Orders_Shippers" FOREIGN KEY 
	(
		"ShipVia"
	) REFERENCES "dbo"."Shippers" (
		"ShipperID"
	)
)

go;
CREATE TRIGGER trg_InsertOrderLog
ON Orders
AFTER INSERT
AS
BEGIN
    INSERT INTO OrderLog (OrderID, Action, Timestamp)
    SELECT inserted.OrderID, 'Inserted', GETDATE()
    FROM inserted;
END;

INSERT Orders 


--  2 Khi tổng giá trị đơn hàng vượt 10,000, in cảnh báo.

SELECT  * from  Orders
SELECT  * from  [Order Details]
--  tao bang canh  bao:
go;
CREATE TABLE OrderWarnings (
    WarningID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT,
    WarningMessage VARCHAR(255),
    WarningTime DATETIME DEFAULT GETDATE()
);


--  tao triger  check don hang 

go;
CREATE TRIGGER trg_CheckOrderTotal
ON [Order Details]
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @OrderID INT;
    DECLARE @TotalAmount DECIMAL(10,2);

    -- Lấy ID đơn hàng từ các bản ghi vừa được chèn hoặc cập nhật
    SELECT @OrderID = OrderID 
    FROM inserted;

    -- Tính tổng giá trị đơn hàng
    SELECT @TotalAmount = SUM(UnitPrice * Quantity * (1 - Discount))
    FROM [Order Details] 
    WHERE OrderID = @OrderID;

    -- Kiểm tra và ghi cảnh báo
    IF @TotalAmount > 10000
		PRINT('Chi phi vuot qua 10,000 roi nhe :))');
		BEGIN
        INSERT INTO OrderWarnings (OrderID, WarningMessage)
        VALUES (@OrderID, 'Tổng giá trị đơn hàng vượt quá 10,000');

    END;
end;
-- Insert into Orders table 
INSERT INTO Orders (CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, 
                    ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES ('VINET', 5, '1996-07-04', '1996-08-01', '1996-07-16', 3, 32.38, 
        'Vins et alcools Chevalier', '59 rue de l''Abbaye', 'Reims', 
        NULL, '51100', 'France');

-- Get the newly inserted OrderID
DECLARE @OrderID INT;
SET @OrderID = SCOPE_IDENTITY(); 

-- Insert into Order Details table
INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (@OrderID, 11, 10000, 12, 0);

--  3 /Tự động cập nhật ShippedDate khi OrderStatus chuyển thành "Shipped".
DROP TRIGGER IF EXISTS trg_UpdateShippedDate
go;
CREATE TRIGGER trg_UpdateShippedDate
ON Orders
AFTER UPDATE
AS
BEGIN
    IF UPDATE(OrderStatus)
    BEGIN
        UPDATE Orders
        SET ShippedDate = GETDATE()
        WHERE OrderStatus = 'Shipped' AND OrderID IN (SELECT OrderID FROM INSERTED);
    END
END;


--  4  Ngăn không cho phép xóa đơn hàng đã có ngày giao hàng (ShippedDate)
go;
CREATE TRIGGER trg_PreventDeleteShippedOrders
ON Orders
AFTER DELETE
AS
BEGIN
    IF EXISTS (SELECT * FROM deleted WHERE ShippedDate IS NOT NULL)
    BEGIN
        RAISERROR('Không thể xóa đơn hàng đã có ngày giao hàng.', 16, 1);
        ROLLBACK TRANSACTION;
    END;
END;

DELETE FROM Orders WHERE OrderID = 10250;  -- Giả sử đơn hàng 10248 đã có ngày giao hàng
DELETE FROM [Order Details] WHERE OrderID = 10250;  -- Giả sử đơn hàng 10248 đã có ngày giao hàng

select  * from Orders
select  * from [Order Details]


DECLARE @OrderID INT;
SET @OrderID= 10253;

DELETE FROM Orders
WHERE OrderID = @OrderID
AND NOT EXISTS (SELECT 1 FROM [Order Details] WHERE OrderID = @OrderID);

-- 5. Ghi log vào bảng ShippingLog khi cột ShippedDate được thay đổi.
DROP TRIGGER IF EXISTS trg_LogShippingDateChange
go;
CREATE TRIGGER trg_LogShippingDateChange
ON Orders
AFTER UPDATE
AS
BEGIN
    IF UPDATE(ShippedDate)
    BEGIN
        INSERT INTO ShippingLog (OrderID, OldShippedDate, NewShippedDate, ChangeDate)
        SELECT d.OrderID, d.ShippedDate, i.ShippedDate, GETDATE()
        FROM DELETED d
        INNER JOIN INSERTED i ON d.OrderID = i.OrderID;
    END
END;
/*
6. Gửi cảnh báo nếu khách hàng đặt quá 5 đơn hàng trong cùng một ngày.
*/
DROP TRIGGER IF EXISTS trg_CheckDailyOrders
go;
CREATE TRIGGER trg_CheckDailyOrders
ON Orders
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT CustomerID
        FROM Orders
        WHERE OrderDate = CAST(GETDATE() AS DATE)
        GROUP BY CustomerID
        HAVING COUNT(*) > 5
    )
    BEGIN
        PRINT 'Đã đặt hơn 5 đơn hàng';
    END
END;

/*
7. Khi CustomerID thay đổi trong bảng Orders, cập nhật vào bảng CustomerOrders.
*/
DROP TRIGGER IF EXISTS trg_UpdateCustomerOrders
go;
CREATE TRIGGER trg_UpdateCustomerOrders
ON Orders
AFTER UPDATE
AS
BEGIN
    IF UPDATE(CustomerID)
    BEGIN
        -- Cập nhật CustomerOrders với CustomerID mới và LastUpdated
        UPDATE CustomerOrders
        SET CustomerID = i.CustomerID, LastUpdated = GETDATE()
        FROM CustomerOrders co
        INNER JOIN INSERTED i ON co.OrderID = i.OrderID;

        -- In thông báo khi CustomerID thay đổi
        PRINT 'CustomerID đã được cập nhật vào bảng CustomerOrders';
    END
END;



UPDATE Orders
SET CustomerID = 202
WHERE OrderID = 1;


/*
8. Cảnh báo nếu có cập nhật trên đơn hàng đã có ShippedDate.
*/
DROP TRIGGER IF EXISTS trg_PreventUpdateShippedOrder
go;
CREATE TRIGGER trg_PreventUpdateShippedOrder
ON Orders
AFTER UPDATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM DELETED WHERE ShippedDate IS NOT NULL)
    BEGIN
        PRINT 'CẢNH BÁO: Không được cập nhật đơn hàng đã giao!';
    END
END;

/*
9. Ghi log thông tin sản phẩm vào bảng ProductOrderLog khi thêm đơn hàng.
*/
DROP TRIGGER IF EXISTS trg_InsertProductOrderLog
go;
CREATE TRIGGER trg_InsertProductOrderLog
ON OrderDetails
AFTER INSERT
AS
BEGIN
    INSERT INTO ProductOrderLog (OrderID, ProductID, Quantity, UnitPrice, TotalPrice, ActionDate)
    SELECT OrderID, ProductID, Quantity, UnitPrice, TotalPrice, GETDATE()
    FROM INSERTED;
END;


/*
10. Tự động tính lại tổng giá trị đơn hàng. Cập nhật TotalAmount khi thêm, sửa hoặc xóa sản phẩm trong Order Details.
*/
DROP TRIGGER IF EXISTS trg_UpdateOrderTotal
go;
CREATE TRIGGER trg_UpdateOrderTotal
ON OrderDetails
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    UPDATE Orders
    SET TotalAmount = (
        SELECT SUM(TotalPrice) FROM OrderDetails WHERE OrderDetails.OrderID = Orders.OrderID
    )
    WHERE OrderID IN (SELECT DISTINCT OrderID FROM INSERTED UNION SELECT DISTINCT OrderID FROM DELETED);
END;

/*
KẾT HỢP NHIỀU BẢNG
1. Khi thêm một đơn hàng mới vào bảng OrderDetails, tự động cộng số lượng (Quantity) vào cột UnitsOnOrder của sản phẩm tương ứng trong bảng Products.
2. Không cho phép xóa khách hàng khỏi bảng Customers nếu họ có đơn hàng chưa được giao (cột ShippedDate trong bảng Orders là NULL).
3. Khi một đơn hàng được giao (cập nhật ShippedDate), ghi log thông tin vào bảng OrderLogs.
4. Khi thêm một dòng mới vào OrderDetails, tự động giảm số lượng sản phẩm tương ứng trong Products (UnitsInStock).
5. Ghi log thông tin khách hàng và đơn hàng mới vào bảng CustomerOrderLogs.
6. Tự động chuyển trạng thái đơn hàng nếu khách hàng bị xóa. Nếu khách hàng bị xóa, cập nhật trạng thái đơn hàng (Orders) thành "Cancelled".
7. Nếu tổng giá trị (Quantity * UnitPrice) của đơn hàng vượt 10,000, ghi log cảnh báo.
8. Nếu tổng giá trị đơn hàng lớn hơn 500, cập nhật Freight trong bảng Orders thành 50.

Trigger kiểm tra và bảo mật dữ liệu

1. Chặn xóa đơn hàng có giá trị lớn hơn 5000. Không cho phép xóa các đơn hàng trong bảng Orders nếu tổng giá trị đơn hàng (tính bằng tổng giá của các sản phẩm trong bảng OrderDetails) vượt quá 5000.
2. Không cho phép cập nhật bất kỳ thông tin nào của khách hàng thuộc quốc gia "USA".
3. Khi một bản ghi trong bảng Employees bị xóa, ghi thông tin vào bảng EmployeeDeletionLog.
4. Khi số lượng trong kho của sản phẩm (bảng Products) giảm xuống dưới 10, ghi log và in cảnh báo.
5. Chỉ cho phép thêm khách hàng nếu email hợp lệ.
6. Không cho phép xóa khách hàng nếu họ có hơn 5 đơn hàng.
7. Ghi lại mọi thay đổi của nhân viên vào bảng EmployeeChangeLog.

TRIGGER TỰ ĐỘNG HÓA
1. Khi thêm một sản phẩm vào bảng OrderDetails, tự động cập nhật tổng giá trị đơn hàng trong bảng Orders.
2. Khi ShippedDate được cập nhật trong bảng Orders, tự động thay đổi trạng thái đơn hàng thành 'Shipped'.
3. Khi thêm một sản phẩm mới vào bảng Products, tự động ghi log thông tin vào bảng ProductLog.
4. Khi số lượng tồn kho (UnitsInStock) của sản phẩm giảm dưới 10, tự động tăng giá sản phẩm lên 10%.
5. Nếu một khách hàng đặt hơn 10 sản phẩm trong một đơn hàng, tự động gắn mã giảm giá vào bảng OrderDetails.
6. Khi thêm một chi tiết đơn hàng mà số lượng bán vượt quá tồn kho, in cảnh báo.
7. Khi thêm một sản phẩm mà QuantityPerUnit để trống, tự động gán giá trị là 'N/A'.
8. Nếu một khách hàng bị khóa (IsActive = 0 trong bảng Customers), hủy đơn hàng của họ.
9. Nếu tổng giá trị đơn hàng của khách hàng vượt 10000, tự động chuyển họ thành VIP.
10. Khi UnitsInStock thay đổi, ghi log thay đổi vào bảng StockChangeLog.*/
