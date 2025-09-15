-- Bảo mật trong SQL 
-- B1: Tạo key chính trong máy chủ
USE master
Create MASTER KEY ENCRYPTION BY PASSWORD = 'md43SGAB@'
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
