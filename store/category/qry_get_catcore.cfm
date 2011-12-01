
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the information for a selected page template. Used by the dsp_catheader.cfm page --->

<cfquery name="qry_get_catCore"  datasource="#Request.ds#"	 username="#Request.user#"  password="#Request.pass#" >
	SELECT * FROM #Request.DB_Prefix#CatCore
	WHERE CatCore_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.catcore_id#">
</cfquery>
		


