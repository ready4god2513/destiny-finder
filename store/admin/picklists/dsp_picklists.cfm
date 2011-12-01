<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form for updating the picklists. Called by home.admin&picklists=edit --->

	<cfmodule template="../../customtags/format_admin_form.cfm"
		box_title="Pick Lists"
		width="450"
		>

	<cfoutput>
	<form action="#self#?#cgi.query_string#" method="post">
	<input type="hidden" name="picklist_id" value="#qry_GetPicklists.picklist_id#"/>
	</cfoutput>
	<!--- Header --->
		<tr valign="top">
			<td colspan = 3><span class="largeformtext">These Pick Lists appear as options in pull-down selections lists in forms throughout the site. Please enter the list of options as a comma separated list. Do not enter a spaces after a comma as the space will appear in the pull-down list.</span><br/><br/>
			</td></tr>

	<cfloop list="#fieldlist#" index="counter">
		
		<cfoutput><tr valign="top">
			<td align="right"><nobr>#replace(counter,"_"," ")#:</nobr></td>
			<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
			<td><textarea cols="45" rows="4" name="#counter#" class="formfield">#evaluate("qry_GetPicklists." & counter)#</textarea></td></tr></cfoutput>
		
	</cfloop>

	<!----SUMBIT ---->
		<tr>
			<td>&nbsp;</td><td></td>
			<td>			
				<input type="submit" name="savelists" value="Save Changes" class="formbutton"/> 			<input type="button" value="Cancel" onclick="javascript:window.history.go(-1);" class="formbutton"/>
			</td></tr>
			</form>
</cfmodule>

