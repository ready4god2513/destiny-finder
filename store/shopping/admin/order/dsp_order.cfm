<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template displays the administrative order details. Has several forms:
	basket edit form
	dropshipping form
	payment form 
--->

<!--- Called by shopping.history and shopping.admin&order=display --->

<!--- see if user has permission to edit user information --->
<cfmodule template="../../../access/secure.cfm"
keyname="users"
requiredPermission="4"
/>
<cfif ispermitted>
	<cfset edituser = 1>
<cfelse>
	<cfset edituser = 0>
</cfif>	

<cfset xfa_return = URLEncodedFormat('fuseaction=shopping.admin&order=display&order_no=#attributes.order_no#')>

<cfhtmlhead text="<script type='text/javascript' src='includes/openwin.js'></script>">

<cfmodule template="../../../customtags/format_output_admin.cfm"
	box_title="Order Manager - Edit Order #(GetOrder.Order_No + Get_Order_Settings.BaseOrderNum)#"
	Width="650">
	
<cfoutput>
<table border="0" cellspacing="6" cellpadding="0" width="100%" class="formtext"
style="color:###Request.GetColors.InputTText#">

	<!--- Top row provides record navigation --->
	<tr height="30">
	
		<!--- return to listing --->
		<td width="53%"><img src="#Request.AppSettings.defaultimages#/icons/lleft.gif" border="0" valign="middle" alt="" hspace="2" vspace="0" /> <a href="#session.Page#">return to list</a>
		</td>
		
		<!--- back and next links --->
		<td align="right" width="47%">

		<cfmodule template="../../../customtags/nextitems.cfm"
			mode="display"
			type="order"
			ID = "#attributes.order_no#"
			class=""
			/>
		</td>
	</tr>
	
	
	<!--- second row: Order number and date ---->
	<tr class="formtitle">
		<td> Order No. #(GetOrder.Order_No + Get_Order_Settings.BaseOrderNum)#</td>		
		<td align="right">#LSDateFormat(GetOrder.DateOrdered, "mmmm d, yyyy")#
		<!--- #LStimeFormat(GetOrder.DateOrdered, "h:mm t")# --->	
		</td>		
	</tr>

	
	<!--- line with order history and invoice print links --->
	<tr class="formbutton">
		<td colspan="2"  align="right">
			<button class="formbutton" onclick="Javascript:location.href='#self#?fuseaction=users.admin&email=write&customer_ID=#getorder.customer_id#&redirect=1&XFA_success=#xfa_return#';">Email Customer</button>
			<cfif getorder.shipto is not getorder.customer_ID and GetOrder.ShipTo IS NOT 0>
			<button class="formbutton" onclick="Javascript:location.href='#self#?fuseaction=users.admin&email=write&customer_ID=#getorder.shipto#&redirect=1&XFA_success=#xfa_return#';">Email Ship to</button>	
			</cfif>
		<cfif not isdefined("attributes.edit")>

		<cfif getorder.user_id IS NOT 0><button class="formbutton" onclick="Javascript:location.href='#self#?fuseaction=users.admin&user=summary&UID=#getorder.user_id##request.token2#';">User Summary</button> </cfif>
		<button class="formbutton" onclick="JavaScript:newWindow=window.open( '#self#?fuseaction=shopping.admin&order=print&print=invoice&Order_No=#attributes.order_no#&redirect=1#Request.Token2#', 'Order', 'width=550,height=400,toolbar=1,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1' ); newWindow.focus()">Print Invoice</button> 
		</cfif> 
		</td>
		</td>
	</tr>
	<tr><td colspan="2"><img src="#request.appsettings.defaultimages#/spacer.gif" height="3" alt="" /></td></tr>
	
	<!--- Addresses & Merchant information --->
	<tr>
		<!--- Print customer information --->
		<td valign="TOP"><strong>Bill To:</strong>
		<cfif edituser>	
		<cfif getorder.user_id is not 0><a href="#self#?fuseaction=users.addressbook&show=billto&order_no=#attributes.order_no#&UID=#getOrder.user_ID##request.token2#&xfa_success=#URLEncodedFormat('#self#?fuseaction=shopping.admin&order=display&inframes=yes&order_no=' & attributes.order_no)#">select</a> | </cfif>
		<a href="#self#?fuseaction=users.admin&customer=edit&Customer_ID=#GetOrder.Customer_ID##request.token2#&xfa_success=#URLEncodedFormat('fuseaction=shopping.admin&order=display&order_no=' & attributes.order_no)#">edit</a></cfif>		<br/>
			<table class="formtext" cellpadding="4" style="color:###Request.GetColors.InputTText#"><tr>
			<td>&nbsp;</td>
			<td><cfmodule template="../../order/dsp_cust.cfm" Customer_ID="#GetOrder.Customer_ID#" /></td>
			</tr></table><br/>
		</td>
	
		<!--- Print Ship To information --->
		<td valign="TOP">	
		
		<strong>Ship to:</strong> 
		<cfif edituser>	
		<cfif getorder.user_id is not 0>
		<a href="#self#?fuseaction=users.addressbook&show=shipto&order_no=#attributes.order_no#&UID=#getOrder.user_ID##request.token2#&xfa_success=#URLEncodedFormat('#self#?fuseaction=shopping.admin&order=display&inframes=yes&order_no=' & attributes.order_no)#">select</a></cfif>
		<cfif getorder.shipto is not getorder.customer_ID and GetOrder.ShipTo IS NOT 0> | <a href="#self#?fuseaction=users.admin&customer=edit&Customer_ID=#GetOrder.ShipTo##request.token2#&xfa_success=#URLEncodedFormat('fuseaction=shopping.admin&order=display&order_no=' & attributes.order_no)#">edit</a><br/></cfif>	</cfif>
		
			<table class="formtext" cellpadding="4" style="color:###Request.GetColors.InputTText#"><tr>
			<td>&nbsp;</td>
			<td>
			<cfif getorder.shipto is getorder.customer_id or getOrder.shipto is 0>
				same
			<cfelse>
				<cfmodule template="../../order/dsp_shipto.cfm" ShipTo="#GetOrder.ShipTo#"/>
			</cfif>
			
			
			</td>
			</tr></table><br/>
		
		</td>
	</tr>
	
	
	<!--- Additional Order Information --->
	<tr>
		<td valign="top">
		<strong>Comments:</strong>
		<cfif len(GetOrder.Comments)>#GetOrder.Comments#<cfelse>None</cfif><br/>
		<cfif len(GetOrder.Giftcard)>
			<strong>Giftcard:</strong>#GetOrder.Giftcard#<br/>
		</cfif>		
		<cfif len(GetOrder.Delivery)>
			<strong>Ship to arrive by:</strong> #GetOrder.Delivery#<br/>
		</cfif>
		<cfif len(GetOrder.Coup_Code)>
			<strong>Coupon:</strong> #GetOrder.Coup_Code#<br/>
		</cfif>
		<cfif len(GetOrder.Cert_Code)>
			<strong>Gift Certificate:</strong> #GetOrder.Cert_Code#<br/>
		</cfif>

		</td>
		
		<td valign="top">
		<!--- Print the Affiliate information --->
		<cfif GetOrder.Affiliate>
			<cfif GetAffiliate.RecordCount>
			<strong>Referred By:</strong> <cfif len(GetAffiliate.FirstName)>#GetAffiliate.FirstName# #GetAffiliate.LastName#<cfelse>#GetAffiliate.UserName#</cfif> <br/>
			(Code: #GetAffiliate.AffCode#)<br/>
			<cfelse>
			Invalid Affiliate Code Used<br/>
			</cfif>
			<strong>URL:</strong> #GetOrder.Referrer#<br/>
		<br/>
		</cfif>
		<!--- Output custom checkout fields --->
		<cfloop index="x" from="1" to="3">
			<cfif len(Evaluate('GetOrder.CustomText' & x))>
			<strong>#Evaluate('get_Order_Settings.CustomText' & x)#: </strong> 
			#Evaluate('GetOrder.CustomText' & x)#<br/><br/>
			</cfif>
		</cfloop>
		<cfloop index="x" from="1" to="2">
			<cfif len(Evaluate('GetOrder.CustomSelect' & x))>
			<strong>#Evaluate('get_Order_Settings.CustomSelect' & x)#: </strong> 
			#Evaluate('GetOrder.CustomSelect' & x)#<br/><br/>
			</cfif>
		</cfloop>
		</td>
	</tr>
	
	
	<!--- line with order history and invoice print links --->
	<tr><td colspan="2"><img src="#request.appsettings.defaultimages#/spacer.gif" height="3" alt="" /></td></tr>
	<tr class="formbutton">
		<td colspan="2"  align="right">
		<cfif not isdefined("attributes.edit")>
	<cfmodule template="../../../access/secure.cfm"
	keyname="shopping"
	requiredPermission="64"
	><button class="formbutton" onclick="Javascript:location.href='#self#?fuseaction=shopping.admin&order=display&order_no=#attributes.order_no#&edit=pay&redirect=1#request.token2#';">Edit Status</button></cfmodule>

		</cfif>
		</td>
		</td>
	</tr>
	<tr><td colspan="2"><img src="#request.appsettings.defaultimages#/spacer.gif" height="3" alt="" /></td></tr>
	
	
<cfif isdefined("attributes.edit") and attributes.edit is "pay">

	<tr><td colspan="2">
		<cfinclude template="put_payform.cfm">
	</td></tr>

<cfelse>

	<!--- Payment info row ---------->
	<tr>
		<!--- payment details --->
		<cfquery name="GetCardData" datasource="#Request.DS#" 
		username="#Request.user#" password="#Request.pass#" maxrows=1>
			SELECT * FROM #Request.DB_Prefix#CardData
			WHERE ID = #GetOrder.Card_ID#
		</cfquery>
		<td valign="top">
<strong>Payment status:</strong> <cfif GetOrder.paid is 1>Paid<cfelse><span class="formerror">NOT PAID</span></cfif><br/>
   <cfif Get_Order_Settings.CCProcess IS NOT "None">  
   <strong>Invoice:</strong> ###GetOrder.InvoiceNum#<br/></cfif>		
			
			
			<cfif NOT GetCardData.RecordCount>
				<strong>Payment:</strong> 
				<cfif GetOrder.OfflinePayment IS "Offline">
					Offline Order<br/>
				<cfelseif GetOrder.OfflinePayment IS "PayPal">
					PayPal Order<br/><br/>
					<cfif GetOrder.AuthNumber IS NOT 0>
					<strong>Transaction No:</strong></b></i> #GetOrder.AuthNumber#<br/><br/>
					</cfif>
					<strong>Status:</strong> #GetOrder.PayPalStatus#<cfif len(GetOrder.Reason)>, #GetOrder.Reason#</cfif><br/>
				<cfelseif GetOrder.OfflinePayment IS "Purchase Order">
					Purchase Order Used<br/><br/>
					<strong>Purchase Order No:</strong></b></i> #GetOrder.PO_Number#<br/>
				<cfelseif GetOrder.Filled>
					Filled #GetOrder.OfflinePayment# Order, no card data<br/>
				<cfelseif GetOrder.Process>
					In-Process #GetOrder.OfflinePayment# Order, no card data<br/>		
				</cfif>

			<cfelse>
				<cfloop query="GetCardData">
				<strong>Charge to:</strong>
				#CardType#<br/>
				<strong>Name on Card:</strong> #NameonCard#<br/>
				<cfif len(EncryptedCard)>
					<cftry>
					<cfmodule template="../../../customtags/crypt.cfm" action="de" 
						string="#EncryptedCard#" key="#Request.encrypt_key#">
					<strong>Card Number:</strong> <cfmodule template="../../../customtags/dsptoken.cfm" cardnumber="#CardNumber#" token="#crypt.value#"><br/>
					<cfcatch type="Any">
					<strong>Card Number:</strong> #CardNumber# (number failed to decrypt)<br/>
					</cfcatch>
					</cftry>
				<cfelse>
					<strong>Card Number:</strong> #CardNumber#<br/>
				</cfif>
				<strong>Expires:</strong> #Expires#
				<cfif GetOrder.AuthNumber IS NOT "0" AND len(GetOrder.AuthNumber)>
					<br/><strong>Authorization Number:</strong> #GetOrder.AuthNumber#
					<cfif len(GetOrder.TransactNum)><br/><strong>TX Number:</strong> #GetOrder.TransactNum#</cfif>
					 <!--- Capture Funds Link --->
					 <cfif GetOrder.paid is 0>
					<cfmodule template="../../../access/secure.cfm"
					keyname="shopping"
					requiredPermission="64"
						><br/><a href="#request.self#?fuseaction=shopping.admin&order=display&order_no=#attributes.order_no#&edit=pay&act=charge#request.token2#"><span style="color: red; font-weight: bold;">Capture Funds</span></a></cfmodule>
					</cfif>
				</cfif>
				</cfloop>

			</cfif>
			
			<cfif len(getOrder.transactNum)>
				<br/><strong>Transaction Num:</strong> #getOrder.transactNum#<br/>
			</cfif>
		</td>
		
		<!--- order notes --->
		<td valign="top">
		<strong>Order status:</strong> 
			<cfif getOrder.void is "1"><span class="formerror"><strong>VOID</strong></span> - 
			<cfelseif GetOrder.process is "0"><span class="formerror">PENDING</span>
			<cfelseif getOrder.process is "1" AND getOrder.filled is "0"><span class="formerror">IN PROCESS</span>
			<cfelse>ORDER FILLED</cfif>
			<cfif len(getorder.status)>#GetOrder.status#</cfif>	
			<br/>			
				
		<cfif GetCerts.RecordCount>
			<br/><strong>Gift Certificates Purchased:</strong> 
			<cfif GetOrder.CodesSent>Emails Sent
			<cfelse>[<a href="#self#?fuseaction=shopping.admin&order=display&order_no=#attributes.order_no#&sendcodes=yes#request.token2#">send codes</a>]
			</cfif><br/>
		</cfif>
		
		<cfif len(getorder.admin_updated)>
			<strong>Last update:</strong>  <cfif len(GetOrder.Admin_Updated)>#LSDateFormat(GetOrder.Admin_Updated, "m/d/yy")#</cfif> by #GetOrder.Admin_Name#<br/>
		</cfif>
		</td>
	</tr>
	
	<cfif len(getorder.notes)>
	<tr>
		<td colspan="2">
			<strong>Notes:</strong> #getorder.notes#
		</td>
	</tr>
	</cfif>
	
</cfif>
	
	
	
<!--- Basket ---->
<cfif isdefined("attributes.edit") and attributes.edit is "dropship">	
	<tr>
		<td colspan="2" height="35" valign="bottom">
			<cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<br/><cfinclude template="put_basket_shipform.cfm"><br/>
		</td>
	</tr>
	
<cfelseif isdefined("attributes.edit") and attributes.edit is "adjust">
	<tr>
		<td colspan="2" height="35" valign="bottom">
			<cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/>
		</td>
	</tr>
	
	<tr>
		<td colspan="2">	
			<br/><cfinclude template="put_basket_update.cfm"><br/>
		</td>
	</tr>
	
<cfelseif isdefined("attributes.edit") and attributes.edit is "taxes">
	<tr>
		<td colspan="2" height="35" valign="bottom">
			<cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/>
		</td>
	</tr>
	
	<tr>
		<td colspan="2">	
			<br/><cfinclude template="put_taxes_update.cfm"><br/>
		</td>
	</tr>
	
<cfelseif isdefined("attributes.edit") and attributes.edit is "product">
	<tr>
		<td colspan="2" height="35" valign="bottom">
			<cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/>
		</td>
	</tr>
	
	<tr>
		<td colspan="2">	
			<br/><cfinclude template="put_basket_product.cfm"><br/>
		</td>
	</tr>
<cfelse>

	<!--- line with adjust order and assign dropshippers --->
	<tr><td colspan="2"><img src="#request.appsettings.defaultimages#/spacer.gif" height="4" alt="" /></td></tr>
	<tr class="formbutton">
		<td colspan="2"  align="right">
		<cfif not isdefined("attributes.edit")>

	<!--- Shopping Permission 64 = order editing --->		
	<cfmodule template="../../../access/secure.cfm"
	keyname="shopping"
	requiredPermission="64"
	>			
		<button class="formbutton" onclick="JavaScript: newWindow = openWin( '#self#?fuseaction=shopping.admin&order=AddProduct&order_no=#attributes.order_no##request.token2#', 'Products', 'width=550,height=400,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()">Add Product</button>
	
		<button class="formbutton" onclick="Javascript:location.href='#self#?fuseaction=shopping.admin&order=display&order_no=#attributes.order_no#&edit=product&redirect=1#request.token2#';">Edit Products</button>
		
		<button class="formbutton" onclick="Javascript:location.href='#self#?fuseaction=shopping.admin&order=display&order_no=#attributes.order_no#&edit=adjust&redirect=1#request.token2#';">Edit Order</button>
	
	<button class="formbutton" onclick="Javascript:location.href='#self#?fuseaction=shopping.admin&order=display&order_no=#attributes.order_no#&edit=taxes&redirect=1#request.token2#';">Edit Taxes</button>

	<button class="formbutton" onclick="Javascript:location.href='#self#?fuseaction=shopping.admin&order=display&order_no=#attributes.order_no#&edit=dropship&redirect=1#request.token2#';">Dropshipping</button>
	</cfmodule>

		</cfif>

		</td>
	</tr>
	<tr><td colspan="2"><img src="#request.appsettings.defaultimages#/spacer.gif" height="4" alt="" /></td></tr>
	
	<tr>
		<td colspan="2">
		<cfinclude template="put_basket.cfm"><br/>
		</td>
	</tr>
	
	<!--- line with order history and invoice print links --->
	<tr><td colspan="2"><img src="#request.appsettings.defaultimages#/spacer.gif" height="3" alt="" /></td></tr>
	<tr class="formbutton">
		<td colspan="2"  align="right">
		<cfif not isdefined("attributes.edit") and not GetOrder.Filled>
		<button class="formbutton" onclick="Javascript:newWindow=window.open( '#self#?fuseaction=shopping.admin&order=print&print=packlist&Order_No=#attributes.order_no#&redirect=1#Request.Token2#', 'PO', 'width=570,height=400,toolbar=1,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1' ); newWindow.focus()">Print Packing Slip</button>  
		<button class="formbutton" onclick="Javascript:location.href='#self#?fuseaction=shopping.admin&order=shipping&redirect=1&order_no=#attributes.order_no##request.token2#&xfa_success=#URLEncodedFormat('fuseaction=shopping.admin&order=display&order_no=' & attributes.order_no)#';">Fill Order</button>  
		</cfif>
		</td>
	</tr>	
	
	<tr><td colspan="2"><img src="#request.appsettings.defaultimages#/spacer.gif" height="3" alt="" /></td></tr>
	
	<tr>
		<td colspan="2" class="formtext">
		<strong>Ship by:</strong> #GetOrder.shipType#<br/>

		<cfif GetOrder.Filled and NOT GetOrder.Void>
			<strong>Shipped On:</strong> #LSDateFormat(GetOrder.DateFilled, "mmmm d, yyyy")#<br/>
			   <cfif len(GetOrder.Shipper)><strong>Shipped by: </strong>
					<cfif GetOrder.Shipper IS "UPS">
					<a target="tracking" href="http://www.ups.com/tracking/tracking.html">#GetOrder.Shipper#</a>
					<cfelseif GetOrder.Shipper IS "USPS">#GetOrder.Shipper#</a>
					<a target="tracking" href="http://www.usps.com/shipping/trackandconfirm.htm">#GetOrder.Shipper#</a>
					<cfelseif GetOrder.Shipper IS "FedEx">
					<a target="tracking" href="http://www.fedex.com/us/tracking/">#GetOrder.Shipper#</a>
					<cfelseif GetOrder.Shipper IS "Airborne">
					<a target="tracking" href="http://track.dhl-usa.com/TrackByNbr.asp">#GetOrder.Shipper#</a>
					<cfelse>
					#GetOrder.Shipper#
					</cfif><br/>
				</cfif>
			<cfif len(GetOrder.Tracking)><strong>Tracking Numbers:</strong> 
				<cfif GetOrder.Shipper IS "UPS">
					<cfloop index="ii" list="#GetOrder.Tracking#">
					<a  target="tracking" href='http://wwwapps.ups.com/tracking/tracking.cgi?tracknum=#ii#'>#ii#</a> 
					</cfloop>
				<cfelse>
					#GetOrder.Tracking#
				</cfif>
			</cfif>
		</cfif>
		
	
	
	<!--- Shopping Permission 32 = order editing --->		
	<cfmodule template="../../../access/secure.cfm"
	keyname="shopping"
	requiredPermission="64"
	>			
		<cfinclude template="put_dropshippers.cfm">
	</cfmodule>
		
		</td>
	</tr>
	
	</CFIF>	
		
</table>
</cfoutput>
<!---- CLOSE MODULE ----->
</cfmodule> 
