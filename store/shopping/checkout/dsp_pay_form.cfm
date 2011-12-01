<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used when there is a problem with the credit card information, displays the error and prompts for the information to be entered again. Called by shopping.checkout (step=payment) --->

	<cfquery name="GetCustomer" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT FirstName, LastName 
	FROM #Request.DB_Prefix#TempCustomer 
	WHERE TempCust_ID = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.BasketNum#">
	</cfquery>

	<cfparam name="errormessage" default="">
	<cfparam name="attributes.CardType" default="">
	<cfparam name="attributes.NameonCard" default="#GetCustomer.FirstName# #GetCustomer.LastName#">
	<cfparam name="attributes.CardNumber" default="">
	<cfparam name="attributes.Month" default="">
	<cfparam name="attributes.Year" default="">

	<cfquery name="GetCards" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT CardName FROM #Request.DB_Prefix#CreditCards
	WHERE USED = 1
	</cfquery>
	
<cfoutput>
<form action="#XHTMLFormat('#self#?fuseaction=shopping.checkout&step=payment#request.token2#')#" method="post" name="editform" id="editform">
</cfoutput>
<input type="hidden" name="step" value="shipto"/>

<cfmodule template="../../customtags/format_input_form.cfm"
box_title="Payment by Credit Card"
width="380"
>
	<cfif len(ErrorMessage)>
	<tr>
		<td colspan="3" align="center" class="formerror"><br/><cfoutput>#ErrorMessage#</cfoutput><br/><br/></td></tr>
	</cfif>		

	<cfinclude template="../../users/formfields/put_ccard.cfm">		

<cfoutput>
	<tr><td colspan="3">
	<img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="3" width="1" /></td></tr></cfoutput>

	<tr>
	<td colspan="2"></td>
	<td><input type="submit" name="SubmitPayment" value="Complete Order" class="formbutton"/>
		<input type="submit" name="CancelForm" value="Cancel" class="formbutton" onclick="noValidation();"/>
		</td></tr>

</cfmodule>

</form>

<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
<!--//
// initialize the qForm object
objForm = new qForm("editform");

// make these fields required
objForm.required("nameoncard,CardNumber<cfif get_Order_Settings.usecvv2>,CVV2</cfif>");

<cfif get_Order_Settings.usecvv2>objForm.CVV2.description = "card check code";</cfif>
objForm.nameoncard.description = "name on card";
objForm.CardNumber.description = "card number";

objForm.CardNumber.validateCreditCard();
<cfif get_Order_Settings.usecvv2>objForm.CVV2.validateNumeric();</cfif>

qFormAPI.errorColor = "<cfoutput>###Request.GetColors.formreq#</cfoutput>";

function noValidation() {
	objForm._skipValidation = true;
}
//-->
</script>
</cfprocessingdirective>

