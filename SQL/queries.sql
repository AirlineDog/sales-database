/*Show a list of customers including their customer code, VAT, name, address, and phone numbers*/
select Customer.Customer_Code, AFM, Name, City, Street, Number, Postal_Code, Phone_Number
from Customer, Customer_Phone_Number
where Customer_Phone_Number.Customer_Code = Customer.Customer_Code;

/*For each customer code show the payments made between 12/5/2012 and 22/5/2012*/
select * 
from Payment 
where Payment_Date >= '2012-5-12 00:00:00' AND Payment_Date <= '2012-5-22 23:59:59'
order by Customer_Code;

/*For each order show the date, the order code and the product codes purchased*/
select distinct o.Order_Date, o.Order_Code, p.Product_Code
from [Order] as o, Product as p, Consists as c
where o.Order_Code = c.Order_Code
AND p.Product_Code = c.Product_Code
order by o.Order_Code;

/*Increase the price of all products by 3%*/
update  Product
set Price = (Price + Price * 0.03);

/*Show for each month of 2012 the total and average payments*/
select DATEPART(month, Payment_Date) as Months,
	SUM(Amount) as sumAmount,
	AVG(Amount) as avgAmount
from Payment
where DATEPART(year, Payment_Date) = 2012
group by DATEPART(month, Payment_Date);

/*Show the VAT number and name of all customers who have made total purchases in January 2013 over 2500€*/
select AFM, C.Name 
from Customer as C, [Order] as O, Product as P, Consists as Con
where O.Customer_Code = C.Customer_Code
	AND O.Order_Code = con.Order_Code
	AND Con.Product_Code = P.Product_Code
	AND datepart(month,o.Order_Date) = 1
	AND datepart(year,o.Order_Date) = 2013 
group by C.Name, C.AFM
having sum(P.Price * Con.Quantity) > 2500;

/*For each customer, show by product category the total value of the products he/she has purchased*/
select c.Name, pc.[Description] as Category ,SUM(p.Price*con.Quantity) as TotalValue
from Customer as c,
	Product_Category as pc,
	[Order] as o,
	Product as p,
	Consists as con
where c.Customer_Code = o.Customer_Code
	AND o.Order_Code = con.Order_Code
	AND con.Product_Code = p.Product_Code
	AND p.Category_Code = pc.Category_Code
group by c.Name, pc.[Description]
order by c.Name;

/*Show average sales by geographic region and category*/
select a.Name, pc.[Description] as Category, AVG(p.Price*con.Quantity) as AverageSales
from Area as a,
	Customer as c,
	[Order] as o,
	Consists as con,
	Product as p,
	Product_Category as pc
where a.Area_Code = c.Area_Code
	AND c.Customer_Code = o.Customer_Code
	AND o.Order_Code = con.Order_Code
	AND con.Product_Code = p .Product_Code
	AND p.Category_Code = pc.Category_Code
group by a.Name, pc.[Description]
order by a.Name;

/*For each month of 2012, show the total sales for that month as a percentage of the total annual sales in 2012*/
select DATEPART(month,  o.Order_Date) as Months,
 SUM(con.Quantity*p.Price)/(select SUM(con.Quantity*p.Price)
							from Consists as con,
								[Order] as o,
								Product as p
							where DATEPART(year, o.Order_Date) = '2012'
								AND con.Product_Code = p.Product_Code
								AND o.Order_Code = con.Order_Code)*100 as SalesPercentage
from Consists as con,
	[Order] as o,
	Product as p
where DATEPART(year, o.Order_Date) = '2012'
	AND con.Product_Code = p.Product_Code
	AND o.Order_Code = con.Order_Code
group by DATEPART(month,  o.Order_Date);

/*For each month, count how many customers have an average purchase value greater than the average of the month*/
GO
create view V1(Month, MonthAVG) as 
select  DATEPART(MONTH, o.Order_Date) as Month, SUM(p.Price * con.Quantity)/(count(distinct o.Order_Code)) as sum
from [Order] as o,
	Consists as con,
	Product as p
where o.Order_Code = con.Order_Code
	AND con.Product_Code = p.Product_Code
group by DATEPART(MONTH, o.Order_Date);
GO

GO
create view V2(Months,Cust_Code,MonthAVG) as
select  DATEPART(MONTH, o.Order_Date) as Month,c.Customer_Code ,SUM(p.Price * con.Quantity)/(count(distinct o.Order_Code)) as sum
from Customer as c,
	[Order] as o,
	Consists as con,
	Product as p
where c.Customer_Code = o.Customer_Code
	AND o.Order_Code = con.Order_Code
	AND con.Product_Code = p.Product_Code
group by DATEPART(MONTH, o.Order_Date),c.Customer_Code;
GO

select V2.Months, count(V2.Cust_Code) as CustNumber
from V1, V2
where V2.MonthAVG > V1.MonthAVG
	AND V1.Month = V2.Months
group By V2.Months
order by V2.Months;

drop view V1;
drop view V2;

/*For each month of 2012, compare the total sales for that month
  against the corresponding month of 2011 (as a percentage)*/
GO
Create View V3(Month,Sales) as
select  DATEPART(MONTH, o.Order_Date), Sum(p.Price*con.Quantity)
from [Order] as o,
	Consists as con,
	Product as p
where DATEPART(year, o.Order_Date) = '2012'
	AND o.Order_Code = con.Order_Code
	AND con.Product_Code = p.Product_Code
group by DATEPART(MONTH, o.Order_Date);
GO

GO
Create View V4(Month,Sales) as
select  DATEPART(MONTH, o.Order_Date), Sum(p.Price*con.Quantity)
from [Order] as o,
	Consists as con,
	Product as p
where DATEPART(year, o.Order_Date) = '2011'
	AND o.Order_Code = con.Order_Code
	AND con.Product_Code = p.Product_Code
group by DATEPART(MONTH, o.Order_Date);
GO

select V3.Month, (V3.Sales-V4.Sales)/V4.Sales*100 as Percentage
from V3,V4
where V3.Month = V4.Month;

drop view V3;
drop view V4;

/*Show for each month of 2012, the average sales for that month
  and the average sales in the months preceding that month*/
GO
Create view V5(Dates, AVG, num) as 
select o.Order_Date, AVG(p.Price*con.Quantity), count(*)
from [Order] as o,
	Consists as con,
	Product as p
where DATEPART(YEAR, o.Order_Date) = '2012'
	AND o.Order_Code = con.Order_Code
	AND con.Product_Code = p.Product_Code
Group by o.Order_Date
GO

GO
Create view V6(Month, MonthAVG, Num) as 
select DATEPART(month,Dates), SUM(AVG*num)/SUM(num) , Sum(num)
from V5
group by DATEPART(month,Dates)
GO

select Month, MonthAVG , (select sum(MonthAVG*Num)/sum(Num) from V6 as b where b.Month<=a.Month) as BeforeAVG
from V6 as a
Group by Month, MonthAVG

drop view V5,V6

/*Indicate the codes of the products whose suppliers all come from the same supplier geographical area*/
GO
Create view V7(Area_Code, Product_Code) as
select sup.Area_Code, s.Product_Code 
		from Supplier as sup, Supply as s 
		where sup.Supplier_Code = s.Supplier_Code;
GO

select distinct t1.Product_Code
from V7 as t1
where t1.Area_Code = all (select t2.Area_Code
							from V7 as t2
							where t1.Product_Code = t2.Product_Code);

Drop view V7;

/*Indicate the code of orders containing at least three products with a common supplier*/
GO
Create view V8(Order_Code, Product_Code, Supplier_Code) as
select distinct con.Order_Code, con.Product_Code, s.Supplier_Code
from  Consists as con, Supply as s
where con.Product_Code = s.Product_Code
GO

select t1.Order_Code
from V8 as t1
where t1.Supplier_Code = any (select distinct t2.Supplier_Code 
								from V8 as t2
								where t2.Order_Code = t1.Order_Code
								AND t2.Product_Code != t1.Product_Code
								AND t2.Supplier_Code = any (select distinct t3.Supplier_Code 
																from V8 as t3
																where t3.Order_Code = t1.Order_Code
																AND t3.Product_Code != t1.Product_Code
																AND t3.Product_Code != t2.Product_Code))
group by t1.Order_Code
Having count(distinct t1.Product_Code) >= 3
order by t1.Order_Code;

Drop view V8;
