
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page outputs a text description of the search criteria above a product list. Used by dsp_products.cfm and catcore_products.cfm ---->


<!--- Output search header --->
<cfif attributes.searchheader>
	<cfoutput><div class="ResultHead">
	<span class="resultheadtext">#qry_Get_products.recordcount# listings for #searchheader#</span>
	<cfif isDefined("qry_Account") AND len(qry_Account.Logo)>
		<div class="acclogoimg">
			<img src="#Request.AppSettings.DefaultImages#/#qry_Account.Logo#">
		</div>
	</cfif>
	<hr>
	</div></cfoutput>
</cfif>

<cfoutput><div align="right" class="section_footer" style="margin:5px;">#pt_pagethru#</div></cfoutput>

<cfif attributes.thickline and (attributes.searchheader OR len(pt_pagethru))>
	<cfmodule template="../customtags/putline.cfm" linetype="thick">
</cfif>
