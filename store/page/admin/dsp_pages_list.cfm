
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the list of pages. Called by page.admin&do=list --->

<cfset addedpath="&fuseaction=Page.admin&do=list">
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
	

				
<cfmodule template="../../customtags/format_output_admin.cfm"
	box_title="Page Manager"
	width="650"
	>

<cfoutput>		
<table width="100%" cellspacing="4" border="0" cellpadding="0" class="formtext" style="color: ###Request.GetColors.OutputTText#;">		

	<tr>
		<td colspan="3">
			<a href="#self#?fuseaction=Page.admin&do=add#Request.Token2#">New Page</a> | <a href="#self#?#replace(cgi.query_string,"list","listform")##request.token2#">Edit Form</a></td>
		<td colspan="3"
		align="right">#pt_pagethru#</td>
	</tr>	
		
	<tr>
		<th>&nbsp;</th>
		<th>sort</th>
		<th align="left">menu title</th>
		<th align="left">links to  <span class="caution">(system pages)</span></th>
		<th align="center">display</th>
		<th></th>
	</tr>	
	
	<tr>
		<td colspan="6" style="BACKGROUND-COLOR: ###Request.GetColors.outputHBgcolor#;"><img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="1" width="1" /></td>
</tr>
		
<cfif qry_get_Pages.recordcount gt 0>		
	<cfset display_break = 0>
	
	<cfloop query="qry_get_Pages" startrow="#PT_StartRow#" endrow="#PT_EndRow#">
	
	<cfif istitle or (display is "0" AND display_break is "0")>
		<tr>
			<td colspan="6" class="formtextsmall">&nbsp;</td>
		</tr>
		<cfif display is "0" and display_break is "0">
			<cfset display_break = 1>
		</cfif>
	</cfif>
	<tr>
		<td>
			<cfif page_id><a href="#self#?fuseaction=Page.admin&do=edit&Page_ID=#Page_ID##Request.Token2#">
			Edit #Page_ID#</a></cfif>
		</td>
		<td align="center">
		<cfif display AND NOT istitle>
			&nbsp;&nbsp;#doPriority(priority,0)#
		<cfelseif display>
			#doPriority(istitle,0)#&nbsp;&nbsp;
		</cfif></td>
		
		<td><a href="#self#?fuseaction=page.display&page_id=#page_ID##Request.Token2#" target="store"><cfif istitle>#Page_name#</strong><cfelse>#Page_name#</cfif></a></td>
		<td <cfif system> class="caution"</cfif>>#Page_URL#</td>
		<td align="center"><cfif Display is 1 and page_id is not "0">Yes</cfif></td>
		<td><a href="#self#?fuseaction=Page.admin&do=copy&Page_ID=#Page_ID##Request.Token2#">copy</a></td>
	</tr>	
	
		</cfloop>	
	
	
	</table>
		
			<div align="right" class="formtext">#pt_pagethru#</div>
		
	<cfelse>	
		<td colspan="6">
		<br/>
		No records selected
		</td>
	</table>	
	</cfif>

</cfoutput>

</cfmodule>


		
