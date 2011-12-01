
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the list of features. Filters according to the search parameters that are passed. Called by feature.admin&feature=list|listform --->

<cfloop index="namedex" list="uname,search_string,feature_type,accesskey,display_status,display,approved,highlight,order,CID,nocat">
	<cfoutput><cfparam name="attributes.#namedex#" default=""></cfoutput>
</cfloop>

<cfset uid = "">

<!--- if user does not have feature admin (1) or editor (2)  permissions then show only features
that current user created ---->
<cfparam name="ispermitted" default=1>
<cfmodule template="../../access/secure.cfm"
	keyname="feature"
	requiredPermission="1,2"
	> 
<cfif not ispermitted>
	<cfset uid = Session.User_ID>
</cfif>



<cfif attributes.display_status is "off">
	<cfset attributes.display = "0">
<cfelseif attributes.display_status is "editor">
	<cfset attributes.display = "1">
	<cfset attributes.approved = "0">
<cfelse>
	<cfset attributes.display = "">
	<cfset attributes.approved = "">
</cfif>


<cfif attributes.nocat is "1">
	<cfquery name="categorized_features"  datasource="#Request.ds#"	 username="#Request.user#"  password="#Request.pass#" >
	SELECT DISTINCT Feature_ID
	FROM #Request.DB_Prefix#Feature_Category
	</cfquery>
</cfif> 

	
<cfquery name="qry_get_Features"   datasource="#Request.ds#"	 username="#Request.user#"  password="#Request.pass#" >
	SELECT F.*, U.Username, A.Name AS accesskey_name 
	FROM (<cfif len(attributes.cid)>(#Request.DB_Prefix#Features F 
		INNER JOIN #Request.DB_Prefix#Feature_Category FC ON FC.Feature_ID = F.Feature_ID)
	 <cfelse>#Request.DB_Prefix#Features F </cfif>
	LEFT OUTER JOIN #Request.DB_Prefix#Users U ON F.User_ID = U.User_ID) 
	LEFT OUTER JOIN #Request.DB_Prefix#AccessKeys A ON F.AccessKey = A.AccessKey_ID

	WHERE 
	
	<cfif attributes.nocat is "1" and categorized_features.recordcount>
	F.Feature_ID NOT IN (#ValueList(categorized_features.feature_id)#)
	<cfelseif len(attributes.cid)>
	FC.Category_ID = #attributes.cid#
	<cfelse> 
	1 = 1
	</cfif>	
	
<cfif trim(uid) is not "">
	AND F.User_ID = #uid#</cfif>
<cfif trim(attributes.search_string) is not "">
				AND (F.Name like '%#attributes.search_string#%'	
				OR F.Author like '%#attributes.search_string#%'	 
				OR F.Copyright like '%#attributes.search_string#%'	 
				OR F.Short_Desc like '%#attributes.search_string#%'	 
				OR F.Long_Desc like '%#attributes.search_string#%') 
				</cfif>
<cfif trim(attributes.feature_type) is not "">
				AND Feature_Type = '#attributes.feature_type#'	</cfif>
<cfif len(attributes.accesskey)>
				AND F.AccessKey = #attributes.accesskey#</cfif>
<cfif trim(attributes.display) is not "">
				AND F.Display = #attributes.display# </cfif>			
<cfif trim(attributes.approved) is not "">
				AND F.Approved = #attributes.approved# </cfif>				
<cfif trim(attributes.display_status) is "current">
				AND (F.Start <= #CreateODBCDateTime(Now())# OR F.Start is null)
				</cfif>
<cfif trim(attributes.display_status) is "current">
				AND (F.Expire >= #CreateODBCDateTime(Now())# OR F.Expire is null)
				</cfif>
<cfif trim(attributes.display_status) is "expired">
				AND F.Expire < #CreateODBCDateTime(Now())#
				</cfif>
<cfif trim(attributes.display_status) is "scheduled">
				AND F.Start > #CreateODBCDateTime(Now())#
				</cfif>
<cfif trim(attributes.highlight) is not "">
				AND F.Highlight = #attributes.highlight#</cfif>
				
			ORDER BY 	
		
			<cfif trim(attributes.order) is "username">			
				 U.Username, F.Name
			<cfelseif trim(attributes.order) is not "">
				 F.#attributes.order#
			<cfelse>
				F.Priority, F.Name
			</cfif>
				 
			</cfquery>
		


