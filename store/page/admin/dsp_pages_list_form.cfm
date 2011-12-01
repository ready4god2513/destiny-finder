
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the List Edit form for pages. This page is used mainly to help reorder the menus at one time. Called by page.admin&do=listform --->

<cfset addedpath="&fuseaction=Page.admin&do=listform">
<cfparam name="currentpage" default="1">

<!--- Create the page through links, max records set to 20 --->
<cfmodule template="../../customtags/pagethru.cfm" 
	totalrecords="#qry_get_pages.recordcount#" 
	currentpage="#currentpage#"
	templateurl="#self#"
	addedpath="#addedpath##request.token2#"
	displaycount="20" 
	imagepath="#request.appsettings.defaultimages#/icons/" 
	imageheight="12" 
	imagewidth="12"
	hilightcolor="###request.getcolors.mainlink#" 
	>
	

			
<cfmodule template="../../customtags/format_admin_form.cfm"
	box_title="Page Manager"
	width="650"
	required_fields="0"
	>

<cfoutput>			
	<tr>
		<td colspan="3">
			<a href="#self#?fuseaction=Page.admin&do=add#Request.Token2#">New Page</a> | <a href="#self#?#replace(cgi.query_string,"listform","list")#">List View</a></td>
		<td colspan="3"
		align="right">#pt_pagethru#</td>
	</tr>	
		
	<tr>
		<th>&nbsp;</th>
		<th>sort</th>
		<th align="left">menu title</th>
		<th align="left">links to    <span class="caution">(system pages)</span></th>
		<th colspan="2" align="center">display</th>
	</tr>	
	
	<tr>
		<td colspan="6" style="BACKGROUND-COLOR: ###Request.GetColors.inputHBgcolor#;">
		<img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="1" width="1" /></td>
	</tr>

<!--- Make list of page IDs to send to next page --->
<cfset PageList = "">

<form name="editform" action="#self#?fuseaction=Page.admin&do=actform#request.token2#" method="post">

<cfif qry_get_Pages.recordcount gt 0>		
	<cfset display_break = 0>
	
	<cfloop query="qry_get_Pages" startrow="#PT_StartRow#" endrow="#PT_EndRow#">
	<!--- Add page to the list of IDs --->
	<cfset PageList = ListAppend(PageList, Page_ID)>
	
	<cfif istitle or (display is 0 AND display_break is 0)>
		<tr>
			<td colspan="6" class="formtextsmall">&nbsp;</td>
		</tr>
		<cfif display is 0 and display_break is 0>
			<cfset display_break = 1>
		</cfif>
	</cfif>
	<tr>
		<td>
			<cfif page_id><a href="#self#?fuseaction=Page.admin&do=edit&Page_ID=#Page_ID##Request.Token2#">
			Edit #Page_ID#</a></cfif>
		</td>
		<td>
		<cfset show_priority = priority>
		<cfif istitle>
			<cfset show_priority = istitle>
		</cfif>
		
		<cfif display><cfif not istitle>&nbsp;&nbsp;&nbsp;</cfif><input type="text" name="Priority#Page_ID#" value="#doPriority(show_priority,0)#" size="2" maxlength="3" class="formfield"/><cfif  istitle>&nbsp;&nbsp;&nbsp;</cfif>
		<cfelse><input type="hidden" name="Priority#Page_ID#" value="#show_priority#"/></cfif></td>
		<td><a href="#self#?fuseaction=page.display&page_id=#page_ID##Request.Token2#" target="store"><cfif istitle>#Page_name#</strong><cfelse>#Page_name#</cfif></a></td>
		<td <cfif system> class="caution"</cfif>>#Page_URL#</td>
		<td align="center"><input type="checkbox" name="Display#Page_id#" value="1" #doChecked(Display)# />
		<input type="hidden" name="Parent_id#Page_ID#" value="#Parent_id#"/>
		</td>
		<td></td>
	</tr>
	</cfloop>	
	
	<tr><td colspan="6" align="center">
	<input type="submit" name="Action" value="Save Changes" class="formbutton"/>
	<input type="hidden" name="PageList" value="#PageList#"/>
		</td></tr>
</form>

	<div align="right" class="formtext">#pt_pagethru#</div>

<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">


objForm = new qForm("editform");

<cfloop index="Page_ID" list="#PageList#">
	objForm.Priority#page_ID#.description = "priority number #page_ID#";
</cfloop>

<cfloop index="page_ID" list="#pageList#">
	objForm.Priority#page_ID#.validateNumeric();
	objForm.Priority#page_ID#.validateRange('0','9999');
</cfloop>

qFormAPI.errorColor = "###Request.GetColors.formreq#";

</script>
</cfprocessingdirective>
		
	<cfelse>	
	<tr>
		<td colspan="6">
		<br/>
		No records selected
		</td>
	</tr>
	</cfif>
	
</cfoutput>

</cfmodule>


		
