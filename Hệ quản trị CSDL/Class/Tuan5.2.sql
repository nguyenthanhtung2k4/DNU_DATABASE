/*Hàm trả về giá trị vô hướng
Bài tập 1: Tính giá trị chiết khấu của một đơn hàng 
Tạo một hàm nhận OrderID làm tham số và trả về tổng giá trị chiết khấu.*/
go;
CREATE FUNCTION getDisciuntAmount(@OrderID INT)
RETURNS DECIMAL ( 18,2)
AS 
BEGIN
DECLARE @DisciuntAmount DECIMAL ( 18,2)
SELECT @DisciuntAmount =  SUM (UnitPrice *Quantity*Discount)
FROM [Order Details]
WHERE [OrderID] = @OrderID;
RETURN @DisciuntAmount; 
END
go;
--  su dung ham
SELECT OrderID ,dbo.getDisciuntAmount(OrderID) AS DiscountAmount
FROM  Orders;

/*Bài tập 2: Kiểm tra số lượng sản phẩm trong kho 
Tạo một hàm nhận ProductID làm tham số và trả về số lượng sản phẩm hiện có trong kho.
*/




/*Bài tập 3: Tính doanh thu của một đơn hàng 
Tạo một hàm nhận OrderID làm tham số và trả về tổng doanh thu của đơn hàng.*/

/*Bài tập 4: Kiểm tra trạng thái giao hàng 
Tạo một hàm nhận OrderID làm tham số và trả về trạng thái giao hàng:
•	Delivered nếu ShippedDate khác NULL.
•	Pending nếu ngược lại.*/


/*Bài tập 5: Tính tổng số lượng sản phẩm bán được cho một khách hàng
Tạo một hàm nhận CustomerID làm tham số và trả về tổng số lượng sản phẩm mà khách hàng đã mua.*/