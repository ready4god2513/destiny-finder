<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the list of saved email templates --->

<cfparam name="currentpage" default="1">

<cfmodule template="../../../customtags/pagethru.cfm" 
	totalrecords="#qry_get_mailtexts.recordcount#" 
	currentpage="#currentpage#"
	templateurl="#cgi.script_name#"
	addedpath="&fuseaction=users.admin&mailtext=list#request.token2#"
	displaycount="20" 
	imagepath="#request.appsettings.defaultimages#/icons/" 
	imageheight="12" 
	imagewidth="12"
	hilitecolor="###request.getcolors.mainlink#" >


<cfmodule template="../../../customtags/format_output_admin.cfm"
	box_title="Send Email"
	Width="575"
	menutabs="yes">
	
	<cfinclude template="dsp_menu.cfm">
		
<cfoutput>	
	<table width="100%" cellspacing="4" border="0" cellpadding="0" class="formtext" 	style="color:###Request.GetColors.InputTText#">
	<tr><td colspan="3" class="formtext">
	You can create and edit standard messages here to prevent having to re-write the same email again and again. The messages created here can be copied into the email form when sending an email.<br/><br/>System emails are generated automatically by the site. You can not delete the default system emails.<br/><br/>
	</td></tr>

	<tr>
		<td colspan="2">
			<a href="#self#?fuseaction=users.admin&mailtext=add#Request.Token2#">Add Email Template</a></td>
		<td align="right" colspan="1">#pt_pagethru#</td>
	</tr>

	<tr>
			<td colspan="3" style="BACKGROUND-COLOR: ###Request.GetColors.outputHBgcolor#;">
			<img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="1" width="1" /></td>
	</tr>
</cfoutput>	
	<cfif qry_get_mailtexts.recordcount gt 0>
		
			
			<!--- startrow="#PT_StartRow#" endrow="#PT_EndRow#"--->
		<cfoutput query="qry_get_mailtexts" group="system">
			
			<tr><td colspan="3" class="formtitle"><br/><cfif system>System Emails<cfelse>Custom Emails</cfif></td></tr>
			
			<tr>
		  		<td></td>
				<th width="45%" align="left">Email Name</th>
				<th width="33%" align="left">MailAction <cfif system>(<span class="caution">system default</span>)</cfif></th>
			</tr>	
			<cfoutput>
		<tr>
			<td>
			<a href="#self#?fuseaction=users.admin&mailtext=edit&mailtext_ID=#mailtext_ID##Request.Token2#">
			Edit #mailtext_ID#</a>
			</td>
			<td>#mailtext_name#</td>
			<td>
			<cfif system><span class="caution">#MailAction#</span><cfelse>#MailAction#</cfif>
			</td>
			</tr>
			</cfoutput>
		</cfoutput>
	
		</table>	
		<div align="center"><cfoutput>#pt_pagethru#</cfoutput></div><br/>
	<cfelse>	
		<td colspan="3">
			<br/>
			No records selected
		</td>
	</table>	
	</cfif>


</cfmodule>
		
