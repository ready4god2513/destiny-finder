
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the list of giftwrap options. Called by shopping.admin&giftwrap=list --->	
<cfquery name="qry_get_giftwraps" datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#" >
	SELECT * FROM #Request.DB_Prefix#Giftwrap
	ORDER BY Display DESC, Priority ASC
</cfquery>
		
