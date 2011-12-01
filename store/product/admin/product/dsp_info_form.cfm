
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form to edit the product pricing information. Called by product.admin&do=price --->

<!--- Initialize the values for the form --->
	<cfset fieldlist="Product_ID,Name,Goog_brand,Goog_condition,Goog_expire,Goog_prodtype">

	<!--- Set the form fields to values retrieved from the record --->
	<cfloop list="#fieldlist#" index="counter">
		<cfset "attributes.#counter#" = evaluate("qry_get_product." & counter)>
	</cfloop>
			
<cfset act_title="Update Product - #attributes.name#">
<cfset action="#self#?fuseaction=Product.admin&do=act_info">	

<cfparam name="attributes.cid" default="">
<cfset action="#action#&cid=#attributes.cid#">


<cfinclude template="../customfields/qry_get_customfields.cfm">
<cfinclude template="qry_get_custominfo.cfm">
				
<cfmodule template="../../../customtags/format_output_admin.cfm"
	box_title="#act_title#"
	Width="700"
	menutabs="yes">
	
	<cfinclude template="dsp_menu.cfm">
	
<cfoutput>
	<!--- Table --->
	<table border="0" cellpadding="0" cellspacing="4" width="100%" class="formtext" 
	style="color:###Request.GetColors.InputTText#">
	<form name="editform" action="#action##request.token2#" method="post">
	
	<input type="hidden" name="product_id" value="#attributes.product_id#"/>
	<input type="hidden" name="customfields" value="#ValueList(qry_Get_Customfields.Custom_ID)#"/>

 
 <!--- Title --->
		<tr>
			<td align="RIGHT" class="formtitle" nowrap="nowrap"><br/>Google Base Fields&nbsp;</td>
			<td colspan="2"><br/><cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#" /></td>
		</tr>
		<tr><td></td><td colspan="2">
		<span class="formtextsmall">These are the minimum required fields for Google Base Export.<br/>
		 You can include additional fields using the custom fields.</span></td></tr>
		<tr>
				<td align="RIGHT">Brand:</td>
				<td></td>
				<td><input type="text" name="Goog_brand" size="30" maxlength="100" 
				value="#qry_Get_Product.Goog_brand#" class="formfield"/></td>
			</tr>	
		<tr>
				<td align="RIGHT">Condition:</td>
				<td></td>
				<td><input type="text" name="Goog_condition" size="30" maxlength="100" 
				value="#qry_Get_Product.Goog_condition#" class="formfield"/></td>
			</tr>	
		<tr>
				<td align="RIGHT">Expiration Date:</td>
				<td></td>
				<td><input type="text" name="Goog_expire" size="15" maxlength="30" 
				value="#qry_Get_Product.Goog_expire#" class="formfield"/></td>
			</tr>	
		<tr>
				<td align="RIGHT">Product Type:</td>
				<td></td>
				<td><input type="text" name="Goog_prodtype" size="30" maxlength="100" 
				value="#qry_Get_Product.Goog_prodtype#" class="formfield"/></td>
			</tr>			
							

		<tr>
			<td align="RIGHT" class="formtitle"><br/>Custom Fields&nbsp;</td>
			<td colspan="2"><br/><cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#" /></td>
		</tr>
		<tr><td></td><td colspan="2">
		<span class="formtextsmall">These can be used to display additional information about the product, <br/>
		 or used internally for product exports or other functions.</span></td></tr>			
				
<!---============== Custom fields ==================== --->	
	<cfloop query="qry_Get_Customfields">
		<cfquery name="get_thisInfo" dbtype="query">
		SELECT * FROM qry_Get_Custominfo
		WHERE Custom_ID = #qry_Get_Customfields.Custom_ID#
		</cfquery>
		<tr>
			<td align="RIGHT">#qry_Get_Customfields.Custom_Name#:</td>
			<td></td>
			<td><input type="text" name="Custom#qry_Get_Customfields.Custom_ID#" size="30" maxlength="150" 
				value="#HTMLEditFormat(get_thisInfo.CustomInfo)#" class="formfield"/></td>
		</tr>	
	</cfloop>
	
	<cfif NOT qry_Get_Customfields.Recordcount>
	<tr><td align="RIGHT" class="formtitle"><br/>Custom Fields&nbsp;</td>
			<td colspan="2"><br/>No custom fields defined</td>
		</tr>	
	</cfif>


		<tr>
			<td colspan="2">&nbsp;</td>
			<td><br/>
			<input type="submit" name="frm_submit" value="Update Product Info" class="formbutton"/> 
			<input type="reset" value="Clear" class="formbutton"/>			
	</td>
	
	</tr>
	</form>	
	
<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
objForm = new qForm("editform");

objForm.Goog_expire.validateDate();

qFormAPI.errorColor = "###Request.GetColors.formreq#";
</script>
</cfprocessingdirective>



<form action="#self#?fuseaction=product.admin&do=list#request.token2#" method="post">			
	<tr>
		<td align="center" colspan="3">
<cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#" width="98%" />	<br/>	
		<input type="hidden" name="act" value="choose"/>
		<input type="hidden" name="cid" value="#iif(len(attributes.cid),attributes.cid,0)#"/>
		<input type="submit" name="DONE" value="Back to Product List" class="formbutton"/>
		<br/><br/>
		</td>
	</tr>
	</form>
		
	</table> 
</cfoutput>		
</cfmodule>		

