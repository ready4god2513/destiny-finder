<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form for editing the payment settings for the store. Called by shopping.admin&payment=cards --->

<!--- Get list of credit cards --->
<cfquery name="GetCards" datasource="#Request.DS#" 
username="#Request.user#" password="#Request.pass#">
	SELECT * FROM #Request.DB_Prefix#CreditCards
</cfquery>


<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
<cfoutput>
 function CancelForm () {
	location.href = '#self#?fuseaction=home.admin&inframes=yes&redirect=yes#request.token2#';
	}
</cfoutput>		
 function offlinealert() {
 
 alert('Please note that this setting is for merchants that do not wish to accept normal credit card orders. Any credit card settings in the Payment Manager will be ignored when this is selected.');
}
</script>
</cfprocessingdirective>


<cfmodule template="../../../customtags/format_output_admin.cfm"
	box_title="Payment Manager"
	Width="550"
	menutabs="yes">

	
	<cfinclude template="dsp_menu.cfm">
	
<cfoutput>
	<table border="0" cellpadding="0" cellspacing="4" width="100%" class="formtext" style="color:###Request.GetColors.InputTText#">

	<!--- Add form ---->
	<form name="editform" action="#self#?fuseaction=shopping.admin&payment=cards#request.token2#" method="post">
	
		<tr>	
			<td align="RIGHT" class="formtitle"><br/>Offline Orders&nbsp;</td>
			<td colspan="2"><br/><cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/></td>
		</tr>
		<tr><td colspan="3" class="formtextsmall"><div style="margin: 10px;">Offline Orders allow your customers to complete the check-out process without requiring a credit card payment. Their Order Receipt will include a message instructing them how to send payment and complete their order. If using purchase orders, they will also have the option to enter a purchase order number to complete their order. </div>
		</td></tr>
		
		<tr>
			<td align="RIGHT">Offline Orders</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			<input type="radio" name="AllowOffline" value="1" #doChecked(get_Order_Settings.AllowOffline)# />Yes 
			&nbsp; <input type="radio" name="AllowOffline" value="0" #doChecked(get_Order_Settings.AllowOffline,0)# />No 
			</td>	
		</tr>
		
		<tr>
			<td align="RIGHT">Use Purchase Orders</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			<input type="radio" name="AllowPO" value="1" #doChecked(get_Order_Settings.AllowPO)# />Yes 
			&nbsp; <input type="radio" name="AllowPO" value="0" #doChecked(get_Order_Settings.AllowPO,0)# />No 
			</td>	
		</tr>
			
		<tr>
			<td align="RIGHT" valign="top">Offline Receipt Message </td>
			<td></td>
			<td>
			<textarea cols="40" rows="5" name="OfflineMessage" class="formfield">#get_Order_Settings.OfflineMessage#</textarea>
			</td>	
		</tr>
		
		<tr>	
			<td align="RIGHT" class="formtitle"><br/>PayPal Orders&nbsp;</td>
			<td colspan="2"><br/><cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/></td>
		</tr>
		<tr><td colspan="3" class="formtextsmall"><div style="margin: 10px;">These settings allow your customer to checkout through PayPal Standard using IPN. You must have a PayPal account and IPN enabled in your PayPal merchant area. You can use PayPal with offline and/or credit card orders or by itself. NOTE: If using PayPal Pro, fill these settings in so your IPN transactions will work, but leave the 'Use PayPal' turned off. </div>
		</td></tr>
		
		<tr>
			<td align="RIGHT">Use PayPal </td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			<input type="radio" name="UsePayPal" value="1" #doChecked(get_Order_Settings.UsePayPal)# />Yes 
			&nbsp; <input type="radio" name="UsePayPal" value="0" #doChecked(get_Order_Settings.UsePayPal,0)# />No 
			</td>	
		</tr>
		
		<tr>
			<td align="RIGHT" valign="baseline">PayPal Account</td>
			<td></td>
			<td>
			<input type="text" name="PayPalEmail" class="formfield" value="#get_Order_Settings.PayPalEmail#" size="30" maxlength="100"/>
			</td>	
		</tr>
		
		<tr>
			<td align="RIGHT">Log Messages:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td><input type="radio" name="PayPalLog" value="1" #doChecked(get_Order_Settings.PayPalLog)# />Yes 
			&nbsp; <input type="radio" name="PayPalLog" value="0" #doChecked(get_Order_Settings.PayPalLog,0)# />No 
			</td>	
		</tr> 

		<tr>	
			<td align="RIGHT" class="formtitle"><br/>CC Orders&nbsp;</td>
			<td colspan="2"><br/><cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/></td>
		</tr>
		<tr><td colspan="3" class="formtextsmall"><div style="margin: 10px;">These settings allow your customer to checkout using a credit card. This requires the use of a payment gateway to process the credit card data, as per PCI Compliance regulations (see docs for more info). After selecting the gateway, be sure to configure your settings on the Card Processing tab as well.</div>
		</td></tr>
		
		<tr>
			<td align="RIGHT">Use Credit Cards </td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			<input type="radio" name="OnlyOffline" value="0" #doChecked(get_Order_Settings.OnlyOffline,0)# />Yes 
			&nbsp; <input type="radio" name="OnlyOffline" value="1" #doChecked(get_Order_Settings.OnlyOffline)# />No 
			</td>	
		</tr>
				
	
		<tr>
			<td align="RIGHT">Online Processer </td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			<select name="CCProcess" size="1" class="formfield">
			<option value="None" #doSelected(get_Order_Settings.CCProcess,'None')#>None</option>
			<option value="AuthorizeNet3" #doSelected(get_Order_Settings.CCProcess,'AuthorizeNet3')#>Authorize.Net</option>
			<!--- <option value="BankofAmerica" #doSelected(get_Order_Settings.CCProcess,'BankofAmerica')#>Bank of America eStore</option> --->
			<option value="CyberSource" #doSelected(get_Order_Settings.CCProcess,'CyberSource')#>CyberSource</option>
	  	 	<option value="LinkPoint" #doSelected(get_Order_Settings.CCProcess,'LinkPoint')#>LinkPoint</option>
	  	 	<option value="PayFlowPro" #doSelected(get_Order_Settings.CCProcess,'PayFlowPro')#>PayFlow Pro (CFX)</option>
			<option value="PayFlowPro4" #doSelected(get_Order_Settings.CCProcess,'PayFlowPro4')#>PayFlow Pro (HTTPS)</option>
			<option value="PayPalPro" #doSelected(get_Order_Settings.CCProcess,'PayPalPro')#>PayPal Payments Pro</option>
			<option value="Shift4OTN" #doSelected(get_Order_Settings.CCProcess,'Shift4OTN')#>Shift4</option>
			<option value="Skipjack" #doSelected(get_Order_Settings.CCProcess,'Skipjack')#>Skipjack</option>
			<option value="SkyPay" #doSelected(get_Order_Settings.CCProcess,'SkyPay')#>SkyPay</option>
			<option value="USAepay" #doSelected(get_Order_Settings.CCProcess,'USAepay')#>USAepay</option>	
			</select>
			<cfif Request.DemoMode>
			<tr><td colspan="2"></td><td class="formtextsmall">
			Store is in demo mode, this selection cannot be modified.
		</td></tr>
			</cfif>
			</td>	
		</tr>		
			
		<tr>
			<td align="RIGHT" valign="top">Cards Accepted </td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			<select name="CreditCards" size="5" multiple="multiple" class="formfield">
			<cfloop query="GetCards">
			<option value="#ID#" #doSelected(GetCards.Used)#>#CardName#</option>
			</cfloop></select>
			</td>	
		</tr>

<!--- Use CVV2? ---->
		<tr>
			<td align="RIGHT" valign="top"><br/>Use CVV2</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td valign="top"><br/>
			<input type="radio" name="usecvv2" value="1" #doChecked(get_Order_Settings.usecvv2)# />Yes 
			&nbsp; <input type="radio" name="usecvv2" value="0" #doChecked(get_Order_Settings.usecvv2,0)# />No 
			<br/>&nbsp;</td>	
		</tr>
			
<!--- save cc info in database? ---->
		<tr>
			<td align="RIGHT">Store Card Info</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			<input type="radio" name="storecardinfo" value="1" #doChecked(get_Order_Settings.storecardinfo)# />Yes 
			&nbsp; <input type="radio" name="storecardinfo" value="0" #doChecked(get_Order_Settings.storecardinfo,0)# />No 
			</td>	
		</tr>
		<tr><td colspan="3" class="formtextsmall">
<font color="FF0000"><div style="margin: 10px;">This setting is only available for processors using tokens (currently Shift4 only) due to PCI compliance regulations. CVV2 info is never stored, as this is not allowed under any circumstances.</div>
</td></tr>
		
<!--- Use billing tab feature --->
		<tr>
			<td align="RIGHT">Use Billing Tab</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			<input type="radio" name="UseBilling" value="1" #doChecked(get_Order_Settings.UseBilling)# />Yes 
			&nbsp; <input type="radio" name="UseBilling" value="0" #doChecked(get_Order_Settings.UseBilling,0)# />No 
			</td>	
		</tr>
		<tr><td colspan="3" class="formtextsmall"><div style="margin: 10px;">The Billing Tab is used if you authorize when the order is placed and capture funds later, orders will be marked as not paid until captured.</div>
</td></tr>
		 
	
	<cfinclude template="../../../includes/form/put_space.cfm">
	
		<tr>
			<td colspan="2"></td>
			<td><input type="submit" name="Submit_cards" value="Save" class="formbutton"/> 	
			 <input type="button" name="Cancel" value="Cancel" onclick="CancelForm();" class="formbutton"/>
			</td>	
		</tr>	
		
		<cfinclude template="../../../includes/form/put_requiredfields.cfm">
	</form>
	</table>
</cfoutput>
</cfmodule>

<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
objForm = new qForm("editform");

objForm.required("CreditCards");

<cfif Request.DemoMode>
objForm.CCProcess.locked = true;
</cfif>

qFormAPI.errorColor = "<cfoutput>###Request.GetColors.formreq#</cfoutput>";
</script>
</cfprocessingdirective>
