<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form to edit the free shipping promotion. Displays any currently used shipping methods and allows the admin to select the ones to apply the promotion to, and set the order amount required. Called by shopping.admin&shipping=free --->

<cfquery name="GetMethods" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	<cfif shipsettings.shiptype is "Intershipper">
		SELECT *, '' AS Shipper FROM #Request.DB_Prefix#IntShipTypes
	<cfelseif shipsettings.shiptype is "UPS">
		SELECT *, 'UPS' AS Shipper FROM #Request.DB_Prefix#UPSMethods
	<cfelseif shipsettings.shiptype is "USPS">
		SELECT *, 'USPS' AS Shipper FROM #Request.DB_Prefix#USPSMethods
	<cfelseif shipsettings.shiptype is "FedEx">
		SELECT * FROM #Request.DB_Prefix#FedExMethods
	<cfelse>
		SELECT *, '' AS Shipper FROM #Request.DB_Prefix#CustomMethods
	</cfif>
	WHERE Used=1
	ORDER BY Priority
</cfquery>


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
	box_title="Free Shipping Settings"
	width="500"
	>
	
	<cfoutput>
	<form action="#self#?fuseaction=shopping.admin&shipping=free#request.token2#"  method="post" name="free">

	<cfinclude template="../../../includes/form/put_space.cfm">

		<tr>
			<td align="right" valign="top" width="35%">For Basket Total Over:</td>
			<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
			<td width="65%">
			<input type="text" name="freeship_min" class="formfield" value="#iif(shipsettings.freeship_min IS NOT 0, NumberFormat(shipsettings.freeship_min, '0.00'), DE('0'))#" size="7" maxlength="15"/> #Request.AppSettings.MoneyUnit#
			</td>	
		</tr>

		<tr>
			<td align="right" valign="top">These Methods are FREE:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			<cfif getmethods.recordcount gt 0>
			<cfloop query="getmethods">
				<input type="checkbox" name="freeship_shipids" value="#ID#" #doChecked(listfind(shipsettings.freeship_shipids,ID))# />#shipper# #name#<br/>
			</cfloop>
	
			<cfelse>
				<span class="formerror">No Shipping Methods currently available.</span>
			</cfif>
			</td>	
		</tr>	
		<tr>
			<td colspan="2"></td>
			<td><input type="submit" name="submit_free" value="Save" class="formbutton"/> 
			<input type="button" value="Cancel" onclick="javascript:window.history.go(-1);" class="formbutton"/>
			</td>	
		</tr>	
	</form>
</cfoutput>	
</cfmodule>


<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
objForm = new qForm("free");

objForm.required("freeship_min");

objForm.freeship_min.validateNumeric();
objForm.freeship_min.description = "minimum basket total";

qFormAPI.errorColor = "<cfoutput>###Request.GetColors.formreq#</cfoutput>";
</script>
</cfprocessingdirective>