<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Called from the users.subscribe circuit this template toggles the users.subscribe field. --->

<cfparam name="attributes.xfa_success" default="#self#?fuseaction=users.manager">
<cfinclude template="../qry_get_user.cfm">

<!--- Set the default to be the opposite of the current setting. --->
<cfif qry_get_user.subscribe is 1>
	<cfparam name="attributes.set" default="0">
<cfelse>
	<cfparam name="attributes.set" default="1">
</cfif>

<cfquery name="UpdateSubscribe" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
UPDATE #Request.DB_Prefix#Users 
SET Subscribe = <cfqueryparam value="#attributes.set#" cfsqltype="#Request.SQL_Bit#">
WHERE User_ID = <cfqueryparam value="#Session.User_ID#" cfsqltype="CF_SQL_INTEGER">
</cfquery>		

<cfset attributes.message="Subscription Updated">	
<cfinclude template="../../includes/form_confirmation.cfm">
