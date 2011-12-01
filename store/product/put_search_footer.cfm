
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This is the standard footer that goes at the bottom of product listings. It is called by catcore_product.cfm and dsp_results.cfm. --->
			
<cfif attributes.thickline>
	<cfmodule template="../customtags/putline.cfm" linetype="thick">
</cfif>
			
<cfoutput><div align="center">#pt_pagethru#</div><br/></cfoutput>

