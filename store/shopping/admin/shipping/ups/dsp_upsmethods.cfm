<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form to update which ups shipping methods are to be used. Called by shopping.admin&shipping=upsmethods --->

<cfquery name="GetOrigin" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT Origin FROM #Request.DB_Prefix#UPS_Settings
</cfquery>

<cfquery name="UPSMethods" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT ID, Name, Used, Priority, #GetOrigin.Origin#Code AS Code 
FROM #Request.DB_Prefix#UPSMethods
WHERE #GetOrigin.Origin#Code <> '00'
ORDER BY Priority
</cfquery>

<cfprocessingdirective suppresswhitespace="no">
<cfhtmlhead text="
<script language=""JavaScript"">
		function CancelForm () {
		location.href = ""#self#?fuseaction=shopping.admin&shipping=settings&redirect=yes#request.token2#"";
		}
	</script>
">
</cfprocessingdirective>

<cfmodule template="../../../../customtags/format_output_admin.cfm"
	box_title="UPS Shipping Methods"
	Width="450">
	
	<cfoutput>
	<table border="0" cellpadding="0" cellspacing="4" width="100%" class="formtext"	style="color:###Request.GetColors.InputTText#">
	
	<form name="editform" action="#self#?fuseaction=shopping.admin&shipping=upsmethods#request.token2#" method="post">
	<input type="hidden" name="ID_List" value="#ValueList(UPSMethods.ID)#">
	</cfoutput>
	
	<cfinclude template="../../../../includes/form/put_space.cfm">
	
	<tr>
		<th align="left">Shipping Type</th>
		<!--- <th>Code</th> --->
		<th>Used?</th>
		<th>Priority<br/><span class="formtextsmall">(1 is highest, 0 is none)</span></th>
	</tr>	
	
<cfoutput query="UPSMethods">
	<tr>
		<td align="left">UPS #Name#</td>
		<!--- <td align="center">#Code#</td> --->
		<td align="center"><input type="checkbox" name="Used#ID#" value="1" #doChecked(Used)# /></td>
		<td align="center" nowrap="nowrap"><input type="text" name="Priority#ID#" value="#doPriority(UPSMethods.Priority,0,99)#" size="4" maxlength="10" class="formfield"/> </td>
	</tr>
</cfoutput>

	<tr>
		<td colspan="5" align="center"><br/>
		<input type="submit" name="submit_change" value="Update Selections" class="formbutton"/> 
		<input type="button" name="Cancel" value="Back to Settings" onclick=CancelForm(); class="formbutton"/><br/><br/>
		</td>
	</tr>
	
	</form>
	</table>
	
</cfmodule>