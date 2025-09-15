## Các thao thác SQL
- *Ngôn ngữx  định nghĩa (DDL)* : Create, drop,alter
- *Ngôn ngữ thao thác(DML)*: update,delete,select
- *Ngôn ngữ điều khiển dữ liệu(DCL)*: grant, remoke
- *Ngôn ngữ kiểm soát()*:commit,rollback

##  T-SQL:  NGôn ngữ mở rộng (T-SQL):
- SQl  đc sử dụng trong hệ quản trị
- T SQL :  chỉ được dùng trong SQL  Sever 

-*Sự khác nhau*: 
- SQL:  ngôn ngữ chung
- T-SQL:  ngôn ngữ mở rộng
- T-SQL:  có thể sử dụng các hàm, thủ tục, view, trigger,
- T-SQL:  có thể sử dụng các câu lệnh DDL, DML
- T-SQL:  có thể sử dụng các câu lệnh DCL, DCL
- T-SQL:  có thể sử dụng các câu lệnh kiểm soát


## Cấu trúc T- SQL: 
``` SQL
 begin
 --  khai báo biến;
 --  Các câu lệnh
 End
 ```
 ## Quy ước T- SQL:
 ### Quy ước đặt tên:
 - *Tên Bảng*:  Chữ cái đầu viết hoa.
 - *Tên cột*:  Dùng danh từ mô tả  có viết hoa chữ cái đầu.
 - *Tên khóa, chỉ mục:* Bắt đầu tiền tố, PK,FK,IX
 
 ### Quy ước cú pháp:
 - *Viết hoa từ khóa SQL:* Phân biệt vơi tên bảng cột
 - *Canh kề và xuống dòng:* Để dễ sử dụng
 - *Commnet*: 1 dòng dùng dấu  '-- Nhiều dòng /* */
### Thủ tục lưu trữ:

-*Biến đầu vào*: Sử dụng  ký tự  @  với tên rõ dàng.(Vd: @Customs)
- *Hàm*:
  - bắt đầu với tiền tố fn_
- *Sử lý  lỗi:*  Sử dụng  TRY...  CATCH  để tránh dừng đột ngột. 

## 1.0 Ngôn ngữ định nghĩa:  

#### 1.1 Chỉnh sửa cấu trúc bảng: 
- *Alter*: Có thể thêm thuộc tính bảng
#### 1.2 Thêm cột

- Cú pháp:
```SQL
ALTER    TABLE    Tên_bảng
ADD   Tên_cột    Kiểu_dữ_liệu   [RBTV] [,...]
```
#### 1.3 Hủy bỏ một cột
Cú pháp
```SQL
ALTER TABLE Tên_bảng
DROP COLUMN Tên_cột [,...]
ROW Tên_hàn
```
#### 1.4 Sửa đổi kiểu dữ liệu cột
Cú pháp:
```SQL
ALTER TABLE  Tên_bảng
ALTER COLUMN  Tên_cột     Kiểu_dữ_liệu_mới

--❑ Ví dụ:
ALTER TABLE VATTU
ALTER COLUMN TenVtu   Nvarchar(30)
--➢ Lưu ý: Kiểu dữ liệu mới phải lớn hơn kiểu dữ liệu cũ đã có
```
#### 1.5 Thêm ràng buộc cho cột
Cú pháp:
```SQL
ALTER  TABLE   Tên_bảng
ADD   CONSTRAINT  Tên_ràng_buộc    Loại_ràng_buộc
❑ Ví dụ:
ALTER TABLE VATTU
ADD CONSTRAINT CK_NgayNhap
CHECK (Ngaynhap <= GetDate())
```
#### 1.6 Hủy ràng buộc đã đặt
Cú pháp:
```SQL
ALTER  TABLE  Tên_bảng
DROP  CONSTRAINT  Tên_ràng_buộc 
❑ Ví dụ:
ALTER TABLE VATTU
DROP CONSTRAINT   CK_NgayNhap
```
#### 1.7 Bật tắt các ràng buộc
Cú pháp:
```SQL
ALTER   TABLE  Tên_bảng
NOCHECK  CONSTRAINT  ALL | Tên_constraint [,...]
ALTER   TABLE  Tên_bảng
CHECK   CONSTRAINT   ALL | Tên_constraint [,...]

```
### 1.8 Đổi tên cột
Cú pháp:
```SQL
❑ Cú pháp:
EXEC SP_Rename ‘Tên_bảng.Tên_cột’, ‘Tên_mới’ , ‘COLUMN’
❑ Ví dụ:
EXEC SP_RENAME ‘VATTU.MAVTU’,  ‘MAVATTU’, ‘COLUMN’
```
### 1.9 Đôi tên cột
```SQL 
--❑ Cú pháp
EXEC sp_rename ‘Tên_bảng’, ‘Tên_mới’
--❑ Ví dụ:
EXEC SP_RENAME ‘VATTU’, ’VT’
```
### 1.10 Xóa bảng
- Cú pháp:
  - DROP TABLE Danh_sách_tên_các_bảng
- **Lưu ý:**: 
  - Câu lệnh Drop Table không thể thực hiện nếu bảng cần xóa được tham chiếu bởi một Foreign Key
  - Các ràng buộc, chỉ mục, trigger,.. đều bị xóa, nếu tạo lại bảng thì cũng phải tạo lại các đối tượng này
  - Sau khi xóa không thể khôi phục lại bảng và dữ liệu bảng

## Ngôn ngữ thao thác
## Hàm sử dụng trong T SQL
- Hàm Chuỗi:
  - Len()
  - Upper()
  - Lower()
  - Format(): Định dạng các thuộc tính tiền,  ngày giờ
  
  - Substring() :  Lấy kí kí tự
  - Concat() :  Thêm giá trị vào trong bảng ghi( VD:  1000 VND)Thêm VND vào thanh ghi.


```SQL
Concat(100,'VND')
-- Kết qủa : 100 VND
```

- Hàm số học:
  - abs()
  - ROUND() : Lấy số thập phân.
  - CEILING()
  - FLOOR()
- Hàm ngày giờ:
  - GETDATE()
  - DATEADD()
  - DATEDIFF()
  - Format(): Định dạng các thuộc tính tiền,  ngày giờ
- Hàm tổng hợp:
  - SUM()
  - AVG()
  - MIN()
  - MAX()
  - COUNT()

## Truy vấn dữ liệu:
- *SELECT*: Lệnh truy vấn để lấy dữ liệu từ các bảng.
  - SELECT FirstName, LastName FROM Employees; 
- *WHERE*: để lọc dữ liệu dựa trên điều kiện nhất định.
  - SELECT * FROM Employees WHERE Salary > 5000; 
- *ORDER BY*: để sắp xếp kết quả theo thứ tự tăng hoặc giảm.
  - SELECT * FROM Employees ORDER BY LastName ASC; 
- *Kết hợp bảng (JOIN)*: Dùng để kết hợp dữ liệu từ hai hoặc nhiều bảng (INNER JOIN, LEFT JOIN, RIGHT JOIN, FULL JOIN)
## Group by 
- *GROUP BY*: Dùng để nhóm dữ liệu theo một hoặc nhiều cột.
- *HAVING*: Dùng để lọc các nhóm sau khi đã áp dụng Group by.
```SQL
SELECT DepartmentID, COUNT(*) AS EmployeeCount
FROM Employees GROUP BY DepartmentID
HAVING COUNT(*) > 5;
GROUP BY
```

## Pivot
- *PIVOT*: Xoay dữ liệu từ dạng hàng thành dạng cột để 
thuận tiện cho việc phân tích.
```SQL
SELECT * 
FROM (SELECT Year, Region, Sales FROM SalesData) AS 
SourceTable
PIVOT (
SUM(Sales) 
FOR Region IN ([North], [South], [East], [West])
) AS PivotTable;
```
*✓Lợi ích*: Tạo báo cáo tóm tắt, dễ dàng so sánh dữ liệu 
theo các chiều khác nhau.
PIVOT

## Một số vấn đề khác trong SQL
### Biến toàn cục , cục bộ:
- Toàn cục:
- Cục bộ
#### *Cục bộ* : Trong Transact-SQL, biến cục bộ được khai báo và sử dụng tạm  thời khi thực thi câu lệnh SQL
- Cú pháp: **Declare**   @Tên_Biến Kiểu_Dữ_Liệu

-Trong đó:
  - @tên_biến: đặt theo quy tắc đặt tên, phải bắt đầu bằng @
  - Kiểu_dữ_liệu: kiểu dữ liệu hệ thống hoặc kiểu dữ liệu người 
dùng 
``` SQL
Declare   @manv   int
Set   @manv = 1
Select   hoten,  diachi
From Nhanvien
Where manv=@manv
```
#### *Toàn cục* : Biến toàn cục là biến có sẵn và hệ thống quản lý
• Biến toàn cục trong SQL Server được đặt tên bắt đầu bởi 2 ký 
hiệu @@
- Cú pháp: **SELECT @@LANGUAGE**.kiểu dữ liệu

```SQL
--Ví dụ: biến toàn cục được sử dụng để xem thông tin phiên bản SQL Server
SELECT @@VERSION AS PHIEN
40
```
### Giá  trị NULL
#### Null: Biểu thị giá trị không xác định hoặc không có dữ liệu.
- **✓IS NULL/IS NOT NUL**L: Kiểm tra giá trị NULL trong câu 
lệnh WHERE
```SQL
SELECT * FROM Employees WHERE ManagerID IS NULL;
```
#### Hàm Xử Lý Null:
- **✓ISNULL()**: Thay thế giá trị NULL bằng một giá trị khác
Ứng dụng: để xử lý trường hợp dữ liệu thiếu hoặc không có 
giá trị, giúp đảm bảo tính toàn vẹn của kết quả truy vấn


## 3 Khung nhìn: VIEW

**Cú pháp:**
```sql
Create View {TênKhung}[Danhsach-Tên_cột]
AS  Select .....
```

- *Nguyên tắc*: 
  - Tên khung, cộyt giống như quy  định
  - Không tạo được ràng buộc và chỉ mục
- *Điều kiện*:
  - không sử dụng từ khóa distinct, top, group by, union
  - Trong select không chứa các biểu thức tính toán – các hàm gộp
### 3.1 Sủa Đổi khung nhìn : 
- Dùng để định nghĩa lại View mà không làm thay đổi các quyền đã
được cấp phát cho người dùng trước đó

**Cú pháp**
```sql
ALTER VIEW tên_khung_nhìn [ (danh_sách_tên_cột) ]
as câu_lệnh_SELECT
```
Ví dụ SQL View
```sql
--  Ví dụ :
alter view customerinfo as
select CUSTOMERNAME, (year(getdate()) - year(birthday)) as
AGE, ADDRESS, GENDER
from customers

```
### 3.2 Xóa khung nhìn :
**Cú pháp**
```sql
DROP VIEW tên-khung-nhìn
```

**Lưu ý**
- Khi một View bị xóa thì các quyền được cấp phát cho
người dùng trên View cũng sẽ bị xóa.
- Khi tạo lại View thì cấp phát lại quyền cho người sử
dụng.
### 3.4 Thêm Dữ Liệu vào View
- Các View là bảng ảo, do đó không thể thêm dữ liệu trực tiếp vào một View. 
- Tuy nhiên, có thể thực hiện thêm dữ liệu vào các bảng cơ sở mà View sử dụng, từ đó làm thay đổi kết quả của View.

### 3.5 Cập nhập dữ liệu:
- Tuy nhiên, có thể cập nhật dữ liệu trong các bảng cơ sở mà View sử dụng, và thay đổi các kết quả hiển thị trong View.
- Ví dụ: Cập nhật số lượng sản phẩm trong một đơn hàng

## 4 Chỉ mục (**Index**)
- **Cho phép bạn  truy vấn đến DL nhanh hơn**
- **Phục vụ** khi có dữ liệu nhiều.
### 4.1 Các loại: *Phân cụm* Và *Không phân cụm*
```SQL
-- không  Phân  cụm
CREATE NONCLUSTERED INDEX 
--  Phân  cụm

CREATE CLUSTERED INDEX
```

#### 4.1.1 Sự khác nhau của non và clustered: 
- *Clustered Index* Phân cụmcụm
  - Số lượng: Mỗi bảng 1 chỉ mục phân cụm
  - Ảnh hưởng: Thứ tự dữ liệu bị thay đổi trong bảng
  - Cấu trúc: lưu trữ trực tiếp
  - Tốc độ: tìm kiếm nhanh cho các  try vấn sắp xếp theo thứ tự
  - Cách dùng: ***CREATE CLUSTERED INDEX***
  - Ví dụ:

- *Non clustered Index*: Không phân cụm
  - Số lượng: 1 bảng có nhiều chỉ mục không phân cụm
  - Ảnh hưởng: Không thay đổi thứ tự dữ liệu trong bảng
  - Cấu trúc: Lưu trữ chỉ mục và trỏ đến dữ liệuliệu
  - Tốc độ: Tìm kiếm nhanh cho các truy vấn khong yêu cầu sắp xếp theo thứ tự chỉ mục 
  - Cách dùng: ***CREATE NONCLUSTERED INDEX***
  - Ví dụ:

### 4.2 Câu lệnh  Index:
Cú pháp:
```Sql
CREATE INDEX ten_index ON ten_bang;
```
#### 4.2 Các kiểu Index :
✓ Single-Column Index

✓ Unique Index

✓ Composite Index

✓ Implicit Index


#### 4.2.1 Single-Column Index Single-Column Index được tạo cho duy nhất 1 cột trong bảng.
• Cú pháp:
```sql
CREATE INDEX ten_index
ON ten_bang (ten_cot);
```
#### 4.2.2 Unique Index là chỉ mục duy nhất, được sử dụng để tăng hiệu suất và đảm bảo tính toàn vẹn dữ liệu.
• Cú pháp:
```sql
CREATE UNIQUE INDEX ten_index
ON ten_bang (ten_cot);
```
#### 4.2.3 Composite Index là chỉ mục kết hợp dành cho hai hoặc nhiều cột trong một bảng.
• Cú pháp:
```sql
CREATE INDEX ten_index
ON ten_bang (cot1, cot2);
```
#### 4.2.4 • Index implicit là các chỉ mục được tạo tự động bởi máy chủ cơ sở dữ liệu khi một bảng được tạo ra.
▪ Được thiết lập tự động cho các ràng buộc Primary
key và Uniqued

▪ Cải thiện hiệu suất truy vấn mà không cần can
thiệp thủ công.

Cú pháp:
```sql
DROP INDEX ten_index;
```
## ==> Phân Biết sự khác nhau của VIEW  và INDEX
### - View :
  - Cho phép xem dữ liệu từ một hoặc nhiều cột trong bảng.
  - Chứa dữ liệu logic của bảng cơ
  sở, giống như cửa sổ để xem
  hoặc thay đổi dữ liệu.

  - Có thể kết hợp dữ liệu từ nhiều
  bảng và được sử dụng trong
  câu lệnh SELECT.

  - Cung cấp bảo mật cho dữ liệu;
  có thể dễ dàng tạo lại nếu bị
  xóa. 
### - INDEX: 
  - Tăng tốc độ tìm kiếm dữ liệu.
  - Là con trỏ chỉ đến địa chỉ vật lý của
  dữ liệu.

  - Có thể được tạo trên một hoặc
  nhiều cột của bảng.

  - Một bảng có thể chứa nhiều INDEX
  để cải thiện hiệu suất truy vấn





  Về xem lại phần tái tạo  và tái tổ chức ( rebuild ,  reogranize ...)


## 5 thủ tục 
``Cách dùng``:
- Được gọi là đối tượng và gồm nhiều tập lệch SQL được nhóm lại và được lưu trữ và thực thi.

- Cấu trúc điều khiển: while, if , for...

- Biến để sử dụng lưu trữ tính toán và được trích xuất ra từ CSDL

`Ưu điểm`:  
- Đơn gải hóa dữ liệu
- Thực thi câu lệnh  nhanh hơn.
- Giảm lưu thông trên mạng
- Tăng tính  bảo mật và cấp quyền cho thủ tục lưu thay vì tác động trực tiếp csdl
- Tái sử dụng lại cho thủ tục lưu trữ.

`Nhược điểm:`


### 5.1 Phân loại thủ tục:
#### 5.1.1 System stored procedure:
- Lưu trữ: trong CSDL Master
- Bắt đầu bằng chứ `sp_*`
```
sp_who_@giname='sa'
sp_sever_info 1
```
#### 5.1.2 Local Stored produre:
- Lưu trong CSDL do người dùng tạo ra
- Được tạo bởi DBA (Database Administrator) hoặc người lập trình

#### 5.1.3 Remote Stored Procedure
- Sử dụng thủ tục của một server khác

#### 5.1.4 Temporary Stored Procedure
- Có chức năng tương tự Local Stored Procedure
- Tự hủy khi kết nối tạo ra bị ngắt hoặc SQL Server ngừng hoạt động
- Lưu trên CSDL TempDB
#### 5.1.5 Extended Stored Procedure:
- Sử dụng chương trình ngoại vi đã được biên dịch thành DLL.// các 
thư viện động Dyamic link library
- Tên bắt đầu bằng xp_*

``` sql
xp_sendmail dùng gửi mail
xp_cmdshell dùng thực hiện lệnh của DOSS
```
### 5.2 Câu lệnh điều khiển:
#### 5.2.1 IF ELSE
-Cú pháp: 
```SQL
-- Cú  Pháp: 
IF {Điều_Kiện} {
  {Thực_Hiện_Đúng}
}ELSE{
  {Thực_Hiện_Sai} 
}
```
#### 5.2.2 While 
-Cú pháp:
```SQL
While {Điều_kiện} 
{Các_Lệnh_Cần_Lặp}
BEGIN {
  {Câu lệnh thực thi trong điều khiện.
}
}
END
```
#### 5.2.3 Break
-  Sử dụng break để thoát khỏi vòng lặp không xác định điều kiện dừng hoặc muốn dừng vòng lặp theo điều kiện do tự chỉ định và thực thi các câu lệnh tiếp sau lệnh END của vòng lặp
-Cú pháp:
```SQL
BREAK;
```
#### 5.2.4 Continue
- `Dùng để` trao quyền thi hành lệnh cho
biểu thức điều kiện của vòng lặp gần nhất
Cú pháp:
```SQL
CONTINUEE
```
### 5.3. Sử dụng thủ tục : 
#### 5.3.1  tạo thủ tục
-Cú pháp: thủ tục
```SQL
CREATE PROCEDURE procedure_name
AS
BEGIN ;
<Các_Câu_lệnh_Thủ_tục>
END
--  Ví dụ 
CREATE PROCEDURE SelectCustomerstabledata
AS
BEGIN : -- Dùng để  toàn vẹn dữ liệu.
SELECT *
FROM Testdb.Customers
END;
```

#### 5.3.2  Thực hiện thủ tục
-Cú pháp: thực hiện
```SQL
EXECUTE sp_name;
Hoặc
EXEC sp_name;
-- ❑Ví dụ:
EXEC uspProductList;
```
#### 5.3.3 Xóa +  sửa thủ tục
-Cú Pháp:  Xóa thủ tục
```SQL
DROP PRO sp_name;
-- Hoặc 
DROP PROCEDURE sp_name;
```
-Cú Pháp:  Sửa thủ tục
```SQL
ALTER   PROC   Tên_thủ_tục [danh-sách-tham-số]
AS 
BEGIN
<Tập lệnh>
END
```
#### 5.3.4 Sử dụng biến trong thủ tục
- Biến trong thủ tục được khai báo và sử dụng như các biến trong SQL
- Biến được khai báo trước khi thực hiện các câu lệnh trong thủ tục
- Biến được sử dụng trong các câu lệnh SELECT, INSERT, UPDATE, DELETE
- Biến được sử dụng trong các câu lệnh IF, CASE, WHILE, FOR, LOOP
#### 5.3.5 Giá trị trả về
`Giá trị trả về` thủ tục: 

- Cú pháp:  giá trị trả về
```SQL
CREATE  PROC  tuoicaonhat
AS
BEGIN
declare @maxtuoi int
select @maxtuoi = max(year(getdate()) - year(ngaysinh)) 
from sinhvien 
return @maxtuoi
END
```

`Giá trị trả về thông qua tham số` thủ tục:
- Cú pháp: 
```SQL
@Tên_Tham_số <Kiểu_dữ_liệu> OUTPUT
--  Hoặc
@TênThamSo <kiểu_dữ_liệu> OUT

````
[Vd:Sử dụng Thủ tục](./Class/Tuan4.sql)

## 6 Con trỏ ( Cursor)
- 3 tính chất con trỏ: 
 - Chỉ đọc
 - Không duyệt lại
 - Duyệt trên dữ liệu gốc (Asenstive) / Duyệt trên dữ liệu tạm(Insensitive) 

### 6.1 Khởi tạo con trỏ (cursor)
-Cú pháp: 
```SQL
  DECLARE cursor_name CURSOR FOR
  SELECT column1, column2, ...
  FROM table_name
  WHERE condition;
```

### 6.2 Mở con trỏ ( open cursor)
-Cú pháp:
```SQL
OPEN cursor_name
```
### 6.3 Đọc dữ liệu từ con trỏ (fetch)
-Cú pháp:
```SQL
FETCH cursor_name INTO variable1, variable2, ...;
```
### 6.4 Đóng con trỏ (close)
-Cú pháp:
```SQL
CLOSE cursor_name;
``` 
### 6.5 Xóa con trỏ (deallocate)
-Cú pháp:
```SQL
DEALLOCATE cursor_name;
```
[Vd: Sử dụng con trỏ]( ./Class/Tuan5.sql)

## 7 Hàm tự định nghĩa (Function)
- 3 Dạng Function: 
  - trả giá trị vô hướng
  - trả về bảng tạm
  - trả về giá trị một bảng
## 7.1 Tạo Function
-Cú pháp:
```SQL
CREATE FUNCTION tên_hàm ([danh_sách_tham_số]) 
RETURNS (kiểu_trả_về_của_hàm) 
AS 
BEGIN 
các_câu_lệnh_của_hàm 
END

--  VÍ dụ:
-- Tạo hàm chuyển chuỗi ngày tháng năm sang xâu ký tự theo mã 112 
Create Function Namthang(@d datetime) 
Returns char(6) 
As 
Begin 
Declare @st char(6) 
Set @st=convert(char(6),@d,112) 
Return @st 
End

```
### *Sự khác nhau của Hàm (Function) và Thủ tục:
- **Hàm Function**: Hàm chỉ trả về một giá trị hoặc kết quả

- **Thủ tục**:  Trả về nhiều giá trị
### 7.2  Xóa function
-Cú pháp:
```SQL
DROP FUNCTION function_name;
```
### 7.3 Hàm thực thi: 
- Dùng để thực thi code khi đã tạo thành công hàm function.
-Cú pháp:
```SQL
EXECUTE tên_hàm

### 7.3 Hàm giá trị vô hướng:
- ❑Khái niệm: Là hàm trả về một giá trị đơn lẻ (scalar
value) như số, chuỗi, hoặc ngày tháng.

-Cú pháp:
```SQL
CREATE FUNCTION function_name (parameters)
RETURNS data_type
AS
BEGIN    
-- Câu lệnh thực thi    
RETURN value
END
```
### 7.4 Hàm trả về biến bảng:
- Khái niệm: Hàm trả về một biến bảng (table variable), cho phép lưu 
trữ nhiều dòng và nhiều cột dữ liệu.

-Cú pháp:
```SQL

CREATE FUNCTION function_name (parameters)
RETURNS @table_variable TABLE (column_definitions)
AS
BEGIN
-- Câu lệnh thực thi
INSERT INTO @table_variable
SELECT ...
RETURN
END
```   
### 7.5 Hàm trả về giá trị bảng:
- Khái niệm: Hàm trả về một giá trị bảng (table-valued), cho 
phép sử dụng như một bảng trong các truy vấn SQL.

-Cú pháp: 
```SQL
CREATE FUNCTION function_name (parameters)
RETURNS TABLE
AS
RETURN 
(
-- Câu lệnh truy vấn
)
```

# 8 Trigger
- Các trường hợp Trigger: 
  - Khi có các dàng buộc về thuộc tính mà không được mô tả.
  - Tạo ra các ràng buộc, kiểm soát ràng buộc
  - khi có sự thay đổi 1  bảng và cập nhập  lại các bảng còn lại  có sự liên kết
  -  Kiểm chứng xóa dữ liệu 1 bảng nào đó.
- Khả năng Trigger:
  - Nhận biết, ngăn chặn  và hủy bỏ  những thao thác làm sai thay đổi trái phép trong csdl 
  - Các thao tác trên dữ liệu có thể được trigẻ phát hiện và tự động thực hiện 1 loạt thao thác
  -  Có thêr kiểm tra những mỗi quan hệ phức tạp trong csdl

**Lưu ý**: triger có thể sử dụng trong view

- **Phân loai**:
  -  Inser trigger: đuc
  - Update Trigger: đuọc kích hoạt khi cập nhập dưx liệu vào bảng (View)
  - Delete Trigger: Xóa một bange trong csdl
  - Tập hợp 3 loại trên

-Cú pháp:
``` sql
Create Trigger <Ten_trigger>
ON Ten_Bang | View
[WITH ENCRYPTION] --  Ngăn ngừa sửa đổi trong nội dung

-- instead of:  sử dụng kiểm tra dữ liệu cập nhập trên view
-- for(after):  được kích hoạt sau khi dữ liệu đã cập nhật
vào bảng
{For | After | Instead of } {[INSERT] [, UPDATE] [,
DELETE]}
AS
Begin
Các-câu-lệnh-của-trigger
End

```

## 8.1  for(after) Trigger:
  - Chỉ được dùng với: *Inser* và *Update*
## 8.2 inserted of Trigger
  - Nó không tác động đến nó sẽ lưu trữ dữ liệu trước khi thực hiện các câu lệnh

## 8.3  Trigger  Fix lỗi
- Khi có lỗi xảy ra trong quá trình thực hiện Trigger:
  - **RAISEROR**: Chuỗi thông báo lỗi tùy chỉnh  trong sql
  - **PRINT** : Chuỗi thông báo lỗi
  - **ROLLBACK TRAN**:  Bỏ qua toàn bộ thông tin trước đó

## 8.4 bangr aor Inserted và Delete trong Trigger
- **Inserted**:  bảng chứa dữ liệu được thêm vào dành cho Trigger
- **Deleted**: bảng chứa dữ liệu được xóa dành cho Trtigger
- Các trường hợp:

##  8.5 IF UPDATE -  Trigger
**Lưu ý**: 
  - **IF UPDATE**: *không được sử dụngdụng* đc đối với cậu  lệnh  DELEETE
  - **IF UPDATE**:  *chỉ sử dụng* INSER và UPDATE

-Cú pháp  IF UPDATE:
```sql
CREATE TRIGGER tên_trigger
ON tên_bảng
FOR { [INSERT] [,] [UPDATE] }
AS
IF UPDATE (tên_cột)
<các_câu_lệnh_của_trigger >


--  VD:  Khôg cho phép sửa :
CREATE TRIGGER UpdateMaNV
ON NHANVIEN
For Update
As
Begin
If update(MaNV)
Begin
Print N'Không thể thay đổi Mã NV'
RollBack transaction --không lưu lại các thay đổi
end
End
```

## 8.6 Sửa,  xóa trong TRIGGER
- **Sửa**:
  - ALTER TRIGGER <tên_trigger>
- **Xóa**:
  - DROP TRIGGER <tên_trigger>
- Làm **mất hiệu** lực của trigger: khi  ta không muốn dùng nó thì ngắt kết nối.
  - ALTER TABLE <tên_bảng> DISABLE TRIGGER <tên_trigger>
- Làm trigger **có hiệu lực**: Khi muốn kích hoạt lại  Trigger thì dùng lệnh bên dưới.
  - ALTER TABLE <tên_bảng> ENABLE TRIGGER<tên_trigger>/[ALL]

## 8.7 Giao tác: Transaction
- Giao tác thực hiện cập nhập nhiều dữ liệu trên nhiều bảng.
-  Các thao tác thực hiện:
   - **BEGIN TRANSACTION** <tên giao tác>: Bắt đầu một giao tác
   - **SAVE TRANSACTION** <tên điểm đánh dấu>: Đánh dấu một vị
trí trong giao tác (gọi là điểm đánh dấu).
   - **ROLLBACK** [ TRANSACTION <tên giao tác> ]: Quay lui trở
lại đầu giao tác hoặc một điểm đánh dấu nào đó trong giao tác.
   - **COMMIT** [ TRANSACTION <tên giao tác> ] : Đánh dấu điểm
kết thúc một giao tác.

[Vd:Sd Trigger](./Class/Tuan6_trigger.sql)


# 9. Bảo  mật:
- Lưu ý:
    - Nếu is_encrypted = 0 database chưa được mã hóa
    - Nếu is_encrypted = 1 database đã được mã hóa
    - Khi tắt TDE, dữ liệu trong Database sữ tự động được giải mã
    - Sau khi  giải mã, có thể xóa  DEK ,  Cert và Master  Key  nếu không còn sử dụng nữa
    - Luôn kiểm tra trạng thái mã hóa bằng cách truy vấn sys.databases
   

## 9.1  Mã hóa Cột
## 9.2  Mã hóa phía khách hàng.


## 9.3 Xác thực truy cập
- Xác thực truy cập là quá trình kiểm tra danh tính của người dùng trước khi cho phép truy cập vào CSDL.

❑Hai phương pháp xác thực trong SQL Server:

✓ Xác thực Windows Authentication (phù hợp với các tổ chức sử dụng Active Directory)

✓ Xác thực SQL Server Authentication

### 9.3.1 Windows Authentication
- Sử dụng tài khoản Windows để xác thực người dùng

❑Quản lý quyền truy cập thông qua tài khoản người dùng

Windows, phù hợp với các tổ chức sử dụng Active Directory.
❑Cú pháp:
``` sql
-- Thêm người dùng Windows
CREATE LOGIN [Domain\UserName] FROM WINDOWS;

-- Thêm người dùng Windows vào cơ sở dữ liệu
USE [Database_Name];
CREATE USER [Domain\UserName] FOR LOGIN [Domain\UserName];

-- Gán quyền hạn cho người dùng Windows
ALTER ROLE [Role_Name] ADD MEMBER [Domain\UserName];

-- Thêm người dùng Windows "MyDomain\JohnDoe"
CREATE LOGIN [MyDomain\JohnDoe] FROM WINDOWS;

-- Thêm người dùng này vào cơ sở dữ liệu "MyDatabase"
USE MyDatabase;
CREATE USER [MyDomain\JohnDoe] FOR LOGIN [MyDomain\JohnDoe];

-- Gán quyền hạn "db_datareader" cho người dùng
ALTER ROLE db_datareader ADD MEMBER [MyDomain\JohnDoe];
```
### 9.3.2 SQL Authentication
- Sử dụng tài khoản SQL Server độc lập, với tên đăng nhập và mật
khẩu được lưu trữ trong cơ sở dữ liệu SQL Server.

❑Cú pháp:
```SQL
CREATE LOGIN [Tên_Login] WITH PASSWORD = 'Mật_khẩu_mạnh';
USE [Tên_Cơ_sở_dữ_liệu];
CREATE USER [Tên_User] FOR LOGIN [Tên_Login];

-- Gán quyền hạn cho user
ALTER ROLE [Role_Name] ADD MEMBER [Tên_User];

```

*```Lưu ý```:
-SQL Server cho phép chuyển đổi giữa Windows Authentication và SQL Server Authentication.
Cú pháp:
```sql
ALTER LOGIN mySqlLogin WITH WINDOWS = 'Domain\Username’;
```
❑SQL Server có thể hoạt động trong chế độ Mixed Mode, cho phép sử dụng 
cả xác thực Windows và SQL Server.
Cú pháp:
```sql 
EXEC sp_configure 'authentication mode’, 2; 
```

### 9.4 Lược đồ CSDL

### 9.5 Phân quyền và bảo mật  trong lược đồ.
```SQL
GRANT SELLECT ON CHEMA:: Sales  TO myUser
```
### 9.6 Vai trò phân quyền
- Vai trò một tập hợp các quyền truy cập được cấp cho người dùng hoặc nhóm nguòiư dùng quản lý quyền một cách hiệu quả.
- Ủy quyền (Delegation) là việc cấp quyền cho một người dùng
hoặc nhóm người dùng để họ có thể cấp quyền cho người dùng
khác, giúp tiết kiệm thời gian và dễ dàng quản lý quyền truy cập.

#### 9.6.1 Tạo và quản lý vai trò
```SQL
CREATE ROLE  MyRole;
--  Cấp quyền select  cho vai trò
GRANT SELECT ON  dbo.Customers TO MyRole;
-- Gán người dùng User1 vbaof vai trò MyRole
EXEC sp_addrolemeber 'MyRole', 'user';
```
#### 9.6.2 Ủy quyền trong SQL Sevver
- Ủy quyền (GRANT) trong SQL Server cho phép người dùng cấp quyền cho người khác để họ có thể thực hiện các thao tác truy cập dữ liệu

```SQL
--  Cấp quyền Select  cho user2 và cho phép user2 ủy quyền  này
GRANT SELECT ON dbo.Customers TO  user2 WITH GRANT OPTION;
-- Kiểm tra  quyền của ngời dùng user
SELECT * FROM  fn_my_permission('dbo.Customers', 'OBJECT')
```
#### 9.6.3 Thu hồi quyền và vai trò 
- Có thể thu hồi quyền từ người dùng hoặc vai trò nếu không còn cần thiết
- Nếu vai trog không sử dụng, có thể xóa vai trò đó.

```SQL
-- thu hồi quyền Selects  từ vai tro  MyRole
REVOKE SELECT ON dbo.Customers FROM MyROle;

--  Xóa  vai trò  ROLE
DROP ROLE MyRole;
```

#### 9.6.4 Kiểm tra quyền và vai trò
- SQL Server cung cấp các chức năng để kiểm tra các quyền mà người dùng có đối với các đối tượng CSDL và vai trò mà họ tham gia.

```SQL
--  Kiểm tra các quyền mà người dùng 'user1'  có trên  bảng Customers 
SELECT * FROM fn_my_permissions('dbo.Customers' , 'OBJECT')

--  Kiểm tra vai trò mà người dùng 'user1' tham  gia 
EXEC sp_helpusẻ 'user1';
```

#### 9.6.5 theo  dõi thay đổi
- Có các loại theo  dõi thay đổi:
   
    - [x] Change Data Capture (CDC)
   
    - [x] Change Tracking (CT) :  CT là một tính năng nhẹ hơn CDC, chỉ theo dõi xem có thay đổi nào
trong dữ liệu mà không lưu trữ chi tiết các giá trị đã thay đổi
   
    - [x] Triggers : được sử dụng để tự động thực thi khi có các thay đổi
(INSERT, UPDATE, DELETE) trên bảng hoặc view.

   
    - [x] SQL Server Auditing: là tính năng cho phép theo dõi và ghi lại các sự kiện truy cập và thay đổi trong cơ sở dữ liệu, đặc biệt hữu ích trong môi trường yêu cầu bảo mật cao
    
- CÚ Pháp (CDC):

```SQL
--/////////////// cdc  theo dõi   thay đổi
  -- bất tính năng cdc cho cơ sở dữ liệu
  EXEC sys.sp_cdc_enable_db;

  -- Bật CDC cho bảng Customer
  EXEC sys.sp_ cdc_enable_table;
    @source_schema = N'dbo',
    @source_name = N'Customer',
    @role_name = NULL;

  --  truy vấn  bảng thay đổi của cdc
  SELECT *  FROM cdc.dbo_Customers_CT;

```

- Cú pháp (CT):

```SQL
--  Bật Change Tracking cho cơ sở dữ liệu
ALTER DATABASE MyDatabase
SET CHANGE_TRACKING =ON
(AUTO_CLEANUP = ON ,  CLEANUO_INTERVAL = 720 );

--  BẬT CHANGE TRACKING  CHO BẢNG CUSTOMERS

 ALTER TABLE db.Customers
 ENABLE CHANGE_TRACKING;

--   TRUY VẤN  CHANGE TRACKINGTABLE  TRONG  BẢNG CUSTOMERS 
  SELECT * FROM  CHANGETABLE ( CHANGES dbo.Customers , 0 ) AS CT
  WHERE CT.SYS_CHANGE_VERSION > 100;

 ```

- CÚ PHÁP ( TRIGGER ):  XEM LẠI PHẦN TRIGGER  BÊN TRÊN CÓ MỘT TRƯƠNG  RIÊNG

- CÚ PHÁP (  SQL  SERVER AUDITING)
```SQL
--  TẠO MỘT AUDIT MỚI
CREATE SEVER AUDIT MyAudit TO FILE ( FILEPATH = 'C:\tungbi\')

-- TẠO  MỘT AUDIT SPECIFICATION để theo dõi các truy vấn
CREATE SERVER AUDIT SPECIFICATION MyAuditSpec
  FOR SERVER AUDIT MyAudit
  ADD (SUCCESSFUL_LOGIN_GROUP),
  ADD (FAILED_LOGIN_GROUP);

```
### 9.7 Kiểm soát đồng thời
- Kiểm soát đồng thời trong SQL Server là phương pháp quản lý
truy cập đồng thời đến cơ sở dữ liệu, giúp tránh các xung đột và
đảm bảo tính nhất quán của dữ liệu.
- Các phương pháp chính:
  
  - [✓]Locks : giúp ngăn chặn các giao dịch khác truy cập dữ liệu khi một giao dịch đang thực hiện thao tác
  
  - [✓]Isolation Levels: xác định mức độ cách ly giữa các giao dịch đồng thời, giúp kiểm soát cách thức các giao dịch truy cập dữ liệu và ảnh hưởng đến nhau
  
  - [✓]Tranzaction Management: ``Quản lý giao dịch`` đảm bảo tính toàn vẹn của dữ liệu trong môi trường đa giao dịch. Giao dịch trong SQL Server bắt đầu bằng lệnh BEGIN ``TRANSACTION``, và có thể được kết thúc bằng COMMIT hoặc ``ROLLBACK`` tùy thuộc vào kết quả của giao dịch.

  - [✓]Deadlock Handling: xảy ra khi hai hoặc nhiều giao dịch chờ nhau giải phóng khóa mà cần để tiếp tục, dẫn đến tình trạng treo mà không thể tiếp tục.

- Cú pháp( Locks):
```SQL
BEGIN TRANSACTION;

--  KHÓA EXCLUSIVE (X) TRÊN BẢNG CUSTOMERS
SELECT * FROM dbo.Customers WITH (XLOCKS);

-- Cập nhật dữ liệu
UPDATE dbo.Customers
SET LastName ='Nguyen'
Where CustomesID =1;
Commit
```
-Cú pháp ( Isolation Levels)
```SQL
-- Cấu trúc ( Isolation Levels) là Read Commited
SET TRANSACTION  ISOLATION LEVEL READ COMMITTED;

-- CẤU TRÚC HÌNH ISOLATION  LEVEL LÀ SERIALIZABLE
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE ;
```
- cÚ PHÁP ( Transaction Management ):

```SQL
BEGIN  TRANSACTION;
--  THỰC HIỆN CÁC THAO TÁC SQL 
UPDATE  dbo.Customers
SET LastName = 'Nguyen'
where CustomesID = 1;
commit
```

- CÚ PHÁP (  DEADLOCK ): 

```SQL
BEGIN  TRY
  BEGIN  TRANSACTION;
  --  THỰC HIỆN   CÁC THAO TÁC 
  UPDATE  dbo.CUSTOMERS SET LastName = 'nGUYEN'  
  WHERE CustomesID = 1;
  COMMIT

END TRY
BEGIN CATCH
  --  XỬ LÝ  LỖI  DEADLOCK
  IF ERROR_NUMBER() - 1250
  BEGIN  
    PRINT( '  TEXT O  DAY');
    ROLLBACK
    --  THỰC HIỆN LẠI GIAO DỊCH 
  END 
END CATCH
```

# 10 Quản trị hệ thống
## 10.1 Sao lưu dữ liệu  ( Back up)
- Back up là quá trình copy toàn bộ hoặc một phần database, transaction log, file, file group thành một tập dữ liệu backup
Ổ đĩa bị hỏng (chứa các tập tin CSDL).
- Lý do  cần sao lưu: 
  [➢] Server bị hỏng.
  
  [➢] Nguyên nhân bên ngoài (thiên nhiên, hỏa hoạn, mất cắp,...)
  
  [➢] User vô tình xóa dữ liệu.
  
  [➢] Bị vô tình hay cố ý làm thông tin sai lệch.
  
  [➢] Bị hack.

### 10.1.1 CÁC KIỂU SAO LƯU CSDL
- Full backup
  - Sao lưu bản đầy đủ của CSDL (stored procedure, view, functicon, transaction log,...)
  - File có phần mở rộng là .bak
  - Quá trình được thực hiện mà không cần offline CSDL
  - Chiếm lượng lớn tài nguyên hệ thống
  - Ảnh hưởng thời gian đáp ứng các yêu cầu hệ thống
- Differential Backup
  - Chỉ sao lưu những thay đổi trên dữ liệu kể từ lần full backup gần nhất
  - File tạo ta có phần mở rộng .bak
  - Sử dụng ít tài nguyên hơn 
  - Không ảnh hưởng đến hiệu suất của hệ thống
  - Sẽ vô nghĩa nếu không có bản sao lưu full backup
- transaction log backup
  - Giảm mất mát dữ liệu
  - Lưu trữ thao tác CSDL
  - Theo dõi thay đổi
  - Phục hồi dữ liệu
  - Xóa log sau sao lưu

[Ví dụ: Tham khảo  cách dùng back up bằng ssms](./tk_CHUONG%208%20-%20Quản%20trị%20hệ%20thống.pdf)

### 10.1.2 back up  băng  T-SQL 
```sql:

-- ❑Full Backup
  BACKUP DATABASE TenCSDL 
  TO DISK = 'C:\Temp\TenCSDL_Full.bak' 
  WITH INIT, 
  NAME = 'Full Backup TenCSDL';

-- ❑Differential Backup
  BACKUP DATABASE TenCSDL 
  TO DISK = 'C:\Temp\TenCSDL_Diff.bak' 
  WITH DIFFERENTIAL, 
  NAME = ‘Differential Backup TenCSDL’';

-- ❑Transaction Log Backup
  BACKUP LOG TenCSDL 
  TO DISK = 'C:\Temp\TenCSDL_Log.bak' 
  WITH INIT, 
  NAME = ‘Transaction Log Backup TenCSDL';
```
## 10.2 Khôi phục  dữ liệu ( restore)
[VD:  Sử dụng  Restore bằng ssms](./tk_CHUONG%208%20-%20Quản%20trị%20hệ%20thống.pdf)

### 10.2.1 Khôi phục  bằng T-SQL
```SQL

  RESTORE DATABASE tendb 
  FROM <thiết bị lưu>
  [ WITH Tùy_chọn_sao_lưu]
  (RECOVERY | NORECOVERY)


  -- Ví dụ:
  Restore Database QLDiem
  From disk='E:\QLDiem01full.bak'
```
# 11 DETACH – ATTACH CSDL
## 11.1 DETACH CSDL
- DETACH là quá trình tách CSDL ra khỏi SQL Server mà không  xóa dữ liệu

[Hướng dẫn trong file bằng  SSMS](./tk_CHUONG%208%20-%20Quản%20trị%20hệ%20thống.pdf)
## 11.2 Attach  CSDL
-ATTACH là quá trình đính kèm lại CSDL đã tách bằng file.mdf và .ldf. Giúp khôi phục CSDL trên cùng máy chủ hoặcchuyển sang máy chủ khác.

[Hướng dẫn trong file bằng  SSMS](./tk_CHUONG%208%20-%20Quản%20trị%20hệ%20thống.pdf)
# 12 import  vs export 
- Import dữ liệu là quá trình chuyển dữ liệu từ nguồn bên  ngoài (như Excel, CSV, hoặc CSDL khác) vào bảng trong  SQL Server.

- Export dữ liệu là quá trình chuyển dữ liệu từ bảng trong SQL Server 
sang các định dạng bên ngoài như Excel, CSV, hoặc database khác

[Hướng dẫn trong file bằng  SSMS](./tk_CHUONG%208%20-%20Quản%20trị%20hệ%20thống.pdf)




