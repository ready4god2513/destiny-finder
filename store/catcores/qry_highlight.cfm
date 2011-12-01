
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--------------- Get Highlighted and/or Sale Categories --------------------->

<!--- Used by the catcore_highlight.cfm and dsp_sale.cfm pages  --->

<cfquery name="qry_get_Hcats" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT Category_ID, Name, Short_Desc, Sm_Image, Sm_Title, Highlight, Sale
	FROM #Request.DB_Prefix#Categories 
	WHERE Display = 1

	<cfif attributes.new is 1 AND attributes.onsale is 1>
		AND Highlight = 1 OR Sale = 1
	<cfelseif attributes.new is 0 AND attributes.onsale is 0>
		AND 1=0
	<cfelseif attributes.new is "1">
 		AND Highlight = 1
	<cfelseif attributes.onsale is "1">
 		AND Sale = 1
	</cfif>
ORDER BY Priority, Name
</cfquery>



