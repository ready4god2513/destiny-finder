<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page is used to reset all the cached data --->

<!--- Clear cached data --->
<cfobjectcache action = "clear">

<!--- Clear Application data --->
<cfset StructClear(Application)>

<!--- Also clear the menus, if stored in session memory, so they reload for the admin --->
<cfif isDefined("Session.SideMenus")>
	<cfset StructDelete(Session, "SideMenus")>
</cfif>
<cfif isDefined("Session.BottomMenus")>
	<cfset StructDelete(Session, "BottomMenus")>
</cfif>
<cfif isDefined("Session.TopMenus")>
	<cfset StructDelete(Session, "TopMenus")>
</cfif>
<cfif isDefined("Session.VertMenus")>
	<cfset StructDelete(Session, "VertMenus")>
</cfif>

<cflocation url="#self#?fuseaction=home.admin&adminmenu=yes&xfa_admin_link=#URLEncodedFormat(cgi.query_string)##Request.Token2#" addtoken="No">

