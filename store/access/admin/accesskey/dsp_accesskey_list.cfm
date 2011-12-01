<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the list of access keys. Called by access.admin&accessKey=list --->

<cfparam name="currentpage" default="1">

<!--- Create the page through links, max of 20 records per page --->
<cfmodule template="../../../customtags/pagethru.cfm" 
	totalrecords="#qry_get_accesskeys.recordcount#" 
	currentpage="#currentpage#"
	templateurl="#cgi.script_name#"
	addedpath="&fuseaction=access.admin&accesskey=list#request.token2#"
	displaycount="20" 
	imagepath="#request.appsettings.defaultimages#/icons/" 
	imageheight="12" 
	imagewidth="12"
	hilitecolor="###request.getcolors.mainlink#" >

	
<cfmodule template="../../../customtags/format_output_admin.cfm"
	box_title="Access Keys"
	width="450"
	>
	
<cfoutput>	
	<table width="100%" cellspacing="4" border="0" cellpadding="0" class="formtext" style="color: ###Request.GetColors.OutputTText#;">	


	<tr>
		<td colspan="2">
			<a href="#self#?fuseaction=access.admin&accesskey=add#Request.Token2#">Add Access Key</a></td>
		<td align="right">#pt_pagethru#</td>
	</tr>

	<tr>
			<td colspan="3" style="BACKGROUND-COLOR: ###Request.GetColors.outputHBgcolor#;"><img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="1" width="1" /></td>
	</tr>
	
	<cfif qry_get_AccessKeys.recordcount gt 0>
			
		<cfloop query="qry_get_AccessKeys" startrow="#PT_StartRow#" endrow="#PT_EndRow#">
		<tr>
			<td>
			<cfif system is not 1>
			<a href="#self#?fuseaction=access.admin&accesskey=edit&AccessKey_ID=#AccessKey_ID##Request.Token2#">
			Edit #AccessKey_ID#</a>
			<cfelse>System</cfif>
			</td>
			<td width="75%">#name#</td>
			<td></td>
			</tr>
		</cfloop>
		</table>
		<div align="center" class="formtext">#pt_pagethru#</div>
	<cfelse>	
		<td colspan="3">
			<br/>
			No records selected
		</td>
	</table>	
	</cfif>
</cfoutput>

</cfmodule>
		
