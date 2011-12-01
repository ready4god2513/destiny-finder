<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This custom tag is used to display a Purchase Order suitable for printing. Called by shopping.admin&po=print and from order\act_printing.cfm --->

<!--- 
Parameters:
	PO_NO_ID - the purchase order number to retrieve
	Datasource = database to query
	Password = password for database
	username = username for database
 --->
<cfinclude template="../../qry_get_order_settings.cfm">
 
<cfparam name="Attributes.PO_NO_ID" default="0">

<cfset User_ID = Session.User_ID>

<cfinclude template="qry_get_po.cfm">


<cfif qry_get_po.RecordCount IS 0>

<p><div class="formtext" align="center"><b>Sorry, there does not appear to be an purchase order with this number in the database.</b></div></p>

<cfelse>

	<cfif qry_get_po_items.RecordCount IS 0>

		<p><div class="formtext" align="center"><b>Sorry, this PO appears to have no items listed.</b></div></p>

	<cfelse>
	
		<!--- Output Purchase Order ----->
<cfmodule template="../../../customtags/format_letterhead.cfm">
		<cfoutput query="qry_get_po">
		
<table width="95%" border="0" cellspacing="4" cellpadding="5" class="formtext" align="center">

	<tr>
		<!--- PO Date, Customer PO --->
		<td valign="top">
			PO Date: #LSDateFormat(printdate, "mmmm d, yyyy")# <br/>
			Customer PO: #Evaluate(Order_No + Get_Order_Settings.BaseOrderNum)#
		</td>
		
		<!--- Blank --->
		<td>&nbsp;</td>
		
		<!--- PO Number, Account--->
		<td valign="top">
			<span class="formtitle">Purchase Order ###PO_no#</span><br/>
			<br/>
			<strong>#account_name#</strong><br/>
			<cfif len(dropship_email)>#dropship_email#<br/></cfif>
			<cfif len(po_text)>#po_text#<br/></cfif>
			<br/>
		</td>
	</tr>

	<tr>
		<!--- Bill To--->
		<td valign="top">
		<strong>BILL TO:</strong><br/>
			<cfif len(Request.AppSettings.Merchant)>
				#Request.AppSettings.Merchant#<br/>
			</cfif>
			<cfif len(Request.AppSettings.MerchantEmail)>
				<a href="mailto:#Request.AppSettings.MerchantEmail#">#Request.AppSettings.MerchantEmail#</a>
			</cfif>
			<br/>
			
		</td>

		<!--- Ship To --->
		<td valign="top">
		<strong>SHIP TO:</strong><br/>
			<cfif ShipTo IS 0>
				<cfmodule template="../../order/dsp_cust.cfm" Customer_ID="#Customer_ID#">
			<cfelse>
				<cfmodule template="../../order/dsp_shipto.cfm" ShipTo="#ShipTo#">
			</cfif>
			<br/>
		</td>
		
		<!--- Shipping info --->
		<td valign="top">
		<cfif len(shipdate)>
			<i><b>Shipped On:</b></i> #LSDateFormat(shipdate, "mmmm d, yyyy")#
			<cfif len(Shipper)><br/>Shipped by #Shipper#</cfif>
			<cfif len(Tracking)><br/>Tracking Numbers: #Tracking#</cfif>
		</cfif>
		</td>
	</tr>
	</cfoutput>
</table>

<!--- Output PO Items qry_get_po_items--->
<table width="94%" border="0" cellspacing="4" cellpadding="0" class="formtext" align="center">

	<!--- Header table --->
	<tr>
		<td>Qty</td>
		<td>Mfg. Part #</td>
		<td>Vendor Part #</td>
		<td>Unit Cost</td>
		<td>Total Cost</td>
	</tr>
	<tr>
		<td colspan="5">
			<cfmodule template="../../../customtags/putline.cfm" linetype="thick"/>
		</td>
	</tr>
	
	<cfoutput query="qry_get_po_items">
	<tr>
		<td>#dropship_qty#</td>
		<td>#sku#</td>
		<td><cfif len(dropship_sku)>#dropship_sku#<cfelse>#sku#</cfif></td>
		<td>#LSCurrencyFormat(dropship_cost)#</td>
		<td>#LSCurrencyFormat(dropship_cost * dropship_qty)#</td>
	</tr>
	
	<tr>
		<td>&nbsp;</td>
		<td colspan="4">#Name#
			<div class="smallformtext">
			<cfif Len(Trim(Options))><i>Options: #Options#</i><br/></cfif>
			<cfif Len(Trim(Addons))><i>#Addons#</i><br/></cfif></div>
			<cfif len(dropship_note)><br/>#dropship_note#</cfif>
		
		</td>
	</tr>
	
	<tr>
		<td colspan="5">
			<cfmodule template="../../../customtags/putline.cfm" linetype="thin"/>
		</td>
	</tr>
	
	</cfoutput>
	
	<tr>
		<td colspan="5">
			<br/>
<strong>Shipping Method:</strong> <cfoutput>#qry_get_po.shiptype#</cfoutput><br/>
<br/>
<cfif len(qry_get_po.notes)><strong>Additional Information:</strong> <cfoutput>#qry_get_po.notes#</cfoutput><br/></cfif>
			
		</td>
	</tr>
	
</table>


</cfmodule>

</cfif>
</cfif>


