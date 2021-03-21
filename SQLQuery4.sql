create database ifood

use ifood

create schema customer

create schema food

create schema driver

create schema admin

create schema orders

create schema assignment

-- daftar table
create table ifood.customer.tbcustomer
(	id_cust char(5) not null,
	name varchar(30) not null,
	address varchar(150),
	email varchar(50),
	phone_number varchar(13)
)

create table ifood.food.tbfood
(id_food char(5) not null,
food_name varchar(35) not null,
stock int not null,
resto_name varchar(20), 
price money not null
)

create table ifood.driver.tbdriver
(id_driver char(5) not null,
driver_name varchar(30) not null,
vehicle_plat varchar(11) not null,
driver_phone varchar(13) not null
)

create table ifood.admin.tbadmin
(id_admin char(5) not null,
admin_name varchar(30) not null,
admin_phone varchar(13) not null
)

create table ifood.orders.tborders
(id_order char(5) not null,
id_cust char(5) not null,
id_food char(5) not null,
id_driver char(5) not null,
driver_phone varchar(13) not null,
totalprice money not null
)

create table ifood.assignment.tbassignment
( id_assigment char(5) not null,
id_admin char(5) not null,
id_driver char(5) not null,
id_order char(5) not null,
)

alter table admin.tbadmin add constraint pk_id_admin primary key (id_admin)
alter table customer.tbcustomer add constraint pk_id_cust primary key (id_cust)
alter table driver.tbdriver add constraint pk_id_driver primary key (id_driver)
alter table food.tbfood add constraint pk_id_food primary key (id_food)
alter table orders.tborders add constraint pk_id_order primary key (id_order)
alter table assignment.tbassignment add constraint pk_id_assigment primary key (id_assigment)

alter table orders.tborders add constraint fk_id_cust_on_tborders foreign key (id_cust) references customer.tbcustomer
alter table assignment.tbassignment add constraint fk_id_admin_on_tbassignment foreign key (id_admin) references admin.tbadmin
alter table assignment.tbassignment add constraint fk_id_order_on_tbassignment foreign key (id_order) references orders.tborders
alter table assignment.tbassignment add constraint fk_id_driver_on_tbassignment foreign key (id_driver) references driver.tbdriver
alter table orders.tborders add constraint fk_id_food_on_orders foreign key (id_food) references food.tbfood

alter table customer.tbcustomer add constraint check_id_cust
check(id_cust like '[0-9][0-9][0-9][0-9][0-9]')
alter table orders.tborders add constraint check_id_order
check(id_order like '[0-9][0-9][0-9][0-9][0-9]')
alter table food.tbfood add constraint check_id_food
check(id_food like '[0-9][0-9][0-9][0-9][0-9]')
alter table admin.tbadmin add constraint check_id_admin
check (id_admin like'[0-9][0-9][0-9][0-9][0-9]')
alter table assignment.tbassignment add constraint check_id_assigment
check (id_assigment like'[0-9][0-9][0-9][0-9][0-9]')
alter table driver.tbdriver add constraint check_id_driver
check (id_driver like'[0-9][0-9][0-9][0-9][0-9]')

--customer
CREATE PROCEDURE datacustomer
AS
BEGIN
  SELECT * FROM ifood.customer.tbcustomer
END

EXEC datacustomer

create procedure tambahdatacustomer(
@id_cust char(5),
@name varchar(30),
@address varchar(150),
@email varchar(50),
@phone_number varchar(13)
)
as
begin
	insert into  ifood.customer.tbcustomer values(
	@id_cust,
	@name,
	@address,
	@email,
	@phone_number
	)
end

exec tambahdatacustomer '23781','ramengurl','cibaduyut','ramengurl@gmail.com','1234567891023'
exec tambahdatacustomer '23782','sushiboy','kampung lama','sushiboy@gmail.com','0213456781901'
exec tambahdatacustomer '23783','pastaman','raguna','pastaman@gmail.com','0813421356784'

create procedure delete_food (
@id_food char(5) )
as
begin
 delete from ifood.food.tbfood
 where id_food=@id_food
 end

 exec delete_food '98213'

exec datacustomer

--driver

CREATE PROCEDURE datadriver
AS
BEGIN
  SELECT * FROM ifood.driver.tbdriver
end

EXEC datadriver


CREATE PROCEDURE tambahdriver ( @id_driver char(5),
@driver_name varchar(30) ,
@vehicle_plat varchar(11)  ,
@driver_phone varchar(13) 
)
AS 
BEGIN
 INSERT INTO ifood.driver.tbdriver values ( 
@id_driver,
@driver_name,
@vehicle_plat, 
@driver_phone
)
END

EXEC tambahdriver '13287','Ahmad subarjo','z 123 bj','082134578891'
EXEC tambahdriver '13289','sayuti malik','b 7819  sfy','0828716590196'
EXEC tambahdriver '13286','sujono sukanti','k 6718 lkj','0817890167415'


exec datadriver

--Admin
create PROCEDURE dataadmin
as
BEGIN
  SELECT * FROM ifood.admin.tbadmin
END

EXEC dataadmin

CREATE PROCEDURE tambahadmin ( 
@id_admin char(5),
@admin_name varchar(30),
@admin_phone varchar(13) 
)
AS 
BEGIN
 INSERT INTO ifood.admin.tbadmin values ( 
@id_admin,
@admin_name, 
@admin_phone
)
END

EXEC tambahadmin'32561','Steve Rogers','0213561782634'
EXEC tambahadmin'32562','tony Stark','0215678910234'
EXEC tambahadmin'32563','cilnt baron','0216716523409'

exec dataadmin

--orders

CREATE PROCEDURE tampilkanorders
AS
BEGIN
  SELECT * FROM ifood.orders.tborders
END

EXEC tampilkanorders

create procedure tambahdataorders
(@id_order char(5) ,
@id_cust char(5) ,
@id_food char(5),
@driver_phone varchar(13),
@id_driver char(5),
@totalprice money
)
as
begin
insert into ifood.orders.tborders 
values(
@id_order,
@id_cust,
@id_food,
@id_driver,
@driver_phone,
@totalprice
)
end

drop procedure tambahdataorders

exec tambahdataorders'00371','23781','98213', '13287', '082134578891', '10000'
exec tambahdataorders'00372','23782','98214','13289','0828716590196','15000'
exec tambahdataorders'00373','23783','98215','13286','0817890167415','20000'

EXEC tampilkanorders

--food

CREATE PROCEDURE tampilkanfood
AS
BEGIN
  SELECT * FROM ifood.food.tbfood
END

EXEC tampilkanfood

CREATE PROCEDURE tambahfood ( @id_food char(5) ,
@food_name varchar(35) ,
@stock int ,
@resto_name varchar(20), 
@price money
)
AS 
BEGIN
 INSERT INTO ifood.food.tbfood values ( 
@id_food ,
@food_name ,
@stock ,
@resto_name , 
@price 
)
END

exec tambahfood '98213','kenang rebus','5','10','10000'
exec tambahfood '98214','ayam terbang','2','Warteg','15000'
exec tambahfood '98215','kalkun panggang','4','Warteg','20000'

EXEC tampilkanfood

--assignment
create PROCEDURE dataassignment
as
BEGIN
  SELECT * FROM ifood.assignment.tbassignment
END

CREATE PROCEDURE tambahassignment (
@id_assigment char(5) ,
@id_admin char(5) ,
@id_driver char(5) ,
@id_order char (5) 
)
AS 
BEGIN
 INSERT INTO ifood.assignment.tbassignment values ( 
@id_assigment ,
@id_admin ,
@id_driver ,
@id_order 
) 
END

exec tambahassignment'90561','32561','13287','00371'
exec tambahassignment'90562','32562','13286','00372'
exec tambahassignment'90563','32563','13289','00373'

exec dataassignment

--trigger customer

create trigger deletedatacustomer
on ifood.customer.tbcustomer
for delete
as
 print 'Penghapusan data pada tabel customer tidak boleh'
 rollback transaction
return


create trigger updatecustomer
on ifood.customer.tbcustomer
for update
AS

		Declare  @id_cust char(5),
				 @name varchar(30),
				 @address varchar(150),
				 @email varchar(50),
		         @phone_number char(9)

	select @id_cust=id_cust,@name=name,@address=address,@email=email,@phone_number=phone_number from inserted

print '===The Data Has Been Updated==='
print 'id_cust		        : '+@id_cust
print 'Name					: '+@name
print 'address		        : '+@address
print 'email	            : '+@email
print 'phone_number         : '+@phone_number

update ifood.customer.tbcustomer
set name='tanboykun'
where id_cust='23783'

CREATE TRIGGER customer_Insert
On ifood.customer.tbcustomer  
for Insert
AS
		Declare  @id_cust char(5),
				 @name varchar(30),
				 @address varchar(150),
				 @email varchar(50),
		         @phone_number varchar(13)

       select @id_cust=id_cust,@name=name,@address=address,@email=email,@phone_number=phone_number from inserted

print '===The Data Has Been Inserted==='
print 'id_cust		        : '+@id_cust
print 'name					: '+@name
print 'address	            : '+@address
print 'email                : '+@email
print 'phone_number         : '+@phone_number

exec tambahdatacustomer '23785','John wick','Bogor','johnwick@gmail.com','0814561452371'

exec datacustomer


--trigger admin
create trigger deletedataadmin
on ifood.admin.tbadmin
for delete
as
 print 'Penghapusan data pada tabel admin tidak boleh'
 rollback transaction
return


CREATE TRIGGER admin_Insert
On ifood.admin.tbadmin
for Insert
AS
		Declare  @id_admin char(5),
				 @admin_name varchar(30),
		         @admin_phone varchar(13)

       select @id_admin=id_admin,@admin_name=admin_name,@admin_phone=admin_phone from inserted

print '===The Data Has Been Inserted==='
print 'id_admin			    : '+@id_admin
print 'admin_name			: '+@admin_name
print 'admin_phone          : '+@admin_phone

exec tambahadmin '32564','tchalla','0812347891087'

exec dataadmin

CREATE TRIGGER TR_Updatadmin
On ifood.admin.tbadmin
for Update
AS

		Declare  @id_admin char(5),
				 @admin_name varchar(30),
		         @admin_phone varchar(13)

       select @id_admin=id_admin,@admin_name=admin_name,@admin_phone=@admin_phone from inserted

print '===The Data Has Been Updated==='
print 'id_admin		        : '+@id_admin
print 'admin_Name			: '+@admin_name
print 'admin_phone          : '+@admin_phone

update ifood.admin.tbadmin 
set admin_phone='0211267890187'
where id_admin='32563'

--driver

create trigger deletedatadrivet
on ifood.driver.tbdriver
for delete
as
 print 'Penghapusan data pada tabel driver tidak boleh'
  rollback transaction
return

CREATE TRIGGER driver_Insert
On ifood.driver.tbdriver  
for Insert
AS
		Declare  @id_driver char(5),
				 @driver_name varchar(30),
				 @vehicle_plat varchar(11),
		         @driver_phone varchar(13)

       select @id_driver=id_driver,@driver_name=driver_name,@vehicle_plat=vehicle_plat,@driver_phone=driver_phone from inserted

print '===The Data Has Been Inserted==='
print 'id_driver		    : '+@id_driver
print 'driver_name			: '+@driver_name
print 'vehicle_plat         : '+@vehicle_plat
print 'driver_phone         : '+@driver_phone

exec tambahdriver '13281','chris pratt','g 2345 klj','0213871897167'

CREATE TRIGGER TR_Updatedriver
On ifood.driver.tbdriver 
for Update
AS

		Declare  @id_driver char(5),
				 @driver_name varchar(30),
				 @vehicle_plat varchar(11),
		         @driver_phone varchar(13)

       select @id_driver=id_driver,@driver_name=driver_name,@vehicle_plat=vehicle_plat,@driver_phone=driver_phone from inserted

print '===The Data Has Been Updated==='
print 'id_driver	        : '+@id_driver
print 'driver_Name			: '+@driver_name
print 'vehicle_plat         : '+@vehicle_plat
print 'driver_phone         : '+@driver_phone

update ifood.driver.tbdriver
set vehicle_plat='az 3276 jdw'
where id_driver='13281'

--food
create trigger deletedatafood
on ifood.food.tbfood
for delete
as
 print 'Penghapusan data pada tabel food tidak boleh'
  rollback transaction
return

CREATE TRIGGER TR_Insertfood
On  ifood.food.tbfood
for Insert
AS
		Declare  @id_food char(5),
				 @food_name varchar(35),
				 @stock int,
				 @resto_name varchar(20),
		         @price money

       select @id_food=@id_food,@food_name=@food_name,@stock=@stock,@resto_name=@resto_name,@price=@price from inserted

print '===The Data Has Been Inserted==='
print 'id_food			    : '+@id_food
print 'food_name			: '+@food_name
print 'stock                : '+cast(@stock as nvarchar)
print 'resto_name           : '+@resto_name
print 'price                : '+cast(@price as nvarchar)

exec tambahfood '98216','burger','7','warunk','25000'

CREATE TRIGGER TR_Updatefood
On ifood.food.tbfood 
for Update
AS

		Declare  @id_food char(5),
				 @food_name varchar(35),
				 @stock int,
				 @resto_name varchar(20),
		         @price money

       select @id_food=id_food,@food_name=food_name,@stock=stock,@resto_name=@resto_name,@price=price from inserted

print '===The Data Has Been Updated==='
print 'id_food	            : '+@id_food
print 'food_name			: '+@food_name
print 'stock                : '+cast(@stock as nvarchar)
print 'resto_name           : '+@resto_name
print 'price				: '+cast(@price as nvarchar)

update ifood.food.tbfood
set food_name='ayam goreng'
where id_food='98214'

--orders
create trigger deletedataorder
on ifood.orders.tborders
for delete
as
 print 'Penghapusan data pada tabel order tidak boleh'
  rollback transaction
return

CREATE TRIGGER TR_Insertorder
On  ifood.orders.tborders
for Insert
AS
		Declare  @id_order char(5),
				 @id_cust char(5),
				 @id_food char (5),
				 @id_driver char(5),
		         @driver_phone varchar(13),
				 @totalprice money

       select @id_order=id_order,@id_cust=id_cust,@id_food=id_food,@id_driver=id_driver,@driver_phone=@driver_phone,@totalprice=totalprice from inserted

print '===The Data Has Been Inserted==='
print 'id_order			    : '+@id_order
print 'id_cust		    	: '+@id_cust
print 'id_food              : '+@id_food
print 'id_driver            : '+@id_driver
print 'driver_phone         : '+@driver_phone
print 'totalprice           : '+cast(@totalprice as nvarchar)

exec tambahdataorders '00374','23785','98216','13281','0213871897167','25000'

CREATE TRIGGER TR_Updatefood
On ifood.orders.tborders
for Update
AS

		Declare  @id_order char(5),
				 @id_cust char(5),
				 @id_food char (5),
				 @id_driver char(5),
		         @driver_phone varchar(13),
				 @totalprice money

       select @id_order=id_order,@id_cust=id_cust,@id_food=id_food,@id_driver=id_driver,@driver_phone=@driver_phone,@totalprice=totalprice from inserted

print '===The Data Has Been Updated==='
print 'id_order			    : '+@id_order
print 'id_cust		    	: '+@id_cust
print 'id_food              : '+@id_food
print 'id_driver            : '+@id_driver
print 'driver_phone         : '+@driver_phone
print 'totalprice           : '+cast(@totalprice as nvarchar)

update ifood.orders.tborders
set totalprice='25000'
where id_order='00374'

select * from customer.tbcustomer
select * from admin.tbadmin
select * from assignment.tbassignment
select * from driver.tbdriver
select * from food.tbfood
select * from orders.tborders

drop database ifood

select * from ifood.orders.tborders