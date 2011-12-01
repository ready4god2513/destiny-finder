<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Creates a copy of a mailtext. Called by users.admin&mailtext=copy --->

<!--- Get the mailtext to copy --->
<cfinclude template="qry_get_mailtext.cfm">

<cfif qry_get_mailtext.recordcount>
	<cftransaction isolation="SERIALIZABLE">

	<cfquery name="Addmailtext" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		INSERT INTO #Request.DB_Prefix#MailText 
		(MailText_Name, MailText_Subject, MailText_Message, System, MailAction)
		VALUES (
		'#qry_get_mailtext.mailtext_name#',
		'#qry_get_mailtext.mailtext_subject#',
		'#qry_get_mailtext.mailtext_message#',
		'#qry_get_mailtext.system#',
		'#qry_get_mailtext.MailAction#')
	</cfquery>	
			
	<cfquery name="Get_id" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
		   SELECT MAX(MailText_ID) AS maxid
		   FROM #Request.DB_Prefix#MailText
	</cfquery>
	
	<cfset attributes.mailtext_id = get_id.maxid>
	
	</cftransaction>
</cfif>		

<cfsetting enablecfoutputonly="no">
