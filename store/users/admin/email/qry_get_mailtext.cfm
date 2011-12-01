<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- We need to get the message requested. --->
<cfparam name="attributes.MailAction" default="">
<cfparam name="attributes.mailtext_id" default="">

<cfquery name="qry_get_mailtext" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
	SELECT * FROM  #Request.DB_Prefix#MailText
	WHERE 1 = 1
		<cfif len(attributes.MailAction)>
			AND MailAction = '#attributes.MailAction#'
		</cfif>
		<cfif len(attributes.mailtext_id)>
			AND MailText_ID = #attributes.mailtext_id#
		</cfif>
</cfquery>
	

		
	
