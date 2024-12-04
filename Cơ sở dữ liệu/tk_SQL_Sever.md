# Hướng dẫn Chi tiết về SQL Server

## 1. Giới thiệu về SQL Server
SQL Server là một hệ quản trị cơ sở dữ liệu (RDBMS) phát triển bởi Microsoft. Nó cho phép người dùng lưu trữ và truy xuất dữ liệu một cách hiệu quả.

## 2. Các thuộc tính cơ bản

### 2.1. Các kiểu dữ liệu
-    **INT**: Số nguyên.
-    **VARCHAR(n)**: Chuỗi ký tự có độ dài tối đa `n`.
-    **DATETIME**: Ngày và giờ.
-    **FLOAT**: Số thực.
-    **BIT**: Giá trị Boolean (0 hoặc 1).

### Ví dụ:
```sql
                CREATE TABLE Users (
                    UserID INT PRIMARY KEY,
                    Username VARCHAR(50) NOT NULL,
                    Email VARCHAR(100),
                    CreatedAt DATETIME DEFAULT GETDATE()
                );
```
### 2.2. Ràng buộc dữ liệu
-    **PRIMARY KEY**: `Ràng buộc` để xác định duy nhất mỗi hàng trong bảng.
-    **FOREIGN KEY**: `Ràng buộc` để liên kết hai bảng với nhau.
-    **UNIQUE**: Đảm bảo `rằng các giá trị` trong cột là duy nhất.
-    **CHECK**: Kiểm tra `điều kiện` cho các giá trị trong cột.
-    **NOT NULL**: Đảm bảo rằng cột `không chứa giá trị NULL`.
### Ví dụ:
```sql
                CREATE TABLE Orders (
                    OrderID INT PRIMARY KEY,
                    UserID INT,
                    Amount FLOAT CHECK (Amount > 0),
                    FOREIGN KEY (UserID) REFERENCES Users(UserID)
                );
```
## 3. Các câu lệnh cơ bản
### 3.1. Câu lệnh SELECT
-   **top** : Cho phép bạn  lấy số lượng đầu tiên.
-   **WHERE**: Dùng để lọc các hàng dựa trên điều kiện nhất định
-   **ORDER BY**: Dùng để sử dụng sắp xếp kết quả truy vấn theo một hoặc nhiều cột.
-   **GROUP BY**: Dùng để nhóm các hàng có cùng giá trị và thường được các hàm (Count , Sum,  Max,  Min)
-   **HAVING**: Dùng để lọc các nhóm sau khi đã nhóm bởi GROUP BY
-   **JOIN**: Dùng để kết hợp dữ liệu từ hai hoặc nhiều bảng trên một điều kiện liên kết.

-    **==>Mục đích**: `Truy xuất` dữ liệu từ một bảng.
```sql
                SELECT * FROM Users WHERE Username = 'john_doe';
```
### 3.2. Câu lệnh INSERT
-    **Mục đích**: `Thêm dữ liệu` mới vào bảng.
```sql
                INSERT INTO Users (Username, Email) VALUES ('john_doe', 'john@example.com');
```
### 3.3. Câu lệnh UPDATE
-    **Mục đích**: `Cập nhật dữ liệu` hiện có trong bảng.

```sql
                UPDATE Users SET Email = 'john.doe@example.com' WHERE Username = 'john_doe';
```

### 3.4. Câu lệnh DELETE

-    **Mục đích**: `Xóa dữ liệu` khỏi bảng.

```sql
                DELETE FROM Users WHERE Username = 'john_doe';

```

## 4. Các hàm tích hợp
### 4.1. Hàm AGGREGATE
-    **SUM**: Tính `tổng`.
-    **AVG**: Tính giá trị `trung bình`.
-    **COUNT**: Đếm `số lượng`.

```sql
                SELECT COUNT(*) FROM Users;

```

### 4.2. Hàm CHỖ
-   **GETDATE()**: Trả về `ngày` và `giờ` hiện tại.
-   **LEN()**: Trả về độ `dài của chuỗi`.

```sql
                SELECT LEN(Username) FROM Users;
```

## 5. Các câu lệnh điều kiện
### 5.1. CASE
-   **Mục đích**: Điều kiện trong `câu lệnh SELECT`.

```sql
                SELECT 
                    Username, 
                    CASE 
                        WHEN Amount > 100 THEN 'High'
                        ELSE 'Low'
                    END AS OrderValue
                FROM Orders;

```
## 6. Tối ưu hóa truy vấn
-   **Sử dụng chỉ mục** (INDEX) để tăng tốc độ truy vấn.
-   **Tránh sử dụng SELECT ***; chỉ chọn cột cần thiết.

```sql
                CREATE INDEX idx_username ON Users (Username);
```



## 7. Kết luận
### SQL Server là một công cụ mạnh mẽ để quản lý và truy vấn dữ liệu. Bằng cách hiểu và sử dụng các thuộc tính và lệnh cơ bản, bạn có thể tương tác hiệu quả với cơ sở dữ liệu của mình.

## 8 Các câu lệnh liên quan đến SQL:
-   **in()**: Cho  phép bạn lấy số lượng nhất định ( chỉ định 1 và 2 và 3)
-   **TOP**: Cho  phép bạn lấy số lượng trong  1 bảng nhất định.
-   **GETDATE()**: Cho  phép bạn lấy thời điểm hiện tại
-   **between**: Cho phép bạn lấy giá trị nằm trong khoảng
-   **notbetween**: Cho phép bạn lấy giá trị nằm trong khoảng
-   **LIKE**: Cho phép bạn tìm kiếm kí tự




