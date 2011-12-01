<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the list of drop-shippers for the order, with links to view or edit the purchase orders. If purchase orders not opened yet, will show a link to create it. Called from dsp_order.cfm --->

<!--- Get list of all dropshippers for this order
<cfset basket_dropshipper_list = "">
<cfloop query="GetOrder">
	<cfif len(dropship_Account_ID) AND dropship_Account_ID is not "0" AND not listfind(basket_dropshipper_list,dropship_Account_ID)>
		<cfset basket_dropshipper_list = listappend(basket_dropshipper_list,dropship_Account_ID)>
	</cfif>
</cfloop>
 --->

<!--- Get all PO records for this order --->
<cfquery name="Get_Order_PO" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT * FROM #Request.DB_Prefix#Order_PO
	WHERE Order_No = #attributes.order_no#
</cfquery>


<!--- Show dropshippers list if order items have been assigned to a dropshipper --->
<cfif len(basket_dropshipper_list) OR Get_Order_PO.recordcount>

	<div align="center" class="formtitle"><br/>Purchase Orders</div>

	<!--- First, output all Purchase Orders created --->
	<cfoutput query="Get_Order_PO">
	
	<cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/>
		
	<table width="100%" class="formtext" style="color:###Request.GetColors.InputTText#">
		<!--- Row 1: account name & menu ---->
		<tr>
			<td width="49%"><strong>Dropshipper:</strong> <a href="#self#?fuseaction=users.admin&account=edit&account_ID=#account_ID#&xfa_success=#xfa_return##Request.Token2#">#vendors[account_ID]#</a></td>
			<td width="13%"><strong>PO:</strong> #po_no#</td>
			<td width="18%"><strong>Date:</strong> #dateformat(printdate,"mm/dd/yy")#</td>	
			<td width="20%"><strong>Status:</strong> <cfif len(po_status)>#po_status#<cfelseif po_open is 1>OPEN<cfelse>CLOSED</cfif></td>		
		</tr>
		<tr>
			<td colspan="2">
			<cfif len(notes)><em>#notes#</em><br/></cfif>
			<cfif len(shipdate)><strong>Shipped:</strong> #dateformat(shipdate,"mm/dd/yy")# 
				    <cfif len(shipper)> via 
						<cfif Shipper IS "UPS">
						<a target="tracking" href="http://www.ups.com/tracking/tracking.html">#Shipper#</a>
						<cfelseif Shipper IS "USPS">#Shipper#</a>
						<a target="tracking" href="http://www.framed.usps.com/cttgate/welcome.htm">#Shipper#</a>
						<cfelseif Shipper IS "FedEx">
						<a target="tracking" href="http://www.fedex.com/us/tracking/">#Shipper#</a>
						<cfelseif Shipper IS "Airborne">
						<a target="tracking" href="http://www.airborne.com/trace/">#Shipper#</a>
						<cfelse>
						#Shipper#
						</cfif>
					</cfif>
				<cfif len(tracking)> tracking: 
					<cfif shipper is "UPS">
						<cfloop index="ii" list="#tracking#">
						<a href="http://wwwapps.ups.com/tracking/tracking.cgi?tracknum=#ii#" target="tracking">#ii#</a> 
						</cfloop>
					<cfelse>
						#tracking#
					</cfif>							
				</cfif>
			</cfif>
			</td>
			
			<td colspan="2" align="right" valign="top">
			 <a href="#self#?fuseaction=shopping.admin&po=edit&order_po_ID=#order_po_ID#&order_no=#attributes.order_no##Request.Token2#">Edit</a> |
		
			
<a href="JavaScript:newWindow=window.open( '#self#?fuseaction=shopping.admin&order=print&print=po&Order_No=#attributes.order_no#&account_id=#account_id##Request.Token2#', 'PO', 'width=570,height=400,toolbar=1,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1' ); newWindow.focus()">View/Print</a>
<cfif po_open is 1> | 
 <a href="#self#?fuseaction=shopping.admin&po=ship&order_po_ID=#order_po_ID#&order_no=#attributes.order_no##Request.Token2#">Fill</a></cfif>
			</td>
		</tr>		
	</table>	
		
	<!--- Remove the current dropshipper from the list of order dropshippers --->
 <cfif listfind(basket_dropshipper_list,Account_ID)>
 	<cfset basket_dropshipper_list = listdeleteat(basket_dropshipper_list,listfind(basket_dropshipper_list,Account_ID))>
 </cfif>
	
	</cfoutput>

	
	
	<!--- Output remaining drop shippers for which no PO Record has been created --->
	<cfloop index="account_ID" list="#basket_dropshipper_list#">

		<cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/>
		<cfoutput>
	<table width="100%" class="formtext" style="color:###Request.GetColors.InputTText#">
		<!--- Row 1: account name & menu ---->
		<tr>
			<td width="49%"><strong>Dropshipper:</strong> <a href="#self#?fuseaction=users.admin&account=edit&account_ID=#account_ID##Request.Token2#">#vendors[account_ID]#</a></td>
			<td width="51%" align="right">
			<a href="#self#?fuseaction=shopping.admin&po=add&order_no=#attributes.order_no#&account_ID=#account_ID##Request.Token2#">Open Purchase Order</a>		</cfoutput>	
			</td>		
		</tr>
	</table>	
	
	</cfloop>

</cfif><!--- dropshipping info exists --->
