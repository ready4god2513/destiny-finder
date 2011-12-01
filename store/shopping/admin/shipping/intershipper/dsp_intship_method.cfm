<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form to add or edit an Intershipper method. Called by shopping.admin&shipping=intship_method --->

<cfquery name="GetMethod" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
SELECT * FROM #Request.DB_Prefix#IntShipTypes
WHERE ID = #attributes.ID#
</cfquery>

<cfmodule template="../../../../customtags/format_admin_form.cfm"
	box_title="Intershipper Shipping Methods"
	width="450"
	>


	<cfoutput>
	<form action="#self#?fuseaction=shopping.admin&shipping=intship_method#request.token2#"  method="post" name="editform">
	<input type="hidden" name="ID" value="#attributes.ID#"/>

	<cfinclude template="../../../../includes/form/put_space.cfm">

		<tr>
			<td align="right" valign="top">Name:</td>
			<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
			<td>
<input type="text" name="Name" size="30" maxlength="50" value="#GetMethod.Name#" class="formfield"/>
			<br/><span class="formtextsmall">Shipping name displayed in the store.</span>
			</td>	
		</tr>
		
		<tr>
			<td align="right" valign="top">Code:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
		<input type="text" name="Code" size="15" maxlength="20" value="#GetMethod.Code#" class="formfield"/>
			<br/><span class="formtextsmall">Must match the Intershipper code.</span>
			</td>
		</tr>
		
		<tr>
			<td align="right" valign="top">Priority:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			<input type="text" name="Priority" value="#doPriority(GetMethod.Priority,0,99)#" size="4" maxlength="10" class="formfield"/>
			<br/><span class="formtextsmall">1 is highest, 0 is none.</span>
			</td>
		</tr>

		<tr>
			<td align="right" valign="top">Used? </td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			<input type="radio" name="Used" value="1" #doChecked(GetMethod.Used)# />Yes 
			&nbsp;<input type="radio" name="Used" value="0" #doChecked(GetMethod.Used,0)# />No
			</td>	
		</tr>
		

		<cfinclude template="../../../../includes/form/put_space.cfm">

		<tr>
			<td colspan="2"></td>
			<td><input type="submit" name="submit_method" value="Save" class="formbutton"/> 
			<input type="submit" name="submit_method" value="Delete" class="formbutton"/> 
			
			<input type="button" value="Cancel" onclick="javascript:window.history.go(-1);" class="formbutton"/>
			</td>	
		</tr>	
	</form>

	<cfprocessingdirective suppresswhitespace="no">
	<script type="text/javascript">
	objForm = new qForm("editform");
	
	objForm.required("Name,Code,Priority,Used");
	
	objForm.Name.description = "description";
	objForm.Code.description = "intershipper code";
	objForm.Priority.validateNumeric();
	
	qFormAPI.errorColor = "###Request.GetColors.formreq#";
	</script>
	</cfprocessingdirective>

</cfoutput>
		
</cfmodule>
