
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template is used to run SkyPay credit card validation
	  The currency default is POUND STERLING.
	  Variables passed in: CardNumber, Expiration, Month, Year, CCType, NameonCard,CVV2  
--->

<!--- Called from checkout/act_pay_form.cfm --->

<!--- Initialize variables --->
<cfparam name="attributes.CVV2" default="">


<!--- Retrive SkyPay settings:
		MerchantNo (Skypay Merchant ID) =  GetSettings.Username
		Dispatch (NOW or LATER) = GetSettings.Transtype 
		AVSCV2Check (YES or NO) = GetSettings.Setting1.  CV2 is passed if provided
 --->
<cfquery name="GetSettings" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
SELECT Transtype, Username, Setting1 FROM #Request.DB_Prefix#CCProcess
</cfquery>

<!--- Address is used by the AVS system --->
<cfset Address = "#GetCustomer.Address1# #GetCustomer.Address2# #GetCustomer.City# #GetCustomer.State2#">

<!--- Card type: VM = Visa/MS, S = Switch  Switch is not currently being supported. --->
<cfset CCardType = "VM">

<!--- The currency default is POUND STERLING. Amount is in minor currency (i.e. pence) so multiply amount by 100. No decimal places are allowed in amount field. --->
<cfset amount = evaluate(GetTotals.OrderTotal * 100)>

<cfset randomnum = RandRange(1000,9999)>
<cfset InvoiceNum = Replace(CGI.REMOTE_ADDR,".","","ALL") & randomnum>


<cfscript>
	// optional attributes for potential future use
	issuenum = IIF(IsDefined('attributes.issuenum'), 'attributes.issuenum', DE(""));
	startmonth = IIF(IsDefined('attributes.startmonth'), 'attributes.startmonth', DE(""));
	startyear = IIF(IsDefined('attributes.startyear'), 'attributes.startyear', DE(""));
</cfscript>


<cftry>

	<!------ use cfhttp to post to skypay gateway ------->
	<cfhttp url="https://secure.skypay.co.uk/authorise/secure_auth.php" method="post">
		<cfhttpparam type="FORMFIELD" name="CardNumber" value="#attributes.CardNumber#">
		<cfhttpparam type="FORMFIELD" name="ExpiryMonth" value="#Month#">
		<cfhttpparam type="FORMFIELD" name="ExpiryYear" value="#Year#">
		<cfhttpparam type="FORMFIELD" name="CardType" value="#CCardType#">
		<cfhttpparam type="FORMFIELD" name="Name" value="#attributes.NameonCard#">
		
		<cfhttpparam type="FORMFIELD" name="AVSCV2Check" value="#GetSettings.Setting1#">
		<cfhttpparam type="FORMFIELD" name="Address" value="#Address#">
		<cfhttpparam type="FORMFIELD" name="Postcode" value="#GetCustomer.Zip#">
		
		<cfif issuenum neq ''>
			<cfhttpparam type="FORMFIELD" name="Issue" value="#issue#">
		</cfif>
		
		<cfhttpparam type="FORMFIELD" name="Amount" value="#amount#">
		<cfhttpparam type="FORMFIELD" name="MerchantNo" value="#GetSettings.Username#">
		<cfhttpparam type="FORMFIELD" name="Order" value="#InvoiceNum#">
		<cfhttpparam type="FORMFIELD" name="Dispatch" value="#GetSettings.Transtype#">
							
		<cfif CVV2 neq ''>
			<cfhttpparam type="FORMFIELD" name="CV2" value="#attributes.CVV2#">
		</cfif>
		<cfif startmonth neq ''>
			<cfhttpparam type="FORMFIELD" name="StartMonth" value="#startmonth#">
		</cfif>
		<cfif startyear neq ''>
			<cfhttpparam type="FORMFIELD" name="StartYear" value="#startyear#">
		</cfif>
		
	</cfhttp>

	<cfset Result = cfhttp.fileContent>
	
<cfcatch>
		
	<cfset Result= "ERROR">
			
 </cfcatch>
	
</cftry>

<!--- Debugging Code - uncomment this code below if you are having problems. It will list out the variables sent to SkyPay and the SkyPay response.
<cfoutput>
CardNumber = #CardNumber#<br/>
ExpiryMonth = #Month#<br/>
ExpiryYear = #Year#<br/>
CardType = #CCardType#<br/>
Name = #NameonCard#<br/>
AVSCV2Check = #GetSettings.Setting1#<br/>
Address = #Address#<br/>
Postcode = #GetCustomer.Zip#<br/>
Amount = #amount#<br/>
MerchantNo = #GetSettings.Username#<br/>
Order = #InvoiceNum#<br/>
Dispatch = #GetSettings.Transtype#<br/>
<cfif CVV2 neq ''>
CV2 = #CVV2#<br/>
</cfif><br/>
</cfoutput>
<cfdump var="#Result#"> 
--->


<!--- Result is a comma delimted list of the following:
	1) "FAILED" or "SUCCESSFUL" or "ERROR"
	2) error_code_message or authorization_code,
	3) skypay cross reference number 
	4) blank or avs result --->


<!--- If there was a connection ERROR ---->
<cfif result is "ERROR">
  <cfset ErrorMessage = "A connection error has occured. Please wait 10 minutes and try again or place your order offline.">
  <cfset display = "Yes">
  <cfset CompOrder = "Complete Order">

<cfelseif listfirst(Result) is "SUCCESSFUL">
  <cfset AuthNumber = ListGetAt(Result,"2")>
  <cfset TransactNum = ListGetAt(Result,"3")>
  <cfif listlen(Result) gt 3>
  	<cfset Notes = ListGetAt(Result,"4")>
  </cfif>
  <cfset attributes.step = "receipt">

<!--- If FAILED ---->
<cfelse>
  <cfset ErrorMessage =  "AUTHORIZATION FAILED - " & ListGetAt(Result,"2")>
  <cfset display = "Yes">
  <cfset CompOrder = "Complete Order">

</cfif>
		

			