
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page completes the PayPal Website Payments Express Checkout process. Sends the SOAP request to PayPal and gets a return response to complete the checkout. Called from checkout/do_checkout.cfm --->

<!--- Retrive PayPal Website Payments Pro settings --->

<cfquery name="GetSettings" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
	SELECT CCServer, Password, Setting1, Transtype, Username 
	FROM #Request.DB_Prefix#CCProcess
</cfquery>

<!--- Get Order Totals --->
<cfquery name="GetTotals" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT * FROM #Request.DB_Prefix#TempOrder 
	WHERE BasketNum = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.BasketNum#">
</cfquery>

<cfset attributes.token = Session.PP_Token>
<cfset attributes.PayerID = Session.PayerID>

<CF_PPExpressComplete
	STRUCTNAME="Results"
	USERNAME="#GetSettings.Username#"
    PASSWORD="#GetSettings.Password#"
	SERVER="#GetSettings.CCServer#"
	SIGNATURE="#GetSettings.Setting1#"
	TOKEN="#attributes.token#"
	PAYERID="#attributes.PayerID#"
	ORDERTOTAL="#GetTotals.OrderTotal#"
	TRANSTYPE="#GetSettings.Transtype#">
			  
			  
<!--- DEBUG 
<cfoutput><h1>#Results.response_code#</h1></cfoutput> 
----->

<cfif Results.Success IS NOT "1">
	<cfset Message = Results.errormessage>    
	<cfset attributes.step = "address">

<cfelse>
	<!--- <cfdump var="#Results#"> --->

	<cfscript>
	//Complete the order
	attributes.step = "receipt";
	PayPal = 'Yes';
	PayPalStatus = Results.PaymentStatus;
	PendingReason = Results.PendingReason;
	if (PayPalStatus IS "Completed")
		Confirmed = 1;
	TransactNum = Results.transactionID;
	</cfscript>		
	
	<cfinclude template="act_pending.cfm">
	
</cfif>


