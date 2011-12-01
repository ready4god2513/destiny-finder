
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the list of current county tax rates, with links to edit or delete and a form to add a new rate. Called by shopping.admin&taxes=county --->

<!---- Get all counties ---->		
<cfinclude template="qry_countytax.cfm">
<!--- Get the Tax Code Info --->
<cfinclude template="qry_codes.cfm">

<cfinclude template="../../../queries/qry_getstates.cfm">

<cfif isdefined("attributes.edit")>
	<cfquery name="getRate" dbtype="query">
		SELECT * FROM GetCounties
		WHERE County_ID = #attributes.edit#
	</cfquery>

	<cfloop list="name,state,taxrate,taxship,county_id" index="counter">
		<cfset "attributes.#counter#" = evaluate("getrate." & counter)>
	</cfloop>
	
	<cfset attributes.taxrate = attributes.taxrate * 100>
	
	<cfset formbutton = "Update">
	
<cfelse><!--- add --->

	<cfset attributes.name = "">
	<cfset attributes.state = "">
	<cfset attributes.taxrate = 0>
	<cfset attributes.taxship = 0>
	<cfset attributes.County_ID = 0>
	<cfset formbutton = "Add Rate">
	
</cfif>

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

	<cfif isdefined("error_message")>
	<tr><td colspan="3" class="formerror" align="center">#error_message#<br/><br/></td></tr>
	</cfif>
<!--- Add form ---->

	<form name="editform" action="#self#?fuseaction=shopping.admin&taxes=county#request.token2#" method="post">
	<input type="hidden" name="County_ID" value="#attributes.County_ID#"/>
	<input type="hidden" name="Code_ID" value="#attributes.Code_ID#"/>
	
		<tr>
			<td align="RIGHT" width="30%">State:</td>
			<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
			<td width="70%"><select name="State" size="1" class="formfield">
				<cfloop query="GetStates">
  				<option value="#Abb#" #doSelected(attributes.State,GetStates.Abb)#>#Name# (#Abb#)</option>
				</cfloop>
				</select></td>	
		</tr>
		
		<tr>
			<td align="RIGHT">County:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			<input type="text" name="Name" value="#attributes.Name#" size="30" maxlength="50" class="formfield"/>
			</td>	
		</tr>

		<tr>
			<td align="RIGHT">Tax Rate:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			<input type="text" name="TaxRate" value="#attributes.TaxRate#" size="5" maxlength="12" class="formfield" onfocus="this.value= '';"/>%
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
	
	objForm.required("State,Name,TaxRate,TaxShip");
	
	objForm.TaxRate.validateNumeric();
	objForm.TaxRate.validateRange(0,99);
	
	objForm.Name.description = "county name";
	objForm.TaxRate.description = "tax rate";
	
	qFormAPI.errorColor = "###Request.GetColors.formreq#";
	
	</script>
	</cfprocessingdirective>

</cfoutput>
	</table>
	
	
	
<cfif GetCounties.RecordCount>	
	<cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#" width="98%"/>
	
	<table border="0" cellpadding="0" cellspacing="4" width="95%" class="formtext" align="center"
	style="color:#<cfoutput>#Request.GetColors.InputTText#</cfoutput>">
		<tr>
			<th>State</th>
			<th>County</th>
			<th>Tax Rate</th>
			<th>Tax Shipping</th>
			<th>&nbsp;</th>
		</tr>
	
		<cfoutput query="GetCounties">
		<tr>
			<td align="center">#State#</td>
			<td align="center">#Name#</td>
			<td align="center">#(TaxRate*100)#%</td>
			<td align="center">#YesNoFormat(TaxShip)#</td>
			<td width="20%">[<a href="#self#?fuseaction=shopping.admin&taxes=county&edit=#County_ID#&code_id=#attributes.code_id##Request.Token2#">edit</a>] [<a href="#self#?fuseaction=shopping.admin&taxes=county&delete=#County_ID#&code_id=#attributes.code_id##Request.Token2#">delete</a>]</td>
		</tr>
		</cfoutput>
	</table>
<cfelse>

	<cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#" width="98%"/>
	<p align="center" class="formtext">No Tax Rates Entered<p> 
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
