<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<cfcomponent displayname="User Functions" hint="This component is used for CFWebstore User functions." output="No">
<!--- This component developed by Mary Jo Sminkey maryjo@cfwebstore.com --->
<!--- Originally developed for use with CFWebstore e-commerce (www.cfwebstore.com) --->

<!--- Requires CFMX 6 or higher --->

<!--- This code is owned by Dogpatch Software and may not be distributes or reused without permission --->

<!------------------------- COMPONENT INITIALIZATION ----------------------------------->
<cffunction name="init" access="public" output="no" returntype="users">
    <cfreturn this>
  </cffunction>

<!---------------------- BEGIN CUSTOMER ADDRESS FUNCTIONS ------------------------------>
<cffunction name="AddCustomer" access="public" returntype="any" displayname="Add a Customer Address" hint="This function takes a form submission for a customer address and adds it to the database, returning the new Customer ID">

	<cfargument name="UID" type="numeric" required="No" default="#Session.User_ID#" hint="User account associated with this record">
	<cfargument name="Basket_ID" type="string" required="No" default="#Session.BasketNum#" hint="The Basket ID for this record.">
	<cfargument name="TableName" type="string" required="No" default="Customers" hint="The table that is being updated">
	
	<cfargument name="FirstName" type="string" required="Yes">
	<cfargument name="LastName" type="string" required="Yes">
	<cfargument name="Company" type="string" required="No" default="">
	<cfargument name="Address1" type="string" required="Yes">
	<cfargument name="Address2" type="string" required="No" default="">
	<cfargument name="City" type="string" required="Yes">
	<cfargument name="County" type="string" required="No" default="">
	<cfargument name="State" type="string" required="Yes">
	<cfargument name="State2" type="string" required="No" default="">
	<cfargument name="Zip" type="string" required="Yes">
	<cfargument name="Country" type="string" required="Yes">
	<cfargument name="Phone" type="string" required="No" default="">
	<cfargument name="Phone2" type="string" required="No" default="">
	<cfargument name="Fax" type="string" required="No" default="">
	<cfargument name="Email" type="string" required="No" default="">
	<cfargument name="Residence" type="boolean" required="No" default="1">

	<cfscript>
		//queries
		var AddCustomer = '';
		var GetCustomerID = '';
		//return var
		var Customer_ID = 0;
		
		//UUID to tag new inserts
		var NewIDTag = CreateUUID();
		//Remove dashes
		NewIDTag = Replace(NewIDTag, "-", "", "All");		
	</cfscript>

	<cftransaction>		
		
	<cfquery name="AddCustomer" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	<cfif Request.dbtype IS "MSSQL">
		SET NOCOUNT ON
	</cfif>
	INSERT INTO #Request.DB_Prefix##arguments.TableName#
	(FirstName, LastName, Company, Address1, Address2, City, County, State, State2, Zip, Country, Phone, Residence, 
	<cfif arguments.TableName IS NOT "TempShipTo">
		Phone2, Fax, Email, 
	</cfif>
	<cfif arguments.TableName IS "Customers">
		ID_Tag, User_ID, LastUsed
	<cfelseif arguments.TableName IS "TempCustomer">
		ShipToYes, TempCust_ID, DateAdded
	<cfelseif arguments.TableName IS "TempShipTo">
		TempShip_ID, DateAdded
	</cfif> )
	VALUES (
		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.firstName)#">,
		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.LastName)#">,
		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.Company)#">,
		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.Address1)#">,
		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.Address2)#">,
		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.City)#">,
		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.County)#">,
		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.State)#">,
		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.State2)#">,
		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.Zip)#">,
		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.Country)#">,
		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.Phone)#">,
		<cfqueryparam cfsqltype="#Request.SQL_Bit#" value="#arguments.residence#">,
		
		<cfif arguments.TableName IS NOT "TempShipTo">
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.Phone2)#">,
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.Fax)#">,
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.Email)#">,
		</cfif>
		
		<cfif arguments.TableName IS "Customers">			
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#NewIDTag#">, 
			<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.UID#">,
		<cfelseif arguments.TableName IS "TempCustomer">
			1, <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.Basket_ID#">,
		<cfelseif arguments.TableName IS "TempShipTo">
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.Basket_ID#">,
		</cfif>
				
		<cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#Now()#"> )
		
		<cfif Request.dbtype IS "MSSQL" AND arguments.TableName IS "Customers">
			SELECT @@Identity AS newID
			SET NOCOUNT OFF
		</cfif>
	</cfquery>				
			
	<cfif arguments.TableName IS "Customers" AND Request.dbtype IS NOT "MSSQL">
		<cfquery name="AddCustomer" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT Customer_ID AS newID 
		FROM #Request.DB_Prefix#Customers
		WHERE ID_Tag = '#NewIDTag#'
		</cfquery>
	</cfif>

	</cftransaction>
	
	<cfif arguments.TableName IS "Customers">	
		<cfset Customer_ID = AddCustomer.newID>
	<cfelse>
		<cfset Customer_ID = arguments.Basket_ID>
	</cfif>

	<cfreturn Customer_ID>


</cffunction>


<cffunction name="UpdateCustomer" displayname="Update a Customer Address" hint="This function takes a form submission for a customer address and updates it in the database." access="public" returntype="void">

	<cfargument name="UID" type="numeric" required="No" default="#Session.User_ID#" hint="User account associated with this record">
	<cfargument name="Address_ID" type="numeric" required="No" default="0" hint="The Customer ID to update.">
	<cfargument name="Basket_ID" type="string" required="No" default="#Session.BasketNum#" hint="The Basket ID to update.">
	<cfargument name="TableName" type="string" required="No" default="Customers" hint="The table that is being updated">
	
	<!--- The fields for the customer address --->
	<cfargument name="FirstName" type="string" required="Yes">
	<cfargument name="LastName" type="string" required="Yes">
	<cfargument name="Company" type="string" required="No" default="">
	<cfargument name="Address1" type="string" required="Yes">
	<cfargument name="Address2" type="string" required="No" default="">
	<cfargument name="City" type="string" required="Yes">
	<cfargument name="County" type="string" required="No" default="">
	<cfargument name="State" type="string" required="Yes">
	<cfargument name="State2" type="string" required="No" default="">
	<cfargument name="Zip" type="string" required="Yes">
	<cfargument name="Country" type="string" required="Yes">
	<cfargument name="Phone" type="string" required="No" default="">
	<cfargument name="Phone2" type="string" required="No" default="">
	<cfargument name="Fax" type="string" required="No" default="">
	<cfargument name="Email" type="string" required="No" default="">
	<cfargument name="Residence" type="boolean" required="No" default="1">

	<cfscript>
		//queries
		var UpdateCustomer = '';
	</cfscript>
		
	<cfquery name="UpdateCustomer" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		UPDATE #Request.DB_Prefix##arguments.TableName# 
		SET FirstName = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.firstName)#">,
		LastName = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.LastName)#">,
		Company = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.Company)#">,
		Address1 = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.Address1)#">,
		Address2 = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.Address2)#">,
		City = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.City)#">,
		County = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.County)#">,
		State = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.State)#">,
		State2 = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.State2)#">,
		Zip = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.Zip)#">,
		Country = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.Country)#">,
		Phone = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.Phone)#">,
		Email = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.Email)#">,
		Residence = <cfqueryparam cfsqltype="#Request.SQL_Bit#" value="#arguments.residence#">,
		Phone2 = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.Phone2)#">,
		Fax = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.Fax)#">,
		<cfif arguments.TableName IS "Customers">		
			LastUsed = <cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#Now()#">,
			User_ID = <cfqueryparam value="#arguments.UID#" cfsqltype="CF_SQL_INTEGER">
			WHERE Customer_ID = <cfqueryparam value="#arguments.Address_ID#" cfsqltype="CF_SQL_INTEGER">
		<cfelseif arguments.TableName IS "TempCustomer">
			ShipToYes = <cfqueryparam cfsqltype="#Request.SQL_Bit#" value="#arguments.shiptoyes#">
			WHERE TempCust_ID = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.Basket_ID#">
		</cfif>
	</cfquery>

</cffunction>

<cffunction name="CheckAddress" displayname="Check a Customer Address" hint="This function takes a form submission for a customer address and checks if it already exists for that user. If found, returns the Customer ID." access="public" returntype="numeric">

	<cfargument name="UID" type="numeric" required="No" default="#Session.User_ID#" hint="User account associated with this record">
	<cfargument name="Field_Type" type="string" required="Yes">
	<cfargument name="FirstName" type="string" required="Yes">
	<cfargument name="LastName" type="string" required="Yes">
	<cfargument name="Company" type="string" required="No" default="">
	<cfargument name="Address1" type="string" required="Yes">
	<cfargument name="Address2" type="string" required="No" default="">
	<cfargument name="City" type="string" required="Yes">
	<cfargument name="County" type="string" required="No" default="">
	<cfargument name="State" type="string" required="Yes">
	<cfargument name="State2" type="string" required="No" default="">
	<cfargument name="Zip" type="string" required="Yes">
	<cfargument name="Country" type="string" required="Yes">
	<cfargument name="Phone" type="string" required="No" default="">
	<cfargument name="Phone2" type="string" required="No" default="">
	<cfargument name="Fax" type="string" required="No" default="">
	<cfargument name="Email" type="string" required="No" default="">

	<cfscript>
		//queries
		var CheckCustomer = '';
		//return var
		var Customer_ID = 0;
	</cfscript>
	
	<cfquery name="CheckCustomer" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows=1>
		SELECT Customer_ID FROM #Request.DB_Prefix#Customers
		WHERE FirstName = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.firstName)#"> 
		AND	LastName = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.LastName)#"> 
		AND Company = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.Company)#"> 
		AND	Address1 = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.Address1)#"> 
		AND	Address2 = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.Address2)#"> 
		AND	City = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.City)#"> 
		AND	County = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.County)#"> 
		AND	State = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.State)#"> 
		AND	State2 = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.State2)#"> 
		AND	Zip = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.Zip)#"> 
		AND	Country = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.Country)#"> 
		AND Phone = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.Phone)#">
		
		<cfif arguments.Field_Type is "customer_id">
		AND Email = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.Email)#">
		AND Phone2 = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.Phone2)#">
		AND Fax = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.Fax)#">
		</cfif>
		
		AND User_ID = <cfqueryparam value="#arguments.UID#" cfsqltype="CF_SQL_INTEGER">
	
	</cfquery>
	
	<cfif CheckCustomer.RecordCount>
		<cfset Customer_ID = CheckCustomer.Customer_ID>
	</cfif>
	
	<cfreturn Customer_ID>
	
</cffunction>


<cffunction name="AddBlankRecord" access="public" returntype="void" displayname="Add a Blank Temp Record" hint="This function is used during checkout to initialize the temporary customer tables.">

	<cfargument name="Basket_ID" type="string" required="No" default="#Session.BasketNum#" hint="The Basket ID to add the record for.">
	<cfargument name="TableName" type="string" required="No" default="TempCustomer" hint="The table to add the record for.">
	
	<cfquery name="AddCustomer" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	INSERT INTO #Request.DB_Prefix##arguments.TableName#
		(FirstName, LastName, Company, Address1, Address2, City, County, State, State2, Zip, Country, Phone, Residence, 
		<cfif arguments.TableName IS "TempCustomer">
			Phone2, Fax, Email, ShipToYes, TempCust_ID, DateAdded
		<cfelseif arguments.TableName IS "TempShipTo">
			TempShip_ID, DateAdded
		</cfif> )
		VALUES (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1,
		<cfif arguments.TableName IS "TempCustomer">
			NULL, NULL, NULL, 1, <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.Basket_ID#">,
		<cfelseif arguments.TableName IS "TempShipTo">
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.Basket_ID#">,
		</cfif>
				
		<cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#Now()#"> )
	</cfquery>		

</cffunction>

<!---------------------- END CUSTOMER ADDRESS FUNCTIONS ------------------------------>

<!---------------------- BEGIN USER ACCOUNT FUNCTIONS ------------------------------>
<cffunction name="AddUser" access="public" returntype="numeric" displayname="Add a User" hint="This function adds a new user account and returns the new user ID.">

	<cfargument name="admin" type="boolean" required="No" default="No" hint="Used to set if this is an admin user, for which fields can be entered.">
	<cfargument name="email" type="string" required="Yes">
	<cfargument name="username" type="string" required="Yes">
	<cfargument name="password" type="string" required="Yes">
	<cfargument name="Subscribe" type="boolean" required="No" default="No">
	<cfargument name="Birthdate" type="string" required="No" default="">
	<cfargument name="Group_ID" type="numeric" required="No" default="#Session.Group_ID#">
	<!--- Credit card fields --->
	<cfargument name="CardType" type="string" required="No" default="">
	<cfargument name="NameOnCard" type="string" required="No" default="">
	<cfargument name="CardNumber" type="string" required="No" default="">
	<cfargument name="CardZip" type="string" required="No" default="">
	<cfargument name="Month" type="string" required="No" default="">
	<cfargument name="Year" type="string" required="No" default="">
	<!--- Admin Access Only --->
	<cfargument name="CurrentBalance" type="any" required="No" default="0">
	<cfargument name="AdminNotes" type="string" required="No" default="">
	<!--- Login Settings, Admin Access Only --->
	<cfargument name="EmailIsBad" type="boolean" required="No" default="No">
	<cfargument name="Disable" type="boolean" required="No" default="No">
	<cfargument name="CardisValid" type="boolean" required="No" default="No">
	
	<cfscript>
	//queries 
	var AddUser = '';
	var GetID = '';
	
	//return var
	var User_ID = 0;
	//other local vars
	var v = StructNew();
	
	//UUID to tag new inserts
	var NewIDTag = CreateUUID();
	//Remove dashes
	NewIDTag = Replace(NewIDTag, "-", "", "All");	
	
	if (len(arguments.Month) AND len(arguments.Year)) {
		v.tempdate = CreateDate(arguments.year, arguments.Month, "1");
		v.lastday = DaysInMonth(v.tempdate);
		v.expdate = CreateDate(arguments.year, arguments.Month, v.lastday);
		}
	else
		v.expdate = Now();
	
	</cfscript>
	
	<!--- encrypt the credit card number --->
	<cfif len(arguments.CardNumber)>
		<cfmodule template="../../customtags/crypt.cfm" return="v.crypt" string="#arguments.CardNumber#" key="#Request.encrypt_key#">
	</cfif>

	<cftransaction isolation="SERIALIZABLE">

	<cfquery name="AddUser" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	<cfif Request.dbtype IS "MSSQL">
		SET NOCOUNT ON
	</cfif>
	INSERT INTO #Request.DB_Prefix#Users
	(ID_Tag, Email, Username, Password, Subscribe, Birthdate, Group_ID,
	CardType, NameonCard, CardNumber, EncryptedCard, CardExpire, CardZip, CurrentBalance, 
	EmailIsBad, Disable, CardisValid, AdminNotes, Basket, 
	LastLogin, LastAttempt, Created, LastUpdate, FailedLogins, LoginsDay, LoginsTotal, 
	Customer_ID, ShipTo, Affiliate_ID, EmailLock)
	VALUES 
	(<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#NewIDTag#">, 
	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#trim(arguments.email)#">, 
	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#trim(arguments.username)#">,
	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Hash(trim(arguments.password))#">, 
	<cfqueryparam cfsqltype="#Request.SQL_Bit#" value="#arguments.Subscribe#">,
	<cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#arguments.birthdate#" null="#YesNoFormat(NOT isDate(arguments.birthdate))#">,
	<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Group_ID#">,
	<!--- Credit card fields --->
	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.CardType#">, 
	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.NameOnCard#">,
	<cfif len(arguments.CardNumber)>
		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="XXXXXXXXXXXX#right(arguments.cardnumber,4)#">, 
		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#v.crypt.value#">,
	<cfelse>
		Null, Null, 
	</cfif>
	<cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#v.expdate#" null="#YesNoFormat(NOT isDate(v.expdate))#">,
	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.CardZip#">,
	<!--- Start the admin fields --->
	<cfif arguments.admin>
		<cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#iif(isNumeric(arguments.CurrentBalance), arguments.CurrentBalance, 0)#">,
		<cfqueryparam cfsqltype="#Request.SQL_Bit#" value="#arguments.EmailIsBad#">,
		<cfqueryparam cfsqltype="#Request.SQL_Bit#" value="#arguments.Disable#">,
		<cfqueryparam cfsqltype="#Request.SQL_Bit#" value="#arguments.CardisValid#">,
		<cfqueryparam cfsqltype="CF_SQL_LONGVARCHAR" value="#arguments.AdminNotes#">,
		NULL, 
	<cfelse>
		0, 0, 0, 1, Null, 
		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.BasketNum#">, 
	</cfif>
	<cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#Now()#">,
	<cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#Now()#">,
	<cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#Now()#">,
	<cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#Now()#">,
	0, 1, 1, 0, 0, 0, Null )
	
	<cfif Request.dbtype IS "MSSQL">
		SELECT @@Identity AS newID
		SET NOCOUNT OFF
	</cfif>
	</cfquery>
	
	<cfif Request.dbtype IS NOT "MSSQL">				
		<cfquery name="AddUser" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
			SELECT User_ID AS newID 
			FROM #Request.DB_Prefix#Users
			WHERE ID_Tag = '#NewIDTag#'
		</cfquery>
	</cfif>
	</cftransaction>
	
	<cfset User_ID = AddUser.newID>
	
	<cfreturn User_ID>

</cffunction>

<cffunction name="UpdateUser" access="public" returntype="void" displayname="Update a User" hint="This function updates a user account.">

	<cfargument name="UID" type="numeric" required="Yes" hint="The user account to update.">
	<cfargument name="edittype" type="string" required="No" default="user" hint="Used to set which type of user update is being run.">
	<cfargument name="email" type="string" required="No" default="">
	<cfargument name="username" type="string" required="No" default="">
	<cfargument name="password" type="string" required="No" default="">
	<cfargument name="Subscribe" type="boolean" required="No" default="No">
	<cfargument name="Birthdate" type="string" required="No" default="">
	<cfargument name="Group_ID" type="numeric" required="No" default="#Session.Group_ID#">
	<!--- Credit card fields --->
	<cfargument name="CardType" type="string" required="No" default="">
	<cfargument name="NameOnCard" type="string" required="No" default="">
	<cfargument name="CardNumber" type="string" required="No" default="">
	<cfargument name="CardZip" type="string" required="No" default="">
	<cfargument name="Month" type="string" required="No" default="">
	<cfargument name="Year" type="string" required="No" default="">
	<cfargument name="CardisValid" type="boolean" required="No" default="0">
	<!--- CC Balance, Admin only --->
	<cfargument name="CurrentBalance" type="any" required="No" default="0">
	<!--- Admin Access Only --->
	<cfargument name="Customer_ID" type="numeric" required="No" default="0" hint="Customer ID for this account">
	<cfargument name="ShipTo" type="numeric" required="No" default="0">
	<cfargument name="Affiliate_ID" type="numeric" required="No" default="0">
	<cfargument name="AdminNotes" type="string" required="No" default="">
	<!--- Login Settings, Admin Access Only --->
	<cfargument name="EmailIsBad" type="boolean" required="No" default="No">
	<cfargument name="EmailLock" type="string" required="No" default="">
	<cfargument name="Disable" type="boolean" required="No" default="No">
	<cfargument name="LoginsTotal" type="numeric" required="No" default="0">
	<cfargument name="LoginsDay" type="numeric" required="No" default="0">
	<cfargument name="FailedLogins" type="numeric" required="No" default="0">
	<cfargument name="LastLogin" type="any" required="No" default="">
	<cfargument name="ResetCounts" type="boolean" required="No" default="No" hint="Used to reset daily counts, to unlock user login.">
	
	<cfscript>
	//queries 
	var UpdateUser = '';
	//other local vars
	var v = StructNew();
	
	if (len(arguments.Month) AND len(arguments.Year)) {
		v.tempdate = CreateDate(arguments.year, arguments.Month, "1");
		v.lastday = DaysInMonth(v.tempdate);
		v.expdate = CreateDate(arguments.year, arguments.Month, v.lastday);
		}
	else
		v.expdate = Now();
	
	</cfscript>
	
	<!--- encrypt the credit card number --->
	<cfif len(arguments.CardNumber) AND Left(arguments.CardNumber, 1) IS NOT 'X'>
		<cfmodule template="../../customtags/crypt.cfm" return="v.crypt" string="#arguments.CardNumber#" key="#Request.encrypt_key#">
	</cfif>
	
	<cfquery name="UpdateUser" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" >
		UPDATE #Request.DB_Prefix#Users
		SET 
		<!--- user fields --->
		<cfif ListFind("user,admin,birthdate", arguments.edittype)>
			Birthdate = <cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#arguments.birthdate#" 
											null="#YesNoFormat(NOT isDate(arguments.birthdate))#">, 
			Subscribe = <cfqueryparam cfsqltype="#Request.SQL_Bit#" value="#arguments.Subscribe#">, 
		</cfif>
		
		<!--- credit card fields --->
		<cfif ListFind("user,cc,admin", arguments.edittype)>
			CardType = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.CardType#">, 
			NameonCard = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.NameOnCard#">,  
			<cfif len(arguments.CardNumber)>
				CardNumber = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="XXXXXXXXXXXX#right(arguments.cardnumber,4)#">, 
				<cfif isDefined("v.crypt.value")>
					EncryptedCard = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#v.crypt.value#">, 
				</cfif>
			<cfelse>
				CardNumber = Null, EncryptedCard = Null, 
			</cfif>
			CardExpire = <cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#v.expdate#" null="#YesNoFormat(NOT isDate(v.expdate))#">,
			CardZip = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.CardZip#">, 
			CardisValid = <cfqueryparam cfsqltype="#Request.SQL_Bit#" value="#arguments.CardisValid#">, 
		</cfif>
		
		<!--- email fields --->
		<cfif ListFind("email,emailasname,admin", arguments.edittype)>
			Email = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#trim(arguments.email)#">, 
			EmailIsBad = <cfqueryparam cfsqltype="#Request.SQL_Bit#" value="#arguments.EmailIsBad#">, 
			EmailLock = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.EmailLock#" null="#YesNoFormat(NOT len(arguments.EmailLock))#">, 
		</cfif>
			
		<!--- login fields --->
		<cfif ListFind("email,emailasname,password,admin", arguments.edittype)>
			<cfif len(trim(arguments.username))>
				Username = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#trim(arguments.username)#">, 
			</cfif>
			<cfif len(Trim(arguments.password))>
				Password = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Hash(trim(arguments.password))#">,  
			</cfif>
		</cfif>
		
		<!--- admin only fields --->
		<cfif edittype IS "admin">	
			AdminNotes =  <cfqueryparam cfsqltype="CF_SQL_LONGVARCHAR" value="#arguments.AdminNotes#">, 
			Group_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.group_id#">, 
			Customer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.customer_id#">, 
			ShipTo = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.shipto#">, 
			Affiliate_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" 
								value="#arguments.affiliate_id#" null="#YesNoFormat(arguments.affiliate_ID IS 0)#">, 
			Disable = <cfqueryparam cfsqltype="#Request.SQL_Bit#" value="#arguments.Disable#">, 
			CurrentBalance = <cfqueryparam cfsqltype="CF_SQL_DOUBLE" 
							value="#iif(isNumeric(arguments.CurrentBalance), arguments.CurrentBalance, 0)#">, 
			<cfif arguments.ResetCounts>
				LoginsDay = 0, 
				FailedLogins = 0, 
			</cfif>
			<cfif isDate(arguments.LastLogin)>
				LastLogin = <cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#arguments.LastLogin#">, 
			</cfif>
			
		</cfif>
		LastUpdate = <cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#Now()#">
		WHERE User_ID = #arguments.uid#
	</cfquery>
	
</cffunction>	

<!---------------------- END USER ACCOUNT FUNCTIONS ------------------------------>


<!---------------------- BEGIN BUSINESS ACCOUNT FUNCTIONS ------------------------------>
<cffunction name="AddAccount" access="public" returntype="numeric" displayname="Add a new Business Account" hint="This function takes a form submission for a business account and adds it to the database, returning the new Account ID">

	<cfargument name="UID" type="numeric" required="No" default="#Session.User_ID#" hint="User ID associated with this record">
	<cfargument name="Acc_Customer_ID" type="numeric" required="Yes" hint="Customer ID used for the account">
	<cfargument name="Acc_Account_Name" type="string" required="Yes">
	<cfargument name="Acc_type1" type="string" required="Yes">
	<cfargument name="Acc_Description" type="string" required="No" default="">
	<cfargument name="Acc_Policy" type="string" required="No" default="">
	<cfargument name="Acc_rep" type="string" required="No" default="">
	<cfargument name="Acc_web_url" type="string" required="No" default="">
	<cfargument name="Acc_Map_URL" type="string" required="No" default="">
	<cfargument name="Acc_terms" type="string" required="No" default="">
	<!--- Admin-only fields --->
	<cfargument name="Acc_Logo" type="string" required="No" default="">
	<cfargument name="Acc_Dropship_Email" type="string" required="No">
	<cfargument name="Acc_PO_Text" type="string" required="No">
	<cfargument name="Acc_Directory_Live" type="boolean" required="No">
	
	<cfscript>
		//queries
		var AddAccount = '';
		var GetAccountID = '';
		//return var
		var Account_ID = 0;
		//other vars
		var WebURL = '';
		
		//UUID to tag new inserts
		var NewIDTag = CreateUUID();
		//Remove dashes
		NewIDTag = Replace(NewIDTag, "-", "", "All");	
		
		if (NOT FindNoCase("http", arguments.Acc_web_url))
			WebURL = "http://" & Trim(arguments.Acc_web_url);
		else
			WebURL = Trim(arguments.Acc_web_url);
	</cfscript>
	
	<cftransaction>
	
		<cfquery name="AddAccount" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			<cfif Request.dbtype IS "MSSQL">
				SET NOCOUNT ON
			</cfif>
			INSERT INTO #Request.DB_Prefix#Account
			(ID_Tag, User_ID, Customer_ID, Account_Name, Description, Policy,
			Type1, Rep, Web_URL, Map_URL, Terms, 
			<cfif isDefined("arguments.Acc_Dropship_Email")>
				Dropship_Email, PO_Text, Directory_Live, Logo, 
			</cfif> LastUsed)
			VALUES (<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#NewIDTag#">, 
			<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.UID#">,
			<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Acc_Customer_ID#">, 			
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.Acc_Account_Name)#">,
			<cfqueryparam cfsqltype="CF_SQL_LONGVARCHAR" value="#Trim(arguments.Acc_Description)#">,
			<cfqueryparam cfsqltype="CF_SQL_LONGVARCHAR" value="#Trim(arguments.Acc_Policy)#">,
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.Acc_type1)#">,
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.Acc_rep)#">,
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#WebURL#">,
			<cfqueryparam cfsqltype="CF_SQL_LONGVARCHAR" value="#Trim(arguments.Acc_Map_URL)#">,
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.Acc_terms)#">,
			<cfif isDefined("arguments.Acc_Dropship_Email")>
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.Acc_Dropship_Email)#">,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.Acc_PO_Text)#">,
				<cfqueryparam cfsqltype="#Request.SQL_Bit#" value="#arguments.Acc_Directory_Live#">,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.Acc_logo)#">,
			</cfif>
			<cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#Now()#">)
			
			<cfif Request.dbtype IS "MSSQL">
				SELECT @@Identity AS newID
				SET NOCOUNT OFF
			</cfif>	
		</cfquery>
		
		<cfif Request.dbtype IS NOT "MSSQL">
			<cfquery name="AddAccount" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
			SELECT Account_ID AS newID 
			FROM #Request.DB_Prefix#Account
			WHERE ID_Tag = '#NewIDTag#'
			</cfquery>
		</cfif>
				
	</cftransaction>
	
	<cfset Account_ID = AddAccount.newID>
	
	<cfreturn Account_ID>
	
	
</cffunction>

<cffunction name="UpdateAccount" access="public" returntype="void" displayname="Update a Business Account" hint="This function takes a form submission for a business account and updates the record in the database">

	<cfargument name="UID" type="numeric" required="No" default="#Session.User_ID#" hint="User ID associated with this record">
	<cfargument name="Acc_Account_ID" type="numeric" required="Yes" hint="The Account to update.">
	<cfargument name="Acc_Customer_ID" type="numeric" required="No" default="0" hint="Customer ID used for the account">
	<cfargument name="Acc_Account_Name" type="string" required="Yes">
	<cfargument name="Acc_type1" type="string" required="Yes">
	<cfargument name="Acc_Description" type="string" required="No" default="">
	<cfargument name="Acc_Policy" type="string" required="No" default="">
	<cfargument name="Acc_rep" type="string" required="No" default="">
	<cfargument name="Acc_web_url" type="string" required="No" default="">
	<cfargument name="Acc_Map_URL" type="string" required="No" default="">
	<cfargument name="Acc_terms" type="string" required="No" default="">
	<!--- Admin-only fields --->
	<cfargument name="Acc_Dropship_Email" type="string" required="No">
	<cfargument name="Acc_PO_Text" type="string" required="No">
	<cfargument name="Acc_Directory_Live" type="boolean" required="No">
	<cfargument name="Acc_Logo" type="string" required="No" default="">
	
	<cfscript>
		//queries
		var UpdAccount = '';
		//other vars
		var WebURL = '';
		
		if (NOT FindNoCase("http", arguments.Acc_web_url))
			WebURL = "http://" & Trim(arguments.Acc_web_url);
		else
			WebURL = Trim(arguments.Acc_web_url);
	</cfscript>
	
	<cftransaction isolation="SERIALIZABLE">
	
		<cfquery name="AddAccount" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			UPDATE #Request.DB_Prefix#Account
			SET Account_Name = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.Acc_Account_Name)#">,
				Description = <cfqueryparam cfsqltype="CF_SQL_LONGVARCHAR" value="#Trim(arguments.Acc_Description)#">,
				Type1 = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.Acc_type1)#">,
				Policy = <cfqueryparam cfsqltype="CF_SQL_LONGVARCHAR" value="#Trim(arguments.Acc_Policy)#">,
				Rep = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.Acc_rep)#">,
				Web_URL = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#WebURL#">,
				Map_URL = <cfqueryparam cfsqltype="CF_SQL_LONGVARCHAR" value="#Trim(arguments.Acc_Map_URL)#">,
				Terms = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.Acc_terms)#">,
				<cfif isDefined("arguments.Acc_Dropship_Email")>
					Dropship_Email = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.Acc_Dropship_Email)#">,
					PO_Text = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.Acc_PO_Text)#">,
					Directory_Live = <cfqueryparam cfsqltype="#Request.SQL_Bit#" value="#arguments.Acc_Directory_Live#">,
					Logo = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(arguments.Acc_logo)#">,
				</cfif>
				<cfif arguments.Acc_Customer_ID IS NOT 0>
				Customer_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Acc_Customer_ID#">,
				</cfif>
				User_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.UID#">,
				LastUsed = <cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#Now()#">
			WHERE Account_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Acc_Account_ID#">
		</cfquery>
				
	</cftransaction>
	
</cffunction>

<cffunction name="GetAccount" access="public" returntype="query" displayname="Get a Business Account" hint="This function takes an account ID and returns the needed information for that business account.">
	<cfargument name="Account_ID" type="numeric" required="Yes" hint="The Account to retrieve.">
	
	<cfset var qry_Get_Account = ''>	
	
	<cfquery name="qry_Get_Account" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT Account_ID, Account_Name, Logo
		FROM #Request.DB_Prefix#Account 
		WHERE Account_ID = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.Account_ID#">
	</cfquery>
	
	<cfreturn qry_Get_Account>

</cffunction>
<!---------------------- END BUSINESS ACCOUNT FUNCTIONS ------------------------------>
	

</cfcomponent>