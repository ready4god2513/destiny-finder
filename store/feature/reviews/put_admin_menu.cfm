<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Feature Permission 8 = feature reviews admin --->

<cfmodule  template="../../access/secure.cfm"
	keyname="feature"
	requiredPermission="8"
	>
	<cfset adminlink = "#Request.SecureURL##self#?fuseaction=feature.admin&Review_ID=#Review_ID##Request.AddToken#">
	
	<cfoutput><div class="menu_admin">[<a href="#XHTMLFormat('#adminlink#&review=edit&XFA_success=#URLEncodedFormat(cgi.query_string)#')#" #doAdmin()#>EDIT Review #Review_ID#</a> | 
<cfset returnURL = "#self#?fuseaction=feature.reviews&do=list&feature_ID=#feature_id#">
<a href="#XHTMLFormat('#adminlink#&review=delete&XFA_success=#URLEncodedFormat(returnURL)#')#" #doAdmin()#>DELETE Review #Review_ID#</a> 
]</div></cfoutput>

</cfmodule>
	
	

