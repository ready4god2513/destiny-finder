
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form to add or edit a standard addon for a product. Called by product.admin&addon=addstd|change --->

<cfparam name="attributes.cid" default="">

<!--- Initialize the values for the form --->
<cfif attributes.Addon is "addstd">
		
		<cfset fieldlist="Std_ID,display,priority">	
				
		<cfloop list="#fieldlist#" index="counter">
			<cfset setvariable("attributes.#counter#", "")>
		</cfloop>

		<cfset attributes.standard_id = 0>
		<cfset attributes.Addon_id = 0>
		<cfset action="#self#?fuseaction=Product.admin&Addon=act&mode=i">
		<cfset act_title="Update Product - #qry_get_product.name#">	
		<cfset act_button ="Add Standard Addon">	
		
		
<cfelse>

		<cfset fieldlist="Addon_id,Standard_ID,display,priority">	
		<!--- Set the form fields to values retrieved from the record --->
		<cfloop list="#fieldlist#" index="counter">
			<cfset "attributes.#counter#" = evaluate("qry_get_addon." & counter)>
		</cfloop>
				
		<cfset action="#self#?fuseaction=Product.admin&Addon=act&mode=u">
		<cfset act_title="Update Product - #qry_get_product.name#">	
		<cfset act_button ="Update Standard Addon">	
	
</cfif>
		
<cfset addons_for_product = "yes">		
<cfinclude template="../../stdaddons/qry_get_stdaddons.cfm">

<!--- Make sure there are standard Addons defined --->
<cfif NOT qry_get_StdAddons.RecordCount>
	<cfset action = "#self#?fuseaction=product.admin&do=addons">
	<cfset act_button = "Return">
</cfif>
		
	
<cfmodule template="../../../../customtags/format_output_admin.cfm"
	box_title="#act_title#"
	Width="700"
	menutabs="yes">
	
	<cfinclude template="../dsp_menu.cfm">

	<cfoutput>
	<!--- Table --->
	<table border="0" cellpadding="0" cellspacing="4" width="100%" class="formtext" style="color:###Request.GetColors.InputTText#">
	
	<form name="editform" action="#action#" method="post">
		<input type="hidden" name="product_id" value="#attributes.product_id#"/>
		<input type="hidden" name="cid" value="#attributes.cid#"/>
		<input type="hidden" name="Addon_ID" value="#attributes.Addon_id#"/>

		<cfif NOT qry_get_StdAddons.RecordCount>
			<tr><td colspan="2"></td>
			<td>There are no standard addons defined.<br/> Please create the standard addon first. </td></tr>
		<cfelse>
		<!--- STD Addon ID --->
			<tr>
				<td align="RIGHT">Select addon to use:</td>
				<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
				<td><select name="Std_ID" class="formfield">
					<cfloop query="qry_get_StdAddons">
						<option value="#Std_ID#" #doSelected(attributes.Standard_ID,Std_ID)#>#Std_Name#</option>
					</cfloop>
					</select>
				</td></tr>
				
				
	 	<!--- Name --->
			<tr>
				<td align="RIGHT">Display:</td>
				<td style="background-color: ###Request.GetColors.formreq#;"></td>
		 		<td><input type="radio" name="Display" value="1" #doChecked(attributes.Display)# /> Yes &nbsp; 
					<input type="radio" name="Display" value="0" #doChecked(attributes.Display,0)# /> No
				</td></tr>
				
		<!--- priority --->
			<tr>
				<td align="RIGHT">Priority:</td>
				<td></td>
				<td><input type="text" name="Priority" class="formfield" value="#doPriority(attributes.Priority,0)#" size="4" maxlength="10"/>
				<span class="formtextsmall">(1 is highest, 0 is none)</span>
				</td></tr>		
			
		</cfif>				
		<tr>
			<td colspan="2">&nbsp;</td>
			<td><br/>
			<input type="submit" name="submit" value="#act_button#" class="formbutton"/>

			</td></tr>
	</form>	
	
<cfif qry_get_StdAddons.RecordCount>

<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
objForm = new qForm("editform");

objForm.Priority.validateNumeric();

qFormAPI.errorColor = "###Request.GetColors.formreq#";
</script>
</cfprocessingdirective>

<cfinclude template="../../../../includes/form/put_requiredfields.cfm">


	</cfif>

</cfoutput>		
		</table> 
</cfmodule>
	
