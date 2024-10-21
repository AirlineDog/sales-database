delete from  Consists
delete from  Payment
delete from  Frequent
delete from  [Order]
delete from  Customer_Phone_Number
delete from  Customer
delete from  Supply
delete from  Supplier_Phone_Number
delete from  Supplier
delete from  Area
delete from  Product
delete from  Product_Category

insert into Product_Category
values (1,'Γυναικείο')
insert into Product_Category
values (2,'Ανδρικό')
insert into Product_Category
values (3,'Παιδικό')
insert into Product_Category
values (4,'Unisex')

insert into Product
values (1,'A25','T-shirt',10.00,35,1)
insert into Product
values (2,'Β25','Φούτερ',15.00,28,1)
insert into Product
values (3,'Τ19','Παντελόνι',12.00,18,3)
insert into Product
values (4,'Κ12','Μπουφάν',18.00,24,3)
insert into Product
values (5,'Κ13','Μπουφάν',20.00,24,3)
insert into Product
values (6,'A26','T-shirt',16.00,35,1)
insert into Product
values (7,'Β25','Φούτερ',21.00,28,1)
insert into Product
values (8,'Τ19','Παντελόνι',19.00,18,3)
insert into Product
values (9,'Κ14','Μπουφάν',21.00,24,3)
insert into Product
values (10,'Κ15','Μπουφάν',23.00,24,3)

insert into Area
values (22,'Αττική',30960) 
insert into Area
values (17,'Φθιώτιδα',35644) 
insert into Area
values (14,'Θεσσαλονίκη',12540)
insert into Area
values (8,'Βοιωτία',19087)
insert into Area
values (5,'Μαγνησία',25036) 
insert into Area
values (7,'Μεσσηνία',35654) 

insert into Supplier
values (1,156328947,'Γιώργος Παπαδάτος','Λιβαδειά','Ελπίδος',33,19156,8)
insert into Supplier
values (2,489301752,'Αμαλία Γιαννακοπούλου','Λαμία','Εσπερίδων',20,14830,17)
insert into Supplier
values (3,145630297,'Άγγελος Γεωργιάδης','Καμένα Βούρλα','Κολιάτσου',7,18752,17)
insert into Supplier
values (4,201963785,'Αναστασία Παπαδημούλη','Γαλάτσι','Κεφαλληνίας',13,29853,22)
insert into Supplier
values (5,156328967,'Γιώργος Αγγελάτος','Λιβαδειά','Κορίνης',27,19156,8)
insert into Supplier
values (6,489331752,'Κατερίνα Κωστοπούλου','Λαμία','Θερμοπυλών',9,14830,17)
insert into Supplier
values (7,145636297,'Άγγελος Καλαντζής','Καμένα Βούρλα','Γερ. Βασιλειάδη',53,18752,17)
insert into Supplier
values (8,211963785,'Αναστασία Κωσταρά','Παγκράτι','Αιγοσθένων',4,29853,22)

declare @supCode int = 1

while @supCode <= 300
begin

declare @datesup datetime = DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 1075), '2011-01-01 00:00:00')
insert into Supply
values (@supCode,@datesup,rand() * 99 + 1, rand() * 7 + 1, rand() * 7 + 1)

set @supCode = @supCode +1

end

select * from Supplier
insert into Supply
values (301,'2020-12-5 12:00:00',50,2,9)
insert into Supply
values (302,'2020-12-6 12:00:00',50,3,9)
insert into Supply
values (303,'2020-12-6 12:00:00',50,6,9)
insert into Supply
values (304,'2020-12-7 12:00:00',50,1,10)
insert into Supply
values (305,'2020-12-8 12:00:00',50,5,10)


insert into Customer
values (1, 695201486,'Μάριος Κωνσταντίνου','Καμάρα','Αγάθωνος',26,14523,14)
insert into Customer
values (2, 154853012,'Κατερίνα Παπανικολάου','Λιβαδειά','Κορίνης',7,12458,8)
insert into Customer
values (3, 459632017,'Γιάννης Μελέτης','Άνω Πατήσια','Ελπίδος',12,11658,22)
insert into Customer
values (4, 635920148,'Κωνσταντίνα Πέτρου','Άγιος Λουκάς','Δημοσθένους',31,25698,17)
insert into Customer
values (5, 695701486,'Μάριος Παπαπέτρου','Καλαμαριά','Αγίων Πάντων',26,14523,14)
insert into Customer
values (6, 154853912,'Κατερίνα Γεροβασίλη','Θήβα','Μπουμπουλίνας',7,12458,8)
insert into Customer
values (7, 459132017,'Γιάννης Πάνου','Ζωγράφου','Παπαδιαμάντη',12,11658,22)
insert into Customer
values (8, 635920108,'Κωνσταντίνα Παπαρίζου','Λαμία','Βύρωνος',31,25698,17)


Declare @OrderCode int = 1

while @OrderCode <= 300
begin

declare @date datetime = DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 1075), '2011-01-01 00:00:00')
insert into [Order]
values (@OrderCode,@date,@date+2 ,rand() * 7 + 1)

set @OrderCode = @OrderCode +1

end



set @OrderCode = 1
while @OrderCode <= 600
begin
insert into Consists
values (rand() * 299 + 1,rand() * 8 + 1,rand() * 100 + 1)

set @OrderCode = @OrderCode +1

end

insert into Supplier_Phone_Number
values (1,6980563214)
insert into Supplier_Phone_Number
values (2,6976985230)
insert into Supplier_Phone_Number
values (3,6945871263)
insert into Supplier_Phone_Number
values (4,6932648720)
insert into Supplier_Phone_Number
values (5,6980563213)
insert into Supplier_Phone_Number
values (6,6976985231)
insert into Supplier_Phone_Number
values (7,6945871264)
insert into Supplier_Phone_Number
values (8,6932648729)

insert into Customer_Phone_Number
values (1,6906521895)
insert into Customer_Phone_Number
values (2,6965014963)
insert into Customer_Phone_Number
values (3,6944593065)
insert into Customer_Phone_Number
values (4,6900478523)
insert into Customer_Phone_Number
values (5,6906521857)
insert into Customer_Phone_Number
values (6,6965014966)
insert into Customer_Phone_Number
values (7,6944593067)
insert into Customer_Phone_Number
values (8,6900478528)

insert into Frequent
values (2,30,150)
insert into Frequent
values (4,0,80)
insert into Frequent
values (5,65,120)
insert into Frequent
values (6,30,200)
insert into Frequent
values (8,20,140)

insert into Payment
values (2,'2012-05-24 22:13:17',30)
insert into Payment
values (4,'2012-05-18 17:04:53',25)
insert into Payment
values (6,'2012-05-13 22:13:17',45)
insert into Payment
values (5,'2012-05-18 17:04:53',35)
insert into Payment
values (2,'2012-05-25 22:13:17',50)
insert into Payment
values (8,'2012-04-19 17:04:53',65)
insert into Payment
values (2,'2012-04-24 22:13:17',30)
insert into Payment
values (4,'2012-06-18 17:04:53',25)
insert into Payment
values (6,'2012-07-13 22:13:17',45)
insert into Payment
values (5,'2012-08-18 17:04:53',35)
insert into Payment
values (2,'2012-08-25 22:13:17',50)
insert into Payment
values (8,'2012-07-19 17:04:53',65)
