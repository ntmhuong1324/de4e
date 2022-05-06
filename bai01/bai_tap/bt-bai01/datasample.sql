-- 1. SELECT
-- Note: Giao hàng thành công là những đơn hàng có status = ‘shipped’
-- Ex1: Lấy tất cả thông tin đơn hàng trong cửa hàng
select *
from sales_data_sample_csv sdsc 


-- Ex2: Lấy thông tin về ORDERNUMBER, PRODUCTCODE,
-- QUANTITYORDERED của các đơn đặt hang
select ORDERNUMBER 
, PRODUCTCODE 
, QUANTITYORDERED 
from sales_data_sample_csv sdsc


-- Ex3: Lấy thông tin các đơn không được giao thành công
select *
from sales_data_sample_csv sdsc 
where status != 'shipped'


-- Ex4: Lấy thông tin các đơn đặt hàng với điều kiện: COUNTRY = ‘USA’
select *
from sales_data_sample_csv sdsc 
where COUNTRY = 'USA'


-- EX5: Lấy thông tin các đơn đặt hàng với DEALSIZE là Small hoặc Medium
select *
from sales_data_sample_csv sdsc 
where DEALSIZE = 'small'
    or DEALSIZE = 'medium'
    
    
-- Ex6: Lấy thông tin các đơn đặt hàng trước năm 2005 (YEARID &lt; 2005)
    SELECT *
    from sales_data_sample_csv sdsc 
     where year(str_to_date(ORDERDATE ,'%c/%e/%Y %k:%i')) < 2005
   
  
-- Ex7: Lấy thông tin những đơn hàng có giá trị trên 2000 (lưu ý cột PRICEEACH
-- VÀ QUANTITYORDERED)
    select *
    , sum( PRICEEACH * QUANTITYORDERED) as VALUE
    from sales_data_sample_csv sdsc 
    group by (ORDERNUMBER)
     having VALUE > 2000