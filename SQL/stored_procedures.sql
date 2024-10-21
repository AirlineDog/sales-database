/*Write a stored procedure which will accept the code of a geographical area
  and print the number of customers in that region*/
GO
create procedure ask1 
    @area_code int
as
    select count(*) as Num
    from Customer
    where Area_Code = @area_code
GO

drop procedure ask1


/*Write a stored procedure which will accept the product code and two dates
  and print the description of the product and all the supplies of that product
  in the the interval between the two dates (supply code, quantity, date)*/
GO
Create procedure ask2
	@product_code int,
	@date1 datetime,
	@date2 datetime
as
	declare cursorAsk2 cursor
		for select p.Description, s.Supply_Code, s.Quantity, s.Supply_Date
			from Product as p,
				Supply as s
			where s.Product_Code = @product_code
				AND p.Product_Code = s.Product_Code
				AND s.Supply_Date >= @date1
				AND s.Supply_Date <= @date2

	open cursorAsk2;

	declare @desc varchar(255),
			@code int,
			@quant int,
			@date datetime

	fetch next from  cursorAsk2 into @desc, @code, @quant, @date;
			Print 'Product Description : ' + @desc;
	While @@FETCH_STATUS = 0
	Begin
		Print 'Supply Code : ' + convert(varchar(20),@code) + '   Quantity : ' + convert(varchar(20), @quant) + '   Date : ' + convert(varchar(19), @date);
		fetch next from cursorAsk2 into @desc, @code, @quant, @date;
	End 
	close cursorAsk2
	deallocate cursorAsk2
Go

drop procedure ask2
