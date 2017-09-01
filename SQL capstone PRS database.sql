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
	--be null.
	FirstName varchar(20) not null,
	--^Our possible FirstName strings are set to support a max of 20 characters, and must not
	--be null.
	LastName varchar(20) not null,
	--^Our possible LastName strings are set to support a max of 20 characters, and must not
	--be null.
	Address varchar(255) not null,
	City varchar(255) not null,
	State varchar(2) not null,
	Zip varchar(5) not null,
	Phone varchar(12) not null,
	--^Our possible Phone strings are set to support a max of 12 characters, and must not
	--be null.
	Email varchar(75) not null,
	--^Our possible Email strings are set to support a max of 75 characters, and must not
	--be null.
	IsReviewer bit not null default 0,
	--^By default, a User is not a reviewer, if they are to be a reviewer, this value
	--needs to be set to 1.
	IsAdmin bit not null default 0,
	--^By default, a User is not an admin, if they are to be an admin, this value
	--needs to be set to 1.
	Active bit not null default 1,
	--^By default, a User is a active, if they are to be inactive, this value
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

^Once the table has been created, we want to comment this out, or move it to a separate script.
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
	(UserName, Password, FirstName, LastName, Phone, Email, IsReviewer, IsAdmin)
	--^Even though IsReviewer and IsAdmin have defaults, like Active and DateCreated, we are added them
	--to the insert, because we don't want the default values for those two, but we do want the defaults
	--for Active and DateCreated.
	Values
	('gpdoud', 'password', 'Greg', 'Doud', '513-703-7315', 'gdoud@maxtrain.com', 1, 1)
	--^This particular insert will add "gpdoud" as a UserName, "password" as a Password, "Greg" as a
	--FirstName, "Doud" as a LastName, "513-703-7315" as a Phone, "gdoud@maxtrain.com" as a Email,
	--and both the IsReviewer and IsAdmin fields would be set to true.
*/

--create procedure ValidateLogin
--^The first time I ran this, we needed to create the stored procedure, but now that it is stored,
--the line below this one alters the stored procedure.
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

exec ValidateLogin
	--Calls the stored procedure ValidateLogin.
	@UserName = 'gpdoud',
	@Password = 'password'
	--The two parameters that are being pushed to ValidateLogin are @UserName and @Password, and
	--they are defined as 'gpdoud' and 'password' respectively.

/*
create table Vendor(
	Id int not null primary key identity(1,1),
	Code varchar(10) not null,
	--^Must be unique, set up index for
	Name varchar(255) not null,
	Address varchar(255) not null,
	City varchar(255) not null,
	State varchar(2) not null,
	Zip varchar(5) not null,
	Phone varchar(12) not null,
	Email varchar(100) not null,
	IsPreApproved bit not null default 0,
	Active bit not null default 1,
	DateCreated datetime default getdate(),
	DateUpdated datetime,
	UpdatedByUser int foreign key references [User](Id)
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

select * from Vendor