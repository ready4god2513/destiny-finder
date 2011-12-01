
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template displays the checkout payment options, with the form to enter credit card information (if available). Called by shopping.checkout (step=payment) 
-------->

<cfinclude template="../../users/qry_get_user_settings.cfm">

<cfquery name="GetUserCard" datasource="#Request.DS#" 
username="#Request.user#" password="#Request.pass#" maxrows=1>
	SELECT CardisValid, CardNumber, CardExpire, CardType
	FROM #Request.DB_Prefix#Users
	WHERE User_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#Session.User_ID#">
</cfquery>

<!--- Check for any trial memberships --->
<cfquery name="CheckTrials" dbtype="query">
	SELECT Recur_Product_ID FROM qry_Get_Basket
	WHERE Recur_Product_ID IS NOT NULL
	AND Recur_Product_ID > 0
</cfquery>

<cfset Trial = CheckTrials.RecordCount>

<!--- Set defaults --->
<cfscript>
//Set defaults
	show_cc = 0;
	show_billcard = 0;
	show_billcardupdate = 0;
	show_paypal = 0;
	show_ppexpress = 0;
	show_offline = 0;
	show_PO = 0;
	noPayment = 0;
	
//Determine which payment options to display
	if (total is 0 AND NOT Trial) 
		noPayment = 1;
		
	else if (get_Order_Settings.CCProcess IS "PayPalPro" AND isDefined("Session.PP_Token")) 
		show_ppexpress = 1;
	else if (get_Order_Settings.CCProcess IS "PayPalPro")
		show_cc = 1;
	else if (get_order_settings.OnlyOffline IS 0)
		show_cc = 1;
		
	if (get_Order_Settings.UsePayPal AND NOT isDefined("Session.PP_Token") AND (Total IS NOT 0 OR (Trial AND NOT show_cc)))
		show_paypal = 1;
		
	if (get_order_settings.AllowOffline AND NOT isDefined("Session.PP_Token") AND Total IS NOT 0) 
		show_offline = 1;
		
	if (get_Order_Settings.AllowPO AND NOT isDefined("Session.PP_Token") AND Total IS NOT 0)
		show_PO = 1;
		
	//if showing credit card, see if the bill card option is available
	if (show_cc AND get_User_Settings.useCCard AND get_Order_Settings.CCProcess IS "Shift4OTN" AND NOT isDefined("Session.PP_Token") ) {
		show_billcardupdate = 1;
		if (len(GetUserCard.cardNumber) AND GetUserCard.CardisValid is 1 AND DateCompare(ParseDateTime(GetUserCard.CardExpire),now(),'m') is 1)
			show_billcard = 1;
	}
		
	numtypes = noPayment + show_cc + show_billcard + show_paypal + show_ppexpress + show_offline + show_PO;
	typecount = 0;
</cfscript>


<!--- Express Checkout - designed for membership checkouts, it bills the card stored in the user record. ----->
<!--- <cfif attributes.fuseaction is "shopping.express">
	
	<!--- If card is expired OR bad OR does not exist, update ---->
	<cfif len(GetUserCard.cardNumber) AND GetUserCard.CardisValid is 1 AND DateCompare(GetUserCard.CardExpire,now(),'m') is 1>
		<cfset show_cc = 0>
		<cfset show_paypal = 0>
		<cfset show_ppexpress = 0>
		<cfset show_offline = 0>
		<cfset purchaseorder = 0>
		<cfset typecount = 0>
			
		<cfmodule template="../../customtags/format_input_form.cfm"
		box_title="Complete Order"
		width="370"
		required_fields = "0">
		<cfoutput>
		<tr>
			<td align="center" >
			<form action="#XHTMLFormat('#request.self#?fuseaction=shopping.checkout&step=payment#request.token2#')#" method="post" name="expressform" id="editform" class="margins">
			<input type="hidden" name="Offline" value="BillUser"/>
   	 		<p class="formtitle">Charge to my #GetUserCard.CardType# Card<br/>number #GetUserCard.CardNumber#</p>
			<div align="center"><input type="submit" name="SubmitPayment" value="Complete Order" class="formbutton"/>
			<input type="submit" name="CancelForm" value="Cancel" class="formbutton"/></div>
			</form></td>
		</tr>
		</cfoutput></cfmodule>	
	</cfif>
</cfif> --->
<!--- end custom code ----->

<table width="650" border="0" cellpadding="5" cellspacing="0" class="formtext" align="center">
<tr>
<!--- Do not move any code ABOVE this line. You can rearrange any of the payment options below here as you like. --->

<!--- noPayment: No Payment Due -- if cart total is $0 --->
<cfif noPayment>
	<cfset typecount = typecount + 1>
	<cfif typecount MOD 2 IS 1><tr></cfif>
	<cfoutput><td valign="top" width="#iif(numtypes IS 1, DE('100%'), DE('50%'))#" align="center"></cfoutput>
	<cfmodule template="../../customtags/format_input_form.cfm"
	box_title="Complete Order"
	width="#iif(numtypes IS 1, DE('50%'), DE('100%'))#"
	required_fields = "0"
	><cfoutput>
		<tr><td align="center" >
		<form action="#XHTMLFormat('#request.self#?fuseaction=shopping.checkout&step=receipt#Request.Token2#')#" 
		method="post" name="offline" class="margins">
		<input type="hidden" name="Offline" value="Pay Offline"/>
   		<p class="formtitle">Order total is #LSCurrencyFormat(0)#, no payment due.</p>
		<input type="submit" name="SubmitPayment" value="Complete Order" class="formbutton"/>
		<input type="submit" name="CancelForm" value="Cancel" class="formbutton"/>
		</form></td></tr>
	</cfoutput></cfmodule>
	</td>
	<cfif typecount MOD 2 IS 0></tr></cfif>
</cfif>
<!--- End no payment --->


<!--- Paypal Express --->
<cfif show_ppexpress>
	<cfset typecount = typecount + 1>
	<cfif typecount MOD 2 IS 1><tr></cfif>
	<cfoutput><td valign="top" width="#iif(numtypes IS 1, DE('100%'), DE('50%'))#" align="center"></cfoutput>
	<cfmodule template="../../customtags/format_input_form.cfm"
	box_title="Complete PayPal Checkout"
	width="#iif(numtypes IS 1, DE('50%'), DE('100%'))#"
	required_fields = "0"
	>
	<cfinclude template="paypal/put_completeexpress.cfm">
	</cfmodule>	
	</td>
	<cfif typecount MOD 2 IS 0></tr></cfif>
</cfif> 


<!--- custom Code: Bill to card on file ----->
<cfif show_billcard>
	<cfset typecount = typecount + 1>
	<cfif typecount MOD 2 IS 1><tr></cfif>
	<cfoutput><td valign="top" width="#iif(numtypes IS 1, DE('100%'), DE('50%'))#" align="center"></cfoutput>
	<cfmodule template="../../customtags/format_input_form.cfm"
	box_title="Bill Card on File"
	width="#iif(numtypes IS 1, DE('50%'), DE('100%'))#"
	required_fields = "0"
	><cfoutput>
	<tr>
		<td align="center">
		<form action="#XHTMLFormat('#request.self#?fuseaction=shopping.checkout&step=payment#request.token2#')#" method="post"
		 name="billcard" class="margins">
		 <input type="hidden"  name="Offline" value="BillUser"/>
			Charge my #GetUserCard.CardType# Card on file<br/>
			with number ending in '#right(GetUserCard.cardNumber,4)#'<br/><br/>
			<input type="submit" name="SubmitPayment" value="Complete Order" class="formbutton"/>
			<input type="submit" name="CancelForm" value="Cancel" class="formbutton" />		
			</form>		
			</td>
		</tr>		
	</cfoutput>
	</cfmodule>
	</td>
	<cfif typecount MOD 2 IS 0></tr></cfif>
</cfif>
<!--- End Bill Card --->	


<!--- Paypal --->
<cfif show_paypal>
	<cfset typecount = typecount + 1>
	<cfif typecount MOD 2 IS 1><tr></cfif>
	<cfoutput><td valign="top" width="#iif(numtypes IS 1, DE('100%'), DE('50%'))#" align="center"></cfoutput>
	<cfmodule template="../../customtags/format_input_form.cfm"
	box_title="Pay by PayPal"
	width="#iif(numtypes IS 1, DE('50%'), DE('100%'))#"
	required_fields = "0"
	>
		<!--- Use full shopping cart PayPal module if no order discounts or credits --->
		<cfif GetTempOrder.OrderDisc IS 0 AND GetTempOrder.Credits IS 0>
			<cfinclude template="paypal/put_paypal_cart.cfm">
		<cfelse>
			<cfinclude template="paypal/put_paypal.cfm">
		</cfif>
	</cfmodule>	
	</td>
	<cfif typecount MOD 2 IS 0></tr></cfif>
</cfif>
<!--- End PayPal Button --->


<!--- Online - credit card processing --->
<cfif show_cc>
	<cfset typecount = typecount + 1>
	<cfif typecount MOD 2 IS 1><tr></cfif>
	<cfoutput><td valign="top" width="#iif(numtypes IS 1, DE('100%'), DE('50%'))#" align="center"></cfoutput>
	<cfparam name="attributes.CardType" default="">
	<cfparam name="attributes.NameonCard" default="#GetCustomer.FirstName# #GetCustomer.LastName#">
	<cfparam name="attributes.CardNumber" default="">
	<cfparam name="attributes.Month" default="">
	<cfparam name="attributes.Year" default="">
	<cfparam name="attributes.UpdateCC" default="">

	<cfquery name="GetCards" datasource="#Request.DS#" username="#Request.user#" 
	password="#Request.pass#">
	SELECT CardName FROM #Request.DB_Prefix#CreditCards
	WHERE USED = 1
	</cfquery>
		
	<cfoutput>
	<form action="#XHTMLFormat('#request.self#?fuseaction=shopping.checkout&step=payment#request.token2#')#" method="post" name="editform" id="editform">

	<cfmodule template="../../customtags/format_input_form.cfm"
	box_title="Pay by Credit Card"
	width="#iif(numtypes IS 1, DE('50%'), DE('100%'))#"
	required_fields = "1"
	>
	
	<cfinclude template="../../users/formfields/put_ccard.cfm">	
	
	<tr><td colspan="3">
	<img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="3" width="1" /></td></tr>

	<cfif Val(Session.User_ID) NEQ 0>
		<cfinclude template="../../users/qry_get_user_extended_settings.cfm">
		<cfif get_User_Extended_Settings.UserCCardOnTheFlyUpdate>
			<tr>
				<td colspan="2">&nbsp;</td>
				<td><input name="UpdateCC" type="checkbox" value="YES" <cfif attributes.UpdateCC is "YES">checked </cfif>/>Save/Update card on file
				<br/>&nbsp;</td>
			</tr>
		</cfif>
	</cfif>
	<tr>
		<td>&nbsp;</td>
		<td colspan="2"><input type="submit" name="SubmitPayment" value="Complete Order" class="formbutton"/>
		<input type="submit" name="CancelForm" value="Cancel" class="formbutton" onclick="noValidation();"/>
		<br/>&nbsp;</td>
	</tr>
	</cfmodule>
	</form>

<cfprocessingdirective suppresswhitespace="No">
<script type="text/javascript">
<!--
objForm = new qForm("editform");
objForm.required("nameoncard,CardNumber<cfif get_Order_Settings.usecvv2>,CVV2</cfif>");

objForm.nameoncard.description = "Name on Card";
objForm.CardNumber.description = "card number";
<cfif get_Order_Settings.usecvv2>objForm.CVV2.description = "cvv2";</cfif>

objForm.CardNumber.validateCreditCard();
<cfif get_Order_Settings.usecvv2>objForm.CVV2.validateNumeric();</cfif>

qFormAPI.errorColor = "###Request.GetColors.formreq#";

function noValidation() {
	objForm._skipValidation = true;
}
//-->
</script>
</cfprocessingdirective>
	
	</cfoutput>
	</td>
	<cfif typecount MOD 2 IS 0></tr></cfif>
</cfif>
<!--- End Credit Card Payment --->

<!--- Purchase Order - purchase using an account number --->
<cfif show_PO>	
	<cfset typecount = typecount + 1>
	<cfif typecount MOD 2 IS 1><tr></cfif>
	<cfoutput><td valign="top" width="#iif(numtypes IS 1, DE('100%'), DE('50%'))#" align="center"></cfoutput>
	<cfmodule template="../../customtags/format_input_form.cfm"
	box_title="Purchase Order"
	width="#iif(numtypes IS 1, DE('50%'), DE('100%'))#"
	required_fields = "0"
	>
	<tr>
		<td>
		<cfoutput>
		<form action="#XHTMLFormat('#request.self#?fuseaction=shopping.checkout&step=payment#Request.Token2#')#" method="post" name="PurchaseOrder" class="margins">
		</cfoutput>
		If you have a purchase order on file with us, enter the number to complete the checkout process. 
		Your PO number will be validated before the order is filled.<br/><br/>
		<div align="center">
		<strong>PO Number:</strong> 
		<input type="text" name="PO_Number" size="20" maxlength="30" class="formfield" value=""/><br/><br/>
		<input type="submit" name="SubmitPayment" value="Complete Order" class="formbutton"/>
		<input type="submit" name="CancelForm" value="Cancel" class="formbutton" onclick="noValidation();"/>
		<input type="hidden" name="Offline" value="Purchase Order"/><br/>
		</div>		
		</form>
		</td>
	</tr>
	</cfmodule>	
	
	<cfprocessingdirective suppresswhitespace="No">
	<script type="text/javascript">
	<!--
	objForm2 = new qForm("PurchaseOrder");
	objForm2.required("PO_Number");
	
	objForm2.PO_Number.description = "purchase order number";
	
	qFormAPI.errorColor = <cfoutput>"###Request.GetColors.formreq#";</cfoutput>
	
	function noValidation() {
		objForm2._skipValidation = true;
	}
	//-->
	</script>
	</cfprocessingdirective>
	</td>
	<cfif typecount MOD 2 IS 0></tr></cfif>
</cfif>
<!--- End Purchase Order --->

<!--- Offline - on account or by check/fax --->
<cfif show_offline>	
	<cfset typecount = typecount + 1>
	<cfif typecount MOD 2 IS 1><tr></cfif>
	<cfoutput><td valign="top" width="#iif(numtypes IS 1, DE('100%'), DE('50%'))#" align="center"></cfoutput>
	<cfmodule template="../../customtags/format_input_form.cfm"
	box_title="Offline Payment"
	width="#iif(numtypes IS 1, DE('50%'), DE('100%'))#"
	required_fields = "0"
	>
	<tr>
		<td>
		<cfoutput>
		<form action="#XHTMLFormat('#request.self#?fuseaction=shopping.checkout&step=payment#Request.Token2#')#" method="post" name="Offline" class="margins">
		</cfoutput>
		If you would like to pay for your order offline, press the button below and print out your receipt. 
		You will be given your Order Number, and your order will be saved to our system. Call or FAX us your 
		credit card number, or mail in your order with a check or money order (be sure to give us your order 
		number at the same time), and your order will be shipped right away!<br/><br/>
		<div align="center">
			<input type="submit" name="SubmitPayment" value="Complete Order" class="formbutton"/>
			<input type="submit" name="CancelForm" value="Cancel" class="formbutton" />
			<input type="hidden" name="Offline" value="Pay Offline"/><br/>
		</div>
		</form>
		</td>
	</tr>
	</cfmodule>	
	</td>
	<cfif typecount MOD 2 IS 0></tr></cfif>
</cfif>
<!--- End Offline Payment --->


<!--- Do not move the code below this line --->

<!--- If total number of types is odd, add an empty table cell --->
<cfif numtypes MOD 2 IS 1>
<td></td></tr>
</cfif>

</table>