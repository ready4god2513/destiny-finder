
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the current shipping table for custom shipping rates and allows add or edit the rates. Called by shopping.admin&shipping=custom --->

<cfif isdefined("attributes.edit")>
	
	<cfquery name="GetRate" datasource="#Request.DS#" 
	username="#Request.user#" password="#Request.pass#">
	SELECT * FROM #Request.DB_Prefix#Shipping
	WHERE ID = #attributes.edit#
	</cfquery>

	<cfloop list="minorder,maxorder,amount,id" index="counter">
		<cfset "attributes.#counter#" = evaluate("getrate." & counter)>
	</cfloop>
	
	<cfset formbutton = "Update">
	
<cfelse><!--- add --->

	<cfset attributes.MinOrder = 0>
	<cfset attributes.MaxOrder = 0>
	<cfset attributes.Amount = 0>
	<cfset attributes.ID = 0>
	<cfset formbutton = "Add Rate">
	
</cfif>


<cfquery name="GetShipping" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT * FROM #Request.DB_Prefix#Shipping
ORDER BY MinOrder
</cfquery>

<cfoutput>
<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
	function CancelForm() {
	location.href = '#self#?fuseaction=shopping.admin&shipping=settings&redirect=yes#request.token2#';
	}
</script>
</cfprocessingdirective>
</cfoutput>

<cfmodule template="../../../customtags/format_output_admin.cfm"
	box_title="Shipping Rates"
	Width="550">
	
	<cfoutput>
	<table border="0" cellpadding="0" cellspacing="4" width="100%" class="formtext"	style="color:###Request.GetColors.InputTText#">

	<cfinclude template="../../../includes/form/put_space.cfm">
	
<!--- Add form ---->	

	<form name="editform" action="#self#?fuseaction=shopping.admin&shipping=custom#request.token2#" method="post">
	<input type="hidden" name="ID" value="#attributes.ID#"/>
	
	
		<tr>
			<td align="RIGHT" width="35%">Minimum Amount:</td>
			<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
			<td width="65%"><input type="text" name="MinOrder" size="5" maxlength="10"  class="formfield" value="#NumberFormat(attributes.MinOrder, '0.00')#" /> 
<cfif ShipSettings.ShipType IS "Price" OR ShipSettings.ShipType IS "Price2">#Request.AppSettings.MoneyUnit#
<cfelseif ShipSettings.ShipType IS "Items">Items
<cfelse>#Request.AppSettings.WeightUnit#</cfif>
			</td>	
		</tr>
	
		<tr>
			<td align="RIGHT">Maximum Amount:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			<input type="text" name="MaxOrder" size="5" maxlength="10"value="#NumberFormat(attributes.MaxOrder, '0.00')#" class="formfield"/> 
<cfif ShipSettings.ShipType IS "Price" OR ShipSettings.ShipType IS "Price2">#Request.AppSettings.MoneyUnit#
<cfelseif ShipSettings.ShipType IS "Items">Items
<cfelse>#Request.AppSettings.WeightUnit#</cfif>
			</td>	
		</tr>
	
	<cfif ShipSettings.ShipType IS "Price" OR ShipSettings.ShipType IS "Weight" 
	OR ShipSettings.ShipType IS "Items">	
		<tr>
			<td align="RIGHT">Shipping Amount:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td><input type="text" name="Amount" size="5" maxlength="10"  value="#NumberFormat(attributes.Amount, '0.00')#" class="formfield"/> #Request.AppSettings.MoneyUnit#
			</td>	
		</tr>
	
	<cfelse>
		<tr>
			<td align="RIGHT">Shipping Percentage:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td><input type="text" name="Amount" size="5" maxlength="10"  value="#DecimalFormat(attributes.Amount * 100)#" class="formfield"/> %
			</td>	
		</tr>
	</cfif>	
	
		<tr>
			<td colspan="2"></td>
			<td><input type="submit" name="Submit_rate" value="#formbutton#" class="formbutton"/> 			
			<input type="button" value="Back to Settings" class="formbutton" onclick="CancelForm();" />
			</td>	
		</tr>	
		</form>
		
		<cfprocessingdirective suppresswhitespace="no">
		<script type="text/javascript">
		objForm = new qForm("editform");
		objForm.required("MinOrder,MaxOrder,Amount");
		
		objForm.MinOrder.validateNumeric();
		objForm.MaxOrder.validateNumeric();
		objForm.Amount.validateNumeric();
		
		objForm.MinOrder.description = "minimum amount";
		objForm.MaxOrder.description = "maximum amount";
		
		<cfif ShipSettings.ShipType IS "Price" OR ShipSettings.ShipType IS "Weight" OR ShipSettings.ShipType IS "Items">
			objForm.Amount.description = "shipping amount";
		<cfelse>
			objForm.Amount.description = "shipping percentage";
		</cfif>
		
		qFormAPI.errorColor = "###Request.GetColors.formreq#";
		</script>
		</cfprocessingdirective>
		</cfoutput>
		
		<cfinclude template="../../../includes/form/put_requiredfields.cfm">
		
	</table>
	
	<cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"  width="98%"/>
	
	
<cfif GetShipping.RecordCount>	

	<table border="0" cellpadding="0" cellspacing="4" width="95%" class="formtext" align="center" style="color:#<cfoutput>#Request.GetColors.InputTText#</cfoutput>">
		<tr>
			<th align="left"><cfif ShipSettings.ShipType IS "Items">Item<cfelse>Order</cfif> Total</th>
			<th><cfif ShipSettings.ShipType IS "Price" OR ShipSettings.ShipType IS "Weight" OR ShipSettings.ShipType IS "Items">Amount<cfelse>Percentage</cfif></th>
			<th>&nbsp;</th>
		</tr>
	
		<cfoutput query="GetShipping">
		<tr>
			<td>
			<cfif ShipSettings.ShipType IS "Price" OR ShipSettings.ShipType IS "Price2">
#LSCurrencyFormat(MinOrder)# - #LSCurrencyFormat(MaxOrder)#
			<cfelseif ShipSettings.ShipType IS "Items">
			#MinOrder# - #MaxOrder# 
			<cfelse>#DecimalFormat(MinOrder)# - #DecimalFormat(MaxOrder)# #Request.AppSettings.WeightUnit#</cfif>
			</td>
			
			<td align="center">
			<cfif ShipSettings.ShipType IS "Price" OR ShipSettings.ShipType IS "Weight" OR ShipSettings.ShipType IS "Items">#LSCurrencyFormat(Amount)#<cfelse>#Evaluate(Amount * 100)# %</cfif>
			</td>
			
			<td width="20%">[<a href="#self#?fuseaction=shopping.admin&shipping=custom&edit=#ID##Request.Token2#">edit</a>] [<a href="#self#?fuseaction=shopping.admin&shipping=custom&delete=#ID##Request.Token2#">delete</a>]</td>
		</tr>
		</cfoutput>
	</table>
<cfelse>
	<p align="center">No Shipping Rates Entered</p>
</cfif>	

</cfmodule>
