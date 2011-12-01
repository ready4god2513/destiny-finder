
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Updates the picklists. Called by home.admin&picklists=edit --->


<cfquery name="update_picklists" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		UPDATE #Request.DB_Prefix#PickLists
		SET 
		<cfloop index="thisfield" list="#fieldlist#">
		#thisfield# = <cfif len(evaluate("attributes." & thisfield))>'#Trim(evaluate("attributes." & thisfield))#'
						<cfelse>NULL</cfif><cfif listlast(fieldlist) is not "#thisfield#">, </cfif>
		</cfloop>
		WHERE Picklist_ID = 1
</cfquery>
		



