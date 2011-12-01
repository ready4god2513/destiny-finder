<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Assigns a user to a group. Called from fuseaction users.admin&user=list. --->

<cfif attributes.assign is not "" and attributes.newgroup is not "">
	<cfquery name="assign_group" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" >
	UPDATE #Request.DB_Prefix#Users
		SET Group_ID = #attributes.newgroup#
		WHERE User_ID = #attributes.assign#
	</cfquery>			
	
	<cflocation url="#self#?#attributes.addedpath##Request.Token2#" addtoken="No">
</cfif>	

