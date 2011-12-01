
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page includes all the required code for CFWebstore layout files --->

<!--- The web page title is set dynamically to match category, page, product or feature name/title. Proper web page titles are important for search engine placement and ranking. --->

<cfparam name="webpage_title" default="#request.AppSettings.siteName#">

<!--- Strip any HTML tags from the title tag if necessary --->
<cfset webpage_title = REReplace(webpage_title,"<[^>]*>","","ALL")>

<!--- Required to use the whitespace suppression --->
<cfinclude template="../includes/puthtmlcompress.cfm">

<!--- Required if you wish to pass parameters into the layout page, will appear as attribute scope --->
<cfinclude template="../includes/parseparams.cfm">

<!--- Use the XHTML doctype for the main customer site only. Several admin functions do not work well with the XHTML doctype --->
<cfif fusebox.fuseaction is "admin">
	<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">	
	<html>
<cfelse>
	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
</cfif>
<head>

<title><cfoutput>#request.AppSettings.siteName#: #webpage_title#</cfoutput></title>

<!---- REQUIRED for search engine safe URLs to work ---->
<cfif IsDefined("variables.baseHref")>
	<cfoutput><base href="#variables.baseHref#"/></cfoutput>
</cfif>


<!--- Includes code for dynamic meta tags --->
<cfinclude template="put_meta.cfm">	

<!--- REQUIRED - provides for informative status bar messages on link roll-overs --->
<script type="text/javascript" src="includes/statusbarmessage.js"></script>

<!--- REQUIRED - Qforms provides the javascript form field error checking --->
<cfinclude template="../includes/qforms.cfm">

<!--- This is used to keep the user's session alive --->
<script type="text/javascript" src="includes/keepalive.js"></script>

<link rel="stylesheet" href="css/calendar.css" type="text/css"/>
<script type="text/javascript" src="includes/CalendarPopup.js"></script>

<script type="text/javascript">
//used for the calendar popup
document.write(getCalendarStyles());
</script>	
	
