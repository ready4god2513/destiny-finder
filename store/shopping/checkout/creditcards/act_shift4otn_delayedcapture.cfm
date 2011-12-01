
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template is used to run Shift4 $$$ ON THE NET credit card validation. Called from checkout/act_pay_form.cfm --->

<cfset Vendor="CFWebstore6">

<!--- Retrieve $$$ ON THE NET settings --->
<cfinclude template="qry_get_Shift4OTN_Settings.cfm">

<!--- see if "Gift Cards" are a valid payment method --->
<cfquery name="qGetCards" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT CardName FROM #Request.DB_Prefix#CreditCards
	WHERE Used=1 and CardName like 'Gift%'
</cfquery>
<cfset GCEnabled=qGetCards.RecordCount GT 0>

<!--- Look up the Order Info --->
<cfquery name="GetOrderTx" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
	SELECT Order_No, AuthNumber, OrderTotal, Notes, TransactNum
	FROM #Request.DB_Prefix#Order_No
	WHERE Order_No = <cfqueryparam value="#attributes.Order_no#" cfsqltype="CF_SQL_INTEGER"> 
	AND AuthNumber <> '0'
	AND Paid=0
	AND Void=0
</cfquery>

<!--- if record found, process the payment --->
<cfif GetOrderTx.recordcount is 1>
	<cfset parms=Replace(GetOrderTx.TransactNum,",,",", ,","ALL")>
	<cfif ListLen(parms) GTE 5>
		<cfset InvoiceNum=Trim(ListGetAt(parms,1))>
		<cfset CardNumLast4=Trim(ListGetAt(parms,2))>
		<cfset TranID=Trim(ListGetAt(parms,3))>
		<cfset PrimaryAmount=Val(ListGetAt(parms,4))>
		<cfset SplitTender=ListGetAt(parms,5) is not "NO">
		<cfif Len(TranID) EQ 16>
			<cfset UniqueID=TranID>
			<cfset TranID=0>
		<cfelse>
			<cfset UniqueID="">
			<cfset TranID=Val(TranID)>
		</cfif>
	<cfelse>
		<cfset InvoiceNum=Trim(ListGetAt(parms,1))>
		<cfset UniqueID=Trim(ListGetAt(parms,2))>
		<cfset PrimaryAmount=Val(ListGetAt(parms,3))>
		<cfset SplitTender=ListLen(parms) EQ 4 and ListGetAt(parms,4) is "YES">
		<cfset Vendor=Vendor & "_TOK">
		<cfset TranID=0>
	</cfif>
	<cfif PrimaryAmount EQ 0>
		<cfset PrimaryAmount=Val(GetOrderTx.OrderTotal)>
	</cfif>

	<cf_CreateCRLFList result="HTMLText" options="TRIM">
		<cfmodule template="../../order/put_order.cfm" Order_No="#attributes.Order_no#" Type="Admin">
	</cf_CreateCRLFList>

	<cfif UniqueID is not "" or Val(TranID) NEQ 0>
		<!--- first try with the tranid --->
		<cf_Shift4OTN
			Result="OTN"
			URL="#get_Shift4OTN_Settings.URL#"
			ProxyServer="#get_Shift4OTN_Settings.ProxyServer#"
			ProxyPort="#get_Shift4OTN_Settings.ProxyPort#"
			ProxyUsername="#get_Shift4OTN_Settings.ProxyUsername#"
			ProxyPassword="#get_Shift4OTN_Settings.ProxyPassword#"
			SerialNumber="#get_Shift4OTN_Settings.SerialNumber#"
			Username="#get_Shift4OTN_Settings.Username#"
			Password="#get_Shift4OTN_Settings.Password#"
			FunctionRequestCode="06"
			MerchantID="#get_Shift4OTN_Settings.MID#"
			Invoice="#InvoiceNum#"
			TranID="#TranID#"
			UniqueID="#UniqueID#"
			SaleFlag = "S"
			PrimaryAmount="#PrimaryAmount#"
			SecondaryAmount="0.00"
			Notes="#HTMLText#"
			APIOptions="ALLDATA"
			Vendor="#Vendor#">
		<cfoutput>
		<!--- Debug --->
		<!--- <cfdump var="#OTN#"> --->
		</cfoutput>
	</cfif>

	<cfif UniqueID is "" and (TranID EQ 0 or OTN.ErrorIndicator is "Y")>
		<!--- try again, this time with the last 4 digits of the card number --->
		<cf_Shift4OTN
			Result="OTN"
			URL="#get_Shift4OTN_Settings.URL#"
			ProxyServer="#get_Shift4OTN_Settings.ProxyServer#"
			ProxyPort="#get_Shift4OTN_Settings.ProxyPort#"
			ProxyUsername="#get_Shift4OTN_Settings.ProxyUsername#"
			ProxyPassword="#get_Shift4OTN_Settings.ProxyPassword#"
			SerialNumber="#get_Shift4OTN_Settings.SerialNumber#"
			Username="#get_Shift4OTN_Settings.Username#"
			Password="#get_Shift4OTN_Settings.Password#"
			FunctionRequestCode="06"
			MerchantID="#get_Shift4OTN_Settings.MID#"
			Invoice="#InvoiceNum#"
			CardNumber="#CardNumLast4#"
			SaleFlag = "S"
			PrimaryAmount="#PrimaryAmount#"
			SecondaryAmount="0.00"
			Notes="#HTMLText#"
			APIOptions="ALLDATA"
			Vendor="#Vendor#">
		<cfoutput>
		<!--- Debug --->
		<!--- <cfdump var="#OTN#"> --->
		</cfoutput>
	</cfif>

	<cfif OTN.ErrorText is not "">
		<cfabort showerror="#OTN.ErrorText#">
	</cfif>

	<cfif IsDefined("OTN.UniqueID")>
		<cfif OTN.UniqueID is not "">
			<cfset attributes.SaveCardNumber="@#OTN.UniqueID#">
		</cfif>
	</cfif>
	
	<!---- Check for error response ---->
	<CFIF OTN.ErrorIndicator is "Y">
		<cfset ErrorMessage="#OTN.LongError# (#OTN.PrimaryErrorCode#,#OTN.SecondaryErrorCode#)">
  		
		<cfquery name="OrderPaid" datasource="#Request.DS#" 
		username="#Request.user#" password="#Request.pass#">	
			UPDATE #Request.DB_Prefix#Order_No
			SET 
			Notes='CC billing failed on #dateformat(now(),"mm/dd/yy")#: #ErrorMessage# #GetOrderTx.Notes#',
			Admin_Name='#Session.Realname#',
			Admin_Updated=#createodbcdatetime(now())#
			WHERE Order_No=<cfqueryparam value="#attributes.Order_no#" cfsqltype="CF_SQL_INTEGER">
		</cfquery>

	<CFELSE>		
  
		<cfif GCEnabled and SplitTender>
	
			<!---
				This block of code handles multiple gift card payments since CFWebStore does not currently
				have support for split tender. If split tender is ever supported, this code can and should
				be removed.
			--->
			<cf_Shift4OTN
				Result="OTNGC"
				URL="#get_Shift4OTN_Settings.URL#"
				ProxyServer="#get_Shift4OTN_Settings.ProxyServer#"
				ProxyPort="#get_Shift4OTN_Settings.ProxyPort#"
				ProxyUsername="#get_Shift4OTN_Settings.ProxyUsername#"
				ProxyPassword="#get_Shift4OTN_Settings.ProxyPassword#"
				SerialNumber="#get_Shift4OTN_Settings.SerialNumber#"
				Username="#get_Shift4OTN_Settings.Username#"
				Password="#get_Shift4OTN_Settings.Password#"
				FunctionRequestCode="07"
				MerchantID="#get_Shift4OTN_Settings.MID#"
				Invoice="#InvoiceNum#"
				APIOptions="ALLDATA"
				Vendor="#Vendor#">
			<cfloop condition="OTNGC.ErrorIndicator is 'N' and OTNGC.Invoice is InvoiceNum">
				<cfif (OTNGC.CardType is "YC" or OTNGC.CardType is "PL") and OTNGC.SaleFlag is "A">
					<cf_Shift4OTN
						Result="OTNGC"
						URL="#get_Shift4OTN_Settings.URL#"
						ProxyServer="#get_Shift4OTN_Settings.ProxyServer#"
						ProxyPort="#get_Shift4OTN_Settings.ProxyPort#"
						ProxyUsername="#get_Shift4OTN_Settings.ProxyUsername#"
						ProxyPassword="#get_Shift4OTN_Settings.ProxyPassword#"
						SerialNumber="#get_Shift4OTN_Settings.SerialNumber#"
						Username="#get_Shift4OTN_Settings.Username#"
						Password="#get_Shift4OTN_Settings.Password#"
						FunctionRequestCode="06"
						MerchantID="#get_Shift4OTN_Settings.MID#"
						Invoice="#InvoiceNum#"
						TranID="#OTNGC.TranID#"
						SaleFlag = "S"
						PrimaryAmount="#OTNGC.PrimaryAmount#"
						SecondaryAmount="0.00"
						Notes="#HTMLText#"
						APIOptions="ALLDATA"
						Vendor="#Vendor#">
				</cfif>
				<cf_Shift4OTN
					Result="OTNGC"
					URL="#get_Shift4OTN_Settings.URL#"
					ProxyServer="#get_Shift4OTN_Settings.ProxyServer#"
					ProxyPort="#get_Shift4OTN_Settings.ProxyPort#"
					ProxyUsername="#get_Shift4OTN_Settings.ProxyUsername#"
					ProxyPassword="#get_Shift4OTN_Settings.ProxyPassword#"
					SerialNumber="#get_Shift4OTN_Settings.SerialNumber#"
					Username="#get_Shift4OTN_Settings.Username#"
					Password="#get_Shift4OTN_Settings.Password#"
					FunctionRequestCode="0D"
					MerchantID="#get_Shift4OTN_Settings.MID#"
					Invoice="#OTNGC.Invoice#"
					TranID="#OTNGC.TranID#"
					APIOptions="ALLDATA"
					Vendor="#Vendor#">
			</cfloop>
			<!--- end of split tender code --->
			
		</cfif>

  		<cfquery name="OrderPaid" datasource="#Request.DS#" 
		username="#Request.user#" password="#Request.pass#">	
			UPDATE #Request.DB_Prefix#Order_No
			SET Paid = 1,
			Admin_Name = '#Session.Realname#',
			Admin_Updated = #createodbcdatetime(now())#
			WHERE Order_No = <cfqueryparam value="#attributes.Order_no#" cfsqltype="CF_SQL_INTEGER">
		</cfquery>
		
	</CFIF>
			
</cfif>
