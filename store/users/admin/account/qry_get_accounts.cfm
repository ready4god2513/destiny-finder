
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the list of Accounts for the admin. Called by the fuseaction users.admin&account=list --->

<!--- initialize parameters --->
<cfloop index="namedex" list="uid,un,customer_ID,Account_name,lastused,type1,directory_live">
	<cfparam name="attributes.#namedex#" default="">
</cfloop>
		
<cfquery name="qry_get_Accounts" datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#" >
			SELECT A.*, U.Username AS UN
			FROM #Request.DB_Prefix#Account A 
			LEFT JOIN #Request.DB_Prefix#Users U ON A.User_ID = U.User_ID
			WHERE 1 = 1
			
			<cfif trim(attributes.uid) is not "">
				AND A.User_ID = #attributes.uid#
				</cfif>
			<cfif trim(attributes.un) is not "">
				AND U.Username Like '%#attributes.un#%'
				</cfif>		
			<cfif trim(attributes.customer_ID) is not "">
				AND A.Customer_ID = #attributes.customer_ID#
				</cfif>
			<cfif trim(attributes.Account_name) is not "">
				AND A.Account_Name Like '%#attributes.Account_name#%'
				</cfif>
			<cfif trim(attributes.lastused) is not "">
				AND A.LastUsed > #createODBCdate(attributes.lastused)#
				</cfif>
			<cfif trim(attributes.type1) is not "">
				AND A.Type1 = '#type1#'
				</cfif>
			<cfif trim(attributes.directory_live) is not "">
				AND A.Directory_Live = #attributes.directory_live#
				</cfif>
			Order by A.Account_ID DESC
		</cfquery>


