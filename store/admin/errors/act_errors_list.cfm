
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Runs the functions for the admin error dumps. Action=1 will download a file, Action=2 will delete files. Called by home.admin&error=list --->

<cfparam name="attributes.Delete" default="">
<cfparam name="filestoremove" default="">

<cfif isdefined ("attributes.Action")>
	<cfswitch expression="#attributes.Action#">
		<!--- 
		view/download a file 
		--->
		<cfcase value="1">
			<cfset theFile = Replace(urldecode(attributes.FID), "cfm", "html")>
			<cfset variables.FileToPush=variables.thisFolder&urldecode(attributes.FID)>			
			<cfif FileExists(variables.FileToPush)>
				<cfheader 
					name="Content-Disposition" 
					value="attachment; filename=#theFile#">
				<cfcontent 
					type="application/unknown" 
					file="#variables.FileToPush#">
			<cfelse>
				<center><h1>Sorry, File Does Not Exist</h1></center>
				<cfabort>
			</cfif>
		</cfcase>
		<!--- 
		delete a file 
		--->
		<cfcase value="2">
			<cfif attributes.Delete IS "Delete Checked" AND isDefined("attributes.filelist")>
				<cfset filestoremove = attributes.filelist>
			<cfelseif attributes.Delete IS "Delete All Errors" AND isDefined("attributes.AllFilesList")>
				<cfset filestoremove = attributes.AllFilesList>
			</cfif>
			
			<cfloop list="#filestoremove#" index="item">
				<cffile 
					action="Delete" 
					file="#variables.thisFolder##urlDecode(item)#">
			</cfloop>

			<cfset innertext = Application.objMenus.getErrorDumps()>
		  	<cfoutput>
			<script type="text/javascript">
				parent.AdminMenu.document.getElementById('errorcount').innerHTML = '#innertext#';
				location.href = '#request.self#?fuseaction=home.admin&error=list#Request.AddToken#';
			</script>
			</cfoutput>
		</cfcase>
	</cfswitch>
</cfif>