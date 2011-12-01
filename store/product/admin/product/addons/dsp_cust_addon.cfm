
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form to add or edit a custom addon for a product. Called by product.admin&addon=addcust|change --->

<cfparam name="attributes.cid" default="">

<!--- Initialize the values for the form --->
<cfset fieldlist="Prompt,AddonDesc,AddonType,Display,Priority,Price,Weight,ProdMult,Required">	

<cfif attributes.Addon is "addcust">
				
		<cfloop list="#fieldlist#" index="counter">
			<cfset setvariable("attributes.#counter#", "")>
		</cfloop>

		<cfset attributes.Addon_id = 0>	
		<cfset attributes.Required = 0>	
		<cfset action="#self#?fuseaction=Product.admin&Addon=act&mode=i">
		<cfset act_title="Update Product - #qry_get_product.name#">	
		<cfset act_button ="Add Custom Addon">	
		
<cfelse><!--- edit custom--->
		<!--- Set the form fields to values retrieved from the record --->
		<cfloop list="#fieldlist#" index="counter">
			<cfset "attributes.#counter#" = evaluate("qry_get_addon." & counter)>
		</cfloop>
				
		<cfset action="#self#?fuseaction=Product.admin&Addon=act&mode=u">
		<cfset act_title="Update Product - #qry_get_product.name#">	
		<cfset act_button ="Update Custom Addon">	
	
</cfif>


<cfinclude template="put_addons_js.cfm">
	
<cfmodule template="../../../../customtags/format_output_admin.cfm"
	box_title="#act_title#"
	Width="700"
	menutabs="yes">	
	
	<cfinclude template="../dsp_menu.cfm">

	<cfoutput>
	<!--- Table --->
	<table border="0" cellpadding="0" cellspacing="4" width="100%" class="formtext"
	style="color:###Request.GetColors.InputTText#">
	
	<form name="editform" action="#action##request.token2#" method="post" onsubmit="return checkForm(this)">
		<input type="hidden" name="product_id" value="#attributes.product_id#"/>
		<input type="hidden" name="cid" value="#attributes.cid#"/>
		<input type="hidden" name="Addon_ID" value="#attributes.Addon_id#"/>					
			
 <!--- Prompt --->
		<tr>
			<td align="RIGHT">Message to display:</td>
			<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
		 	<td><input type="text" name="Prompt" value="#HTMLEditFormat(attributes.Prompt)#" size="30" class="formfield" maxlength="100"/>
			<input type="hidden" name="Prompt_required" value="The message for the Addon is required!"/>
			</td>
			</tr>
			
			
 <!--- Description --->
		<tr>
			<td align="RIGHT">Description in Cart:</td>
			<td></td>
		 	<td>
			<input type="text" name="AddonDesc"  value="#HTMLEditFormat(attributes.AddonDesc)#" size="30" maxlength="100" class="formfield"/>
			</td>
			</tr>	
			
 <!--- Addon Type --->
		<tr>
			<td align="RIGHT">Addon Type:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
		 	<td>
			<select name="AddonType" size="1" class="formfield">
			<option value="textbox" #doSelected(attributes.AddonType,'textbox')#>textbox</option>
			<option value="checkbox" #doSelected(attributes.AddonType,'checkbox')#>checkbox</option>
			<option value="quantity" #doSelected(attributes.AddonType,'quantity')#>quantity box</option>
			<option value="textfield" #doSelected(attributes.AddonType,'textfield')#>textfield</option>
			<option value="calendar" #doSelected(attributes.AddonType,'calendar')#>calendar</option>
			</select>
			</td>
			</tr>	

<!--- priority --->
		<tr>
			<td align="RIGHT">Priority:</td>
			<td></td>
			<td><input type="text" name="Priority" value="#doPriority(attributes.Priority,0)#" size="4" maxlength="10" class="formfield"/><span class="formtextsmall"> (1 is highest, 0 is none)</span>
			</td></tr>		
			
 <!--- Price --->
		<tr>
			<td align="RIGHT">Amount added to price:</td>
			<td></td>
		 	<td>
			<input type="text" name="Price"  value="#attributes.Price#" size="12" class="formfield"/>
			<input type="hidden" name="Price_float" value="The Addon price must be a number!"/>
			</td>
			</tr>	
			
 <!--- Weight --->
		<tr>
			<td align="RIGHT">Amount added to weight:</td>
			<td></td>
		 	<td>
			<input type="text" name="Weight"  value="#attributes.Weight#" size="12" class="formfield"/>
			<input type="hidden" name="Weight_float" value="The Addon weight must be a number!"/>
			</td>
			</tr>	
			
			
 <!--- Product Multiplier --->
		<tr>
			<td align="RIGHT">Product quantity multiplies <br/>price and weight:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
		 	<td>
			<input type="radio" name="ProdMult" value="1" #doChecked(attributes.ProdMult)# /> Yes &nbsp; 
			<input type="radio" name="ProdMult" value="0" #doChecked(attributes.ProdMult,0)# /> No
			</td>
			</tr>	
		<tr>
			<td align="RIGHT">Required?</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
		 	<td>
			<input type="radio" name="Required" value="1" #doChecked(attributes.Required)# /> Yes &nbsp; 
			<input type="radio" name="Required" value="0" #doChecked(attributes.Required,0)# /> No
			</td>
			</tr>			
 <!--- display --->
		<tr>
			<td align="RIGHT">Display in store?</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
		 	<td>
			<input type="radio" name="Display" value="1" #doChecked(attributes.Display)# /> Yes &nbsp; 
			<input type="radio" name="Display" value="0" #doChecked(attributes.Display,0)# /> No
			</td>
			</tr>
			

		<tr>
			<td colspan="2">&nbsp;</td>
			<td><br/>
			<input type="submit" name="submit" value="#act_button#" class="formbutton"/>
			<input type="button" value="Cancel" onclick="CancelForm();" class="formbutton"/>
			</td>
		</tr>
		</form>	

		<cfinclude template="../../../../includes/form/put_requiredfields.cfm">
	
	</table> 
	</cfoutput>
	
</cfmodule>

