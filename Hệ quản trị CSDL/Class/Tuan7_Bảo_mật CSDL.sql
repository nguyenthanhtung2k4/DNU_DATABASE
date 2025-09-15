/*Mã hóa dữ liệu: đảm bảo dữ liệu quan trọng không bị lộ khi bị truy cập trái phép.
Các kỹ thuật mã hóa:
- Transparent Data Encryption
- Column Encryption
- Always Encrypted*/

-- /////////////////////Bảo mật trong SQL 
-- B1: Tạo key chính trong máy chủ
USE master
Create MASTER KEY ENCRYPTION BY PASSWORD = 'md43SGAB@'

--Bài 1: TDE mã hóa toàn bộ database ở mức file để bảo vệ dữ liệu khỏi bị đọc trái phép nếu file bị đánh cắp.
    -- B2: Tạo sert
    CREATE CERTIFICATE NorthWind_Cert
    WITH SUBJECT = 'TDE certificate for NorthWind';
    -- B3: Tạo DEK để sd cert
    USE NorthWind
    CREATE DATABASE ENCRYPTION KEY
    WITH ALGORITHM = AES_256
    ENCRYPTION BY SERVER CERTIFICATE NorthWind_Cert
    -- B4: Kích hoạt
    ALTER DATABASE NorthWind SET ENCRYPTION ON
    -- B5:Kiểm tra
    SELECT name, is_encrypted FROM sys.databases WHERE  name = 'NorthWind';
    -- nếu kết quả kiểm tra là 0 thì là ch mã hoá và ngc lại là 1



-- ////////////////////////// Giải mã hóa ( Tắt TDE và xóa mã hóa )
    USE Master
    -- 1 Tat kich hoat
    ALTER DATABASE NorthWind SET ENCRYPTION OFF;
    -- 2 kiem tra 
    SELECT name, is_encrypted FROM sys.databases WHERE  name = 'NorthWind';
    -- 3 xoa  DEK 
    USE NorthWind
    Drop DATABASE ENCRYPTION KEY
    --  4 Xoa sert neu  khong can
    DROP CERTIFICATE NorthWind_Cert;
    -- 5 Xoa Master key  ( neu khong co  database nao  dung TDE)
    USE master;
    Drop Master KEY;
    /*
    Lưu ý:
        - Nếu is_encrypted = 0 database chưa được mã hóa
        - Nếu is_encrypted = 1 database đã được mã hóa
        - Khi tắt TDE, dữ liệu trong Database sữ tự động được giải mã
        Sau khi  giải mã, có thể xóa  DEK ,  Cert và Master  Key  nếu không còn sử dụng nữa
        Luôn kiểm tra trạng thái mã hóa bằng cách truy vấn sys.databases

    */  

--Bài 2: Mã hóa cột Phone trong bảng Customers bằng Column Encryption với Symmetric Key và kiểm tra xem dữ liệu có được mã hóa hay không.
    SELECT * FROM Customers


    Create MASTER KEY ENCRYPTION BY PASSWORD = 'tong@'
    CREATE CERTIFICATE MyCertificate
    WITH SUBJECT = 'Certificate for Symmetric Key Encryption';
    GO
    USE Northwind
    CREATE SYMMETRIC KEY MySymmetricKey
    WITH ALGORITHM = AES_256
    ENCRYPTION BY CERTIFICATE MyCertificate;
    GO
    -- Giả sử bảng Customers đã tồn tại và có cột Phone
    -- Thêm cột mới để lưu trữ dữ liệu đã mã hóa
    ALTER TABLE Customers
    ADD Phone_Encrypted VARBINARY(MAX);
    GO

    -- Mở Symmetric Key để sử dụng
    OPEN SYMMETRIC KEY MySymmetricKey
    DECRYPTION BY CERTIFICATE MyCertificate;
    GO

    -- Cập nhật dữ liệu, mã hóa cột Phone và lưu vào cột Phone_Encrypted
    UPDATE Customers
    SET Phone_Encrypted = ENCRYPTBYKEY(KEY_GUID('MySymmetricKey'), Phone);
    GO

    -- Đóng Symmetric Key sau khi sử dụng
    CLOSE SYMMETRIC KEY MySymmetricKey;
    GO

-- Bài 2.1:  Giải mã hóa:
    -- B1: Mở Symmetric Key để sử dụng
    OPEN SYMMETRIC KEY MySymmetricKey
    DECRYPTION BY CERTIFICATE MyCertificate;
    GO
    -- Cập nhật dữ liệu, giải mã cột Phone và lưu vào cột Phone
    -- UPDATE Customers
    -- SET Phone = DECRYPTBYKEY(KEY_GUID('MySymmetricKey'), Phone_Encrypted);
    -- GO
    -- Xem giai ma hoa:

    SELECT Phone_Encrypted,
    CONVERT(VARCHAR(MAX),DECRYPTBYKEY(Phone_Encrypted)) as  Giai_Phone

    FROM Customers

--Bài 3: Mã hóa title của nhân viên (Employees.Email) và kiểm tra mã hóa.
    OPEN SYMMETRIC KEY MySymmetricKey
    DECRYPTION BY CERTIFICATE MyCertificate;
    go;
    SELECT Title,
        CONVERT(varchar(MAX),ENCRYPTBYKEY(KEY_GUID('MySymmetricKey')), Title)     AS MaHoa_Title
    FROM Employees
    -- Đóng Symmetric Key sau khi sử dụng
    CLOSE SYMMETRIC KEY MySymmetricKey;
    GO

--Bài 4: Mã hóa cột "CustomerID" trong bảng Orders
    SELECT  * from  Customers
    
    
    OPEN SYMMETRIC KEY MySymmetricKey
    DECRYPTION BY CERTIFICATE MyCertificate;
    GO

    SELECT
        CustomerID,
        CONVERT(VARCHAR(MAX),ENCRYPTBYKEY(KEY_GUID('MySymmetricKey'), CustomerID)) as  MaHoa_CustomerID
    FROM
        Customers
--Bài 5: Mã hóa cột Freight trong bảng Orders
SELECT Freight FROM  Orders
    OPEN  SYMMETRIC KEY MysymetricKey
    DECRYPTION BY CERTIFICATE MyCertificate;
    GO

    SELECT
        Freight,
        CONVERT(VARCHAR(MAX),ENCRYPTBYKEY(KEY_GUID('MySymmetricKey'), CustomerID)) as  MaHoa_Freight
    FROM
        Orders

-- Xác thực truy cập
--Bài 1: Tạo một tài khoản đăng nhập sử dụng Windows Authentication. Cấp quyền truy cập cơ sở dữ liệu Northwind. Gán quyền chỉ đọc dữ liệu.
    -- Bước 1: Tạo Login sử dụng Windows Authentication
    CREATE LOGIN [admin\Authentication] FROM WINDOWS;
    GO

    -- Bước 2: Sử dụng cơ sở dữ liệu Northwind
    USE Northwind;
    GO

    -- Bước 3: Tạo User trong cơ sở dữ liệu Northwind và liên kết với Login Windows
    -- **Lưu ý chỉnh sửa:** Tên User chỉ nên là phần tên người dùng hoặc nhóm, không bao gồm tên miền.
    CREATE USER [Authentication] FOR LOGIN [NorthWind\Authentication];
    GO

    -- Bước 4: Gán quyền chỉ đọc (db_datareader) cho User trong cơ sở dữ liệu Northwind
    -- **Lưu ý chỉnh sửa:** Tên User phải khớp với tên User đã tạo ở Bước 3.
    ALTER ROLE db_datareader ADD MEMBER [Authentication];
    GO

--Bài 2: Tạo một tài khoản  Server Authentication với tên người dùng và mật khẩu riêng. Cấp quyền đọc và ghi dữ liệu trên database Northwind.
-- Bước 1: Tạo SQL Server Login sử dụng Server Authentication
    CREATE LOGIN [admin] WITH PASSWORD = 'tong@';
    GO

    -- Bước 2: Sử dụng cơ sở dữ liệu Northwind
    USE Northwind;
    GO

    -- Bước 3: Tạo User trong cơ sở dữ liệu Northwind và liên kết với SQL Server Login
    CREATE USER [thanhtung] FOR LOGIN [admin];
    GO

    -- Bước 4: Gán quyền đọc và ghi dữ liệu (db_datareader và db_datawriter) cho User trong cơ sở dữ liệu Northwind
    -- Gán quyền đọc dữ liệu
    ALTER ROLE db_datareader ADD MEMBER [thanhtung];
    GO

    -- Gán quyền ghi dữ liệu
    ALTER ROLE db_datawriter ADD MEMBER [thanhtung];
    GO
--Bài 3: Chặn tài khoản sau 3 lần nhập sai mật khẩu (Login Lockout Policy). Thiết lập chính sách khóa tài khoản khi nhập sai mật khẩu quá nhiều lần. Kiểm tra thử nghiệm bằng cách cố đăng nhập sai nhiều lần.
/*Lược đồ
- Tạo lược đồ
- Gán đối tượng vào lược đồ
- Thêm và xóa lược đồ
- Phân quyền và cấp bảo mật cho lược đồ*/

--Bài 1: Tạo một lược đồ mới có tên SalesSchema. Chuyển bảng Orders từ dbo sang SalesSchema. Kiểm tra xem bảng Orders đã nằm trong SalesSchema chưa.
--bước 1: tạo lược đồ mới có tên SalesSchema
    GO
    CREATE SCHEMA SalesSchema;
    GO
    --bước 2: chuyển bằng Orders từ schema mặc định (dbo) sang SalesSchema
    ALTER SCHEMA SalesSchema TRANSFER dbo.Orders;

    --bước 3: kiểm tra xem bảng orders đã nằm trong SalesSchema chưa
    SELECT TABLE_SCHEMA, TABLE_NAME 
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE TABLE_NAME = 'Orders';
--Bài 2: Tạo user SalesUser. Cấp quyền SELECT, INSERT trên SalesSchema. Kiểm tra user SalesUser có thể truy vấn dữ liệu từ bảng Orders không.
-- Bước 1: Tạo SQL Server Login cho SalesUser sử dụng Server Authentication
    CREATE LOGIN SalesUser WITH PASSWORD = 'tong@'; -- **Quan trọng: Thay 'YourStrongPassword123' bằng mật khẩu mạnh thực tế**
    GO

    -- Bước 2: Sử dụng cơ sở dữ liệu hiện tại (nơi bạn muốn tạo User)
    -- Giả sử bạn đang thao tác trên database Northwind (nếu chưa thì hãy USE [TênDatabase])
    USE Northwind; -- Hoặc USE [Tên Database của bạn]
    GO

    -- Bước 3: Tạo User SalesUser trong database hiện tại và liên kết với SQL Server Login
    CREATE USER SalesUser FOR LOGIN SalesUser;
    GO

    -- Bước 4: Tạo SalesSchema nếu nó chưa tồn tại
    IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'SalesSchema')
    BEGIN
        EXEC sp_executesql N'CREATE SCHEMA SalesSchema AUTHORIZATION dbo'; -- Tạo schema và gán dbo làm owner
    END
    GO

    -- Bước 5: Cấp quyền SELECT và INSERT trên SalesSchema cho User SalesUser
    GRANT SELECT, INSERT ON SCHEMA::SalesSchema TO SalesUser;
    GO
--Bài 3: Tạo vai trò SalesManager. Cấp quyền SELECT, INSERT, UPDATE trên lược đồ SalesSchema cho vai trò SalesManager. Thêm SalesUser vào vai trò SalesManager. Kiểm tra SalesUser có thể UPDATE dữ liệu không.
    USE Northwind;
    GO

    -- Bước 2: Tạo Database Role SalesManager
    CREATE ROLE SalesManager;
    GO

    -- Bước 3: Cấp quyền SELECT, INSERT, UPDATE trên lược đồ SalesSchema cho vai trò SalesManager
    GRANT SELECT, INSERT, UPDATE ON SCHEMA::SalesSchema TO SalesManager;
    GO

    -- Bước 4: Thêm User SalesUser vào vai trò SalesManager
    ALTER ROLE SalesManager ADD MEMBER SalesUser;
    GO
--Bài 4: 1.	Tạo user LimitedUser. Chỉ cấp quyền SELECT trên bảng Orders, không cấp quyền khác. Kiểm tra LimitedUser có thể đọc dữ liệu nhưng không thể INSERT hoặc UPDATE.
    -- Bước 1: Tạo SQL Server Login cho LimitedUser sử dụng Server Authentication
    CREATE LOGIN LimitedUser WITH PASSWORD = 'YourStrongPassword123'; -- **Quan trọng: Thay 'YourStrongPassword123' bằng mật khẩu mạnh thực tế**
    GO

    -- Bước 2: Sử dụng cơ sở dữ liệu Northwind
    USE Northwind;
    GO

    -- Bước 3: Tạo User LimitedUser trong cơ sở dữ liệu Northwind và liên kết với SQL Server Login
    CREATE USER LimitedUser FOR LOGIN LimitedUser;
    GO

    -- Bước 4: Cấp quyền SELECT trên bảng Orders cho User LimitedUser
    GRANT SELECT ON OBJECT::Orders TO LimitedUser;
    GO
