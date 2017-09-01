--use master
--go
--^identifies the default database to use as "master," which is very important if we wanted
--to "drop" a database (we don't want to be in the database we are dropping!)

--drop database if exists PRS
--go
--^In the event that we need to clear out and recreate an existing database known as PRS, 
--"drop" allows us to do that.

--create database PRS
--go 
--^This produces the database "PRS"

--use PRS
--go
--^After our database has been created, or recreated, we want to make sure that we are using
--that database.

/*
create table [User](
	--^For the purpose of this table, we need to surround the word "User" with "[]," in order to
	--identify it as the name of our variable, rather than as a SQL keyword.
	Id  int not null primary key identity(1,1), 
	--^Sets up the primary key as "Id," with the value starting at 1, and incrementing by 1.
	UserName varchar(20) not null,
	--^Our possible UserName strings are set to support a max of 20 characters, and must not
	--be null.
	Password varchar(10) not null,
	--^Our possible Password strings are set to support a max of 10 characters, and must not
	--be null (Would need to modify for practical use, 10 characters not enough).
	FirstName varchar(20) not null default '',
	--^Our possible FirstName strings are set to support a max of 20 characters, and must not
	--be null.
	LastName varchar(20) not null default '',
	--^Our possible LastName strings are set to support a max of 20 characters, and must not
	--be null.
	Address varchar(255) not null default '',
	--^Our possible Address strings are set to support a max of 255 characters, and must not
	--be null.
	City varchar(255) not null default '',
	--^Our possible City strings are set to support a max of 255 characters, and must not
	--be null.
	State varchar(2) not null default '',
	--^Our possible State strings are set to support a max of 2 characters, and must not
	--be null.
	Zip varchar(10) not null default '',
	--^Our possible LastName strings are set to support a max of 10 characters, and must not
	--be null.
	Phone varchar(14) not null default '',
	--^Our possible Phone strings are set to support a max of 14 characters, and must not
	--be null.
	Email varchar(100) not null default '',
	--^Our possible Email strings are set to support a max of 100 characters, and must not
	--be null.
	IsReviewer bit not null default 0,
	--^By default, a User is not a reviewer, if they are to be a reviewer, this value
	--needs to be set to 1.
	IsAdmin bit not null default 0,
	--^By default, a User is not an admin, if they are to be an admin, this value
	--needs to be set to 1.
	Active bit not null default 1,
	--^By default, a User is active, if they are to be inactive, this value
	--needs to be set to 0.
	DateCreated datetime not null default getdate(),
	--^By default, when an item is created, it will be given that exact datetime value through
	--getdate().
	DateUpdated datetime,
	--^If changes are made to an item, then we update this field, but created the item does
	--not count as a change, so this can be null, and there is no default.
	UpdatedByUser int foreign key references [User](Id)
	--^Because we use this when a change is made, this is also allowed to be null, with no default.
	--This field will be used as a foreign key, referencing the [User](Id) field.
)

--^Once the table has been created, we want to comment this out, or move it to a separate script.
*/

/*
----This has been commented out after index has been created.
create unique index IX_UserName
--^This index will be used to ensure that each UserName is "unique."
	on [User](UserName)
	--^Specifies [User](UserName) as the target (Can support multiple fields by doing something
	--like [User](UserName, Password)).
*/

/*
insert into [User]
	(UserName, Password, FirstName, LastName, Address, City, State, Zip, Phone, Email, IsReviewer, IsAdmin)
	--^Even though IsReviewer and IsAdmin have defaults, like Active and DateCreated, we are added them
	--to the insert, because we don't want the default values for those two, but we do want the defaults
	--for Active and DateCreated.
	Values
	('gpdoud', 'password', 'Greg', 'Doud', '123 Example Lane', 'Loveland', 'OH', '45140', '513-703-7315', 'gdoud@maxtrain.com', 1, 1)
	--^This particular insert will add "gpdoud" as a UserName, "password" as a Password, "Greg" as a
	--FirstName, "Doud" as a LastName, "513-703-7315" as a Phone, "gdoud@maxtrain.com" as a Email,
	--and both the IsReviewer and IsAdmin fields would be set to true.
--*/

--create procedure ValidateLogin
--^The first time I ran this, we needed to create the stored procedure, but now that it is stored,
--the line below this one alters the stored procedure.
/*
alter procedure ValidateLogin
	@UserName varchar(20),
	@Password varchar(20)
	--^The two parameters that we are bringing in are the variables @UserName and @Password, both
	--of which support 20 characters.
	as
	begin 
		--^Now that we know which parameters we need, let's get started.
		if exists (select UserName, Password from [User] where UserName = @UserName and Password = @Password)
			--If the parameters we set up, in this case, @UserName and @Password, exist, then the lines below
			--are run, where the message "You have entered a valid UserName and Password" is printed.  If this
			--is not the case, "This UserName and Password combination is invalid" is printed instead.
			begin
				print 'You have entered a valid UserName and Password'
			end
			else
			begin
				print 'This UserName and Password combination is invalid'
			end
	end
	--^That ends the stored procedure, let's "go!"
go
*/
exec ValidateLogin
	--Calls the stored procedure ValidateLogin.
	@UserName = 'gpdoud',
	@Password = 'password'
	--The two parameters that are being pushed to ValidateLogin are @UserName and @Password, and
	--they are defined as 'gpdoud' and 'password' respectively.

/*
create table Vendor(
	Id int not null primary key identity(1,1),
	--^Sets up the primary key as "Id," with the value starting at 1, and incrementing by 1.
	Code varchar(10) not null,
	--^Our possible Code strings are set to support a max of 10 characters, and must not
	--be null (Will be used to store stock market code for company).
	Name varchar(255) not null default '',
	--^Our possible Name strings are set to support a max of 255 characters, and must not
	--be null.
	Address varchar(255) not null default '',
	--^Our possible Address strings are set to support a max of 255 characters, and must not
	--be null.
	City varchar(255) not null default '',
	--^Our possible City strings are set to support a max of 255 characters, and must not
	--be null.
	State varchar(2) not null default '',
	--^Our possible State strings are set to support a max of 2 characters, and must not
	--be null.
	Zip varchar(10) not null default '',
	--^Our possible Address strings are set to support a max of 10 characters, and must not
	--be null.
	Phone varchar(14) not null default '',
	--^Our possible Phone strings are set to support a max of 14 characters, and must not
	--be null.
	Email varchar(100) not null default '',
	--^Our possible Email strings are set to support a max of 100 characters, and must not
	--be null.
	IsPreApproved bit not null default 0,
	--^Our IsPreApproved bit must not be null, and will be used for the purpose of defining
	--which companies are already approved or not, with the default being not automatically approved.
	Active bit not null default 1,
	--^Our Active bit must not be null, and will be used for the purpose of defining
	--whether a company is considered active or not, with the default being active.
	DateCreated datetime default getdate(),
	--^By default, when an item is created, it will be given that exact datetime value through
	--getdate().
	DateUpdated datetime,
	--^If changes are made to an item, then we update this field, but created the item does
	--not count as a change, so this can be null, and there is no default.
	UpdatedByUser int foreign key references [User](Id)
	--^Because we use this when a change is made, this is also allowed to be null, with no default.
	--This field will be used as a foreign key, referencing the [User](Id) field.
)
*/
/*
--This has been commented out after index has been created.
create unique index IX_Code
--^This index will be used to ensure that each Code is "unique."
	on Vendor(Code)
	--^Specifies Vendor(Code) as the target (Can support multiple fields by doing something
	--like Vendor(Code, Name)).
*/
/*
insert into Vendor
	(Code, Name, Address, City, State, Zip, Phone, Email, IsPreApproved)
	values
	('MSFT', 'Microsoft', '1 Microsoft Way', 'Redmond', 'WA', '98052', '425-882-8080', 'info@microsoft.com' ,'0')
insert into Vendor
	(Code, Name, Address, City, State, Zip, Phone, Email, IsPreApproved)
	values
	('GOOGL', 'Google', '1600 Amphitheatre Parkway', 'Mountain View', 'CA', '94043', '877-355-5787', 'info@google.com' ,'0')
insert into Vendor
	(Code, Name, Address, City, State, Zip, Phone, Email, IsPreApproved)
	values
	('AAPL', 'Apple', '1 Infinite Loop', 'Cupertino', 'CA', '95014', '408-974–2042', 'info@apple.com', '0')
*/

create table Product(
	Id int not null primary key identity(1,1),
	--^Sets up the primary key as "Id," with the value starting at 1, and incrementing by 1.
	VendorId int not null foreign key references Vendor(Id),
	--^Sets up the foreign key as "VendorId," referencing Vendor(Id).
	PartNumber varchar(50) not null default '',
	--^Our possible PartNumber strings are set to support a max of 50 characters, and must not
	--be null.
	Name varchar(150) not null default '',
	--^Our possible Name strings are set to support a max of 150 characters, and must not
	--be null.
	Price decimal(10,2) not null default '',
	--^Our possible Price decimal are set to support a max of 10 numbers before the decimal place, 
	--two numbers after the decimal place, and must not be null.
	Unit varchar(255) not null default '',
	--^Our possible Unit strings are set to support a max of 255 characters, and must not
	--be null.  This field will identify how the item is shipped (box, crate, etc.) or if a digital package.
	PhotoPath varchar(255) default '',
	--^Our possible PhotoPath strings are set to support a max of 255 characters, and must not
	--be null.
	Active bit not null default 1,
	--^By default, a Product is active, if they are to be inactive, this value
	--needs to be set to 0.
	DateCreated datetime not null default getdate(),
	--^By default, when an item is created, it will be given that exact datetime value through
	--getdate().
	DateUpdated datetime,
	--^If changes are made to an item, then we update this field, but created the item does
	--not count as a change, so this can be null, and there is no default.
	UpdatedByUser int foreign key references [User](Id)
	--^Because we use this when a change is made, this is also allowed to be null, with no default.
	--This field will be used as a foreign key, referencing the [User](Id) field.
)

declare @vendorId int
select @vendorId = id from Vendor where Code = 'MSFT'
insert into Product
	(VendorId, PartNumber, Name, Price, Unit, PhotoPath)
	values
	(@vendorId, '1796', 'Surface Pro', '799.00', 'Box', '')
	--https://img-prod-cms-rt-microsoft-com.akamaized.net/cms/api/am/imageFileData/RW7Li9?ver=7528&q=60&m=6&h=327&w=582&b=%23FFFFFFFF&o=f
insert into Product
	(VendorId, PartNumber, Name, Price, Unit, PhotoPath)
	values
	(@vendorId, 'W10H', 'Windows 10 Home', '119.99', 'Digital download', '')
	--https://www.windowscentral.com/sites/wpcentral.com/files/styles/larger/public/field/image/2017/03/cloudwallpaper.jpg?itok=VC2ajDrI
insert into Product
	(VendorId, PartNumber, Name, Price, Unit, PhotoPath)
	values
	(@vendorId, 'One M8', 'HTC One M8 for Windows, Gunmetal Grey 32GB (Verizon Wireless)', '158.95', 'Box', '')
	--https://images-na.ssl-images-amazon.com/images/G/01/aplusautomation/vendorimages/b6a68b13-9d07-43a1-84f7-8b2d2b4a3ab8.png._CB322355900__SR300,300_.png

declare @vendorID int
select @vendorID = id from Vendor where Code = 'GOOGL'
insert into Product
	(VendorId, PartNumber, Name, Price, Unit, PhotoPath)
	values
	(@vendorId, 'XE510C24-K01US', 'Samsung Chromebook Pro', '499.99', 'Box', '')
	--https://www.staples-3p.com/s7/is/image/Staples/s1099135_sc7?$splssku$
insert into Product
	(VendorId, PartNumber, Name, Price, Unit, PhotoPath)
	values
	(@vendorId, 'GSB', 'G Suite Business (monthly charge)', '10.00', 'Digital service', '')
	--https://gsuite.google.com/img/logo/lockup_gsuite.svg
insert into Product
	(VendorId, PartNumber, Name, Price, Unit, PhotoPath)
	values
	(@vendorId, 'G-2PW2100', 'Pixel', '649.00', 'Box', '')
	--https://ss7.vzw.com/is/image/VerizonWireless/Google_Marlin_Slate?fmt=jpg&bgc=f6f6f6&resmode=sharp2&qlt=80,1&wid=352&hei=717

declare @vendorId int
select @vendorId = id from Vendor where Code = 'AAPL'
insert into Product
	(VendorId, PartNumber, Name, Price, Unit, PhotoPath)
	values
	(@vendorId, 'A1534', 'Macbook', '1,299.00', 'Box', '')
	--https://store.storeimages.cdn-apple.com/4974/as-images.apple.com/is/image/AppleInc/aos/published/images/m/ac/macbook/select/macbook-select-space-gray-201706?wid=452&hei=420&fmt=jpeg&qlt=95&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp&.v=1497296733186
insert into Product
	(VendorId, PartNumber, Name, Price, Unit, PhotoPath)
	values
	(@vendorId, '', 'Apple TV 32GB', '149.00', 'Box', '')
	--https://store.storeimages.cdn-apple.com/4974/as-images.apple.com/is/image/AppleInc/aos/published/images/a/pp/apple/tv/apple-tv-hero-select-201510?wid=538&amp;amp;hei=535&amp;amp;fmt=jpeg&amp;amp;qlt=95&amp;amp;op_sharpen=0&amp;amp;resMode=bicub&amp;amp;op_usm=0.5,0.5,0,0&amp;amp;iccEmbed=0&amp;amp;layer=comp&amp;amp;.v=1494609288841
insert into Product
	(VendorId, PartNumber, Name, Price, Unit, PhotoPath)
	values
	(@vendorId, '', 'IPhone 7', '649.00', 'Box', '')
	--https://store.storeimages.cdn-apple.com/4974/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/select/iphone7-select-2016?wid=222&hei=305&fmt=png-alpha&qlt=95&.v=1471892660314

create table Status(
	Id INT not null primary key identity(1,1),
	--^Sets up the primary key as "Id," with the value starting at 1, and incrementing by 1.
	Description VARCHAR(20) not null default '',
	--This string will define the status of a purchase request.
	--It may be "New," "Review," "Approved," "Rejected," or "Revise."
	Active bit not null default 1,
	--^By default, a Status is active, if they are to be inactive, this value
	--needs to be set to 0.
	DateCreated datetime not null default getdate(),
	--^By default, when an item is created, it will be given that exact datetime value through
	--getdate().
	DateUpdated datetime,
	--^If changes are made to an item, then we update this field, but created the item does
	--not count as a change, so this can be null, and there is no default.
	UpdatedByUser int foreign key references [User](Id)
	--^Because we use this when a change is made, this is also allowed to be null, with no default.
	--This field will be used as a foreign key, referencing the [User](Id) field.
)

create table PurchaseRequest(
	Id int not null primary key identity(1,1),
	--^Sets up the primary key as "Id," with the value starting at 1, and incrementing by 1.
	UserId int not null foreign key references [User](Id),
	--^The PurchaseRequest will ID the User that makes the request.
	Description varchar(100),
	--^This string is what is being purchases, and may store 100 characters.
	Justification varchar(255),
	--^This string is why the purchase should go through, and may store 255 characters.
	DateNeeded datetime default dateadd(day,7,getdate())
	--^This datetime value, for the purposes of this exercise, is to be 7 days later than the current
	--datetime.  Using getdate()+7, would have also worked, but that appears to be limited to days.
	DeliveryMode varchar(25),
	--How is the item being delivered? USPS, FedEx, DHL, UPS, Digital download?  This string may
	--store 25 characters
	StatusId int not null foreign key references Status(Id),
	Total decimal(10,2) not null default '',
	SubmittedDate datetime not null getdate(),
	Active bit default 1,
	--^By default, a PurchaseRequest is active, if they are to be inactive, this value
	--needs to be set to 0.
	ReasonForRejection varchar(100)
	DateCreated datetime not null default getdate(),
	--^By default, when an item is created, it will be given that exact datetime value through
	--getdate().
	DateUpdated datetime,
	--^If changes are made to an item, then we update this field, but created the item does
	--not count as a change, so this can be null, and there is no default.
	UpdatedByUser int foreign key references [User](Id)
	--^Because we use this when a change is made, this is also allowed to be null, with no default.
	--This field will be used as a foreign key, referencing the [User](Id) field.
)

create table PurchaseRequestLineItem(
	Id int not null primary key identity(1,1),
	PurchaseRequestId int not null foreign key references PurchaseRequest(Id),
	ProductId int not null foreign key references Product(Id),
	Quantity int,
	Active bit not null default 1,
	--^By default, a PurchaseRequest is active, if they are to be inactive, this value
	--needs to be set to 0.
	DateCreated datetime not null default getdate(),
	--^By default, when an item is created, it will be given that exact datetime value through
	--getdate().
	DateUpdated datetime,
	--^If changes are made to an item, then we update this field, but created the item does
	--not count as a change, so this can be null, and there is no default.
	UpdatedByUser int foreign key references [User](Id)
	--^Because we use this when a change is made, this is also allowed to be null, with no default.
	--This field will be used as a foreign key, referencing the [User](Id) field.
)



select * from Vendor
select * from [User]