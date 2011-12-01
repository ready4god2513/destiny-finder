<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Runs the CRUD functions for MailText table --->

<cfswitch expression="#mode#">

	<cfcase value="i">
	
			<cfquery name="Addmailtext" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			INSERT INTO #Request.DB_Prefix#MailText 
			(MailText_Name, MailText_Subject, MailText_Message, System, MailAction)
			VALUES
			('#Attributes.mailtext_name#',
			'#Attributes.mailtext_subject#', 
			'#Attributes.mailtext_message#',
			0,
			'#attributes.MailAction#'
			 )
			</cfquery>	

	</cfcase>
			
	<cfcase value="u">
	
		<cfif submit is "delete">
		
				<cfquery name="deletemailtext" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				DELETE FROM #Request.DB_Prefix#MailText 
				WHERE MailText_ID = #attributes.mailtext_ID#
				</cfquery>
						
		<cfelse>
		
			<cfquery name="update_mailtext" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			UPDATE #Request.DB_Prefix#MailText 
			SET MailText_Name = '#Attributes.mailtext_Name#',
			MailText_Subject = '#Attributes.mailtext_Subject#',
			MailText_Message = '#Attributes.mailtext_Message#',
			MailAction = '#Attributes.MailAction#'
			WHERE MailText_ID = #Attributes.mailtext_ID#
			</cfquery>	

		</cfif>
	</cfcase>

</cfswitch>
			

