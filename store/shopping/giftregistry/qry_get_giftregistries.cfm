
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the users gift registries. Called by shopping.giftregistry --->
<cfparam name="attributes.name" default="">
<cfparam name="attributes.city" default="">
<cfparam name="attributes.giftRegistry_ID" default="">
<cfparam name="attributes.sort" default="">
<cfparam name="attributes.order" default="">

<!--- remove any non-alphanumeric or non-space characters --->
<cfset attributes.sort = Trim(sanitize(attributes.sort))>
<cfset attributes.order = Trim(sanitize(attributes.order))>
<cfset attributes.city = Trim(sanitize(attributes.city))>
<!--- This field needs to allow quotes, etc. --->
<cfset attributes.name = Trim(HTMLEditFormat(attributes.name))>

<cfif attributes.order is "desc">
	<cfset orderby = "desc">
<cfelse>
	<cfset orderby = "asc">
</cfif>

<!--- Search for registries --->
<cfquery name="qry_get_registries" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT * FROM #Request.DB_Prefix#GiftRegistry
WHERE 
	1 = 1
	<cfif len(variables.UID)>
		AND User_ID = <cfqueryparam value="#variables.UID#" cfsqltype="CF_SQL_INTEGER">
	</cfif>
	<cfif len(attributes.name) OR len(attributes.city)>

		<cfif len(attributes.name)>
		AND (Event_name LIKE <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="%#attributes.name#%">
		OR Registrant LIKE <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="%#attributes.name#%">
		OR OtherName LIKE <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="%#attributes.name#%">)
		</cfif>
		
		<cfif len(attributes.city)>
		AND (City LIKE <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="%#attributes.city#%">
		OR State LIKE <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="%#attributes.city#%">)
		</cfif>
		
		AND Private = 0
		AND Live = 1
		
	<cfelseif attributes.GiftRegistry_ID GT 0>
		And GiftRegistry_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#Val(attributes.giftRegistry_ID)#">
		AND Live = 1
		
	<cfelseif isdefined("attributes.do")>
		<!--- No search criteria entered --->
		AND 0 =  1
	</cfif>

ORDER BY
	<cfif attributes.sort is "name">
		Registrant #orderby#
	<cfelseif attributes.sort is "date">
		Event_Date #orderby#,
		Registrant
	<cfelse>
		Event_Date, Registrant
	</cfif>
</cfquery>

