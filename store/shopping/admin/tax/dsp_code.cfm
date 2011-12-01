<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form to add or edit a tax code. Called by shopping.admin&taxes=editcode --->

<cfinclude template="qry_codes.cfm">

<cfmodule template="../../../customtags/format_admin_form.cfm"
	box_title="Tax Codes"
	width="550"
	>

<cfoutput>
	<form name="editform" action="#self#?fuseaction=shopping.admin&taxes=editcode#request.token2#"  method="post">
	<input type="hidden" name="Code_ID" value="#attributes.Code_ID#"/>

	<cfinclude template="../../../includes/form/put_space.cfm">	
	
		<tr>
			<td align="right" valign="top">Code Name:</td>
			<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
			<td>
			<input type="text" name="CodeName" size="30" maxlength="50" value="#GetCodes.CodeName#" class="formfield"/>
			</td>	
		</tr>
		
		<tr>
			<td align="right" valign="top">Display Name:</td>
			<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
			<td>
			<input type="text" name="DisplayName" size="30" maxlength="50" value="#GetCodes.DisplayName#" class="formfield"/>
			</td>	
		</tr>
		<tr><td colspan="2"></td>
		<td><span class="formtextsmall">Description of the tax as displayed in the store. Taxes with the same display name will be shown as the same line item for the customer during checkout.</span><br/>
			</td>	
		</tr>	
		
		<tr>
			<td align="right" valign="top" nowrap="nowrap">Tax All Users? </td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			<input type="radio" name="TaxAll" value="1" #doChecked(GetCodes.TaxAll)# />Yes 
			&nbsp;<input type="radio" name="TaxAll" value="0" #doChecked(GetCodes.TaxAll,0)# />No</td>	
		</tr>	
		<tr><td colspan="2"></td>
		<td><span class="formtextsmall">Will this tax apply to all users regardless of location? If turned on, 
		be sure to set the tax amount and shipping as well.<br/>
			If turned off, you will need to set the tax amount(s) by location under 'Rates'</span><br/>
			</td>	
		</tr>	
		
		<tr>
			<td align="right" valign="top" nowrap="nowrap">Show on Products? </td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			<input type="radio" name="ShowonProds" value="1" #doChecked(GetCodes.ShowonProds)# />Yes 
			&nbsp;<input type="radio" name="ShowonProds" value="0" #doChecked(GetCodes.ShowonProds,0)# />No</td>	
		</tr>	
		<tr><td colspan="2"></td>
		<td><span class="formtextsmall">If turned on, this will display the product prices with the tax included and excluded. Typically used for VAT taxes. Product prices should be entered without the VAT amount included.</span><br/>
			</td>	
		</tr>	
			
		<tr>
			<td align="right" valign="top" nowrap="nowrap">Tax Amount:</td>
			<td></td>
			<td>
			<input type="text" name="TaxRate" value="#iif(GetCodes.TaxRate GT 0,Evaluate(DE('GetCodes.TaxRate*100')),DE(''))#" size="4" maxlength="10" class="formfield"/>%</td>	
		</tr>	
		<tr><td colspan="2"></td>
		<td><span class="formtextsmall">The percent tax collected for "All Users" and/or amount used for the product prices.</span><br/>
			</td>
		</tr>
		
		<tr>
			<td align="right" valign="top" nowrap="nowrap">Tax Shipping? </td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			<input type="radio" name="TaxShipping" value="1" #doChecked(GetCodes.TaxShipping)# />Yes 
			&nbsp;<input type="radio" name="TaxShipping" value="0" #doChecked(GetCodes.TaxShipping,0)# />No</td>	
		</tr>	
		<tr><td colspan="2"></td>
		<td><span class="formtextsmall">Include the shipping cost when calculating tax for "All Users" or when displaying estimated product tax in the shopping cart.</span><br/>
			</td>	
		</tr>	
		
		<tr>
			<td align="right" valign="top" nowrap="nowrap">Address used for Tax:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			<select name="TaxAddress" size="1" class="formfield">
				<option value="Billing" #doSelected(GetCodes.TaxAddress,"Billing")#>Billing Address</option>
				<option value="Shipping" #doSelected(GetCodes.TaxAddress,"Shipping")#>Shipping Address</option>
			</select></td>	
		</tr>	
		<tr><td colspan="2"></td>
		<td><span class="formtextsmall">If not taxing all users, which address is used?</span><br/>
			</td>	
		</tr>
		
		<tr>
			<td align="right" valign="top" nowrap="nowrap">Order for Calculation:</td>
			<td></td>
			<td>
			<input type="text" name="CalcOrder" value="#GetCodes.CalcOrder#" size="4" maxlength="10" class="formfield"/></td>	
		</tr>	
		<tr><td colspan="2"></td>
		<td><span class="formtextsmall">This is used to determine the order of calculation when using multiple tax codes. Generally this is only important when there are cumulative taxes or if you have multiple VAT taxes, to set the default one for the shopping cart.</span><br/>
			</td>
		</tr>

		
		<tr>
			<td align="right" valign="top" nowrap="nowrap">Cumulative? </td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			<input type="radio" name="Cumulative" value="1" #doChecked(GetCodes.Cumulative)# />Yes 
			&nbsp;<input type="radio" name="Cumulative" value="0" #doChecked(GetCodes.Cumulative,0)# />No</td>	
		</tr>	
		<tr><td colspan="2"></td>
		<td><span class="formtextsmall">Detemines if taxes calculated earlier in the order are included when calculating this tax.</span><br/>
			</td>	
		</tr>

	</cfoutput>

		<cfinclude template="../../../includes/form/put_space.cfm">
			
		<tr>
			<td colspan="2"></td>
			<td><input type="submit" name="submit_code" value="Save" class="formbutton"/> 
			<input type="submit" name="submit_code" value="Delete" class="formbutton" onclick="return confirm('Are you sure you want to delete this tax code? All associated rates will be deleted as well.');"/> 
			
			<input type="button" value="Cancel" onclick="javascript:window.history.go(-1);" class="formbutton"/>
			</td>	
		</tr>	

	</form>
		
</cfmodule>

<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
objForm = new qForm("editform");

objForm.required("CodeName,TaxAll,ShowonProds,TaxAddress,TaxShipping,Cumulative");

objForm.CodeName.description = "code name";
objForm.TaxAddress.description = "address to tax";
objForm.TaxRate.description = "tax rate";
objForm.CalcOrder.description = "calculation order";

objForm.TaxRate.validateNumeric();
objForm.TaxRate.validateRange(0,99);

objForm.CalcOrder.validateNumeric();
objForm.CalcOrder.validateRange(0,99);

objForm.TaxRate.createDependencyTo("TaxAll", "1");
objForm.TaxAll.enforceDependency();

objForm.TaxRate.createDependencyTo("ShowonProds", "1");
objForm.ShowonProds.enforceDependency();

qFormAPI.errorColor = "<cfoutput>###Request.GetColors.formreq#</cfoutput>";
</script>
</cfprocessingdirective>

