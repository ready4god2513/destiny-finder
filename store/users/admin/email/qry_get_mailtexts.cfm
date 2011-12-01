
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<cfparam name="attributes.mailtext_name" default="">

<cfquery name="qry_get_mailtexts"  datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT * FROM #Request.DB_Prefix#MailText
		WHERE 1 = 1
		<cfif len(attributes.mailtext_name)>AND MailText_Name like '%#attributes.mailtext_name#%'</cfif>
		<cfif isdefined("attributes.email")>
		AND System = 0
		</cfif>		
		ORDER BY System DESC, MailAction
</cfquery>
		
