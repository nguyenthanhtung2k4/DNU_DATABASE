--1. Bật tính năng CDC trên database Northwind và theo dõi thay đổi bảng Orders.
    USE Northwind

    EXEC sys.sp_cdc_enable_db;
    EXEC sys.sp_cdc_enable_table;
    @source_schema = 'dbo',
    @source_name='Customer',
    @role_name=NULL;
    --  B3 kiểm tra bang
--2. Tạo trigger theo dõi INSERT, UPDATE, DELETE trên bảng Products và lưu lịch sử vào bảng Product_Logs
-- Bước 1: Tạo bảng Product_Logs để lưu lịch sử thay đổi
    
    go;
    CREATE TABLE Product_Logs (
        LogID INT PRIMARY KEY IDENTITY(1,1),
        ProductID INT,
        ProductName NVARCHAR(255),
        OperationType NVARCHAR(10), -- 'INSERT', 'UPDATE', 'DELETE'
        OperationTime DATETIME DEFAULT GETDATE(),
        ModifiedBy SYSNAME -- Lưu tên user đã thực hiện thay đổi
    );
    GO

    -- Bước 2: Tạo Trigger trg_theodoi_products trên bảng Products
    CREATE TRIGGER trg_theodoi_products
    ON Products
    AFTER INSERT, UPDATE, DELETE
    AS
    BEGIN
        -- Khai báo biến để lưu loại thao tác
        DECLARE @OperationType NVARCHAR(10);

        -- Xác định loại thao tác (INSERT, UPDATE, DELETE)
        IF EXISTS(SELECT 1 FROM inserted) AND EXISTS(SELECT 1 FROM deleted)
            SET @OperationType = 'UPDATE';
        ELSE IF EXISTS(SELECT 1 FROM inserted)
            SET @OperationType = 'INSERT';
        ELSE IF EXISTS(SELECT 1 FROM deleted)
            SET @OperationType = 'DELETE';

        -- Xử lý INSERT
        IF @OperationType = 'INSERT'
        BEGIN
            INSERT INTO Product_Logs (ProductID, ProductName, OperationType, ModifiedBy)
            SELECT ProductID, ProductName, @OperationType, SYSTEM_USER
            FROM inserted;
        END

        -- Xử lý UPDATE
        ELSE IF @OperationType = 'UPDATE'
        BEGIN
            INSERT INTO Product_Logs (ProductID, ProductName, OperationType, ModifiedBy)
            SELECT i.ProductID, i.ProductName, @OperationType, SYSTEM_USER
            FROM inserted i;
        END

        -- Xử lý DELETE
        ELSE IF @OperationType = 'DELETE'
        BEGIN
            INSERT INTO Product_Logs (ProductID, ProductName, OperationType, ModifiedBy)
            SELECT ProductID, ProductName, @OperationType, SYSTEM_USER
            FROM deleted;
        END
    END
    GO

    -- Bước 3: Kiểm tra Trigger (ví dụ)

    -- **Ví dụ INSERT:**
    INSERT INTO Products (ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued)
    VALUES ('Tetungtungst Product', 1, 1, '10 boxes x 20 bags', 199.00, 39, 0, 10, 0);
    GO

    -- **Ví dụ UPDATE:**
    UPDATE Products
    SET UnitPrice = 555.00
    WHERE ProductName = 'ting Product';
    GO

    -- **Ví dụ DELETE:**
    DELETE FROM Products
    WHERE ProductName = 'Test Product';
    GO

    -- **Xem lại lịch sử trong bảng Product_Logs:**
    SELECT * FROM Product_Logs;
    GO

--3.  Sử dụng READ COMMITTED để tránh đọc dữ liệu chưa được COMMIT.
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
GO

BEGIN TRANSACTION;

-- Ví dụ: Đọc dữ liệu từ bảng Customers
SELECT * FROM Customers WHERE City = 'London';

SELECT * FROM Customers WHERE City = 'London';
ROLLBACK TRANSACTION;
GO


--4. Hãy tạo một vai trò (OrderManager), có thể chỉnh sửa bảng Orders nhưng không thể xóa dữ liệu.aaaaaaaaaa