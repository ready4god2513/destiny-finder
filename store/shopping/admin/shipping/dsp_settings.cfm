<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form to update the Shipping Settings for the store. Called by shopping.admin&shipping=settings --->

<!--- Replace HTML breaks with hard returns --->
<cfset HTMLBreak = Chr(60) & 'br/' & Chr(62)>
<cfset HTMLParagraph = HTMLBreak & HTMLBreak>
<cfset NoShipMess = Replace(ShipSettings.NoShipMess, HTMLParagraph, '', "ALL")>

	
<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
<cfoutput>
 function CancelForm() {
	location.href = '#self#?fuseaction=home.admin&inframes=yes&redirect=yes#request.token2#';
	}
</cfoutput>		
		
 function getSelectValue(selectObject) {
 
 var shiptype = selectObject.options[selectObject.selectedIndex].value;

 if (shiptype == 'UPS') {
 alert('After saving your settings, be sure to check the Rate Calculation instructions at the bottom of this page for information on how to set up the automated UPS Shipping calculations.');
 }
 
else if (shiptype == 'FedEx') {
 alert('After saving your settings, be sure to check the Rate Calculation instructions at the bottom of this page for information on how to set up the automated FedEx Shipping calculations.');
 }
 
 else if (shiptype == 'USPS') {
 alert('After saving your settings, be sure to check the Rate Calculation instructions at the bottom of this page for information on how to set up automatic calculation of United States Postal Service Rates.');
 }
 
 else if (shiptype == 'Intershipper') {
 alert('After saving your settings, be sure to check the Rate Calculation instructions at the bottom of this page for information on how to set up your Intershipper account.');
 }
   
 else {
 alert('After saving your settings, be sure to check the Rate Calculation instructions at the bottom of this page for information on how to set up your custom shipping tables.');
 }
document.forms[0].submit();
}
</script>
</cfprocessingdirective>

<cfmodule template="../../../customtags/format_admin_form.cfm"
	box_title="Shipping Settings"
	width="550"
	required_fields="0"
	>

	<cfoutput>
	
<!--- Add form ---->
	<form name="editform" action="#self#?fuseaction=shopping.admin&shipping=settings#request.token2#" method="post">
	<input type="hidden" name="fuseaction" value="shopping.admin"/>
	<input type="hidden" name="shipping" value="settings"/>
	<input type="hidden" name="ID" value="1"/>

		<cfinclude template="../../../includes/form/put_space.cfm">
		<tr>
			<td align="RIGHT" width="30%">Global Shipping Method:</td>
			<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
			<td width="70%">
			<select name="ShipType" size="1" class="formfield">
				<option value="Price" #doSelected(ShipSettings.ShipType,'Price')#>Amount Added by Total Price</option>
				<option value="Weight" #doSelected(ShipSettings.ShipType,'Weight')#>Amount Added by Total Weight</option>
				<option value="Items" #doSelected(ShipSettings.ShipType,'Items')#>Amount Added per Item</option>
				<option value="Price2" #doSelected(ShipSettings.ShipType,'Price2')#>Percentage Added by Total Price</option>
				<option value="Weight2" #doSelected(ShipSettings.ShipType,'Weight2')#>Percentage Added by Total Weight</option>
				<option value="UPS" #doSelected(ShipSettings.ShipType,'UPS')#>Automated UPS Shipping Rates</option>
				<option value="USPS" #doSelected(ShipSettings.ShipType,'USPS')#>Automated USPS Shipping Rates</option>
				<option value="FedEx" #doSelected(ShipSettings.ShipType,'FedEx')#>Automated FedEx Shipping Rates</option>
				<option value="Intershipper" #doSelected(ShipSettings.ShipType,'Intershipper')#>Multiple Shippers using Intershipper</option>
			</select>
			</td>	
		</tr>
		
		<tr>
			<td align="RIGHT">Offer In-Store Pickup?</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td><input type="radio" name="InStorePickup" value="1" #doChecked(ShipSettings.InStorePickup)# />Yes 
			&nbsp;<input type="radio" name="InStorePickup" value="0" #doChecked(ShipSettings.InStorePickup,0)# />No
			</td>	
		</tr>	
		
		<tr>
			<td align="RIGHT">Show Estimator?</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td><input type="radio" name="ShowEstimator" value="1" #doChecked(ShipSettings.ShowEstimator)# />Yes 
			&nbsp;<input type="radio" name="ShowEstimator" value="0" #doChecked(ShipSettings.ShowEstimator,0)# />No
			</td>	
		</tr>	
<tr><td colspan="3" class="formtextsmall">
Shows a shipping estimator in the shopping cart. Be sure your web server can handle the additional memory requirements for this! With automatic shipping rates, you will also notice a considerable speed difference on the shopping cart page as it will have to send a request out to retrieve rate information.
</td></tr>

		<tr>
			<td align="RIGHT">Show Freight?</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td><input type="radio" name="ShowFreight" value="1" #doChecked(ShipSettings.ShowFreight)# />Yes 
			&nbsp;<input type="radio" name="ShowFreight" value="0" #doChecked(ShipSettings.ShowFreight,0)# />No
			</td>	
		</tr>	
<tr><td colspan="3" class="formtextsmall">
If you use any freight prices on items in your store, this sets whether to show the charges separately to the customer, or to combine them with the shipping charges. 
</td></tr>

		<tr>
			<td align="RIGHT">Use Drop-Shippers?</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td><input type="radio" name="UseDropShippers" value="1" #doChecked(ShipSettings.UseDropShippers)# />Yes
			&nbsp;<input type="radio" name="UseDropShippers" value="0" #doChecked(ShipSettings.UseDropShippers,0)# />No
			</td>	
		</tr>	
<tr><td colspan="3" class="formtextsmall">
Sets whether to use drop-shipper addresses when calculating shipping rates. Generally only used with automatic shipping rates. Be sure to enter valid addresses for all your drop-shippers when using this setting! 
</td></tr>
			
		<tr>	
			<td align="RIGHT" class="formtitle"><br/>Base Rates&nbsp;</td>
			<td  colspan="2"><br/><cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/></td>
		</tr>
<tr><td colspan="3" class="formtextsmall">
Base rates are added to all orders requiring shipping. The Base Amount is a set fee added to the calculated shipping cost. The handling rate is a percentage of the item total added to the order. You can use either or both.
</td></tr>
		
		<tr>
			<td align="RIGHT">Base Amount:</td>
			<td></td>
			<td>
				<input type="text" name="ShipBase" value="#DecimalFormat(ShipSettings.ShipBase)#" size="8" maxlength="15" class="formfield"/> #Request.AppSettings.MoneyUnit#
			</td>	
		</tr>
	
		<tr>
			<td align="RIGHT">Handling Percentage:</td>
			<td></td>
			<td>
				<input type="text" name="ShipHand" value="#(ShipSettings.ShipHand * 100)#" size="8" maxlength="15" class="formfield"/> %
			</td>	
		</tr>	
		
		<tr>	
			<td align="RIGHT" class="formtitle"><br/>No Shipping&nbsp;</td>
			<td colspan="2"><br/><cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/></td>
		</tr>
	
<tr><td colspan="3" class="formtextsmall">
If online credit card processing is on, orders should generally not be accepted if shipping can not be calculated. This is generally caused by international orders. If allowed, the Customer Message will be displayed and no shipping cost will be added to the order.
</td></tr>

		<tr>
			<td align="right">Allow No Shipping:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td><input type="radio" name="AllowNoShip" value="1" #doChecked(ShipSettings.AllowNoShip)# />Yes 
			&nbsp;<input type="radio" name="AllowNoShip" value="0" #doChecked(ShipSettings.AllowNoShip,0)# />No</td>	
		</tr>

<tr><td colspan="3" class="formtextsmall"><br/>
If shipping cannot be calculated, the order will have a notation on it when displayed in the Administrator. Enter the message you wish to use. Do not use "No Shipping" as this is used for orders that do not have a shipping charge. 
</td></tr>

		<tr>
			<td align="right">Admin Message:</td>
			<td></td>
			<td><input type="text" name="NoShipType" value="#ShipSettings.NoShipType#" size="20" maxlength="50" class="formfield"/></td>	
		</tr>

<tr><td colspan="3" class="formtextsmall"><br/>
A custom message will be displayed to the customer if the shipping amount can not be calculated. This will generally be the policy for International Orders or some other message about how such orders are handled.
</td></tr>

		<tr>
			<td align="right" valign="top">Customer Message:</td>
			<td></td>
			<td><textarea cols="45" rows="8" name="NoShipMess" wrap="virtual" class="formfield">#NoShipMess#</textarea></td>	
		</tr>
		
		<cfinclude template="../../../includes/form/put_space.cfm">
		
		<tr>
			<td colspan="2"></td>
			<td><input type="submit" name="Submit_shipping" value="Save Changes" onclick="getSelectValue(this.form.ShipType);" class="formbutton"/>  <input type="button" name="back" value="Cancel" onclick="CancelForm();" class="formbutton"/>

			</td>	
		</tr>	
</form>			
		<cfinclude template="../../../includes/form/put_requiredfields.cfm">	
		
		<tr>	
			<td class="formtitle" align="right"><br/>Rate Calculation&nbsp;</td>
			<td colspan="2"><br/><cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/></td>
		</tr>
		
<tr><td colspan="3" class="formtextsmall">
<div class="formerror" align="center">Be sure to save your settings above before proceeding!</div><br/>
<cfif shipsettings.shiptype is "UPS">
To use UPS Shipping, first complete the UPS OnLine&reg; Tools Registration Wizard to register to use the UPS API. Configure your UPS Settings for your store, and be sure your unit of weight in the Store Settings is set to the same as your UPS setting for weight. Select the shipping methods you wish to offer on the Shipping Methods page.

<cfelseif shipsettings.shiptype is "USPS">
To use United States Postal Service Rates, be sure to sign up for an account at www.usps.com/webtools/ and configure your settings below. Also be sure your unit of weight in the Store Settings is set to pounds, and that you have filled in the Merchant Zip Code box. Otherwise, the shipping calculations will return incorrect amounts, or other errors. Please note that this tag uses an HTTP connection to get rates, and thus we cannot guarantee that a connection will always be established, nor can we guarantee that the correct rates will be returned. USPS shipping is only available for merchants in the USA.

<cfelseif shipsettings.shiptype is "Intershipper">
To use Intershipper Rates, be sure to sign up for an account at www.intershipper.com and configure your settings below. Please note that this tag uses an HTTP connection to get rates, and thus we cannot guarantee that a connection will always be established, nor can we guarantee that the correct rates will be returned.

<cfelseif shipsettings.shiptype is "FedEx">
To use FedEx<sup>&reg;</sup> Rates, be sure to sign up for an account at www.fedex.com and configure your settings below. Please note that this tag uses an HTTP connection to get rates, and thus we cannot guarantee that a connection will always be established, nor can we guarantee that the correct rates will be returned.

<cfelse>
Define your Custom Shipping Rates in the Shipping Table. You can also add a shipping surchage on a per country basis using the Country Rates table, or for additional shipping methods in the Shipping Methods section. These amounts are calculated before adding in the base rate and handling percentage.

</cfif>

		</td></tr>

		<tr>
			<td align="right" valign="top"></td>
			<td class="formtitle" colspan="3"><br/>
<ul>

<cfif NOT ListFind("UPS,USPS,FedEx,Intershipper", shipsettings.shiptype)>
	<li><a href="#self#?fuseaction=shopping.admin&shipping=customsettings#Request.Token2#">Custom Shipping Settings</a></li>
	<li><a href="#self#?fuseaction=shopping.admin&shipping=custom#Request.Token2#">Shipping Table</a></li>
	<li><a href="#self#?fuseaction=shopping.admin&shipping=country#Request.Token2#">Country Rates</a></li>
	<li><a href="#self#?fuseaction=shopping.admin&shipping=methods#Request.Token2#">Shipping Methods</a></li>
	<li><a href="#self#?fuseaction=shopping.admin&shipping=free#Request.Token2#">Free Shipping Promotion</a></li>

<cfelseif shipsettings.shiptype is "UPS">

	<!--- Check if registration has been completed yet --->
	<cfinclude template="ups/qry_ups_settings.cfm">
	
	<cfif NOT Request.DemoMode>
	<li><a href="#self#?fuseaction=shopping.admin&shipping=upswizard#Request.Token2#">UPS OnLine&reg; Tools Registration Wizard</a></li>
	<cfelse>
	<li><span class="formtext">The store is in test mode, <br/>UPS&reg; Registration not available.</span></li>
	</cfif>
		
	<cfif len(GetUPS.username) AND len(GetUPS.accesskey)>
		<li><a href="#self#?fuseaction=shopping.admin&shipping=ups#Request.Token2#">UPS Settings</a></li>
		<li><a href="#self#?fuseaction=shopping.admin&shipping=upsmethods#Request.Token2#">Shipping Methods</a></li>
		<li><a href="#self#?fuseaction=shopping.admin&shipping=free#Request.Token2#">Free Shipping Promotion</a></li>
  	</cfif>  
	
<cfelseif shipsettings.shiptype is "FedEx">

	<!--- Check if registration has been completed yet --->
	<cfinclude template="fedex/qry_fedex_settings.cfm">
	
	<cfif NOT Request.DemoMode>
	<li><a href="#self#?fuseaction=shopping.admin&shipping=fedexregister#Request.Token2#">FedEx Subscription Request</a></li>
	<cfelse>
	<li><span class="formtext">The store is in test mode, <br/>FedEx&reg; Subscription not available.</span></li>
	</cfif>
	<cfif len(GetFedEx.meternum)>
	<li><a href="#self#?fuseaction=shopping.admin&shipping=fedex#Request.Token2#">FedEx Settings</a></li>
	<li><a href="#self#?fuseaction=shopping.admin&shipping=fedex_methods#Request.Token2#">FedEx Shipping Methods</a></li>
<li><a href="#self#?fuseaction=shopping.admin&shipping=free#Request.Token2#">Free Shipping Promotion</a></li>
	</cfif>
	
<cfelseif shipsettings.shiptype is "Intershipper">
	<li><a href="#self#?fuseaction=shopping.admin&shipping=intershipper#Request.Token2#">Intershipper Settings</a></li>
	<li><a href="#self#?fuseaction=shopping.admin&shipping=intship_methods#Request.Token2#">Intershipper Shipping Methods</a></li>
<li><a href="#self#?fuseaction=shopping.admin&shipping=free#Request.Token2#">Free Shipping Promotion</a></li>

<cfelseif shipsettings.shiptype is "USPS">
	<li><a href="#self#?fuseaction=shopping.admin&shipping=usps#Request.Token2#">USPS Settings</a></li>
	<li><a href="#self#?fuseaction=shopping.admin&shipping=usps_methods#Request.Token2#">Shipping Methods</a></li>
	<li><a href="#self#?fuseaction=shopping.admin&shipping=free#Request.Token2#">Free Shipping Promotion</a></li>
</cfif>

		</ul>
		</td></tr>

</cfoutput>
</cfmodule>


<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
objForm = new qForm("editform");

objForm.required("InStorePickup,ShipBase,ShipHand,AllowNoShip,UseDropShippers");

objForm.InStorePickup.description = "in-store pickup";
objForm.ShipBase.description = "base amount";
objForm.ShipHand.description = "handling percentage";
objForm.AllowNoShip.description = "allow no shipping";

objForm.ShipBase.validateNumeric();
objForm.ShipHand.validateRange('0','99');

qFormAPI.errorColor = "<cfoutput>###Request.GetColors.formreq#</cfoutput>";
</script>
</cfprocessingdirective>
