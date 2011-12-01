<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Performs the admin actions for memberships: add, update, delete. Called by access.admin&membership=act --->

<cfparam name="attributes.recur_product_ID" default="">

<cfswitch expression="#mode#">
	<cfcase value="i">
	
		<!--- check to make sure the user is valid --->
		<cfquery name="finduser" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			SELECT User_ID FROM #Request.DB_Prefix#Users
			WHERE Username = '#attributes.UName#'
		</cfquery>
			
		<cfif finduser.recordcount is 1>
	
	
		<cfquery name="AddMembership" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			INSERT INTO #Request.DB_Prefix#Memberships 
			(User_ID, Order_ID, Product_ID, Membership_Type, AccessKey_ID, Date_Ordered, 
			Start, Time_Count, Access_Count, Expire, Valid, Suspend_Begin_date,
			Next_Membership_ID, Recur, Recur_Product_ID)
			
			VALUES (#finduser.User_ID#, 
			<cfif len(trim(attributes.Order_ID))>#attributes.Order_ID#, <cfelse>Null,</cfif>
			<cfif len(trim(attributes.Product_ID))>#attributes.Product_ID#, <cfelse>Null,</cfif>
			'#attributes.Membership_Type#',
			<cfif len(attributes.AccessKey_ID)>'#Trim(attributes.AccessKey_ID)#',<cfelse>NULL,</cfif>
			#CreateODBCDate(Now())#,
			<cfif len(trim(attributes.start))>#CreateODBCDate(attributes.start)#, <cfelse>Null,</cfif>
			<cfif len(trim(attributes.Time_count))>#attributes.Time_Count#, <cfelse>Null,</cfif>
			<cfif len(trim(attributes.Access_count))>#attributes.Access_Count#, <cfelse>Null,</cfif>
			<cfif len(trim(attributes.expire))>#CreateODBCDate(attributes.expire)#, <cfelse>Null,</cfif>
			#attributes.valid#, 	
			<cfif isDate(attributes.Suspend_Begin_date)>#CreateODBCDate(attributes.Suspend_Begin_date)#, <cfelse>Null,</cfif>
			<cfif len(trim(attributes.Next_Membership_ID))>#attributes.Next_Membership_ID# <cfelse>Null</cfif>,
			<cfif len(trim(attributes.Recur))>#attributes.Recur# <cfelse>0</cfif>,
			<cfif len(trim(attributes.Recur_product_ID))>#attributes.Recur_product_ID# <cfelse>0</cfif>
		)
			</cfquery>	
			
		<cfelse>
			
			<cfset attributes.error_message = "Could not add Membership. Not a valid User">
		
		</cfif>	
			

	</cfcase>
			
	<cfcase value="u">
		<cfif submit is "delete">

			<!--- see if membership is child --->
			<cfquery name="findparent" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				SELECT Membership_ID FROM #Request.DB_Prefix#Memberships
				WHERE Next_Membership_ID =  #attributes.Membership_ID#
			</cfquery>
			
			<!--- Update parent membership if it exists --->
			<cfif findparent.recordcount>
				<cfquery name="UpdateParentMembership" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				UPDATE #Request.DB_Prefix#Memberships
				SET Next_Membership_ID = NULL
				WHERE Membership_ID =  #findparent.Membership_ID#
				</cfquery>
			</cfif>
			
			<cfquery name="deleteMembership" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			DELETE FROM #Request.DB_Prefix#Memberships 
			WHERE Membership_ID = #attributes.Membership_ID#
			</cfquery>
				
		<cfelse>
		
		<!--- check to make sure the user is valid --->
		<cfquery name="finduser" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			SELECT User_ID FROM #Request.DB_Prefix#Users
			WHERE Username = '#attributes.UName#'
		</cfquery>
			
			<cfif finduser.recordcount is 1>
			
				<cfset form.User_id = finduser.User_ID>

				<cfquery name="UpdateMembership" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
    			UPDATE #Request.DB_Prefix#Memberships
    			SET	User_ID = #finduser.user_id#,
				Order_ID =  <cfif len(attributes.Order_ID)>'#Trim(attributes.Order_ID)#',<cfelse>NULL,</cfif>
				Product_ID =  <cfif len(attributes.Product_ID)>'#Trim(attributes.Product_ID)#',<cfelse>NULL,</cfif>
				Membership_Type = '#attributes.membership_Type#',
				AccessKey_ID = <cfif len(attributes.AccessKey_ID)>'#Trim(attributes.AccessKey_ID)#',<cfelse>NULL,</cfif>
				Start = <cfif len(attributes.Start)>#createODBCdate(attributes.Start)#,<cfelse>NULL,</cfif>
				Time_Count = <cfif len(attributes.time_count)>'#Trim(attributes.time_count)#',<cfelse>NULL,</cfif>
				Access_Count = <cfif len(attributes.access_count)>'#Trim(attributes.access_count)#',<cfelse>NULL,</cfif>
				Expire = <cfif len(attributes.Expire)>#createODBCdate(attributes.Expire)#,<cfelse>NULL,</cfif>
				Valid = #attributes.Valid#,
				Access_Used  = #attributes.Access_used#,
				Suspend_Begin_Date = <cfif len(attributes.Suspend_Begin_date)>#createODBCdate(attributes.Suspend_Begin_date)#<cfelse>NULL</cfif>,
				Recur =	<cfif len(trim(attributes.Recur))>#attributes.Recur# <cfelse>0</cfif>,
				Recur_Product_ID = <cfif len(trim(attributes.Recur_product_ID))>#attributes.Recur_product_ID# <cfelse>0</cfif>
				WHERE Membership_ID =  #attributes.Membership_ID#
				</cfquery>
			
				<cfinclude template="act_suspend.cfm">

			<cfelse>
			
				<cfset attributes.error_message = "Oops! Not a valid User">
			
			</cfif>
			

		</cfif>

	</cfcase>
			
</cfswitch>

<!--- update admin menu  --->
<cfset attributes.admin_reload = "membershipcount">


		