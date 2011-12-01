
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to retrieve a listing of accounts. Called by users.directory --->

<cfloop index="namedex" list="account_name,rep,type1,directory_live,city,state,country,description,sortby,order">
	<cfparam name="attributes.#namedex#" default="">
</cfloop>

<!--- remove any non-alphanumeric or non-space characters --->
<cfset attributes.sortby = Trim(sanitize(attributes.sortby))>
<cfset attributes.order = Trim(sanitize(attributes.order))>

<cfif attributes.order is "desc">
	<cfset orderby = "desc">
<cfelse>
	<cfset orderby = "asc">
</cfif>

<cfquery name="qry_get_Accounts"   datasource="#Request.ds#"	 username="#Request.user#"  password="#Request.pass#" >
			SELECT A.*, C.FirstName, C.LastName, C.Company, 
			C.Address1, C.Address2, C.City, C.State, 
			C.State2, C.Zip, C.Country, C.Phone, C.Phone2,
			C.Fax, C.Email, C.Residence
			FROM #Request.DB_Prefix#Account A 
			INNER JOIN #Request.DB_Prefix#Customers C ON A.Customer_ID = C.Customer_ID
			WHERE A.Directory_Live = 1
			<cfif trim(attributes.account_name) is not "">
				AND A.Account_Name LIKE <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="%#attributes.account_name#%">
				</cfif>
			<cfif trim(attributes.type1) is not "">
				AND A.Type1 = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#attributes.type1#">
				</cfif>
			<cfif trim(attributes.rep) is not "">
				AND Rep LIKE <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="%#attributes.rep#%">
				</cfif>
			<cfif trim(attributes.city) is not "">
				AND C.City LIKE <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="%#attributes.city#%">
				</cfif>
			<cfif trim(attributes.state) is not "">
				AND C.State LIKE <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="%#attributes.state#%">
				</cfif>
			<cfif trim(attributes.country) is not "">
				AND C.Country = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#attributes.country#">
				</cfif>
			<cfif trim(attributes.description) is not "">
				AND A.Description LIKE <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="%#attributes.description#%">
				</cfif>
			ORDER BY
			<cfif attributes.sortby is "city">
				State #orderby#, 
				City #orderby#,
				Account_Name
			<cfelseif attributes.sortby is "type1">
				Type1 #orderby#,
				Account_Name
			<cfelseif attributes.sortby is "name">
				Account_Name #orderby#
			<cfelseif attributes.sortby is "rep">
				Rep #orderby#,
				Account_Name
			<cfelse>
				Account_Name
			</cfif>
		</cfquery>
		

