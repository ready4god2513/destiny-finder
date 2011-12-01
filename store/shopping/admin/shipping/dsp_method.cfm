<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form to add or edit a shipping method. Called by shopping.admin&shipping=method --->

<cfquery name="GetMethod" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
SELECT * FROM #Request.DB_Prefix#CustomMethods
WHERE ID = #attributes.ID#
</cfquery>

<cfmodule template="../../../customtags/format_admin_form.cfm"
	box_title="Shipping Methods"
	width="500"
	>

<cfoutput>
	<form name="editform" action="#self#?fuseaction=shopping.admin&shipping=methods#request.token2#"  method="post">
	<input type="hidden" name="ID" value="#attributes.ID#"/>

	<cfinclude template="../../../includes/form/put_space.cfm">	
	
		<tr>
			<td align="right" valign="top">Description:</td>
			<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
			<td>
			<input type="text" name="name" size="30" maxlength="50" value="#GetMethod.Name#" class="formfield"/>
			<br/><span class="formtextsmall">Method as displayed in the store.</span>
			</td>	
		</tr>
		
		<tr>
			<td align="right" valign="top">Method Cost:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			<input type="text" name="amount" size="5" maxlength="10"  value="#GetMethod.Amount#" class="formfield"/> #Request.AppSettings.MoneyUnit#
			<br/><span class="formtextsmall">Cost added to (or multiplied by) the base shipping cost.</span>
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
			<td align="right" valign="top">Domestic? </td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			<input type="radio" name="Domestic" value="1" #doChecked(GetMethod.Domestic)# />Yes 
			&nbsp;<input type="radio" name="Domestic" value="0" #doChecked(GetMethod.Domestic,0)# />No
			<br/><span class="formtextsmall">Offered to domestic customers</span>
			</td>	
		</tr>
		
		<tr>
			<td align="right" valign="top">International? </td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			<input type="radio" name="International" value="1" #doChecked(GetMethod.International)# />Yes 
			&nbsp;<input type="radio" name="International" value="0" #doChecked(GetMethod.International,0)# />No
			<br/><span class="formtextsmall">Offered to international customers</span>
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

	</cfoutput>

		<cfinclude template="../../../includes/form/put_space.cfm">
			
		<tr>
			<td colspan="2"></td>
			<td><input type="submit" name="submit_method" value="Save" class="formbutton"/> 
			<input type="submit" name="submit_method" value="Delete" class="formbutton"  onclick="return confirm('Are you sure you want to delete this method?');"/> 
			
			<input type="button" value="Cancel" onclick="javascript:window.history.go(-1);" class="formbutton"/>
			</td>	
		</tr>	
	</form>
		
</cfmodule>

<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
objForm = new qForm("editform");

objForm.required("name,amount,Priority,Domestic,International,Used");

objForm.name.description = "description";

objForm.amount.validateNumeric();
objForm.Priority.validateNumeric();

qFormAPI.errorColor = "<cfoutput>###Request.GetColors.formreq#</cfoutput>";
</script>
</cfprocessingdirective>

