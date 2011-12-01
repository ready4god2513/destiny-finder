<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<cfcomponent displayname="Global Functions" hint="This component is used for handling various global functions for the store." output="No">
<!--- This component developed by Mary Jo Sminkey maryjo@cfwebstore.com --->
<!--- Developed for use with CFWebstore e-commerce (www.cfwebstore.com) --->

<!--- Requires CFMX 6 or higher --->

<!--- This code is owned by Dogpatch Software and may not be distributes or reused without permission --->

<!--- Include global functions --->
<cfinclude template="../includes/cfw_functions.cfm">


<!------------------------- COMPONENT INITIALIZATION ----------------------------------->
<cffunction name="init" access="public" output="no" returntype="global">
    <cfreturn this>
  </cffunction>



<!------------------------- BEGIN DEBUG OUTPUT FUNCTION ----------------------------------->
<cffunction name="putDebug" displayname="Display Debug Text" hint="This function is used to output debug text to the page." output="Yes" access="public">

<cfargument name="debugtext" type="string" required="Yes" hint="The full text of the debug string to output.">

<cfoutput>
<pre>#arguments.debugtext#</pre>
</cfoutput>

</cffunction>

<!------------------------- END DEBUG OUTPUT FUNCTION ----------------------------------->


<!------------------------- BEGIN URL CLEANER FUNCTION ----------------------------------->
<cffunction name="CodeCleaner" access="public" output="No" displayname="Code Cleaner" hint="Cleans dangerous tags from text strings, useful to strip URL and form strings." returntype="string">
	<!--- 
	|| BEGIN FUSEDOC ||
	
	|| PROPERTIES ||
	Author: Erki Esken, erki@dreamdrummer.com
	Version: 1.2
	Server Requirements: ColdFusion 4.5+
	
	|| RESPONSIBILITIES ||
	I clean input string from CF tags, SCRIPT blocks, dangerous HTML tags,
	HTML form tags and disable DOM event handlers. You can explicitly tell
	me not to remove some of the things named above. Or alternativly I can
	just escape all tags so that <table> becomes &lt;table&gt; etc.
	
	|| HISTORY ||
	25.04.2001, first created
	25.04.2001, added "javascript:" and "vbscript:" removing, also SERVER and BUTTON tag removing
	07.09.2001, added META and PARAM tags, improved SCRIPT block removing, added BODY tags removing, also added CFEXIT if an end tag was found
	
	--->
	
	<cfargument name="input" required="yes" type="string">
	<cfargument name="r_output" required="No" type="string" default="clean_code">
	<cfargument name="escapeAllTags" required="No" type="boolean" default="no">
	<cfargument name="removeBodyTags" required="No" type="boolean" default="no">
	<cfargument name="removeCFtags" required="No" type="boolean" default="yes">
	<cfargument name="removeScriptBlocks" required="No" type="boolean" default="yes">
	<cfargument name="removeScripts" required="No" type="boolean" default="yes">
	<cfargument name="removeDangerousHTMLtags" required="No" type="boolean" default="yes">
	<cfargument name="removeHTMLformTags" required="No" type="boolean" default="yes">
	<cfargument name="removeDOMeventHandlers" required="No" type="boolean" default="yes">
	
	<cfscript>	
		var domEventsRegExp = '';
		// Set arguments.input to local variable
		var tmp = arguments.input;
	</cfscript>
	
	<cftry>
		<cfscript>		
		if (arguments.escapeAllTags) {
			// Just escape all tags
			tmp = Replace(tmp, "<", "&lt;", "ALL");
			tmp = Replace(tmp, ">", "&gt;", "ALL");
		} else {
			// Remove CF tags
			if (arguments.removeCFtags)
				tmp = REReplaceNoCase(tmp, "(<CF[^>]*>)(.*(</CF[^>]*>))?", "", "ALL");
			
			// Remove BODY tags (leaves only what was between <body> and </body>, everything else is removed)
			if (arguments.removeBodyTags) {
				tmp = REReplaceNoCase(tmp, ".*<BODY[^>]*>", "", "ALL");
				tmp = REReplaceNoCase(tmp, "</BODY[^>]*>.*", "", "ALL");
			}
	
			// Remove SCRIPT blocks
			if (arguments.removeScriptBlocks)
				tmp = REReplaceNoCase(tmp, "(<SCRIPT[^>]*>)(.*(</SCRIPT[^>]*>))?", "", "ALL");
			
			// Remove dangerous HTML tags
			if (arguments.removeDangerousHTMLtags)
				tmp = REReplaceNoCase(tmp, "(</?(APPLET|EMBED|FRAME|FRAMESET|IFRAME|ILAYER|LAYER|META|OBJECT|PARAM|SERVER)[^>]*>)", "", "ALL");
			
			// Remove HTML form tags
			if (arguments.removeHTMLformTags)
				tmp = REReplaceNoCase(tmp, "(</?(BUTTON|FORM|INPUT|KEYGEN|OPTION|SELECT|TEXTAREA)[^>]*>)", "", "ALL");
			
			// Remove "javascript:" and "vbscript:"
			if (arguments.removeScripts)
				tmp = REReplaceNoCase(tmp, "javascript:|vbscript:", "", "ALL");
			
			// Disable DOM event handlers by changing them to innocent foo attribute that gets ignored by the browser
			if (arguments.removeDOMeventHandlers) {
				// All DOM event handlers
				domEventsRegExp = "onabort|onafterupdate|onbeforeunload|onbeforeupdate|onblur|onbounce|onchange|onclick|ondataavailable|ondatasetchanged|ondatasetcomplete|ondblclick|ondragdrop|ondragstart|onerror|onerrorupdate|onfilterchange|onfinish|onfocus|onhelp|onkeydown|onkeypress|onkeyup|onload|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|onmove|onreadystatechange|onreset|onresize|onrowenter|onrowexit|onscroll|onselect|onselectstart|onstart|onsubmit|onunload";
				tmp = REReplaceNoCase(tmp, domEventsRegExp, "foo", "ALL");
			}
		}
		</cfscript>
		<cfcatch>
			<cfthrow type="Global.CodeCleaner" message="Error executing regular expressions on input string.">
		</cfcatch>
	</cftry>
	
	<cfreturn SetVariable(arguments.r_output, tmp)>

</cffunction>

<!-------------------------- END URL CLEANER FUNCTION ------------------------------------>



<!------------------------- BEGIN SEND EMAIL FUNCTION ----------------------------------->
<cffunction name="sendAutoEmail" displayname="Send Auto Email" hint="This function is used to send user emails in the store. It uses standard email texts saved in the database." output="No" access="public">

<cfargument name="UN" type="string" required="No" hint="The username to send the email to." default="">
<cfargument name="UID" type="numeric" required="No" hint="The user ID to send the email to." default="0">
<cfargument name="Email" type="string" required="No" hint="The email address if the user is available." default="">
<cfargument name="MailAction" type="string" required="Yes" hint="The mail template to use for the email">
<cfargument name="MergeContent" type="string" required="No" hint="Text placed into the email" default="">
<cfargument name="MergeName" type="string" required="No" hint="User's name to put into the email" default="">
<cfargument name="XFA_Success" type="string" required="No" hint="Page to return to after sending the email" default="">

<cfscript>
	var subject = "";
	var body = "";
	//queries
	var getUser = '';
	var getEmailText = '';
	var addressto = arguments.email;
</cfscript>

<cfquery name="getUser" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
	SELECT DISTINCT Email, U.Username, U.Password, U.EmailLock, U.LastLogin, U.Created			
	FROM #Request.DB_Prefix#Users U 
	WHERE U.EmailIsBad = 0
	<cfif len(arguments.un)>
		AND U.UserName = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.un#">
	<cfelseif arguments.uid IS NOT 0>
		AND U.User_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.uid#">
	<cfelse>
		AND 0=1
	</cfif>
</cfquery>


<cfquery name="getEmailText"  datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
	SELECT * FROM  #Request.DB_Prefix#MailText
	WHERE MailAction = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.MailAction#">
</cfquery>

<cfscript>
	subject = getEmailText.mailtext_subject;
	body = getEmailText.mailtext_message;

	subject = doTextReplace(subject, arguments.MergeName);
	
	if (getUser.RecordCount) {
		body = doTextReplace(body, arguments.MergeName, arguments.MergeContent, getUser, getUser.Recordcount);
		if (NOT len(addressto) OR NOT isEmail(addressto)) {
			addressto = getUser.email; }
		}
	else
		body = doTextReplace(body, arguments.MergeName, arguments.MergeContent);
		
</cfscript>		

<!--- Send the email --->
<cfprocessingdirective suppresswhitespace="no">
	<cfmail to="#addressto#" 
        from="#request.appsettings.merchantemail#" 
        subject="#subject#"
		type="html" server="#request.appsettings.email_server#" port="#request.appsettings.email_port#">
		<cfmailparam name="Message-id" value="<#CreateUUID()#@#ListGetAt(request.appsettings.merchantemail, 2, "@")#>">
		<cfmailparam name="Reply-To" Value="#request.appsettings.merchantemail#">
#body#

	</cfmail>
</cfprocessingdirective>

<cfif len(arguments.XFA_success)>
	<cflocation url="#request.self#?#arguments.XFA_success##request.token2#" addtoken="No">
</cfif>

</cffunction>
<!------------------------- END SEND EMAIL FUNCTION ----------------------------------->

<!------------------------- BEGIN EMAIL TEXT REPLACE FUNCTION ----------------------------------->
<cffunction name="doTextReplace" displayname="Email Text Replacement Function" hint="This function is used to replace the coded sections in the email templates." output="No" access="public">

<!--- for internal use. Sends standard email to user 
	Sample use:
	<cfinvoke component="#Request.CFCMapping#.global" 
		method="sendAutoEmail"
		MailAction="[number or name]"  		(required) 
		UN OR UID="#user_ID#"  				(for user information)
		Email="user_email"					(for emails where user account may not be available)
		MergeContent="#content#" 			(optional) variable text placed in email 
		MergeName="#FirstName# #LastName#" 	(optional) real name of user
		XFA_Success="url" 					(optional) 
		>	 	
	---->	

<cfargument name="EmailText" type="string" required="Yes" hint="The text string to do replacements on.">
<cfargument name="MergeName" type="string" required="No" hint="User's name to put into the email" default="">
<cfargument name="MergeContent" type="string" required="No" hint="Text placed into the email" default="">
<cfargument name="UserQuery" type="query" required="No" hint="User query to use in the text replacement, if any.">
<cfargument name="RecordCount" type="numeric" required="No" default="0" hint="Records returned when querying for the user.">

<cfscript>

	var str = arguments.EmailText;
	var Merchant = Request.AppSettings.Merchant;
			
	// Replace mailmerge code: %SiteName%, %SiteURL%, %Merchant%, %MerchantEmail% 
	str = replaceNoCase(str,'%SiteName%',request.appsettings.sitename,'All');
	str = replaceNoCase(str,'%SiteURL%',request.StoreURL,'All');
	str = replaceNoCase(str,'%Merchant%',Merchant,'All');
	str = replaceNoCase(str,'%MerchantEmail%',request.appsettings.MerchantEmail,'All');
	str = replaceNoCase(str,'%Date%',dateFormat(now(),'mm/dd/yyyy'),'All');
	
	if (len(arguments.MergeContent))
		str = replaceNoCase(str,'%MergeContent%', replace(arguments.MergeContent,chr(13)&chr(10),'<br />','all'));
	if (len(arguments.MergeName)) 
		str = replaceNoCase(str,'%MergeName%',arguments.MergeName);
		
	//if user record passed in, replace these variables as well
	if (isDefined("arguments.UserQuery") AND arguments.RecordCount GT 0) {
		str = replaceNoCase(str,'%Email%',arguments.UserQuery.Email,'All');
		str = replaceNoCase(str,'%Username%',arguments.UserQuery.Username,'All');
		str = replaceNoCase(str,'%Password%',arguments.UserQuery.Password,'All');
		str = replaceNoCase(str,'%EmailLock%',arguments.UserQuery.EmailLock,'All');
		str = replaceNoCase(str,'%LastLogin%',dateformat(arguments.UserQuery.LastLogin,'mm/dd/yyyy'),'All');
		str = replaceNoCase(str,'%Created%',dateformat(arguments.UserQuery.Created,'mm/dd/yyyy'),'All');	
	}
		
</cfscript>		

<cfreturn str>

</cffunction>

<!------------------------- BEGIN RANDOM PASSWORD FUNCTION ----------------------------------->

<cffunction name="randomPassword" returntype="struct" displayname="Create Random Password" hint="This function creates a random password, given specific criteria." output="No">

<cfargument name="Length" type="numeric" required="Yes">
<cfargument name="AllowNums" type="boolean" required="No" default="Yes">
<cfargument name="AllowSpecials" type="boolean" required="No" default="No">
<cfargument name="Case" type="string" required="No" default="Both">
<cfargument name="ExcludedValues" type="string" required="no" default="">

<!---
Name : random_password.cfm
Author : Jason Hilton
Email : webmaster@discgolferusa.com
Created : 1/3/03
Last Modified : 1/3/03
Comments: I wasn't happy with the different password generator custom tags I could find so 
I decided to create my own with the functionality I thought would be beneficial.

Instructions:

<cf_random_password
	Length="int"
	AllowNums="yes" or "no"
	AllowSpecials="yes" or "no"
	Case="Upper" or "Lower" or "Both"
	ExcludedValues="Comma delimited list of values to exclude from passwords">

REQUIRED PARAMETERS:
	Length,AllowNums,AllowSpecials,Case
OPTIONAL PARAMETERS:
	ExcludedValues
	
*NOTE* The parameter ExcludedValues will exclude only the case you specify for a character.  So to exclude all L's you must enter "l,L".  Also quotes, apostrophes and pound signs are excluded automatically.*NOTE*
	
Example:

<cf_random_password
	Length="8"
	AllowNums="no"
	AllowSpecials="no"
	Case="lower"
	ExcludedValues="i,l,o,z">
--->

<cfscript>
var local = StructNew();
var Result = StructNew();

errorhead = "cf_random_password has encountered the following error(s):<br /><br />";
// Check to see that all parameters exist and are valid

// Check the length parameter
if (IsDefined("arguments.length")) {
	if (arguments.length NEQ "" and isnumeric(arguments.length)) 
		tmplength=arguments.length;
	else 
		error_msg = "You must enter a valid integer value for the LENGTH parameter.<br />";
}
else
	error_msg = "The parameter LENGTH is not defined.<br />";

// Check the allownums parameter
if (IsDefined("arguments.allownums")) {
	if (arguments.allownums NEQ "") {
		if (arguments.allownums EQ "yes")
			tmpallownums = 1; // 1 = allow numbers
		else
			tmpallownums = 0; // 0 = don't allow numbers
	}
	else
		error_msg = "You must enter either a yes or a no for the ALLOWNUMS parameter.<br />";
}
else
	error_msg = "The parameter ALLOWNUMS is not defined.<br />";

// Check the allowspecials parameter

if (IsDefined("arguments.allowspecials")) {
	if (arguments.allowspecials NEQ "") {
		if (arguments.allowspecials EQ "yes")
			tmpallowspecials = 1; // 1 = allow special characters
		else
			tmpallowspecials = 0; // 0 = don't allow special characters
		}
	else
		error_msg = "You must enter either a yes or a no for the ALLOWSPECIALS parameter.<br />";
}
else
	error_msg = "The parameter ALLOWSPECIALS is not defined.<br />";


// Check the case parameter

if (IsDefined("arguments.case")) {
	if (arguments.case NEQ "") {
		if (arguments.case EQ "both")
			tmpcase = 2; // 2 = allow both upper and lower case characters
		else if (arguments.case EQ "upper")
			tmpcase = 1; // 1 = allow upper case characters
		else if (arguments.case EQ "lower")
			tmpcase = 0; // 0 = allow lower case characters
		else
			error_msg = "You must enter upper, lower, or both for the CASE parameter.<br />";
	}
	else
		error_msg = "You must enter upper, lower, or both for the CASE parameter.<br />";
}
else
	error_msg = "The parameter CASE is not defined.<br />";


// Automatically exclude all apostraphe's and quotes within the ascii range of 33-47
tmpexcludedlist = "34,35,39,44";

// Get the Ascii values of items in the ExcludedValues list
if (IsDefined("arguments.excludedvalues")) {
	if (len(arguments.excludedvalues) GT 1 AND listlen(arguments.excludedvalues, ',') EQ 1)
		error_msg = "The value for parameter EXCLUDEDVALUES is not a valid comma seperated value list.<br />";
	else {
		for (a=1; a lte ListLen(arguments.excludedvalues); a=a+1) {
			tempvalue = ListGetAt(arguments.excludedvalues,a);
			if (listfind(tmpexcludedlist,ASC(tempvalue),',') EQ 0)
				tmpexcludedlist = ListAppend(tmpexcludedlist,ASC(tempvalue), ',');
			}
		}
}

// If error messages exist display them and kill process
if (IsDefined("error_msg")) {
	Result.Success = 0;
	Result.ErrorMessage = errorhead & error_msg;
	Result.new_password = '';
}

else {

	// Since no error messages were found, the following code will generate the password
	
	// Generate the list of ascii values allowed
	authorizedascii="";
	if (tmpallowspecials EQ 1) {
		for (b=33; b lte 47; b = b+1) {
			authorizedascii = ListAppend(authorizedascii,b,',');
		}
	}
	if (tmpallownums EQ 1) {
		for (c=48; c lte 57; c = c+1) {
			authorizedascii = ListAppend(authorizedascii,c,',');
		}
	}
	if (tmpcase EQ 2 OR tmpcase EQ 1) {
		for (d=65; d lte 90; d = d+1) {
			authorizedascii = ListAppend(authorizedascii,d,',');
		}
	}
	if (tmpcase EQ 2 OR tmpcase EQ 0) {
		for (e=97; e lte 122; e = e+1) {
			authorizedascii = ListAppend(authorizedascii,e,',');
		}
	}
	
	// Remove the excluded values
	for (f=1; f lte ListLen(tmpexcludedlist); f=f+1) {
		tempvalue = ListGetAt(tmpexcludedlist,f);
		if (listfind(authorizedascii,tempvalue,','))
			authorizedascii = listdeleteat(authorizedascii, listfind(authorizedascii,tempvalue,','),',');
	}
	
	// Find the length of the authorizedascii list for the randomizer
	authorizedlen = listlen(authorizedascii,',');
	
	// Let the password creation begin!
	new_password = "";
	for (g=1; g lte tmplength; g = g+1) {
		tmpposition = RandRange(1,authorizedlen);
		new_password = new_password & Chr(ListGetAt(authorizedascii,tmpposition,','));
	}
	
	Result.Success = 1;
	Result.ErrorMessage = '';
	Result.new_password = new_password;

}

</cfscript>

<cfreturn Result>

</cffunction>
<!------------------------- BEGIN RANDOM PASSWORD FUNCTION ----------------------------------->




</cfcomponent>
