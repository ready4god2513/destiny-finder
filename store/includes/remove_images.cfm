<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->
		
<!---- This template offers to remove the photos associated with a product, feature, or page record. 	
--->

<!--- Display offer first --->
<cfif not isdefined("attributes.remove_images")>

	<cfparam name="attributes.xfa_success" default="fuseaction=home.admin&img=remove">
	<cfparam name="attributes.image_list" default="">

	<cfmodule template="../customtags/format_admin_form.cfm"
		box_title="Delete Images"
		width="450"
		required_fields= "0"
		>
		<tr><td>
		
		<br/>
		<div class="formtitle" align="center">Delete the following images?</div>
		
		<cfoutput>
		<form action="#XHTMLFormat('#self#?fuseaction=home.admin&img=remove#request.token2#')#" method="post">
		<input type="hidden" name="xfa_success" value="#attributes.xfa_success#"/>		
		<table class="formtext">
		<cfloop list="#attributes.image_list#" index="i">
			<tr>
				<td><input type="checkbox" name="remove_file" value="#i#"/></td>
				<td>#i#</td>
			</tr>			<tr>
				<td></td>
				<td><img src="#request.appsettings.defaultimages#/#i#" alt="" /><br/><br/></td>
			</tr>
		</cfloop>
		</cfoutput>
		</table>	
	
		<div align="center">
		<input class="formbutton" type="submit" name="remove_images" value="Delete Selected"/></div>
		</form>	
		</td></tr>
	</cfmodule> 

	
<!--- If Submitted to self, delete images and forward --->
<cfelse>


	<cfif isdefined("attributes.remove_file") and len(attributes.remove_file)>
		<cfloop list="#attributes.remove_file#" index="i">
		
			<cfset topPath = GetDirectoryFromPath(ExpandPath("*.*"))>
			<cfset theFile= "#toppath##request.appsettings.defaultimages##request.slash##i#">
			<!--- debug
			<cfoutput><h1>#theFile#</h1></cfoutput> --->
			<!---  Make sure file path is correct for the server --->
			<cfset theFile = ReReplace(theFile, "[\\\/]", Request.slash, "ALL")>
		
			<cfif FileExists('#theFile#')>
				<cffile action="DELETE" File="#theFile#">
			</cfif>
			
		</cfloop>	
	</cfif>

	<!--- debug
	<cfoutput>#attributes.xfa_success#</cfoutput> --->
	
	<cflocation url="#request.self#?#attributes.xfa_success##request.token2#" addtoken="No">
	
</cfif>
