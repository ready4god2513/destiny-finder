
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Javascript redirect after login or logout. If javascript is turned off, will give user a link to click on to continue. Called from act_login.cfm and act_logout.cfm--->

<cfif isdefined("attributes.submit_logout")>
	<cfparam name="attributes.xfa_logout_successful" default="#self#?fuseaction=users.manager">
	<cfset redirect = attributes.xfa_logout_successful>
	<cfset action = "logged out">

<cfelse>
	<cfparam name="attributes.xfa_login_successful" default="#self#?fuseaction=users.manager">
	<cfset redirect = attributes.xfa_login_successful>
	<cfset action = "logged in">
</cfif>

<cfparam name="attributes.server_port" default="80">

<cfset redirect = URLDecode(redirect)>
<cfset redirect = ReReplaceNoCase(redirect, "<[^>]*>", "", "ALL")>

<!--- Check if the redirect already has session information --->
<cfif NOT FindNoCase("CFID=",redirect) AND len(Request.Token2)>
	<cfset redirect = redirect & Request.Token2>
</cfif>
	
<!--- Remove any previous error messages or redirect parameter --->
<cfset redirect = REReplaceNoCase(redirect, "[&(&amp;)]*errormess=[0-9]+", "", "ALL")>
<cfset redirect = REReplaceNoCase(redirect, "[&(&amp;)]*redirect=yes", "", "ALL")>

<!--- If on checkout registration page, remove that from the redirect URL --->
<cfset redirect = ReplaceNoCase(redirect, "&step=register", "&step=address")>

<!--- Add error message --->
<cfif isdefined("variables.errormess") AND variables.errormess IS NOT 0>
	<cfset attributes.xfa_login_successful = Request.LoginURL>
	<cfset redirect = redirect & "&errormess=#errormess#">
	<cfset action = "not logged in">
</cfif>

<!--- If checking out, redirect back to the start of the checkout --->
<cfif FindNoCase("shopping.checkout", redirect)>
	<cflocation url="#redirect#&login=yes" addtoken="No">
</cfif>

<!--- If redirecting to an admin page, set to open in full window with menu --->
<cfif FindNoCase(".admin", redirect)>
	<cfset redirect = redirect & "&newWindow=yes">
</cfif>

<!--- Check server port on login form. If SSL, redirect to SecureURL --->
<cfif attributes.server_port IS 443>
	<cfset redirectURL = "#Request.SecureURL##redirect#&redirect=yes">
<!--- Check if logging in to access admin, if so redirect to SecureURL --->
<cfelseif ReFind("fuseaction=[a-zA-z0-9]+\.admin",redirect)>
	<cfset redirectURL = "#Request.SecureURL##redirect#&redirect=yes">
<!--- Check if logging in to access user functions, if so redirect to SecureURL --->
<cfelseif ReFind("fuseaction=users/.",redirect)>
	<cfset redirectURL = "#Request.SecureURL##redirect#&redirect=yes">
<!--- Regular store links --->
<cfelse>
	<cfset redirectURL = "#Request.StoreURL##redirect#&redirect=yes">
</cfif>
	

<cfoutput>
<script type="text/javascript">
window.top.location.href = '#redirectURL#';
</script>

You are #action#. <a href="#XHTMLFormat(redirectURL)#" target="_top">Click</a> to continue. 
</cfoutput> 
