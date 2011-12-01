
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Called during checkout, determines whether to use a current customer record, update an existing one or create a new record. Called from act_register.cfm --->

<!--- Move the query into a structure --->
<cfset CustRecord = queryRowToStruct(GetTempRecord)>

<!--- Does the temporary address already exist in the customer table? ---->
<cfset CustRecord.Field_Type = this_field>
<cfset Check_ID = Application.objUsers.CheckAddress(argumentcollection=CustRecord)>
		
<cfif Check_ID IS NOT 0>  <!--- YEA! the record already exits! Use this customer ID ---->

	<cfset this_ID = Check_ID>
	<cfset whatToDo = "nothing">
	<cfset UpdateUser = "1">
	
<cfelse><!--- this record does not exist. Is it an update or brand new? --->

	<cfset CopiedFrom = attributes[this_field]>
	
	<cfif CopiedFrom is "0"><!--- if temp record was NOT a copy of a record, then it's brand new. ----> 

		<cfset WhatToDo = "ADD">
		<cfset UpdateUser = "1">
	
	<cfelse><!--- Temp was a copy that has now changed. Check if this ID was used as customer or shipping in any orders. ---->
	
		<cfquery name="FindOrdersCustomer" datasource="#Request.DS#" username="#Request.user#" 
		password="#Request.pass#" maxrows=1>
		SELECT C.Customer_ID, N.Order_No
		FROM #Request.DB_Prefix#Order_No N 
		RIGHT JOIN #Request.DB_Prefix#Customers C ON N.Customer_ID = C.Customer_ID
		WHERE C.Customer_ID = <cfqueryparam value="#CopiedFrom#" cfsqltype="CF_SQL_INTEGER">
		</cfquery>
	
		<cfquery name="FindOrdersShipto" datasource="#Request.DS#" username="#Request.user#" 
		password="#Request.pass#" maxrows=1>
		SELECT C.Customer_ID, N.Order_No
		FROM #Request.DB_Prefix#Order_No N 
		RIGHT JOIN #Request.DB_Prefix#Customers C ON N.ShipTo = C.Customer_ID
		WHERE C.Customer_ID = <cfqueryparam value="#CopiedFrom#" cfsqltype="CF_SQL_INTEGER">
		</cfquery>
	
		<cfif FindOrdersCustomer.RecordCount OR FindOrdersShipto.recordcount>
			<!--- there are orders with the old record, so we'll ADD the new record ---->
			<cfset WhatToDo = "ADD">
			<cfset UpdateUser = "0">
						
		<cfelse>
			
			<!--- no orders, so we'll UPDATE the record --->
			<cfset this_ID = CopiedFrom>
			<cfset WhatToDo = "Update">
			<cfset UpdateUser = "0">
			
		</cfif>
	</cfif>
</cfif>



<cfif WhatToDo is "ADD">

	<!--- Add the customer record --->
	<cfset this_id = Application.objUsers.AddCustomer(argumentcollection=CustRecord)>

<cfelseif WhatToDo is "Update">

	<cfset CustRecord.Address_ID = this_ID>
	<!--- Update the customer record --->
	<cfset Application.objUsers.UpdateCustomer(argumentcollection=CustRecord)>

</cfif>

<!--- If customer logged in, and this is not a PayPal billing record, update their user profile --->
<cfif Session.User_ID and UpdateUser AND GetTempRecord.Company IS NOT "PayPal Account">
	<cfquery name="UpdateUser" datasource="#Request.DS#" username="#Request.user#" 
	password="#Request.pass#">
	UPDATE #Request.DB_Prefix#Users
	SET #this_field# = <cfqueryparam value="#This_ID#" cfsqltype="CF_SQL_INTEGER">
	WHERE User_ID = <cfqueryparam value="#Session.User_ID#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
</cfif>
