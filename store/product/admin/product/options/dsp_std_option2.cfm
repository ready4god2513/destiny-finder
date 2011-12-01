
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the second form page for standard options. Used to enter SKUs and number in stock, or to disable individual choices for the option specific for this product only. Called by product.admin&option=std2 --->

<cfinclude template="qry_get_option.cfm">

<!--- <cfset attributes.std_id = qry_get_option.std_id> --->
<!--- <cfinclude template="../../stdoptions/qry_get_stdoption.cfm"> --->

<cfset act_title="Update Product - #qry_get_product.name#">
<cfset act_button ="Update Option">	
<cfset action="#self#?fuseaction=Product.admin&option=act2">

<cfif attributes.cid is not "">
	<cfset action="#action#&cid=#attributes.cid#">
</cfif>
		
<cfinclude template="put_options_js.cfm">
		
<cfmodule template="../../../../customtags/format_output_admin.cfm"
	box_title="#act_title#"
	Width="700"
	menutabs="yes">
	
	<cfinclude template="../dsp_menu.cfm">

	<cfoutput>
	<!--- Table --->
	<table border="0" cellpadding="0" width="80%" cellspacing="4" align="center" class="formtext"
	style="color:###Request.GetColors.InputTText#">
	
	<form name="editform" action="#action##request.token2#" method="post">
	
		<input type="hidden" name="Num" value="#qry_get_Opt_Choices.Recordcount#"/>
		<input type="hidden" name="Product_ID" value="#attributes.Product_ID#"/>
		<input type="hidden" name="Option_ID" value="#attributes.Option_ID#"/>
		<input type="hidden" name="Display" value="#qry_get_option.Display#"/>
	
		<tr>
			<td colspan="4" class="formtitle"><br/>
			Enter any additional things you want to modify on this option:<br/><br/></td>
		</tr>
		
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
<strong>NOTE ON STOCK AMOUNTS:</strong> This option is currently in use for inventory tracking on orders in the system. You will not be able to delete the option or clear all the stock amounts until those orders are removed, but you can hide individual choices from being displayed in the store for new orders. The numbers in stock may still change according to actions made to any existing orders in the system. <br/>&nbsp;
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

		<tr>
			<td align="LEFT"><br/><b>Choice Name</b></td>
			<td align="LEFT"><br/><b>SKU</b> <br/>
				<font size="-2">(blank if not used)</font></td>
 			<td align="center"><br/><b>Num in Stock</b> <br/>
				<font size="-2">(blank if not used)</font></td>
 			<td align="center"><br/><b>Show?</b></td>
		</tr>

	<!--- Determine name and value of each option Addon --->
	<cfloop query="qry_get_Opt_Choices">
		<!--- If exist, display name and value in text input boxes --->
		<tr>
			<td>#ChoiceName#</td>
			<input type="hidden" name="Choice_ID#currentrow#" value="#qry_get_Opt_Choices.choice_id#"/>
			<td><input type="text" name="SKU#currentrow#" value="#SKU#" size="25" maxlength="50" class="formfield" <cfif CheckOtherSKUs.RecordCount>onfocus="this.blur();"</cfif>/></td>
			<td align="center"><input type="text" name="NumInStock#currentrow#" class="formfield" value="<cfif qry_get_Opt_Choices.NumInStock IS NOT 0>#qry_get_Opt_Choices.NumInStock#</cfif>" size="8" <cfif CheckOtherInv.RecordCount>onfocus="this.blur();"</cfif>/> </td>
			<td align="center"><input type="checkbox" class="formfield" name="Display#currentrow#" #doChecked(ItemDisplay)# /></td>
		</tr>

	</cfloop>

	
	
		<tr>
			<td colspan="4">
				<table width="60%" border="0" cellpadding="0" align="center" class="formtext">
					<tr>
						<td colspan="2"><br/>
						<input type="submit" name="submit" value="#act_button#" class="formbutton"/> 
						<input type="button" value="Cancel" onclick="CancelForm();" class="formbutton"/>
						</td></tr>
					<tr>
						<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
						<td width="100%">&nbsp;required fields</td></tr>
				</table>
	
			</td></tr>
				
	</form>	
	
<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
objForm = new qForm("editform");



<cfloop query="qry_get_Opt_Choices">
<cfif CheckInvUse.RecordCount>
objForm.required('NumInStock#currentrow#');
</cfif>
objForm.NumInStock#currentrow#.validateNumeric();
objForm.NumInStock#currentrow#.description = "Number in Stock for selection #currentrow#";
</cfloop>

qFormAPI.errorColor = "###Request.GetColors.formreq#";
</script>
</cfprocessingdirective>
</cfoutput>	

</table> 
</cfmodule>
	
