
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Updates the product custom fields. Called by product.admin&fields=act --->

<cfparam name="attributes.TotalFields" default="0">

<cfinclude template="qry_get_customfields.cfm">

<!--- Loop through the number of fields that were returned --->

<cfloop index="i" from="1" to="#attributes.TotalFields#">

	<!--- See if this field was returned, and has information in it --->
	<cfif isDefined("attributes.Custom_Name#i#") AND len(attributes['Custom_Name' & i]) AND NOT isDefined("attributes.Remove#i#")>
	
		<cfset Custom_ID = attributes['Custom_ID' & i]>
	
		<!--- If entered, check if this is an update or a new field --->
		<cfquery name="checkField" dbtype="query">
			SELECT Custom_ID FROM qry_Get_Customfields
			WHERE Custom_ID = #Custom_ID#
		</cfquery>
		
		<!--- Field exists, update it --->
		<cfif checkField.RecordCount>
			<cfquery name="UpdCustom" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				UPDATE #Request.DB_Prefix#Prod_CustomFields
				SET Custom_Name = '#attributes['Custom_Name' & i]#',
				Google_Code = '#attributes['Google_Code' & i]#',
				Custom_Display = #iif(isDefined("attributes.Custom_Display#i#"),1,0)#,
				Google_Use = #iif(isDefined("attributes.Google_Use#i#"),1,0)#
				WHERE Custom_ID = #Custom_ID#
			</cfquery>
	
		<!--- New custom field, insert it --->
		<cfelse>
			<cftransaction isolation="SERIALIZABLE">
				<cfquery name="getNewID" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
					SELECT MAX(Custom_ID) + 1 AS newid FROM #Request.DB_Prefix#Prod_CustomFields
					</cfquery>
				<cfset newID = iif(len(getNewID.newid),getNewID.newid,1)>
			
				<cfquery name="InsCustom" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
					INSERT INTO #Request.DB_Prefix#Prod_CustomFields
					(Custom_ID, Custom_Name, Google_Code, Custom_Display, Google_Use)
					VALUES
					(#newID#, 
					'#attributes['Custom_Name' & i]#',
					'#attributes['Google_Code' & i]#',
					#iif(isDefined("attributes.Custom_Display#i#"),1,0)#,
					#iif(isDefined("attributes.Google_Use#i#"),1,0)#)
				</cfquery>
			
			</cftransaction>
		
	
	
		</cfif>
		
	<!--- Field was not returned, or not entered, check if this was a previous custom field, and is selected to be removed --->
	<cfelseif isDefined("attributes.Remove#i#")>
		
		<cfset Custom_ID = attributes['Custom_ID' & i]>
		
		<!--- Remove product data first --->
		<cfquery name="RemoveProdData" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			DELETE FROM #Request.DB_Prefix#Prod_CustInfo
			WHERE Custom_ID = #Custom_ID#
		</cfquery>
		
		<!--- Remove Custom field --->
		<cfquery name="RemoveProdData" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			DELETE FROM #Request.DB_Prefix#Prod_CustomFields
			WHERE Custom_ID = #Custom_ID#
		</cfquery>
		
	</cfif>
	


</cfloop>

