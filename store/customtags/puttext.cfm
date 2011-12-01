
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This custom tag is used for outputting sections of text on the page --->

<!--- 
Required:
Text is the text to output
Token is used to check if cookies on or off

Optional:
class is the style sheet class to use
block is used to add a blockquote tag around the output
ptag is used to include a paragraph tag in the output
 --->
<cfif thistag.ExecutionMode is "start">


<cfparam name="attributes.Text" default="">
<cfparam name="attributes.Token" default="">
<cfparam name="attributes.class" default="mainpage">
<cfparam name="attributes.block" default="No">
<cfparam name="attributes.ptag" default="No">

<cfscript>
function XHTMLFormat(str){ 
	var formattedstr = Replace(str, "&", "&amp;", "ALL");
	return formattedstr;
} 
</cfscript>

<!--- Remove any wrapping <p>tags</p> --->
<!--- This regular expression should only find text that starts and end with <p> tags, but does not use them inside --->
<cfset Text = ReReplaceNoCase(attributes.Text, '^\s*(<p>)(?!.*<p\s*[^>]*>)(.*?)(</p>)\s*$', '\2')>
 
<!--- Check if cookies not on, if not, append client variables to any links in the text --->
<cfif len(attributes.Token)>
	<cfset paramMatch = '(<a[[:space:]]+.*?href=".*?\.cfm\?.*?)(".*?>)'>
	<cfset noparamMatch = '(<a[[:space:]]+.*?href=".*?\.cfm)(".*?>)'>
	<!--- Add token to any links with URL parameters --->
	<cfset Text = ReReplaceNoCase(Text, paramMatch, '\1&amp;#XHTMLFormat(Session.URLToken)#\2', 'ALL')>
	<!--- Add token to any links with no URL parameters --->
	<cfset Text = ReReplaceNoCase(Text, noparamMatch, '\1#XHTMLFormat(attributes.Token)#\2', 'ALL')>
</cfif>

<cfoutput><cfif attributes.block><blockquote></cfif>
<div class="#attributes.class#">#Text#</div><cfif attributes.ptag><br/></cfif>
<cfif attributes.block></blockquote></cfif></cfoutput>

</cfif>

