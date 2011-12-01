
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the list of current state tax rates, with links to edit or delete and a form to add a new rate. Called by shopping.admin&taxes=state --->

<!---- Get all state taxes ---->		
<cfinclude template="qry_statetax.cfm">
<!--- Get the Tax Code Info --->
<cfinclude template="qry_codes.cfm">

<cfif isdefined("attributes.edit")>

	<cfquery name="getRate" dbtype="query">
		SELECT * FROM GetTaxes
		WHERE Tax_ID = #attributes.edit#
	</cfquery>

	<cfloop list="state,taxrate,taxship,tax_id" index="counter">
		<cfset "attributes.#counter#" = evaluate("getRate." & counter)>
	</cfloop>
	
	<cfset attributes.taxrate = attributes.TaxRate * 100>
	
	<cfset formbutton = "Update">
	
<cfelse><!--- add --->

	<cfset attributes.state = "">
	<cfset attributes.taxrate = 0>
	<cfset attributes.taxship = 0>
	<cfset attributes.Tax_ID = 0>
	<cfset formbutton = "Add Rate">
	
</cfif>



<cfset taxedstates = valuelist(gettaxes.state)>

<cfinclude template="../../../queries/qry_getstates.cfm">


<cfprocessingdirective suppresswhitespace="no">
<cfhtmlhead text="
<script language=""JavaScript"">

		function CancelForm () {
		location.href = '#self#?fuseaction=shopping.admin&taxes=codes&redirect=yes#request.token2#';
		}
	
	</script>
">
</cfprocessingdirective>

<cfmodule template="../../../customtags/format_output_admin.cfm"
	box_title="Tax Rates - #GetCodes.CodeName#"
	Width="550"
	menutabs="yes">
	
	<cfinclude template="dsp_menu.cfm">
	
<cfoutput>
	<table border="0" cellpadding="0" cellspacing="4" width="100%" class="formtext"	style="color:###Request.GetColors.InputTText#">

	
<!--- Add form ---->

	<form name="editform" action="#self#?fuseaction=shopping.admin&taxes=state#request.token2#" method="post">
	<input type="hidden" name="Tax_ID" value="#attributes.Tax_ID#"/>
	<input type="hidden" name="Code_ID" value="#attributes.Code_ID#"/>
	
		<tr>
			<td align="RIGHT" width="30%">State:</td>
			<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
			<td width="70%"><select name="State" size="1" class="formfield">
				<cfloop query="GetStates">
				<!--- Only show if does not already have a rate set, or is being edited --->
				<cfif isdefined("attributes.edit") OR listcontains(taxedstates,abb) is 0>
  				<option value="#Abb#" #doSelected(attributes.State,GetStates.Abb)#>#Name# (#Abb#)</option>
				</cfif>
				</cfloop>
				</select></td>	
		</tr>

		<tr>
			<td align="RIGHT">Tax Rate:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			<input type="text" name="TaxRate" value="#attributes.TaxRate#" size="5" class="formfield" onfocus="this.value= '';" />%
			</td>	
		</tr>
		
		<tr>
			<td align="RIGHT">Tax Shipping?:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td><input type="radio" name="TaxShip" value="1" #doChecked(attributes.TaxShip)# /> Yes 
			&nbsp;&nbsp;<input type="radio" name="TaxShip" value="0" #doChecked(attributes.TaxShip,0)# /> No
			</td>	
		</tr>	
		
		<cfinclude template="../../../includes/form/put_space.cfm">
		
		<tr>
			<td colspan="2"></td>
			<td><input type="submit" name="Submit_rate" value="#formbutton#" class="formbutton"/> 
			<input type="button" name="Cancel" value="Cancel" onclick="CancelForm();" class="formbutton"/>
			</td>	
		</tr>	
		
		<cfinclude template="../../../includes/form/put_requiredfields.cfm">
		</form>
		
	<cfprocessingdirective suppresswhitespace="no">
	<script type="text/javascript">

	objForm = new qForm("editform");
	
	objForm.required("State,TaxRate,TaxShip");
	
	objForm.TaxRate.validateNumeric();
	objForm.TaxRate.validateRange(0,99);
	
	objForm.TaxRate.description = "tax rate";
	
	qFormAPI.errorColor = "###Request.GetColors.formreq#";
	
	</script>
	</cfprocessingdirective>

</cfoutput>
	</table>
	

<cfif GetTaxes.RecordCount>	
	<cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#" width="98%"/>
	
	<table border="0" cellpadding="0" cellspacing="4" width="95%" class="formtext" align="center"
	style="color:#<cfoutput>#Request.GetColors.InputTText#</cfoutput>">
		<tr>
			<th>State</th>
			<th>Tax Rate</th>
			<th>Tax Shipping</th>
			<th>&nbsp;</th>
		</tr>
	
		<cfoutput query="GetTaxes">
		<tr>
			<td align="center">#State#</td>
			<td align="center">#(TaxRate*100)#%</td>
			<td align="center">#YesNoFormat(TaxShip)#</td>
			<td width="20%">[<a href="#self#?fuseaction=shopping.admin&taxes=state&edit=#Tax_ID#&code_id=#attributes.code_id##Request.Token2#">edit</a>] [<a href="#self#?fuseaction=shopping.admin&taxes=state&delete=#Tax_ID#&code_id=#attributes.code_id##Request.Token2#">delete</a>]</td>
		</tr>
		</cfoutput>
	</table>
<cfelse>

	<cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#" width="98%"/>
	<p align="center" class="formtext">No States Rates Entered<p>
</cfif>	

<cfoutput>
	<table border="0" cellpadding="0" cellspacing="4" width="95%" class="formtext" align="center"
	style="color:###Request.GetColors.InputTText#">
		<form name="editform" action="#self#?fuseaction=shopping.admin&taxes=codes#request.token2#" method="post">
		<tr><td align="center">
		<input type="submit" value="Back to Tax Codes" class="formbutton"/>
		</td></tr>
		</form>
	</table>
</cfoutput>


</cfmodule>
