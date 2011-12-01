<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template is called from the users.register switch (do_register.cfm) and saves the dsp_customer.cfm form information. It is also called from users.address and users.member circuits. --->

<cfparam name="attributes.xfa_customer_success" default="">
<cfparam name="attributes.phone2" default="">
<cfparam name="attributes.email" default="">
<cfparam name="attributes.fax" default="">
<cfset attributes.Message="">
<cfset accessokay = "yes">

<!--- Check for a blank state in the address --->
<cfif NOT len(attributes.State)>
	<cfset attributes.State = 'Unlisted'>
</cfif>

<!--- If not adding a new customer, check that the user has access to this user record --->
<cfif attributes.submit_customer IS NOT "Add">
	<cfquery name="CheckUser" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows=1>
			SELECT Customer_ID
			FROM #Request.DB_Prefix#Customers 
			WHERE User_ID = <cfqueryparam value="#Session.User_ID#" cfsqltype="CF_SQL_INTEGER">
			AND Customer_ID = <cfqueryparam value="#attributes.customer_ID#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
	<cfif NOT CheckUser.RecordCount>
		<cfset accessokay = "no">
	</cfif>
</cfif>

<!--- Make sure required fields are not blank --->
<cfif len(trim(attributes.FirstName)) AND len(trim(attributes.LastName)) AND len(trim(attributes.Address1)) AND len(trim(attributes.City)) AND len(trim(attributes.Zip))>

<!--- Make sure user has access to the requested customer account --->

	<cfif accessokay>
			
		<cfswitch expression = "#attributes.submit_customer#">
	
			<cfcase value="Add">
					
				<!--- Check database for duplicate record --->
				<cfset attributes.UID = Session.User_ID>
				<cfset attributes.Field_Type = "customer_id">
				<cfset Check_ID = Application.objUsers.CheckAddress(argumentcollection=attributes)>
				
				<cfif Check_ID IS NOT 0>
		
					<cfset attributes.customer_id = Check_ID>
		
				<cfelse>		
					<!--- if no record exits, then add it --->	
					<cfset attributes.UID = Session.User_ID>
					<cfset attributes.customer_id = Application.objUsers.AddCustomer(argumentcollection=attributes)>
				
				</cfif>
				
			</cfcase>
	
			<cfcase value="update">
			
				<!--- first check to see if record has any orders --->
				<cfquery name="FindCustomer" datasource="#Request.DS#" username="#Request.user#" 	
				password="#Request.pass#" maxrows=1>
				SELECT C.*, N.Order_No
				FROM #Request.DB_Prefix#Order_No N 
				RIGHT JOIN #Request.DB_Prefix#Customers C ON N.Customer_ID = C.Customer_ID
				WHERE C.Customer_ID = <cfqueryparam value="#attributes.customer_ID#" cfsqltype="CF_SQL_INTEGER">
				</cfquery>
	
			
				<cfif FindCustomer.RecordCount AND NOT len(FindCustomer.Order_No)>
				<!--- if no orders, update record --->
					<cfset update_record = "YES">			
				<cfelse>
				<!--- if orders, compare update with record --->
					<cfif findcustomer.FirstName IS Trim(attributes.FirstName) 
					AND findcustomer.LastName IS Trim(attributes.LastName) 
					AND findcustomer.Company IS Trim(attributes.Company) 
					AND	findcustomer.Address1 IS Trim(attributes.Address1) 
					AND findcustomer.Address2 IS Trim(attributes.Address2)
					AND findcustomer.City IS Trim(attributes.City) 
					AND findcustomer.County IS attributes.County 
					AND findcustomer.State IS attributes.State 
					AND findcustomer.State2 IS Trim(attributes.State2)
					AND findcustomer.Zip IS Trim(attributes.Zip)
					AND findcustomer.Country IS attributes.Country 
					AND findcustomer.Phone IS Trim(attributes.Phone)
					AND findcustomer.Phone2 IS Trim(attributes.Phone2)
					AND findcustomer.Fax IS Trim(attributes.Fax)
					AND findcustomer.Email IS Trim(attributes.Email)>
						<cfset update_record = "NO">
					<cfelse>
						<cfset update_record = "YES">
					</cfif>
				</cfif>	
				
				
				<cfif update_record is "YES">
				
					<!--- Update the customer address --->
					<cfset attributes.Address_ID = attributes.Customer_ID>
					<cfset attributes.UID = Session.User_ID>
					<cfset Application.objUsers.UpdateCustomer(argumentcollection=attributes)>
				
				<cfelse>
					<!--- add new record --->
					<cfset old_customer_id = attributes.customer_id>
					
					<cfset attributes.UID = Session.User_ID>
					<cfset attributes.customer_id = Application.objUsers.AddCustomer(argumentcollection=attributes)>
					
					<!--- remove user from old record --->
					<cfquery name="UpdateCustomer" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
					UPDATE #Request.DB_Prefix#Customers 
					SET User_ID = 0
					WHERE Customer_ID = <cfqueryparam value="#old_customer_ID#" cfsqltype="CF_SQL_INTEGER">
					</cfquery>
									
					<!--- update user if necessary --->	
					<cfquery name="getUser" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
					SELECT Customer_ID, ShipTo
					FROM #Request.DB_Prefix#Users
					WHERE User_ID = <cfqueryparam value="#Session.User_ID#" cfsqltype="CF_SQL_INTEGER">
					</cfquery>
					
					<cfif getUser.customer_id is old_customer_id or getUser.shipto is old_customer_id>
					
						<cfquery name="UpdateUser" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
						UPDATE #Request.DB_Prefix#Users
						SET Customer_ID = 
						<cfif getuser.customer_id is old_customer_id>
							<cfqueryparam value="#attributes.customer_id#" cfsqltype="CF_SQL_INTEGER">
						<cfelse>
							<cfqueryparam value="#getuser.customer_id#" cfsqltype="CF_SQL_INTEGER">
						</cfif>, ShipTo = 
						<cfif getuser.shipto is old_customer_id>
							<cfqueryparam value="#attributes.customer_id#" cfsqltype="CF_SQL_INTEGER">
						<cfelse>
							<cfqueryparam value="#getuser.shipto#" cfsqltype="CF_SQL_INTEGER">
						</cfif>
						WHERE User_ID = <cfqueryparam value="#Session.User_ID#" cfsqltype="CF_SQL_INTEGER">
						</cfquery>
					
					</cfif>
					
				</cfif>
				
			</cfcase>
			
			<cfcase value="delete">
				<!--- first check to see if record has any orders --->
				<cfquery name="FindCustomer" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows=1>
				SELECT C.*, N.Order_No
				FROM #Request.DB_Prefix#Order_No N 
				RIGHT JOIN #Request.DB_Prefix#Customers C ON N.Customer_ID = C.Customer_ID
				WHERE (C.Customer_ID = <cfqueryparam value="#attributes.customer_id#" cfsqltype="CF_SQL_INTEGER">)
				</cfquery>
	
				<!--- first check to see if record has been used for shipping in an order --->
				<cfquery name="Findshipto" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows=1>
				SELECT Order_No
				FROM #Request.DB_Prefix#Order_No 
				WHERE ShipTo = <cfqueryparam value="#attributes.customer_id#" cfsqltype="CF_SQL_INTEGER">
				</cfquery>
				
				<cfif FindCustomer.RecordCount AND NOT len(FindCustomer.Order_No) AND findshipto.recordcount lt 1>
					<!--- if no orders, delete --->
					<cfquery name="deletecustomer" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
					DELETE FROM #Request.DB_Prefix#Customers 
					WHERE Customer_ID = <cfqueryparam value="#attributes.customer_id#" cfsqltype="CF_SQL_INTEGER">
					</cfquery>
				
				<cfelse>
					<!--- if orders, set user to 0 --->
					<cfquery name="UpdateCustomer" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
					UPDATE #Request.DB_Prefix#Customers 
					SET User_ID = 0
					WHERE Customer_ID = <cfqueryparam value="#attributes.customer_id#" cfsqltype="CF_SQL_INTEGER">
					</cfquery>
				</cfif>
			
				<!--- if old record is in User Record, update user record --->
					<cfquery name="getUser" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
					SELECT Customer_ID, ShipTo
					FROM #Request.DB_Prefix#Users
					WHERE User_ID = <cfqueryparam value="#Session.User_ID#" cfsqltype="CF_SQL_INTEGER">
					</cfquery>
					
					<cfif getUser.customer_id IS attributes.customer_id OR getUser.shipto IS attributes.customer_id>
					
						<cfquery name="UpdateUser" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
						UPDATE #Request.DB_Prefix#Users
						SET Customer_ID = <cfif getuser.customer_id is attributes.customer_id>0
						<cfelse>
						<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#getuser.customer_id#">
						</cfif>, 
						ShipTo = <cfif getuser.shipto is attributes.customer_id>0
						<cfelse>
						<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#getuser.shipto#">
						</cfif>
						WHERE User_ID = <cfqueryparam value="#Session.User_ID#" cfsqltype="CF_SQL_INTEGER">
						</cfquery>
						
						<cfinclude template="act_set_registration_permissions.cfm">
						
					</cfif>
	
					<cfset attributes.customer_id = 0>
					
			</cfcase>
		</cfswitch>
	
		<cfif attributes.mode is "customer">
			<cfif attributes.shipto is not 0>
				<cfset attributes.shipto = attributes.customer_ID>
			</cfif>
		
			<cfquery name="UpdateUser" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			UPDATE #Request.DB_Prefix#Users
			SET Customer_ID = <cfqueryparam value="#attributes.customer_id#" cfsqltype="CF_SQL_INTEGER">, 
			ShipTo = <cfqueryparam value="#attributes.shipto#" cfsqltype="CF_SQL_INTEGER">
			WHERE User_ID = <cfqueryparam value="#Session.User_ID#" cfsqltype="CF_SQL_INTEGER">
			</cfquery>
			
			<cfinclude template="act_set_registration_permissions.cfm">
			
			<!--- If using email notification and this is a new user, and using the normal register process, send email --->
			<cfif attributes.fuseaction IS "users.register" AND get_User_Settings.MemberNotify AND attributes.submit_customer IS "Add">
				<cfinclude template="act_email_member_add.cfm">
			</cfif>
	
		</cfif>
	
		<cfif attributes.mode is "shipto">
			<cfquery name="UpdateUser" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			UPDATE #Request.DB_Prefix#Users
			SET ShipTo = <cfqueryparam value="#attributes.customer_id#" cfsqltype="CF_SQL_INTEGER">
			WHERE User_ID = <cfqueryparam value="#Session.User_ID#" cfsqltype="CF_SQL_INTEGER">
			</cfquery>
		</cfif>
		
		<cfif len(attributes.xfa_customer_success)>
			<cflocation url="#request.self#?#attributes.xfa_customer_success##request.token2#" addtoken="no">
			<cfabort>
		</cfif>
		
	
	<cfelse><!--- Not an accessible account --->
		<cfset attributes.Message = "You do not have access to edit this customer account.">
	
	</cfif>
	
<cfelse><!--- Otherwise, redisplay form --->

	<cfset attributes.Message = "You did not fill out all the required fields!">

</cfif>


<cfif attributes.message is "">

		<cfloop list="#attributes.fieldlist#" index="counter">
			<cfset setvariable("attributes.#counter#", "")>
		</cfloop>
</cfif>

