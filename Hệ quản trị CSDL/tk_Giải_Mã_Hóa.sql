
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