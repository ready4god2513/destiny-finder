
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form to add or edit a custom option for a product. Called by product.admin&option=addcust|change --->

<cfparam name="attributes.cid" default="">

<!--- Initialize the values for the form --->
<cfset fieldlist="Prompt,OptDesc,ShowPrice,display,Required,priority,">	

<cfif attributes.option is "addcust">
				
		<cfloop list="#fieldlist#" index="counter">
			<cfset setvariable("attributes.#counter#", "")>
		</cfloop>

		<cfset attributes.option_id = 0>
		<cfset attributes.ShowPrice = "No">	
		<cfset CheckOtherSKUs.RecordCount = 0>
		<cfset CheckInvUse.RecordCount = 0>
		<cfset CheckOtherInv.RecordCount = 0>
		
		<cfset action="#self#?fuseaction=Product.admin&option=act&mode=i">
		<cfset act_title="Update Product - #qry_get_product.name#">	
		<cfset act_button ="Add Custom Option">	
		
<cfelse><!--- edit custom--->
		<!--- Set the form fields to values retrieved from the record --->
		<cfloop list="#fieldlist#" index="counter">
			<cfset "attributes.#counter#" = evaluate("qry_get_option." & counter)>
		</cfloop>
				
		<cfset action="#self#?fuseaction=Product.admin&option=act&mode=u">
		<cfset act_title="Update Product - #qry_get_product.name#">	
		<cfset act_button ="Update Custom Option">	
	
</cfif>

<cfinclude template="put_options_js.cfm">

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
		<input type="hidden" name="option_ID" value="#attributes.option_id#"/>			
			
 <!--- Prompt --->
		<cfif NOT len(attributes.Prompt)>
			<cfset attributes.Prompt = "Choose One:">
		</cfif>		
		<tr>
			<td align="RIGHT">Message to display:</td>
			<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
		 	<td><input type="text" name="Prompt" value="#HTMLEditFormat(attributes.Prompt)#" size="30" maxlength="50" class="formfield"/>
			<input type="hidden" name="Prompt_required" value="The message for the option is required!"/>
			</td>
			</tr>
			
			
 <!--- Description --->
		<tr>
			<td align="RIGHT">Description in Cart:</td>
			<td></td>
		 	<td>
			<input type="text" name="OptDesc" value="#HTMLEditFormat(attributes.OptDesc)#" size="30" maxlength="50" class="formfield"/>
			</td>
			</tr>
			
						
 <!--- required --->
		<tr>
			<td align="RIGHT">Require a selection?</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
		 	<td>
			<input type="radio" name="Required" value="1" #doChecked(attributes.Required)# /> Yes &nbsp; 
			<input type="radio" name="Required" value="0" #doChecked(attributes.Required,0)# /> No<br/>
			<span class="formtextsmall">(defaults to yes if you enter stock amounts) </span>
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
			
 <!--- Show Price --->
		<tr>
			<td align="RIGHT">Show price on selections?</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
		 	<td>
			<input type="radio" name="ShowPrice" value="No" #doChecked(attributes.ShowPrice,'No')# /> No &nbsp;&nbsp; 
			<input type="radio" name="ShowPrice" value="AddPrice" #doChecked(attributes.ShowPrice,'AddPrice')# /> Amount Added &nbsp; 
			<input type="radio" name="ShowPrice" value="Total" #doChecked(attributes.ShowPrice,'Total')# /> Total
			</td>
			</tr>
			
			
<!--- priority --->
		<tr>
			<td align="RIGHT" valign="top">Priority:</td>
			<td></td>
			<td> <input type="text" name="Priority" value="#doPriority(attributes.Priority,0)#" size="4" maxlength="10" class="formfield"/>
			<span class="formtextsmall"> (1 is highest, 0 is none)</span><br/>&nbsp;
			</td></tr>		
</cfoutput>

<cfif CheckOtherSKUs.RecordCount>
<input type="hidden" name="OtherSKUs" value="1"/>
		<tr>
			<td colspan="3">
<strong>NOTE ON SKUs:</strong> Another option for this product is currently being used to set SKUs. You will not be able to add SKUs for this option unless the SKUs for the other option are removed first. <br/>&nbsp;
			</td>
			</tr>
</cfif>			
<cfif CheckInvUse.RecordCount>
<input type="hidden" name="TrackInv" value="1"/>
		<tr>
			<td colspan="3">
<strong>NOTE ON STOCK AMOUNTS:</strong> This option is currently in use for inventory tracking on orders in the system. You will not be able to delete the option or any current option choices or clear all the stock amounts, but you can hide individual choices from being displayed in the store for new orders. The numbers in stock may still change according to actions made to any existing orders in the system. <br/>&nbsp;
			</td>
			</tr>
<cfelseif CheckOtherInv.RecordCount>
<input type="hidden" name="OtherInv" value="1"/>
		<tr>
			<td colspan="3">
<strong>NOTE ON STOCK AMOUNTS:</strong> Another option for this product is currently in use for inventory tracking. You will not be able to add stock amounts for this option unless the stock amounts for the other option are removed first. <br/>&nbsp;
			</td>
			</tr>
</cfif>

<!---================ TABLE =================--->			
		<tr>
			<td colspan="3">
	
				<table width="95%" class="formtext" align="center">
				
<!---- Determine number of option Addons --->
<cfset Number = iif(isDefined("qry_get_Opt_Choices.Recordcount"),Evaluate(DE('qry_get_Opt_Choices.Recordcount')),0) >

<cfif Number>
				<tr>
					<td align="LEFT" valign="bottom"><b>Choice Name</b></td>
					<td align="LEFT"><b>Price</b><br/>
						<font size="-2">(Add to Base,<br/>
 						blank if 0)</font></td>
 					<td align="LEFT"><b>Weight</b><br/>
						<font size="-2">(Add to Base,<br/>
 						blank if 0)</font></td>
					<td align="LEFT" valign="bottom"><b>SKU</b><br/>
						<font size="-2">(blank if not used)</font></td>
 					<td align="center" valign="bottom"><b>Num in Stock</b><br/>
						<font size="-2">(blank if not used)</font></td>
					<td align="center" valign="bottom"><b>Order</b></td>
 					<td align="center" valign="bottom"><b>Show?</b></td>
					<td align="center" valign="bottom"><b>Delete</b></td>
				</tr>

		<!--- Determine name and value of each option choice --->
		<cfoutput query="qry_get_Opt_Choices">
			<input type="hidden" name="Choice_ID#currentrow#" value="#qry_get_Opt_Choices.choice_id#"/>
			<tr>
				<td><input type="text" name="ChoiceName#currentrow#" value="#HTMLEditFormat(ChoiceName)#" size="25" maxlength="50" class="formfield"/></td>
				<td><input type="text" name="Price#currentrow#" value="<cfif qry_get_Opt_Choices.Price IS NOT 0>#Trim(NumberFormat(qry_get_Opt_Choices.Price, '_________.__'))#</cfif>" size="8" class="formfield"/></td>
<input type="hidden" name="Price#currentrow#_float" value="The selection price must be a number!"/>
				<td><input type="text" name="Weight#currentrow#" value="<cfif qry_get_Opt_Choices.Weight IS NOT 0>#Trim(NumberFormat(qry_get_Opt_Choices.Weight, '_________.__'))#</cfif>" size="8" class="formfield"/></td>
<input type="hidden" name="Weight#currentrow#_float" value="The selection weight must be a number!"/>
				<td><input type="text" name="SKU#currentrow#" value="#SKU#" size="15" maxlength="50" class="formfield" <cfif CheckOtherSKUs.RecordCount>onfocus="this.blur();" autocomplete="off"</cfif>/></td>
				<td align="center"><input type="text" name="NumInStock#currentrow#" value="<cfif qry_get_Opt_Choices.NumInStock IS NOT 0>#qry_get_Opt_Choices.NumInStock#</cfif>" size="8" class="formfield" <cfif CheckOtherInv.RecordCount>onfocus="this.blur();" autocomplete="off"</cfif>/></td>
<td align="center"><input type="text" name="SortOrder#currentrow#" value="<cfif qry_get_Opt_Choices.SortOrder IS NOT 9999>#qry_get_Opt_Choices.SortOrder#</cfif>" size="6" class="formfield"/></td>
<input type="hidden" name="SortOrder#currentrow#_float" value="The sort order must be a number!"/>
<td align="center"><input type="checkbox" name="Display#currentrow#" #doChecked(Display)# class="formfield"/></td>
<td align="center"><input type="checkbox" name="Delete#currentrow#" class="formfield" <cfif CheckInvUse.RecordCount>disabled="disabled"</cfif>/></td>
			</tr>
		</cfoutput>
</cfif>



<cfset Start = Number + 1>

<!--- Prompt user for number of choices on this option --->
<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
    var num = prompt('How many <cfif Number>additional </cfif>selections do you want for this option?','<cfif Number>0<cfelse>1</cfif>','0');
if (num != null) {
num = parseInt(num);
	num += <cfoutput>#Number#</cfoutput>;
	document.write('<input type="hidden" name="num" value="' + num + '"/>\n');
<cfif NOT Number>
if (num <= 0) { num = 1}
document.write('<tr><td align="LEFT" valign="bottom"><br/>\n');
		document.write('<b>Choice Name</b></td>\n');
		document.write('<td align="LEFT"><br/>\n');
		document.write('<b>Price</b><br/>\n');
		document.write('<font size="-2">\(Add to Base,<br/>leave blank if 0\)</font></td>\n');
document.write('<td align="LEFT"><br/>\n');
		document.write('<b>Weight</b><br/>\n');
		document.write('<font size="-2">\(Add to Base,<br/>leave blank if 0\)</font></td>\n');
		document.write('<td align="LEFT" valign="bottom"><br/>\n');
		document.write('<b>SKU</b><br/>\n');
		document.write('<font size="-2">\(blank if not used\)</font></td>\n');
		document.write('<td align="center" valign="bottom"><br/>\n');
		document.write('<b>Num in Stock</b><br/>\n');
		document.write('<font size="-2">\(blank if not used\)</font></td>\n');
		document.write('<td align="center" valign="bottom"><br/><b>Order</b></td>\n');
		document.write('<td align="center" valign="bottom"><br/><b>Show?</b></td>\n');
		document.write('<td align="center" valign="bottom"><br/><b>Delete</b></td></tr>\n');
</cfif>		
	for (var i=<cfoutput>#Start#</cfoutput>; i<=num; i++){
	document.write('<tr><td><input type="text" name="ChoiceName' + i + '" size="25" maxlength="50" class="formfield"/></td>\n');
	document.write('<td><input type="text" name="Price' + i + '" size="8" class="formfield"/></td>\n');
document.write('<td><input type="text" name="Weight' + i + '" size="8" class="formfield"/></td>\n');
document.write('<td><input type="text" name="SKU' + i + '" size="15" maxlength="50" class="formfield" <cfif CheckOtherSKUs.RecordCount>onfocus="this.blur();"</cfif>/></td>\n');
document.write('<td align="center"><input type="text" name="NumInStock' + i + '" size="8" class="formfield" <cfif CheckOtherInv.RecordCount>onfocus="this.blur();"</cfif>/></td>\n');
document.write('<td align="center"><input type="text" name="SortOrder' + i + '" size="6" class="formfield"/></td>\n');
document.write('<td align="center"><input type="checkbox" name="Display' + i + '" class="formfield" checked="checked" /></td>\n');
document.write('<td align="center"><input type="checkbox" name="Delete' + i + '" class="formfield"/></td></tr>\n');
document.write('<input type="hidden" name="Price' + i + '_float" value="The choice price must be a number!"/>');
document.write('<input type="hidden" name="Weight' + i + '_float" value="The choice weight must be a number!"/>');
document.write('<input type="hidden" name="SortOrder' + i + '_float" value="The sort order must be a number!"/>');
	}
}
else {
location.href = "<cfoutput>#request.self#?fuseaction=Product.admin&do=options&product_id=#attributes.Product_ID#&redirect=yes#Request.Token2#</cfoutput>";
}

    </script>
</cfprocessingdirective>

	</table></td></tr>

			
		<tr>
			<td colspan="2">&nbsp;</td>
			<td><br/>
			<input type="submit" name="submit" value="<cfoutput>#act_button#</cfoutput>" class="formbutton"/>
			<input type="button" value="Cancel" onclick="CancelForm();" class="formbutton"/>
			</td>
		</tr>
		</form>	

	
		<cfinclude template="../../../../includes/form/put_requiredfields.cfm">
	
	</table> 
</cfmodule>

