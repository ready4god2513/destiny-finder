
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Creates a copy of a store page. Called by page.admin&do=copy --->

<!--- Get the page to copy --->
<cfinclude template="qry_get_page.cfm">

<cfif qry_get_page.recordcount>
	<cftransaction isolation="SERIALIZABLE">

	<cfquery name="Get_id" datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
		   SELECT MAX(page_ID) AS maxid
		   FROM #Request.DB_Prefix#Pages
	</cfquery>
	
	<cfset attributes.page_id = get_id.maxid + 1>
	
	<!--- Add new page, set display to 0 until approved. --->
	<cfquery name="AddCopyPage" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		INSERT INTO #Request.DB_Prefix#Pages 
		(Page_ID, Page_URL, PageAction, CatCore_ID, PassParam, Display, Page_Name, Page_Title, 
		Sm_Image, Lg_Image, Sm_Title, Lg_Title, Color_ID, PageText, System, Href_Attributes, 
		AccessKey, Priority, Parent_ID, Title_Priority, TitleTag, Metadescription, Keywords)
		VALUES (
		#attributes.page_id#,
		'#qry_get_page.Page_URL#',
		'#qry_get_page.PageAction#',
		#qry_get_page.CatCore_ID#,
		'#qry_get_page.PassParam#',
		0,
		'Copy of #qry_get_page.Page_Name#',
		'#qry_get_page.Page_Title#',
		'#qry_get_page.Sm_Image#',
		'#qry_get_page.Lg_Image#',
		'#qry_get_page.Sm_Title#',
		'#qry_get_page.Lg_Title#',
		<cfif isNumeric(qry_get_page.Color_ID)>#qry_get_page.Color_ID#<cfelse>NULL</cfif>,
		'#qry_get_page.PageText#',
		0,
		'#qry_get_page.Href_Attributes#',
		#qry_get_page.AccessKey#,
		#qry_get_page.Priority#,
		#qry_get_page.Parent_ID#,
		#qry_get_page.Title_Priority#,
		'#qry_get_page.TitleTag#',
		'#qry_get_page.Metadescription#',
		'#qry_get_page.Keywords#')
	</cfquery>
	
	</cftransaction>
	
	<cfset do = "edit">
</cfif>		

<cfsetting enablecfoutputonly="no">
