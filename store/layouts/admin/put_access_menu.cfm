<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the admin menu for the access circuit. Called from the home.admin fuseaction --->

<cfparam name="totaltabs" default="0">
<cfparam name="accessmenu" default="">

<cfmodule template="../../access/secure.cfm" keyname="access" requiredPermission="2">  

<!--- If page being called is a access admin page, set tabs open on Access menu --->
<cfif (FindNoCase("access.admin", attributes.xfa_admin_link))>
	<cfset tabstart = totaltabs>
</cfif>

<cfset totaltabs = totaltabs + 1>

<cfsavecontent variable="accessmenu">
<cfoutput> 

	<cfmodule template="../../access/secure.cfm"
	keyname="access"
	requiredPermission="4"
	>  
		<cfset innertext = Application.objMenus.getValidMemberships()>
		<div id="Memberships_Div" spry:region="txtPending"><br/><a href="#self#?fuseaction=access.admin&membership=list&show=all&IsExpired=current&valid=0#Request.Token2#" onmouseover="return escape(access3)" target="AdminContent">Validate Memberships</a>:<br/> <span style="color: red"><span id="membershipcount" spry:content="{Memberships}">#innertext#</span> need approval.</span><br/><br/>
		</div>
		
		<a href="#self#?fuseaction=access.admin&membership=list#Request.Token2#" onmouseover="return escape(access1)" target="AdminContent">Memberships</a><br/>

<a href="#self#?fuseaction=access.admin&report=recurring#Request.Token2#" onmouseover="return escape(access4)" target="AdminContent">Membership Report</a><br/>
	</cfmodule>
	
	
	<a href="#self#?fuseaction=access.admin&accesskey=list#Request.Token2#" onmouseover="return escape(access2)" target="AdminContent">Access Keys</a><br/>
	
	</cfoutput> 

</cfsavecontent>

</cfmodule>

