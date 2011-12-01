
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the list of discounts. Called by product.admin&discount=list --->

<cfloop index="namedex" list="Name,Coup_code,accesskey,display,current">
	<cfparam name="attributes.#namedex#" default="">
</cfloop>
				
<cfquery name="qry_get_Discounts"   datasource="#Request.ds#"	 username="#Request.user#"  password="#Request.pass#" >
	SELECT D.*, A.Name AS accesskey_name 
	FROM #Request.DB_Prefix#Discounts D
	LEFT OUTER JOIN #Request.DB_Prefix#AccessKeys A ON D.AccessKey = A.AccessKey_ID
	WHERE 1 = 1

<cfif trim(attributes.Name) is not "">
		AND D.Name Like '%#attributes.Name#%'	</cfif>
<cfif trim(attributes.Coup_code) is not "">
		AND D.Coup_Code Like '%#attributes.Coup_code#%'	</cfif>
<cfif trim(attributes.display) is not "">
		AND D.Display Like '%#attributes.display#%'	</cfif>
<cfif trim(attributes.current) is "current">
		AND (D.EndDate >= #CreateODBCDateTime(Now())# OR D.EndDate IS NULL)	</cfif>
<cfif trim(attributes.current) is "expired">
		AND D.EndDate < #CreateODBCDateTime(Now())#          				</cfif>
<cfif trim(attributes.current) is "scheduled">
		AND D.StartDate > #CreateODBCDateTime(Now())#						</cfif>		
<cfif len(attributes.accesskey)>
		AND D.AccessKey = #attributes.accesskey#</cfif>
				
	ORDER BY D.Name, D.MinOrder
</cfquery>
		



