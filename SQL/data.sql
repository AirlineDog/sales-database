use DB23

insert into Product_Category
values (1,'Γυναικείο')
insert into Product_Category
values (2,'Ανδρικό')
insert into Product_Category
values (3,'Παιδικό')
insert into Product_Category
values (4,'Unisex')

insert into Product
values (1,'A25','T-shirt',15.95,35,1)
insert into Product
values (2,'Β25','Φούτερ',19.99,28,1)
insert into Product
values (4,'Τ19','Παντελόνι',23.90,18,3)
insert into Product
values (5,'Κ12','Μπουφάν',22.70,24,3)

insert into Area
values (22,'Γαλάτσι',30960) 
insert into Area
values (17,'Κάτω Πατήσια',35644) 
insert into Area
values (14,'Παλαιό Φάληρο',12540)
insert into Area
values (8,'Παγκράτι',19087)

insert into Supplier
values (4,156328947,'Γιώργος Παπαδάτος','Αθήνα','Ελπίδος',33,19156,8)
insert into Supplier
values (7,489301752,'Αμαλία Γιαννακοπούλου','Αθήνα','Εσπερίδων',20,14830,17)
insert into Supplier
values (6,145630297,'’γγελος Γεωργιάδης','Αθήνα','Κολιάτσου',7,18752,17)
insert into Supplier
values (2,201963785,'Αναστασία Παπαδημούλη','Αθήνα','Κεφαλληνίας',13,29853,22)

insert into Supply
values (1,'2020-11-20 23:12:54',8,2,2)
insert into Supply
values (4,'2020-07-20 08:14:32',15,6,4)
insert into Supply
values (7,'2020-09-28 10:53:02',12,4,1)
insert into Supply
values (9,'2020-10-15 09:38:46',23,7,5)

insert into Customer
values (1, 695201486,'Μάριος Κωνσταντίνου','Νέο Φάληρο','Αγάθωνος',26,14523,14)
insert into Customer
values (2, 154853012,'Κατερίνα Παπανικολάου','Παγκράτι','Κορίνης',7,12458,8)
insert into Customer
values (3, 459632017,'Γιάννης Μελέτης','Μενιδιάτικα','Ελπίδος',12,11658,22)
insert into Customer
values (4, 635920148,'Κωνσταντίνα Πέτρου','’γιος Λουκάς','Δημοσθένους',31,25698,17)

insert into [Order]
values (12, '2020-10-29 17:25:06','2020-11-01 08:32:49',4)
insert into [Order]
values (17, '2020-11-02 15:38:54','2020-11-04 09:14:55',2)
insert into [Order]
values (20, '2020-11-05 10:56:14','2020-11-08 08:45:33',1)
insert into [Order]
values (24, '2020-11-18 13:04:48','2020-11-19 09:03:58',3)

insert into Consists
values (12,4,2)
insert into Consists
values (17,5,1)
insert into Consists
values (20,4,3)
insert into Consists
values (24,5,2)

insert into Supplier_Phone_Number
values (4,6980563214)
insert into Supplier_Phone_Number
values (2,6976985230)
insert into Supplier_Phone_Number
values (7,6945871263)
insert into Supplier_Phone_Number
values (6,6932648720)

insert into Customer_Phone_Number
values (2,690652189)
insert into Customer_Phone_Number
values (3,6965014963)
insert into Customer_Phone_Number
values (1,6944593065)
insert into Customer_Phone_Number
values (4,6900478523)

insert into Frequent
values (2,30,150)
insert into Frequent
values (1,0,80)
insert into Frequent
values (4,65,120)

insert into Payment
values (2,'2020-11-24 22:13:17',30)
insert into Payment
values (4,'2020-11-18 17:04:53',25)

