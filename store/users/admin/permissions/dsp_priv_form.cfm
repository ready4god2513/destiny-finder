<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the list of available permissions for the selected type, called from act_set_permissions.cfm --->

<cfhtmlhead text="
	<script type='text/javascript' src='includes/mxAjax/core/js/prototype.js'></script>
	<script type='text/javascript' src='includes/mxAjax/core/js/mxAjax.js'></script>
	<script type='text/javascript' src='includes/mxAjax/core/js/mxMultiSelect.js'></script>
	<link rel='stylesheet' type='text/css' href='css/ricostyles.css'/>
	">
<cfoutput>
<form action="#self#?#cgi.query_string#" method="post" name="permissions">
</cfoutput>
<cfmodule template="../../../customtags/format_admin_form.cfm"
	box_title="#attributes.type# Permissions"
	width="500"
	required_fields="0"
	>
<!--- Get list of keys --->
<cfinclude template="../../../access/admin/accesskey/qry_get_accesskeys.cfm">
			
<cfoutput>	
<input type="hidden" name="type" value="#attributes.type#"/>
<input type="hidden" name="ID" value="#attributes.ID#"/>
<tr><td colspan="2" align="center"><b>#qry_get_type.typename# Permissions</b></td></tr>

<tr><td>
<strong>ACCESS KEYS</strong>
<cfoutput>
	<div id="contentkey_listControl" class="multiSelectControl"></div>
	<select name="contentkey_list" id="contentkey_list" size="8" multiple="multiple">
	<cfset attributes.circuit = "contentkey_list">
	<cfinclude template="act_get_keyvalue.cfm">
	<cfloop query="qry_get_accesskeys">
	<option value="#accesskey_ID#" #doSelected(listContainsNoCase(keyvalue, accesskey_id))#> #name#</option>
	</cfloop>
	</select>
	<script type="text/javascript">
		contentkey_listObj = new mxAjax.MultiSelect({
			executeOnLoad: true,
			target: "contentkey_list",
			cssClass: "multiSelect"
		});
	</script>
</cfoutput>

</td>

<cfloop query="qry_get_groups">
	<cfif qry_get_groups.currentrow MOD 2 IS 0><tr></cfif>
	<td>
	<cfset attributes.circuit = qry_get_groups.Name>
	<cfinclude template="act_get_keyvalue.cfm">
	<cfinclude template="qry_get_permission_list.cfm">
	<cfinclude template="dsp_select_permissions.cfm">
	</td>
	<cfif qry_get_groups.currentrow MOD 2 IS 1></tr></cfif>
</cfloop>

<cfif qry_get_groups.recordcount MOD 2 IS 0><td>&nbsp;</td></cfif>
		
<tr><td colspan="2" align="center">
<!--- check if a registration key exists in the permission list --->
		<cfset attributes.circuit = "registration">
		<cfinclude template="act_get_keyvalue.cfm">
		<input type="hidden" name="registration_key" value="#keyvalue#"/>	
		<input type="hidden" name="submit_key" value="Update Permissions"/>
		<!--- If admin group, and in demo mode, do not allow permissions to be changed --->
		<cfif Request.DemoMode AND attributes.type IS "Group" AND attributes.ID IS 1>
		<input type="button" value="Set Permissions" onclick="javascript:alert('The admin group cannot be modified while in demo mode.');" class="formbutton"/>
		<cfelse>		
		<input type="submit" value="Set Permissions" class="formbutton"/>
		</cfif>
		<input type="button" value="Cancel" onclick="javascript:window.history.go(-1);" class="formbutton"/> 	
</td></tr>

</cfoutput>
</cfmodule>
</form>

<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
	<!--- objForm = new qForm("permissions");

	<cfoutput query="qry_get_groups">
		<cfset attributes.circuit = qry_get_groups.name>
		<cfinclude template="act_get_keyvalue.cfm">
		objForm.#name#.setBits('#keyvalue#', 'true');
	</cfoutput> --->
	
	qFormAPI.errorColor = "###Request.GetColors.formreq#";
	
<!--- 	function submitForm() {
		<cfoutput query="qry_get_groups">
			objForm.#name#_bits.setValue(objForm.#name#.getBits());
		</cfoutput>
		objForm.submit();
	
	} --->
	</script>
</cfprocessingdirective>

