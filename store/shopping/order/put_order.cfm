<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This custom tag is used to display an order for any of the invoice pages in the store. --->

<!--- 
Parameters:
Order_No - the order number to retrieve
Type - type of display to use, customer or admin
Datasource = database to query
Password = password for database
username = username for database
 --->
<cfif isDefined("ThisTag.ExecutionMode") AND ThisTag.ExecutionMode eq "END">
	<cfexit method="EXITTAG">
</cfif>		

<cfinclude template="../qry_get_order_settings.cfm">
<cfinclude template="../qry_ship_settings.cfm">

<cfparam name="Attributes.Order_No" default="0">
<cfparam name="Attributes.Type" default="Admin">
 
<cfset Order_No = Attributes.Order_No>
<cfset Type = Attributes.Type>
<cfset errormess = "">

<cfinclude template="qry_order.cfm">

<cfif len(errormess)>

	<cfoutput>
	<div class="formtext" align="center"><p><b>#errormess#</b></p></div></cfoutput>
	
<cfelse>
	

<cfmodule template="../../customtags/format_letterhead.cfm" action="#caller.attributes.fuseaction#">
<table width="90%" border="0" cellspacing="4" cellpadding="5" class="formtext" align="center">
	<tr>
		<!--- Merchant--->
		<td valign="top" width="33%">
		
<cfoutput>
	<!---- Merchant Address: ---->
	<cfif caller.attributes.fuseaction is "shopping.checkout">	
		<cfif len(Request.AppSettings.Merchant)>
			#request.appsettings.merchant# <br/>
		</cfif>
		<cfif len(Request.AppSettings.MerchantEmail)>
		<a href="mailto:#Request.AppSettings.MerchantEmail#">
		#Request.AppSettings.MerchantEmail#</a><br/>
		</cfif>
	</cfif>
	
	<!--- Print the Affiliate information --->
	<cfif GetOrder.Affiliate AND Type IS "Admin">
		<p><div class="formtext">
		<cfif GetAffiliate.RecordCount>
			Referred By: #GetAffiliate.FirstName# #GetAffiliate.LastName# <br/>
			(Code: #GetAffiliate.AffCode#)<br/>
		<cfelse>
			Invalid Affiliate Code Used<br/>
		</cfif>
		URL: #GetOrder.Referrer#<br/></font>
		</div></P>
	</cfif>
	
		</td>
		
		<!--- Blank --->
		<td width="33%">&nbsp;</td>
		
		<!--- Display order number and date of the order --->
		<td valign="top" width="33%"><br/>
			<span class="formtitle">ORDER #(getorder.Order_No + Get_Order_Settings.BaseOrderNum)#<br/> #LSDateFormat(getorder.dateordered, "mmmm d, yyyy")#</span><br/>
			<cfif Get_Order_Settings.CCProcess IS NOT "None" AND Type IS "Admin"><span class="formtext"><i>(Invoice ###GetOrder.InvoiceNum#)</i></span><br/></cfif>

		</td>
	</tr>

	</cfoutput>
	
	<tr>
		<!--- Billing address. --->
		<td valign="top">
		<b><i><cfif GetOrder.ShipTo IS 0>Bill/Ship<cfelse>Bill</cfif> To:</i></b><br/>
		<cfmodule template="dsp_cust.cfm" Customer_ID="#GetOrder.Customer_ID#"/>
		</td>

		<!--- Shipping address if different from billing. --->
		<td valign="top">
		<cfif GetOrder.ShipTo IS NOT 0>
		<b><i>Ship To:</i></b><br/>
		<cfmodule template="dsp_shipto.cfm" ShipTo="#GetOrder.ShipTo#"/>
		</cfif>
		</td>
		
		<td valign="top">	
	<cfif caller.attributes.fuseaction is "shopping.admin" AND Type IS "Admin">
		<p><div class="formtext">
		<cfif GetOrder.paid is 1><strong>Paid</strong><br/></cfif>

	<cfelseif caller.attributes.fuseaction is not "shopping.checkout">
	<!--- This is stuff the customer can see when viewing the 
	order in Order History ---->		
			<cfoutput>
			<strong>Order Type:</strong> #GetOrder.OfflinePayment#<br/>
			<strong>Status:</strong> 
				<cfif GetOrder.Void>Cancelled #LSDateFormat(GetOrder.DateFilled, "mmmm d, yyyy")#
				<cfelseif GetOrder.Filled>Shipped 
				<cfelseif GetOrder.Process>Being Processed
				<cfelse>Pending
				</cfif><br/>
			</cfoutput>
	
	</cfif>
	
		<cfif GetOrder.Void>
		<p><div class="formtext">
		<cfoutput>
		<i><b>Cancelled On:</b></i> #LSDateFormat(GetOrder.DateFilled, "mmmm d, yyyy")#
		</cfoutput>
		</div></p>
	</cfif>
	
 	<cfif GetOrder.Filled AND NOT GetOrder.Void>
		<p><div class="formtext">
		<cfoutput>
		<i><b>Shipped On:</b></i> #LSDateFormat(GetOrder.DateFilled, "mmmm d, yyyy")#
		<cfif len(GetOrder.Shipper)><br/>Shipped by #GetOrder.Shipper#</cfif>
		<cfif len(GetOrder.Tracking)><br/>Tracking Numbers: #GetOrder.Tracking#</cfif>
		</cfoutput>
		</div></p>
	</cfif> 
	
		&nbsp;
		</td>
	</tr>
			
	<!--- Display the credit card information for the order --->
	<tr>
	<td colspan="3">

			<cfif NOT GetCardData.RecordCount AND Type IS "Admin">
				<cfoutput><br/>
				<cfif GetOrder.OfflinePayment IS "Offline">
				<i><b>Offline Order, no card data</b> </i><br/>
				<cfelseif GetOrder.OfflinePayment IS "PayPal">
				<i><b>PayPal Order, no card data</b> </i><br/><br/>
				<i><b>Transaction No:</b></i> #GetOrder.AuthNumber#<br/><br/>
				<i><b>Status:</b></i> #GetOrder.PayPalStatus#<cfif len(GetOrder.Reason)>, #GetOrder.Reason#</cfif><br/>
				<cfelseif GetOrder.OfflinePayment IS "Purchase Order">
				<i><b>Purchase Order, no card data</b> </i><br/><br/>
				<i><b>Purchase Order No:</b></i> #GetOrder.PO_Number#<br/>
				<cfelseif GetOrder.Filled>
				<i><b>Filled #GetOrder.OfflinePayment# Order, no card data</b> </i><br/>
				<cfelseif GetOrder.Process>
				<i><b>In-Process #GetOrder.OfflinePayment# Order, no card data</b> </i><br/>
				</cfif>
				</cfoutput>
			
			<cfelse>
				<cfoutput query="GetCardData" maxrows=1><br/>
				<i><b>Charged to:</b> </i><br/>	
				<b>#CardType#</b><br/>
				Name on Card: #NameonCard#<br/>
				<cfif len(EncryptedCard) AND Type IS "Admin">
					<cftry>
						<cfmodule template="../../customtags/crypt.cfm" action="de" 
							string="#EncryptedCard#" key="#Request.encrypt_key#">
						Card Number: <cfmodule template="../../customtags/dsptoken.cfm" cardnumber="#CardNumber#" token="#crypt.value#"><br/>
					<cfcatch type="Any">
						Card Number: #CardNumber# (number failed to decrypt)<br/>
					</cfcatch>
					</cftry>
				<cfelse>
					Card Number: #CardNumber#<br/>
				</cfif>
				
				Expires: #Expires#
				<cfif Type IS "Admin" AND GetOrder.AuthNumber IS NOT "0" AND len(GetOrder.AuthNumber)>
				<br/>Authorization Number: #GetOrder.AuthNumber#</cfif>
				</cfoutput>
			</cfif>	
	</td>
	</tr>

</table>

<br/><br/>

	<!--- Display Order --->
	<cfmodule template="dsp_basket.cfm" Order_No="#Order_No#" Customer_ID="#GetOrder.Customer_ID#" />
	
	<cfoutput>
<table width="90%" border="0" cellspacing="4" cellpadding="5" align="center" class="formtext">
<tr><td><cfif ShipSettings.ShipType IS 'UPS'>
<tr><td colspan="2"><br/><br/>
<img src="#Request.AppSettings.defaultimages#/icons/ups_smlogo.jpg" alt="" width="32" height="32" border="0" align="left" /><i>UPS, UPS brandmark, and the Color Brown are trademarks of United
Parcel Service of America, Inc. All Rights Reserved.</i>
	</td></tr>	
</cfif></td></tr>
</table>
</cfoutput>
</cfmodule>


</cfif>
