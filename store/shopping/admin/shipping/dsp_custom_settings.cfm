<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form to modify the Intershipper settings. Called by shopping.admin&shipping=intershipper --->

<cfset qrySettings = Application.objShipping.getCustomSettings()>

<cfprocessingdirective suppresswhitespace="no">
<cfhtmlhead text="
<script language=""JavaScript"">
		function CancelForm () {
		location.href = ""#self#?fuseaction=shopping.admin&shipping=settings&redirect=yes#request.token2#"";
		}
	</script>
">
</cfprocessingdirective>

<cfmodule template="../../../customtags/format_admin_form.cfm"
	box_title="Custom Shipping Settings"
	width="550"
	>
	
	<cfoutput>
	<form action="#self#?fuseaction=shopping.admin&shipping=customsettings#request.token2#" name="custom"  method="post">

	<cfinclude template="../../../includes/form/put_space.cfm">
	
		<tr>
			<td align="right" valign="top" nowrap="nowrap">Show Shipping Table:</td>
			<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
<td><input type="radio" name="ShowShipTable" value="1" #doChecked(qrySettings.ShowShipTable)# />Yes 
&nbsp;<input type="radio" name="ShowShipTable" value="0" #doChecked(qrySettings.ShowShipTable,0)# />No</td>	
		</tr>	
		<tr><td colspan="2"></td><td class="formtextsmall">
		Displays the table of shipping rates on the shopping basket page.
		</td></tr>
	
<cfif shipsettings.shiptype is "Items">	
		<tr>
			<td align="right" valign="top" nowrap="nowrap">Calculate Per Item:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
<td><input type="radio" name="MultPerItem" value="1" #doChecked(qrySettings.MultPerItem)# />Yes 
&nbsp;<input type="radio" name="MultPerItem" value="0" #doChecked(qrySettings.MultPerItem,0)# />No</td>	
		</tr>	
		<tr><td colspan="2"></td><td class="formtextsmall">
		Sets whether the amount in the shipping table is multiplied per item. 
		</td></tr>
		
		<tr>
			<td align="right" valign="top" nowrap="nowrap">Cumulative Amounts:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
<td><input type="radio" name="CumulativeAmounts" value="1" #doChecked(qrySettings.CumulativeAmounts)# />Yes 
&nbsp;<input type="radio" name="CumulativeAmounts" value="0" #doChecked(qrySettings.CumulativeAmounts,0)# />No</td>	
		</tr>	
		<tr><td colspan="2"></td>
		<td class="formtextsmall">
		If turned on, each range in the shipping table is applied in sequence until the order amount is reached.
		</td></tr>
		
<cfelse>	
	<input type="hidden" name="MultPerItem" value="1"/>
	<input type="hidden" name="CumulativeAmounts" value="0"/>
</cfif>

		<tr>
			<td align="right" valign="top" nowrap="nowrap">Methods Multiply Shipping:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
<td><input type="radio" name="MultMethods" value="1" #doChecked(qrySettings.MultMethods)# />Yes 
&nbsp;<input type="radio" name="MultMethods" value="0" #doChecked(qrySettings.MultMethods,0)# />No</td>	
		</tr>	
		<tr><td colspan="2"></td>
		<td class="formtextsmall">
		If turned on, the shipping method amounts will multiply the calculated shipping total. Otherwise, they will be added to the shipping total.
		</td></tr>

		<tr>
			<td align="right" valign="top" nowrap="nowrap">Debug:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
<td><input type="radio" name="Debug" value="1" #doChecked(qrySettings.Debug)# />On 
&nbsp;<input type="radio" name="Debug" value="0" #doChecked(qrySettings.Debug,0)# />Off</td>	
		</tr>	
		
		<cfinclude template="../../../includes/form/put_space.cfm">

		<tr>
			<td colspan="2"></td>
			<td><input type="submit" name="submit_custom" value="Save" class="formbutton"/> 
			<input type="button" value="Cancel" onclick="javascript:CancelForm();" class="formbutton"/>
			</td>	
		</tr>	
	</form>
	</cfoutput>
</cfmodule>

<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
objForm = new qForm("custom");

objForm.required("ShowShipTable,MultPerItem,CumulativeAmounts,Debug");

qFormAPI.errorColor = "<cfoutput>###Request.GetColors.formreq#</cfoutput>";
</script>
</cfprocessingdirective>