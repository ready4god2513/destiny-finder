<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->


<!---
*** SYNATAX ***
<CF_PAGETHRU 
	TOTALRECORDS="integer" 
	currentpage="integer" 
	TEMPLATEURL="URL Path"
	ADDEDPATH="string" 
	DISPLAYCOUNT="integer" 
	PAGEGROUP="integer"
	IMAGEPATH="URL path" 
	IMAGEHEIGHT="integer" 
	IMAGEWIDTH="integer"
	HILIGHTCOLOR="hex code or color literal" 
	PREVIOUSSTR="string"
	NEXTSTR="string" 
	PREVIOUSGROUPSTR="string" 
	NEXTGROUPSTR="string">

 - TOTALRECORDS (required) specifies the records returned by the query to be paged through.
 - currentpage (required) the current page in the query that is to be displayed.
 - TEMPLATEURL (required) the URL path of the template that is paging though the query.
	This will usually be that same template that is calling CF_PageThru.
 - ADDEDPATH (optional) additonal URL parameters that will tacked on to the navigational URLs.
	The parameter list must start with an amperstand (&)
 - DISPLAYCOUNT (optional) specifies the maximum number of records to be displayed per page.
	The default is 25 records.
 - PAGEGROUP (optional) the maximum numnber of numeric page links to be displayed at one time
	in the page through navigation.  Set PAGEGROUP="0" to turn page grouping off.
	The default is 10.
 - IMAGEPATH (optional) the URL path of the images to be used in the navigation.  This
	customtags buttons for Next/Previous and Next Group/Previous Group.
	The default is "" (empty path) which results in using the current template
	URL directory for images.  Set IMAGEPATH="NONE" to use hypertext buttons.
	Images names are: right.gif, rright.gif, left.gif and lleft.gif
 - IMAGEHEIGHT (optional) the height of all image buttons.  The default is 10 pixels.
 - IMAGEWIDTH (optional) the width of all image buttons.  The default is 10 pixels.
 - HILITECOLOR (optional) the text color of the current page number in the page through
	navigation.  The default is "Red".
 - PREVIOUSSTR (optional) the hyperlink text of the previous button.  The default is "<".
	You must set IMAGEPATH="NONE" to use this option.
 - NEXTSTR (optional) the hyperlink text of the next button.  The default is ">".
	You must set IMAGEPATH="NONE" to use this option.
 - PREVIOUSGROUPSTR (optional) the hyperlink text of the previous group button.  The default is "<<".
	You must set IMAGEPATH="NONE" to use this option.
 - NEXTGROUPSTR (optional) the hyperlink text of the next group button.  The default is ">>".
	You must set IMAGEPATH="NONE" to use this option.

	
*** RETURNED VARS ***

PT_StartRow  - the first row of the paged query to be displayed on the current page.
PT_EndRow - the last row of the paged query to be displayed on the current page.
PT_PageThru - navigation.  Output this variable wherever you want the PageThru navigation
	to be displayed.
PT_ErrorCode - Numeric error code.  If not zero, an error occured. 
PT_ErrorMsg - Error description.

--->

<!--- INITIALIZE VARIABLES --->
<cfparam name="attributes.totalrecords" default="0">
<cfparam name="attributes.displaycount" default="25">
<cfparam name="attributes.pagegroup" default="10">
<cfparam name="attributes.currentpage" default="1">
<cfparam name="attributes.templateurl" default="">
<cfparam name="attributes.addedpath" default="">
<cfparam name="attributes.imagepath" default="">
<cfparam name="attributes.imageheight" default="10">
<cfparam name="attributes.imagewidth" default="10">
<cfparam name="attributes.hilitecolor" default="red">
<cfparam name="attributes.previousstr" default="&lt;">
<cfparam name="attributes.previousgroupstr" default="&lt;&lt;">
<cfparam name="attributes.nextstr" default="&gt;">
<cfparam name="attributes.nextgroupstr" default="&gt;&gt;">
<cfparam name="attributes.pagename" default="page">
<cfset errorcode = 0>
<cfset pagestr = "">

<!--- ERROR CODES --->
<cfset ErrorArray = ArrayNew(1)>
<cfset ErrorArray[1] = "The 'TotalRecords' parameter must be a positive integer.">
<cfset ErrorArray[2] = "The 'DisplayCount' parameter must be an integer greater than zero.">
<cfset ErrorArray[3] = "The 'PageGroup' parameter must be a positive integer.">
<cfset ErrorArray[4] = "The 'currentpage' parameter must be an integer greater than zero.">

<!--- CHECK IF PARAMETERS PASSED ARE PROPER --->
<cfif NOT IsNumeric(attributes.totalrecords) OR Val(attributes.totalrecords) LT 0>
	<cfset errorcode = 1>
</cfif>
<cfif NOT IsNumeric(attributes.displaycount) OR Val(attributes.displaycount) LT 1>
	<cfset errorcode = 2>
</cfif>
<cfif NOT IsNumeric(attributes.pagegroup) OR Val(attributes.pagegroup) LT 0>
	<cfset errorcode = 3>
</cfif>
<cfif NOT IsNumeric(attributes.currentpage) OR Val(attributes.currentpage) LT 1>
	<cfset errorcode = 4>
</cfif>


<!---	Calculate Page Starts and Stops	--->
<cfset start = (attributes.currentpage - 1) * attributes.displaycount + 1>
<cfset end = attributes.currentpage * attributes.displaycount>
<cfset end = iif(end GT attributes.totalrecords, attributes.totalrecords, end)>

<cfset maxpages = attributes.totalrecords / attributes.displaycount>
<cfif attributes.totalrecords MOD attributes.displaycount>
<cfset maxpages = IncrementValue(maxpages)>
</cfif>


<!---	Calculate the range of diaplyed pages	--->
<cfif maxpages GT attributes.pagegroup AND attributes.pagegroup>
	<cfif (maxpages - attributes.currentpage) GT (attributes.pagegroup - 1)>
		<cfset frompage = attributes.currentpage>
		<cfset topage = attributes.currentpage + attributes.pagegroup - 1>
	<cfelse>
		<cfset frompage = maxpages - (attributes.pagegroup - 1)>
		<cfset topage = maxpages>
	</cfif>
<cfelse>
	<cfset frompage = 1>
	<cfset topage = maxpages>
</cfif>


<!---	Decide to use hypertext or graphic navigation	--->
<cfif not comparenocase(UCase(attributes.imagepath), 'none')>
	<cfset pgstr = attributes.previousgroupstr>
	<cfset ppstr = attributes.previousstr>
	<cfset npstr = attributes.nextstr>
	<cfset ngstr = attributes.nextgroupstr>
<cfelse>
	<cfset pgstr = "<img src=""#attributes.imagepath#lleft.gif"" width=""#attributes.imagewidth#"" height=""#attributes.imageheight#"" border=""0"" style=""vertical-align: middle"" alt=""#attributes.previousgroupstr#"" />">
	<cfset ppstr = "<img src=""#attributes.imagepath#left.gif"" width=""#attributes.imagewidth#"" height=""#attributes.imageheight#"" border=""0"" style=""vertical-align: middle"" alt=""#attributes.previousstr#"" />">
	<cfset npstr = "<img src=""#attributes.imagepath#right.gif"" width=""#attributes.imagewidth#"" height=""#attributes.imageheight#"" border=""0"" style=""vertical-align: middle"" alt=""#attributes.nextstr#"" />">
	<cfset ngstr = "<img src=""#attributes.imagepath#rright.gif"" width=""#attributes.imagewidth#"" height=""#attributes.imageheight#"" border=""0"" style=""vertical-align: middle"" alt=""#attributes.nextgroupstr#"" />">
</cfif>


<cfif maxpages GT 1>
	<cfset pagestr = "<font size=""-1"">#attributes.pagename#&nbsp;</font>">
	<cfif frompage NEQ 1 AND attributes.pagegroup GT 1>
		<cfif (attributes.currentpage - attributes.pagegroup) GT 1><cfset prev = attributes.currentpage - attributes.pagegroup><cfelse><cfset prev = 1></cfif>
		<cfset pagestr = pagestr & " <a href=""#attributes.templateurl#?currentpage=#prev##attributes.addedpath#""  onmouseover=""dmim('back'); return document.returnValue;"" onmouseout=""dmim(''); return document.returnValue;"">#pgstr#</a> ">
	</cfif>
	<cfif attributes.currentpage NEQ 1><cfset prev = attributes.currentpage - 1>
		<cfset pagestr = pagestr & " <a href=""#attributes.templateurl#?currentpage=#prev##attributes.addedpath#""   onmouseover=""dmim('previous'); return document.returnValue;"" onmouseout=""dmim(''); return document.returnValue;"">#ppstr#</a> ">
	</cfif>
	
	<cfif attributes.pagename is not "">
	<cfloop index="count" from="#frompage#" to="#topage#">
		<cfif count IS attributes.currentpage>
			<cfset pagestr = pagestr & " <b><font color=""#attributes.hilitecolor#""> #count#</font></b> ">
		<cfelse>
			<cfset pagestr = pagestr & " <a href=""#attributes.templateurl#?currentpage=#count##attributes.addedpath#""   onmouseover=""dmim('page #count#'); return document.returnValue;"" onmouseout=""dmim(''); return document.returnValue;""> #count#</a> ">
		</cfif>
	</cfloop>
	</cfif>
	
	<cfif attributes.currentpage NEQ maxpages><cfset next = attributes.currentpage + 1>
		<cfset pagestr = pagestr & " <a href=""#attributes.templateurl#?currentpage=#next##attributes.addedpath#"" onmouseover=""dmim('next'); return document.returnValue;"" onmouseout=""dmim(''); return document.returnValue;"">#npstr#</a> ">
	</cfif>
	<cfif topage NEQ maxpages and attributes.pagegroup GT 1><cfset next = topage + 1>
		<cfset pagestr = pagestr & " <a href=""#attributes.templateurl#?currentpage=#next##attributes.addedpath#"" onmouseover=""dmim('next'); return document.returnValue;"" onmouseout=""dmim(''); return document.returnValue;"">#ngstr#</a> ">
	
	</cfif>
</cfif>

<!--- RETURN VARIABLES --->
<cfset caller.pt_startrow = start>
<cfset caller.pt_endrow = end>
<cfset caller.pt_pagethru = pagestr>
<cfset caller.pt_errorcode = errorcode>
<cfif errorcode IS 0>
	<cfset caller.pt_errormsg = "ok.">
<cfelse>
	<cfset caller.pt_errormsg = ErrorArray[errorcode]>
</cfif>

