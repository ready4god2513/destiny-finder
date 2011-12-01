
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page can be used to output the merchant address and email on your layout files. --->
<!--- Make replacements for @ and . in address string to HIDE email address from spambots. --->
<cfset email = Replace(Request.AppSettings.MerchantEmail, "@", "&##64;", "All")>
<cfset email = Replace(email, ".", "&##46;", "All")>

<cfoutput>
<div class="menu_footer">
<cfif len(Request.AppSettings.Merchant)>#Request.AppSettings.Merchant#<br/></cfif>
<cfif len(Request.AppSettings.MerchantEmail)>
<a href="mailto&##58;#email#">#email#</a>
</cfif></div>
</cfoutput>



