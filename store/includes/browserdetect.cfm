
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Basic browser detection. Used to detect MSIE6 on secure server due to bug with cookie handling --->

<!--- Needed for Railo support --->
<cfif NOT isDefined("checkforattack")>
	<cfinclude template="cfw_functions.cfm">
</cfif>

<cfscript> 
function testQueryString(browserType,query_string){ 

	var browserInfo = browserType;
	
	//Run SQL injection tests
	// skip tests if this is an admin page
	//
	if (StructKeyExists(fusebox, 'fuseaction') AND fusebox.fuseaction IS 'admin') {
		BrowserInfo.hackattempt = "no";
	}
	else {
		BrowserInfo.hackattempt = checkforattack();
	}
	
	if (BrowserInfo.browserName IS "hack attempt") {
		BrowserInfo.hackattempt="yes";
	}
	
	if (FindNoCase("http", query_string)) {
		BrowserInfo.hackattempt="yes";
	}
	
	else if (FindNoCase("/includes/includes/", CGI.Path_Info)) {
		BrowserInfo.hackattempt="yes";
	}
	
	//double check for these particularly nasty injection attacks
	else if (FindNoCase("EXEC(", query_string) OR FindNoCase("EXEC(", CGI.Script_Name) OR FindNoCase("EXEC(", CGI.Path_Info)) {
		BrowserInfo.hackattempt="yes";
	}
	
	else if (FindNoCase("CAST(", query_string) OR FindNoCase("CAST(", CGI.Script_Name) OR FindNoCase("CAST(", CGI.Path_Info)) {
		BrowserInfo.hackattempt="yes";
	}
	  
	return BrowserInfo;
} 
</cfscript> 

<cfscript> 
BrowserInfo = testQueryString(Request.BrowserType, cgi.query_string); 
browserName = BrowserInfo.browserName;
browserVersion = BrowserInfo.browserVersion;
</cfscript>

<cfif BrowserInfo.hackattempt>
	<cfoutput><br/><br/>Sorry, your page request appears to be a hack attempt and processing has been halted.<br/><br/> If you arrived at this site via another location, it may have had some code intended to try and find sensitive information. <br/><br/>If you believe this message was received in error, return to the previous page and change the text you entered. <br/><br/>If you continue to receive this message, please contact the Webmaster. </cfoutput>
	<cfabort>
</cfif>