drop table Consists
drop table Payment
drop table Frequent
drop table [Order]
drop table Customer_Phone_Number
drop table Customer
drop table Supply
drop table Supplier_Phone_Number
drop table Supplier
drop table Area
drop table Product
drop table Product_Category

create table Product_Category(
	Category_Code	int not null,
	[Description]		Varchar(255),
	constraint Product_Category_PK Primary key (Category_Code));

Create table Product(
	Product_Code	int not null,
	Name			varchar(255),
	[Description]		varchar(255),
	Price			money constraint Product_Price_CH check(price>0) not null,
	Quantity		int constraint Product_Quantity_CH check(Quantity>0) not null,
	Category_Code	int not null,
	constraint Product_PK Primary key (Product_Code),
	constraint Product_FK Foreign key (Category_code) references Product_Category);

Create table Area(
	Area_Code			int not null,
	Name				varchar(255) not null,
	[Population]		int constraint Area_Population_CH check([Population]>0),
	constraint Area_PK Primary key (Area_Code));

Create table Supplier(
	Supplier_Code	int not null,
	AFM				numeric(9,0) constraint Supplier_AFM_UQ unique not null,
	Name			varchar(255),
	City			varchar(255),
	Street			varchar(255),
	Number			smallint,
	Postal_Code		numeric(5,0),
	Area_Code		int not null,
	constraint Supplier_PK Primary key (Supplier_Code),
	constraint Supplier_FK Foreign key (Area_code) references Area);

Create table Supplier_Phone_Number(
	Supplier_Code	int not null,
	Phone_Number	numeric(10,0) not null,
	constraint Supplier_Phone_Number_PK Primary key (Supplier_Code, Phone_Number),
	constraint Supplier_Phone_Number_FK Foreign key (Supplier_Code) references Supplier ON DELETE CASCADE);

Create table Supply(
	Supply_Code		int not null,
	Supply_Date		datetime not null,
	Quantity		int constraint Supply_Quantity_CH check(Quantity>0) not null,
	Supplier_Code	int not null,
	Product_Code	int not null,
	constraint Supply_PK Primary key (Supply_Code),
	constraint Supply_FK_Sup Foreign key (Supplier_Code) references Supplier,
	constraint Supply_Fk_Pro Foreign key (Product_Code) references Product);

Create table Customer(
	Customer_Code	int not null,
	AFM				numeric(9,0) constraint Customer_AFM_UQ unique not null,
	Name			varchar(255),
	City			varchar(255),
	Street			varchar(255),
	Number			smallint,
	Postal_Code		numeric(5,0),
	Area_Code		int not null,
	constraint Customer_PK Primary key (Customer_Code),
	constraint Customer_FK Foreign key (Area_code) references Area);

Create table Customer_Phone_Number(
	Customer_Code	int not null,
	Phone_Number	numeric(10,0) not null,
	constraint Supplier_Phone_Number_PK2 Primary key (Customer_Code, Phone_Number),
	constraint Supplier_Phone_Number_FK2 Foreign key (Customer_Code) references Customer ON DELETE CASCADE);

Create table [Order](
	Order_Code		int not null,
	Order_Date		datetime not null,
	Sent_Date		datetime not null,
	Customer_Code	int not null,
	constraint Order_PK Primary key (Order_Code),
	constraint Order_FK	Foreign key (Customer_Code) references Customer ON DELETE CASCADE);

Create table Frequent(
	Customer_Code	int not null,
	Balance			money constraint Frequent_Balance_CH check(Balance>=0),
	Credit_Limit	money constraint Frequent_Creadit_Limit_CH check(Credit_Limit>=0)
	constraint Frequent_PK Primary key (Customer_Code), 
	constraint Frequent_Fk Foreign key (Customer_Code) references Customer ON DELETE CASCADE);

Create table Payment(
	Customer_Code	int not null,
	Payment_Date	datetime not null,
	Amount			money constraint Payment_Amount_CH check(Amount>0) not null,
	constraint Payment_PK Primary key (Customer_Code, Payment_Date),
	constraint Payment_FK Foreign key (Customer_Code) references Frequent ON DELETE CASCADE);
	
Create table Consists(
	Order_Code		int not null,
	Product_Code	int not null,
	Quantity		int constraint Consists_Quantity_CH check(Quantity>0),
	constraint Consists_FK_Ord Foreign key (Order_Code) references [Order] ON DELETE CASCADE,
	constraint Consists_FK_Pro Foreign key (Product_Code) references Product ON DELETE CASCADE);
