<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Product Permission 64 = product reviews admin --->
<cfmodule  
	template="../../access/secure.cfm"
	keyname="product"
	requiredPermission="64"
	>
	
	<cfif isdefined("Review_ID")>
		<cfset adminlink = "#Request.SecureURL##self#?fuseaction=product.admin&review_id=#review_id##Request.AddToken#">
		<cfoutput><div class="menu_admin">[<a href="#XHTMLFormat('#adminlink#&review=edit&xfa_success=#URLEncodedFormat(cgi.query_string)#')#" #doAdmin()#>EDIT Review #Review_ID#</a> | 
<cfset returnURL = "#self#?fuseaction=product.reviews&do=list&product_ID=#product_id#">
<a href="#XHTMLFormat('#adminlink#&review=delete&xfa_success=#URLEncodedFormat(returnURL)#')#" #doAdmin()#>DELETE Review #Review_ID#</a> 
]</div>
</cfoutput>
	</cfif>

</cfmodule>
	
	

