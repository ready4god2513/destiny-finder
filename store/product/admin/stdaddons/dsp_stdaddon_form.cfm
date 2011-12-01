
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form for adding or editing a standard addon. Called by product.admin&stdaddon=add|edit --->

<!--- Initialize the values for the form --->
<cfset fieldlist="Std_Name,std_prompt,Std_Desc,std_type,std_display,std_price,std_weight,std_prodmult,std_required">	
		
<cfswitch expression="#stdaddon#">
			
	<cfcase value="add">
		<cfloop list="#fieldlist#" index="counter">
			<cfset setvariable("attributes.#counter#", "")>
		</cfloop>
		<cfset attributes.Std_ID = 0>
		<cfset attributes.std_required = 0>
		
		<cfset action="#self#?fuseaction=product.admin&stdaddon=act&mode=i">
	    <cfset act_title="New Standard Addon">
		<cfset act_button="Create Addon">	
	</cfcase>
					
	<cfcase value="edit">
		<!--- Set the form fields to values retrieved from the record --->					
		<cfloop list="#fieldlist#" index="counter">
			<cfset "attributes.#counter#" = evaluate("qry_get_stdaddon." & counter)>
		</cfloop>
				
		<cfset action="#self#?fuseaction=product.admin&Stdaddon=act&mode=u">
		<cfset act_title="Update Standard Addon">
		<cfset act_button="Update Addon">	
				
	</cfcase>
</cfswitch>

<cfif isdefined("attributes.product_id")>
	<cfset action="#action#&product_id=#attributes.product_id#">
</cfif>
<cfif isdefined("attributes.cid")>
	<cfset action="#action#&cid=#attributes.cid#">
</cfif>	
	
<!--- CF Form Checking work around ------->
<cfset attributes.required = attributes.std_required>

<cfinclude template="put_stdaddons_js.cfm">

<cfmodule template="../../../customtags/format_admin_form.cfm"
	box_title="#act_title#"
	width="550"
	>
	
	<!--- Table --->
	<cfoutput>
	<form name="StdOptions" action="#action##request.token2#" method="post" onsubmit="return checkForm(this)">
		<input type="hidden" name="Std_ID" value="#attributes.std_id#"/>

<cfif NOT len(attributes.std_prompt)>
	<cfset attributes.Std_Prompt = "Choose One:">
</cfif>

 <!--- Name --->
		<tr>
			<td align="RIGHT">Name for this Addon:</td>
			<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
		 	<td>
			<input type="text" name="Std_Name" value="#HTMLEditFormat(attributes.Std_Name)#" size="30" class="formfield" maxlength="50"/>
			<input type="hidden" name="Std_Name_required" value="The name for the addon is required!"/>
			</td>
			</tr>			
			
 <!--- Prompt --->
		<tr>
			<td align="RIGHT">Message to display:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
		 	<td><input type="text" name="Std_Prompt" value="#HTMLEditFormat(attributes.std_Prompt)#" size="30" class="formfield" maxlength="100"/>
			<input type="hidden" name="Std_Prompt_required" value="The message for the addon is required!"/>
			</td>
			</tr>			
			
 <!--- Description --->
		<tr>
			<td align="RIGHT">Description in Cart:</td>
			<td></td>
		 	<td>
			<input type="text" name="Std_Desc"  value="#HTMLEditFormat(attributes.Std_Desc)#" size="30" class="formfield" maxlength="100"/>
			</td>
			</tr>	
			
 <!--- addon Type --->
		<tr>
			<td align="RIGHT">Addon Type:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
		 	<td>
			<select name="Std_type" size="1" class="formfield">
			<option value="textbox" #doSelected(attributes.std_type,'textbox')#>textbox</option>
			<option value="checkbox" #doSelected(attributes.std_type,'checkbox')#>checkbox</option>
			<option value="quantity" #doSelected(attributes.std_type,'quantity')#>quantity</option>
			<option value="textfield" #doSelected(attributes.std_type,'textfield')#>textfield</option>
			<option value="calendar" #doSelected(attributes.std_type,'calendar')#>calendar</option>
			</select>
			</td>
			</tr>	
			
 <!--- Price --->
		<tr>
			<td align="RIGHT">Amount added to price:</td>
			<td></td>
		 	<td>
			<input type="text" name="Std_Price"  value="#attributes.Std_Price#" size="12" class="formfield"/>
			<input type="hidden" name="Std_Price_float" value="The price must be a number!"/>
			</td>
			</tr>	
			
 <!--- Weight --->
		<tr>
			<td align="RIGHT">Amount added to weight:</td>
			<td></td>
		 	<td>
			<input type="text" name="Std_Weight"  value="#attributes.Std_Weight#" size="12" class="formfield"/>
			<input type="hidden" name="Std_Weight_float" value="The addon weight must be a number!"/>
			</td>
			</tr>	
	
 <!--- Product Multiplier --->
		<tr>
			<td align="RIGHT">Product quantity multiplies<br/> price and weight:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
		 	<td>
			<input type="radio" name="Std_ProdMult" value="1" #doChecked(attributes.Std_ProdMult)# /> Yes 
			&nbsp; <input type="radio" name="Std_ProdMult" value="0" #doChecked(attributes.Std_ProdMult,0)# /> No
			</td>
			</tr>			
			<tr>
			<td align="RIGHT">Required?</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
		 	<td>
			<input type="radio" name="StdRequired" value="1" #doChecked(attributes.required)# /> Yes 
			&nbsp; <input type="radio" name="StdRequired" value="0" #doChecked(attributes.required,0)# /> No
			</td>
			</tr>		
 <!--- display --->
		<tr>
			<td align="RIGHT">Display in store?</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
		 	<td>
			<input type="radio" name="Std_Display" value="1" #doChecked(attributes.Std_Display)# /> Yes 
			&nbsp; <input type="radio" name="Std_Display" value="0" #doChecked(attributes.Std_Display,0)# /> No
			</td>
			</tr>
	
		<tr>
			<td colspan="2">&nbsp;</td>
			<td><br/>
			<input type="submit" name="submit" value="#act_button#" class="formbutton"/>
			<input type="button" value="Cancel" onclick="javascript:window.history.go(-1);" class="formbutton"/>
			
			<cfif attributes.stdaddon is "edit">
				<input type="submit" name="submit" value="Delete" class="formbutton" onclick="return confirm('Are you sure you want to delete this standard addon?');"/>
			</cfif>
			</td>
		</tr>
		</form>	

</cfoutput>
</cfmodule>
	
