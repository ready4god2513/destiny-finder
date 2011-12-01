<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Outputs the footer for the accounts listings, called by catcore_accounts.cfm and dsp_results.cfm --->

<cfmodule template="../../customtags/putline.cfm" linetype="thick" width="100%">

<cfoutput>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
		<td class="section_footer"><img src="#request.appsettings.defaultimages#/icons/up.gif" border="0" valign="baseline" alt="" hspace="2" vspace="0" /><a href="#XHTMLFormat(Request.currentURL)###top" class="section_footer" #doMouseover('top of page')#>top</a> 
<!---
|<img src="#request.appsettings.defaultimages#/icons/left.gif" border="0" valign="middle" alt="" hspace="2" vspace="0" /><a href="#self#?fuseaction=category.display&category_id=#listlast(request.qry_get_cat.parentids)#" class="section_footer"  onmouseover=" window.status='back'; return true" onmouseout="window.status=' '; return true">#listlast(request.qry_get_cat.parentnames,":")#</a>
--->
		</td>
		
		<td align="right" class="section_footer">
		#pt_pagethru#
		</td>
	</tr>
</table>
</cfoutput>
