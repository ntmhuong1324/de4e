-- Lấy ra dữ liệu của 10 giao dịch (transaction) có số lượng sản phẩm (quantity) cao nhất từ bảng. Kết qủa được sắp xếp giảm dần theo số lượng

select *
from transactionhistory t 
order by quantity desc limit 10

-- Lấy ra dữ liệu của 10 đơn hàng (order) có số lượng sản phẩm (quantity) cao nhất từ bảng. Các thông tin cần lấy là Mã đơn hàng và Số lượng sản phẩm trong đơn hàng. Kết qủa được sắp xếp giảm dần theo số lượng
select ReferenceOrderID  , 
sum(Quantity)
from transactionhistory t 
group by ReferenceOrderID 
order by sum(quantity) desc
limit 10



-- Lấy ra số lượng bán được của từng sản phẩm trong tháng 9 năm 2013. Kết quả trả ra sắp xếp theo số lượng từ cao tới thấp

select ProductID
, sum(Quantity), TransactionDate
from transactionhistory t
where 
	year(TransactionDate) = 2013
	and month(TransactionDate) = 9
group by ProductID 
order by sum(Quantity) desc


-- Cho biết giá trị trung bình của mỗi đơn hàng (order) trong tháng 10 năm 2013. Kết quả sắp xếp theo thứ tự giảm dần giá trị đơn hàng

select 
ReferenceOrderID 
, TransactionDate 
, avg(
cast(quantity*ActualCost 
as decimal(10,2)
) 
) as 'Average'
from transactionhistory t
where
year(TransactionDate) = 2013
and month (TransactionDate) = 10
group by 
ReferenceOrderID 
, TransactionDate 
order by 
avg (quantity*ActualCost) desc


-- Tạo 1 bảng mới tên là TransactionHistory2 lấy dữ liệu của các giao dịch từ bảng TransactionHistory và thêm 1 cột tên là “Value” để thể hiện giá trị của từng giao dịch (giá trị = Quantity * ActualCost).

create table transactionhistory2
as (select *
from transactionhistory t
where 1=2)

alter table transactionhistory2 
add Value varchar(50)

insert into transactionhistory2 
select *
from (
select *, (Quantity * ActualCost) as Value
from transactionhistory 
) abc;
