<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template processes the reinstatement of a suspended  membership. It creates a new membership record with the appropriate start date and calculated end date. --->

<cfparam name="attributes.suspend_end_date" default="">

<!--- UUID to tag new inserts --->
<cfset NewIDTag = CreateUUID()>
<!--- Remove dashes --->
<cfset NewIDTag = Replace(NewIDTag, "-", "", "All")>

<!--- Process template only if attributes.suspend_ending is defined ---->
<cfif isdate(attributes.suspend_end_date)>

	<!--- Verify that the suspend ending is after the starting date --->
	<cfif datecompare(attributes.suspend_end_date,attributes.suspend_begin_date) is 1>
	
		<!--- Calculate number of days to carry over to the next record --->
		<cfset daysleft = DateDiff('d',attributes.suspend_begin_date,attributes.Expire)>
		<cfset newexpire = DateAdd('d',daysleft,attributes.suspend_end_date)>
			
		<!--- Copy current membership to new membership --->
		
		<!--- check to make sure the user is valid --->
		<cfquery name="finduser" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			SELECT User_ID FROM #Request.DB_Prefix#Users
			WHERE 
				<cfif isdefined("attributes.UName")>
					UserName = '#attributes.UName#'
				<cfelse>
					User_ID = '#attributes.User_ID#'
				</cfif>
		</cfquery>
			
		<cfif finduser.recordcount is 1>
			
			<cftransaction>
				
			<cfquery name="AddMembership" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			<cfif Request.dbtype IS "MSSQL">
				SET NOCOUNT ON
			</cfif>
			INSERT INTO #Request.DB_Prefix#Memberships 
				(ID_Tag, User_ID, Order_ID, Product_ID, Membership_Type, AccessKey_ID, Date_Ordered, 
				Start, Time_Count, Access_Count, Expire, Valid,	Suspend_Begin_Date, Next_Membership_ID)
			
			VALUES ('#NewIDTag#', 
			#finduser.User_ID#, 
			<cfif len(trim(attributes.Order_ID))>#attributes.Order_ID#, <cfelse>Null,</cfif>
			<cfif len(trim(attributes.Product_ID))>#attributes.Product_ID#, <cfelse>Null,</cfif>
			'#attributes.Membership_Type#',
			'#attributes.AccessKey_ID#',
			#CreateODBCDate(Now())#,
			#CreateODBCDate(attributes.suspend_end_date)#,
			<cfif len(trim(attributes.Time_count))>#attributes.Time_Count#, <cfelse>Null,</cfif>
			<cfif len(trim(attributes.Access_count))>#attributes.Access_Count#, <cfelse>Null,</cfif>
			<cfif len(trim(attributes.expire))>#CreateODBCDate(newexpire)#, <cfelse>Null,</cfif>
			#attributes.valid#,
			Null,
			Null
			)
			<cfif Request.dbtype IS "MSSQL">
				SELECT @@Identity AS New_ID
				SET NOCOUNT OFF
			</cfif>
			</cfquery>	
		
			<cfif Request.dbtype IS NOT "MSSQL">
				<cfquery name="AddMembership" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
				SELECT Membership_ID AS New_ID 
				FROM #Request.DB_Prefix#Memberships
				WHERE ID_Tag = '#NewIDTag#'
				</cfquery>
			</cfif>
			
			</cftransaction>
		
			<cfset OLD_Membership_id = attributes.Membership_id>
			<cfset attributes.Membership_id = AddMembership.New_ID>
		
		
			<!--- Update old membership with new membership ID --->
			<cfquery name="UpdateMembership" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			UPDATE #Request.DB_Prefix#Memberships
			SET
			Next_Membership_ID = #attributes.Membership_id#,
			Suspend_Begin_Date = #createODBCdate(attributes.Suspend_Begin_date)#
			WHERE Membership_ID =  #OLD_Membership_ID#
			</cfquery>
			
		
		<cfelse><!--- error: --->
			
			<cfset attributes.error_message = "Could not add Membership. Not a valid User">
		
		</cfif>	
	
	<cfelse><!--- error: --->
	
		<cfset attributes.error_message="The Suspend Ending date must be after the starting date.">	
	
	</cfif>

</cfif><!--- processing check --->

<cfsetting enablecfoutputonly="no">
