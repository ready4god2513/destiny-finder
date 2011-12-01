
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to display the list of errors. Called by home.admin&error=list --->

<cfset AllFiles = "">

<cfmodule template="../../customtags/format_output_admin.cfm"
	box_title="Error Template List"
	width="550"
	>

<cfoutput>
<table width="100%" cellspacing="4" border="0" cellpadding="0" class="formtext" style="color: ###Request.GetColors.OutputTText#;">	
</cfoutput>

<cfif variables.FileCount IS 0>
<tr><td colspan="5" align="center"><br/>No current errors found</td></tr>

<cfelse>
<cfoutput><tr><td colspan="5" align="center"><br/><b>#variables.FileCount# error<cfif variables.FileCount IS NOT 1>s</cfif> found</b><br/>&nbsp;</td></tr></cfoutput>

<tr>
	<td align="center" nowrap="nowrap"><p>Name</p></td>
	<td align="center" nowrap="nowrap"><p>Size</p></td>
	<td align="center" nowrap="nowrap"><p>Date</p></td>
	<td nowrap="nowrap"><p>&nbsp;</p></td>
	<td align="center" nowrap="nowrap"><p><img src="images/icons/grid_delete.gif" width="11" height="15" alt="Delete" border="0" /></p></td>
</tr>
<cfoutput><form action="#self#?fuseaction=home.admin&error=list&Action=2#Request.Token2#" method="post"></cfoutput>
<tr><td colspan="5"><hr noshade="noshade" /></td></tr>
<cfoutput 
	query="error_list">
	<cfif Compare(error_list.Name,"..") and 
		  Compare(error_list.Name,".") and 
		  CompareNoCase(error_list.Name,"act_num_errors.cfm") and 
		  not CompareNoCase(error_list.Type,"file")>
		<tr>
			<td nowrap="nowrap"><b><a href="#self#?fuseaction=home.admin&error=display&ID=#Replace(error_list.Name, ".cfm", "")##Request.Token2#" target="error">#error_list.Name#</a></b></td>
			<td align="center" nowrap="nowrap" width="30">#error_list.Size#</p></td>
			<td align="center" nowrap="nowrap">#LSDateFormat(error_list.DateLastModified, "mm/dd/yy")# #TimeFormat(error_list.DateLastModified, "HH:mm:ss")#</td>
			<td class="Tiny" nowrap="nowrap" align="right">
			<img src="images/icons/spacer.gif" width="10" height="14" alt="" border="0" />
			<a href="#self#?fuseaction=home.admin&error=list&FID=#URLEncodedFormat(error_list.Name)#&Action=1#Request.Token2#"><img src="images/icons/grid_save.gif" width="14" height="14" alt="Download" border="0" /></a>
			<img src="images/icons/spacer.gif" width="10" height="14" alt="" border="0" />
			</td>
			<td align="center" nowrap="nowrap"><p><input type="checkbox" name="filelist" value="#URLEncodedFormat(error_list.Name)#" class="formfield"/></p></td>
			<cfset AllFiles = ListAppend(AllFiles,URLEncodedFormat(error_list.Name))>
	   	</tr>
	</cfif>
</cfoutput>
</cfif>
<tr>
	<td colspan="5" nowrap="nowrap" class="Tiny">
	<hr noshade="noshade" />
	</td></tr>
<tr><tr><td colspan="1" nowrap="nowrap" class="Tiny">
	<blockquote>
	<img src="images/icons/grid_save.gif" width="14" height="14" alt="Download" border="0" /> = Save to local disk<br/>
	<img src="images/icons/grid_delete.gif" width="11" height="15" alt="Delete" border="0" /> = Delete file (<strong>no confirmation!</strong>)
</blockquote>	
</td>
	<td align="right" valign="top" colspan="4">
	<input type="submit" name="Delete" value="Delete All Errors" class="formbutton"  onclick="return confirm('Are you sure you want to delete all the errors? This action cannot be reversed.');"/>
	<input type="submit" name="Delete" class="formbutton" value="Delete Checked" onclick="return confirm('Are you sure you want to delete the checked errors? This action cannot be reversed.');"/> </td>
	
</tr>

<cfoutput><input type="hidden" name="AllFilesList" value="#AllFiles#"></cfoutput>
</form>
</table>


</cfmodule>