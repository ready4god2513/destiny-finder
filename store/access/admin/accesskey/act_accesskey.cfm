
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Performs the admin actions for access keys: add, update, delete. Called by access.admin&accessKey=act --->

<cfswitch expression="#mode#">

	<cfcase value="i">
	
			<cfquery name="AddKey" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			INSERT INTO #Request.DB_Prefix#AccessKeys 
			(Name, System)
			VALUES
			('#Attributes.Name#', 0)
			</cfquery>	

	</cfcase>
			
	<cfcase value="u">
	
		<cfif submit is "delete">
		
			<!--- check if key is being used, if it is, do not allow deletion ---->
			<cfset attributes.error_message = "">
			
			<cfquery name="checkmemberships" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				SELECT Membership_ID
				FROM #Request.DB_Prefix#Memberships
				WHERE AccessKey_ID LIKE '#AccessKey_ID#'
				OR AccessKey_ID LIKE '#AccessKey_ID#,%'
				OR AccessKey_ID LIKE '%,#AccessKey_ID#'
				OR AccessKey_ID LIKE '%,#AccessKey_ID#,%'
			</cfquery>
			
			<cfif checkmemberships.recordcount gt 0>
				<cfset attributes.error_message = attributes.error_message &  "<br/>This Accesskey is used in Memberships. Please edit or delete those first.">
			</cfif>
			

			<cfquery name="checkcategory" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				SELECT Category_ID
				FROM #Request.DB_Prefix#Categories
				WHERE AccessKey = #AccessKey_ID#
			</cfquery>
			
			<cfif checkcategory.recordcount gt 0>
				<cfset attributes.error_message = attributes.error_message &  "<br/>This Accesskey is used in Categories. Please edit or delete those first.">
			</cfif>
						
			

			<cfquery name="checkfeature" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				SELECT Feature_ID
				FROM #Request.DB_Prefix#Features
				WHERE AccessKey = #AccessKey_ID#
			</cfquery>
			
			<cfif checkfeature.recordcount gt 0>
				<cfset attributes.error_message = attributes.error_message &  "<br/>This Accesskey is used in Features. Please edit or delete those first.">
			</cfif>		
				
				

			<cfquery name="checkpage" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				SELECT Page_ID
				FROM #Request.DB_Prefix#Pages
				WHERE AccessKey = #AccessKey_ID#
			</cfquery>
			
			<cfif checkpage.recordcount gt 0>
				<cfset attributes.error_message = attributes.error_message &  "<br/>This Accesskey is used in Features. Please edit or delete those first.">
			</cfif>		
				
				
			<cfquery name="checkProduct" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				SELECT Product_ID
				FROM #Request.DB_Prefix#Products
				WHERE AccessKey = #AccessKey_ID#
			</cfquery>
			
			<cfif checkProduct.recordcount gt 0>
				<cfset attributes.error_message = attributes.error_message &  "<br/>This Accesskey is used in Products. Please edit or delete those first.">
			</cfif>		
			
			
			<cfif NOT len(attributes.error_message)>
			
			<!--- Remove the access key from any users or groups it was assigned to --->
			
			<cfquery name="getUsers" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			SELECT User_ID, Permissions FROM #Request.DB_Prefix#Users
			WHERE Permissions LIKE '%contentkey_list%'
			</cfquery>
			
			<cfloop query="getUsers">
				<!--- search for access key list --->
				<cfset list_loc = ListContainsNoCase(Permissions,'contentkey_list',';')>
				<cfif list_loc>
					<cfset contentlist = ListLast(ListGetAt(Permissions,list_loc,';'),'^')>
					<!--- Search for key being deleted --->
					<cfset key_loc = ListFind(contentlist, AccessKey_ID)>
					<cfif key_loc>
						<!--- Remove the key and remove the key list from the permissions --->
						<cfset newkeys = ListDeleteAt(contentlist, key_loc)>
						<cfset newlist = ListDeleteAt(Permissions, list_loc, ";")>
						<cfif len(newkeys)>
							<!--- Update permissions if access keys left in the list --->
							<cfset contentlist = 'contentkey_list^' & newkeys>
							<cfset newlist = ListPrepend(newlist, contentlist, ";")>
						</cfif>
						<!--- Update the user record --->
						<cfquery name="UpdateUser" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
						UPDATE #Request.DB_Prefix#Users
						SET Permissions = '#newlist#'
						WHERE User_ID = #User_ID#
						</cfquery>
					</cfif>
				</cfif>
			</cfloop>
			
			
			<cfquery name="getGroups" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			SELECT Group_ID, Permissions FROM #Request.DB_Prefix#Groups
			WHERE Permissions LIKE '%contentkey_list%'
			</cfquery>
			
			<cfloop query="getGroups">
				<!--- search for access key list --->
				<cfset list_loc = ListContainsNoCase(Permissions,'contentkey_list',';')>
				<cfif list_loc>
					<cfset contentlist = ListLast(ListGetAt(Permissions,list_loc,';'),'^')>
					<!--- Search for key being deleted --->
					<cfset key_loc = ListFind(contentlist, AccessKey_ID)>
					<cfif key_loc>
						<!--- Remove the key and remove the key list from the permissions --->
						<cfset newkeys = ListDeleteAt(contentlist, key_loc)>
						<cfset newlist = ListDeleteAt(Permissions, list_loc, ";")>
						<cfif len(newkeys)>
							<!--- Update permissions if access keys left in the list --->
							<cfset contentlist = 'contentkey_list^' & newkeys>
							<cfset newlist = ListPrepend(newlist, contentlist, ";")>
						</cfif>
						<!--- Update the group record --->
						<cfquery name="UpdateGroup" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
						UPDATE #Request.DB_Prefix#Groups
						SET Permissions = '#newlist#'
						WHERE Group_ID = #Group_ID#
						</cfquery>
					</cfif>
				</cfif>
			</cfloop>
		
				<cfquery name="deleteAccessKey" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				DELETE FROM #Request.DB_Prefix#AccessKeys 
				WHERE AccessKey_ID = #AccessKey_ID#
				</cfquery> 
			
			
			<cfelse>
			
				<cfset attributes.error_message = "This Access Key could not be deleted for the following reasons:<br/>" &  attributes.error_message >
			
			</cfif>	
			
				
		<cfelse>
		
			<cfquery name="UpdateKeys" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				UPDATE #Request.DB_Prefix#AccessKeys
				SET Name = '#attributes.name#'
				WHERE AccessKey_ID =  #attributes.AccessKey_ID#
			</cfquery>

		</cfif>
	</cfcase>

</cfswitch>
			

