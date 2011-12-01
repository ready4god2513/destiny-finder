
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the list of promotions. Called by product.admin&promotion=list --->

<cfloop index="namedex" list="Name,Coup_code,accesskey,display,current">
	<cfparam name="attributes.#namedex#" default="">
</cfloop>
				
<cfquery name="qry_get_promotions" datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#" >
	SELECT P.*, A.Name AS accesskey_name 
	FROM #Request.DB_Prefix#Promotions P
	LEFT OUTER JOIN #Request.DB_Prefix#AccessKeys A ON P.AccessKey = A.AccessKey_ID
	WHERE 1 = 1

<cfif trim(attributes.Name) is not "">
		AND P.Name Like '%#attributes.Name#%'	</cfif>
<cfif trim(attributes.Coup_code) is not "">
		AND P.Coup_Code Like '%#attributes.Coup_code#%'	</cfif>
<cfif trim(attributes.display) is not "">
		AND P.Display Like '%#attributes.display#%'	</cfif>
<cfif trim(attributes.current) is "current">
		AND (P.EndDate >= #CreateODBCDateTime(Now())# OR P.EndDate IS NULL)	</cfif>
<cfif trim(attributes.current) is "expired">
		AND P.EndDate < #CreateODBCDateTime(Now())#          				</cfif>
<cfif trim(attributes.current) is "scheduled">
		AND P.StartDate > #CreateODBCDateTime(Now())#						</cfif>		
<cfif len(attributes.accesskey)>
		AND P.AccessKey = #attributes.accesskey#</cfif>
				
	ORDER BY P.Name, P.QualifyNum
</cfquery>
		



