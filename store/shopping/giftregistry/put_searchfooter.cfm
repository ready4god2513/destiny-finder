
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Outputs the footer for the Gift Registry listings, called by dsp_results.cfm --->

<cfmodule template="../../customtags/putline.cfm" linetype="thick" width="100%">

<cfoutput>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
		<td class="section_footer"><img src="#request.appsettings.defaultimages#/icons/up.gif" border="0" style="vertical-align: middle" alt="" hspace="2" vspace="0" /><a href="#XHTMLFormat(Request.currentURL)###top" class="section_footer" #doMouseOver('top of page')#>top of page</a> 
		</td>
		<td align="right" class="section_footer">
		#pt_pagethru#
		</td>
	</tr>
</table>
</cfoutput>
