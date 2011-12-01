
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Sets up variables for downloads and clears any old download directories created more than a day ago. --->

<cfinclude template="../customtags/deleteDirectory.cfm">

<cfset error_message = "">

<!--- Set top store directory --->
<cfset TopDirectory = GetDirectoryFromPath(ExpandPath("*.*"))>

<cfset downloadDir = TopDirectory & "tempdownloads" & Request.Slash>

<!--- First, try to clear any old directories --->
<cftry>
	<cfdirectory action="LIST" directory="#downloadDir#" name="downloadList"  sort="datelastmodified">
	
	<cfloop query="DownloadList">
		<cfif DownloadList.name is not "." AND DownloadList.name is not ".." AND DownloadList.Type IS "dir">
		
			<!--- If more than 2 hours old, delete the directory --->
			<cfif DateCompare(DownloadList.datelastModified, DateAdd("h", -2, Now()), "h") LT 0>
				<cfset temp = deleteDirectory("#downloadDir##DownloadList.Name#","True")>
			</cfif>
		
		</cfif>
	</cfloop>


<cfcatch type="Any">
</cfcatch>
</cftry>





