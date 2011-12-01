
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Creates a new directory for the download and moves a copy of the file there. Then gives the user a link to that location to download from. --->


<!--- Set up directory variables and clear any old directories --->
<cfinclude template="act_clear_downloads.cfm">

<!---- look up the membership ID ----->
<cfif qry_get_membership.recordcount>

	<cfif len(qry_get_membership.content_url)>
	
		<!--- increment the download stats ---->					
		<cfquery name="UpdateDownloads" datasource="#Request.DS#" username="#Request.user#" 
		password="#Request.pass#">
			UPDATE Memberships
			SET Access_Used = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#(qry_get_membership.Access_Used + 1)#">
			WHERE Membership_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#qry_get_membership.Membership_ID#">
		</cfquery>	
			
		<!--- Determine current location of file --->
		<cfset download_file = "#Request.DownloadPath##Request.Slash##qry_get_membership.content_url#">
		<cfset TheFile = GetFileFromPath(qry_get_membership.content_url)>
		
		<!--- Set new directory for file --->
		<cfset NewDirName = CreateUUID()>
		<cfset newDirectory = downloadDir & NewDirName>
		
		<!---  Make sure file path is correct for the server --->
		<cfset download_file = ReReplace(download_file, "[\\\/]", Request.slash, "ALL")>
		
		<cfif FileExists("#download_File#")>
		
 			<cftry> 
			<!--- Create New Directory --->	
			<cfdirectory action="CREATE" directory="#newDirectory#" mode="644">
	
			<!--- Move the file to new Directory --->
			<cffile action="COPY" source="#download_File#" destination="#newDirectory##Request.slash##TheFile#" attributes="Normal" mode="644">

			<!--- Pause the page until the file has been created --->
			<cfloop condition = "NOT FileExists('#newDirectory##Request.slash##TheFile#')">   
				<cfset createObject('java', 'java.lang.Thread').sleep(500)> 
			</cfloop>

			
 			<cfcatch type="Any">
				<cfset error_message = "Sorry, this server does not appear to be correctly set up for downloads. Please contact the admin for more information.">
			</cfcatch>
			</cftry>
			
		<cfelse>
			<cfset error_message = "Sorry, there was a problem retrieving the file from the server. Please contact us for more assistance.">
		
		</cfif>
		
	<!--- debug 
	<cfoutput>#download_file# - #thefile#</cfoutput>
	---------->
		
	<cfelse><!--- check for file ---->
	
		<cfset error_message = "Not a downloadable file">
		
	</cfif>
<cfelse><!--- membership not found ---->

	<cfset error_message = "This file is not available">

</cfif>



