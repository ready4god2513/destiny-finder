
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Performs the admin actions for groups: add, update, delete.
Called by users.admin&group=act --->

<cfset attributes.error_message="">

<cfswitch expression="#mode#">
	<cfcase value="i">
		<!--- add new group --->
		<cftransaction isolation="SERIALIZABLE">

		<cfquery name="Get_id" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
			SELECT MAX(Group_ID) AS maxid 
			FROM #Request.DB_Prefix#Groups
			</cfquery>
		
		<cfset attributes.group_id = get_id.maxid + 1>
		
		<cfquery name="addgroup" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		INSERT INTO #Request.DB_Prefix#Groups 	
		(Group_ID, Name, Description, Group_Code, Wholesale, TaxExempt, ShipExempt)
		VALUES
		(#attributes.Group_ID#,
		'#attributes.name#',
		'#attributes.Description#',
		'#attributes.group_code#',
		#attributes.wholesale#,
		#attributes.TaxExempt#,
		#attributes.ShipExempt#
		)
		</cfquery>
		
		</cftransaction>
		
		<cfinclude template="act_update_discounts.cfm">
		<cfinclude template="act_update_promotions.cfm">
		
	</cfcase>
			
	<cfcase value="u">
		<cfif submit is "Delete">
			<!--- Delete Group. Administrator group can not be deleted. --->
			<cfif attributes.gid is "1">
				<cfset attributes.error_message = "You cannot delete this group">
			<cfelse>
				<cfinclude template="act_delete_group.cfm">
			</cfif>				
			
		<cfelse>
			<!--- Update Group --->
			<cfset attributes.group_id = attributes.gid>
			<cfinclude template="act_update_discounts.cfm">
			<cfinclude template="act_update_promotions.cfm">
			
			<cfquery name="update_group" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" >
				UPDATE #Request.DB_Prefix#Groups
				SET
				Name = '#trim(attributes.Name)#',
				Description = '#trim(attributes.Description)#',
				Group_Code = '#trim(attributes.Group_code)#',
				Wholesale = #attributes.Wholesale#,
				TaxExempt = #attributes.TaxExempt#,
				ShipExempt = #attributes.ShipExempt#
				WHERE Group_ID = #attributes.gid#
			</cfquery>
			
		</cfif>

	</cfcase>	
</cfswitch>
			

