<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the order shipping charges and other information (comments, gift cert, coupon, etc.) --->

<!--- Called by shopping.checkout (step=payment) --->

<cfoutput>
<table border="0" cellspacing="0" cellpadding="6" width="520" align="center" class="formtext">
	<tr>
	<td valign="top" width="50%">
<!--- If shipping calculated by weight or UPS, display total weight --->
<cfif NOT ListFind("Price,Price2,Items",ShipSettings.ShipType) AND Session.CheckoutVars.TotalWeight GT 0>
	<b>Total Weight:</b> #Session.CheckoutVars.TotalWeight# #Request.AppSettings.WeightUnit#<br/>
</cfif>

<cfif ShipSettings.ShowFreight AND TotalFreight>
	<b>Freight Charges:</b> #LSCurrencyFormat(TotalFreight)#<br/>
	<cfset ShipAmount = ShipCost>
<cfelse>
	<cfset ShipAmount = ShipCost + TotalFreight>
</cfif>

<b>Shipping Charges:</b> 
<!--- If shipping not calculated, display message --->
<cfif Session.CheckoutVars.NoShipInfo IS 1>
	#ShipSettings.NoShipMess#
<!--- If shipping was calculated, and is 0, no shipping charges --->
<cfelseif ShipAmount IS 0>
	No Shipping Charges
<!--- Else Display Shipping Cost --->
<cfelse>
	#LSCurrencyFormat(ShipAmount)#
</cfif>

<cfif len(GetTempOrder.Delivery)>
<br/><br/><b>Ship to arrive on/by:</b> #GetTempOrder.Delivery#
</cfif>

<cfif Session.CheckoutVars.Download>
	<br/><br/>Downloadable products will be available on the My Account page of this web site after the order is processed.
</cfif>


</td><td valign="top" width="50%">


<cfif len(GetTempOrder.giftcard)>
<b>Gift Card Message:</b> #HTMLEditFormat(GetTempOrder.GiftCard)#
<br/></cfif>

<cfif len(Session.Coup_Code)>
<b>Coupon:</b> #Session.Coup_Code#
<br/></cfif>

<cfif len(Session.Gift_Cert)>
<b>Gift Certificate:</b> #Session.Gift_Cert#
<br/></cfif>

<!--- Output custom text fields --->
<cfloop index="x" from="1" to="3">
	<cfif len(Evaluate('GetTempOrder.CustomText' & x))>
	<b>#Evaluate('get_Order_Settings.CustomText' & x)#:</b>
	#Evaluate('GetTempOrder.CustomText' & x)#<br/>
	</cfif>
</cfloop>
<!--- Output custom selectbox fields --->
<cfloop index="x" from="1" to="2">
	<cfif len(Evaluate('GetTempOrder.CustomSelect' & x))>
	<b>#Evaluate('get_Order_Settings.CustomSelect' & x)#:</b>
	#Evaluate('GetTempOrder.CustomSelect' & x)#<br/>
	</cfif>
</cfloop>

<cfif len(GetTempOrder.comments)>
<b>Comments:</b> #GetTempOrder.comments#
<br/>
</cfif>

</td>
</tr></table><br/>
</cfoutput>