
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This sends an email to the customer to inform them that the order has shipped. If entered, tracking numbers are included in the email with a link to the shippers tracking page. Called from order\act_order_shipping.cfm and po\act_po.cfm --->

<cfquery name="GetCust" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows=1>
SELECT C.Email, O.DateOrdered, C.Firstname, C.LastName, O.User_ID, O.Customer_ID
FROM #Request.DB_Prefix#Order_No O, #Request.DB_Prefix#Customers C
WHERE O.Customer_ID = C.Customer_ID
AND O.Order_No = #attributes.Order_No#
</cfquery>

<cfset LineBreak = Chr(13) & Chr(10)>

<!--- Initialize the content of the message --->
<cfset Message = "The following order has been shipped:" & LineBreak & "-----------------" & LineBreak & LineBreak>

<cfset Message = Message & "Order Number: " & Evaluate(attributes.Order_No + get_order_settings.BaseOrderNum) & LineBreak>

<cfset Message = Message & "Placed: " & LSDateFormat(GetCust.DateOrdered, "mmmm d, yyyy") & LineBreak & LineBreak>

<!--- If notes added, add to the email message --->
<cfif len(Trim(attributes.CustNotes))>
	<cfset Message = Message & attributes.CustNotes & LineBreak & LineBreak>
</cfif>


<!--- If tracking numbers entered, add to the email message --->
<cfif len(Trim(attributes.Tracking))>

<cfset Message = Message & "The following tracking number/s have been assigned to your shipment:" & LineBreak>

<cfloop index="num" list="#attributes.Tracking#">
<cfset Message = Message & num & LineBreak>
</cfloop>

<cfset Message = Message & LineBreak>

<cfif attributes.Shipper IS NOT "Other">
<cfset Message = Message & "You can track your order online by going to the following web address">
<cfset Message = Message & LineBreak & "and entering your tracking number/s:" & LineBreak>

<cfif attributes.Shipper IS "UPS">
<cfset Message = Message & "http://www.ups.com/tracking/tracking.html" & LineBreak & LineBreak>
<cfelseif attributes.Shipper IS "USPS">
<cfset Message = Message & "http://www.usps.com/shipping/trackandconfirm.htm" & LineBreak & LineBreak>
<cfelseif attributes.Shipper IS "FedEx">
<cfset Message = Message & "http://www.fedex.com/us/tracking/" & LineBreak & LineBreak>
<cfelseif attributes.Shipper IS "Airborne">
<cfset Message = Message & "http://track.dhl-usa.com/TrackByNbr.asp" & LineBreak & LineBreak>
</cfif>

</cfif>


<cfset Message = Message & "Thanks for your order!" & LineBreak>

</cfif>


<cfinvoke component="#Request.CFCMapping#.global" 
	method="sendAutoEmail" UID="#GetCust.User_ID#" 
	Email="#GetCust.Email#" MergeName="#GetCust.Firstname# #GetCust.Lastname#"
	MailAction="OrderShipped" MergeContent="#Message#">
			
		




