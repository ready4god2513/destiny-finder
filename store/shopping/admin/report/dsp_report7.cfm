<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the Coupon Totals Report. Only coupons used for order-based discounts are used. Called by dsp_reports.cfm --->

<tr><td colspan="2" align="CENTER"><cfoutput>
<strong>COUPON SALES REPORT - #LSDateFormat(StartDate, "mmm d, yyyy")# - #LSDateFormat(ToDate, "mmm d, yyyy")#</strong><br/>&nbsp;
</td></tr>
</cfoutput>

<cfif NOT ordersfound>
	<tr><td align="center">No coupon orders found for this date range.</td></tr>

<cfelse>
	
	<!--- Order-level discounts --->
	<cfif OrderDiscounts.RecordCount>

		<tr><td align="center"><strong>ORDER DISCOUNTS</strong></td></tr>
		<tr><td align="center">
		<cfoutput><table width="95%" border="0" cellspacing="0" cellpadding="5" bgcolor="###Request.GetColors.OutputTbgcolor#" align="center" class="formtext" style="color:###Request.GetColors.OutputTText#"> </cfoutput>
		<tr>
		<td><b>Coupon Code</b></td>
		<td><b>Orders</b></td>
		<td><b>Amount Sold</b></td>
		<td><b>Discount</b></td>
		<td><b>Net Sales</b></td>
		</tr>
		<cfoutput query="OrderDiscounts">
		<cfif CurrentRow MOD 2 IS 0>
			<tr>
		<cfelse>
			<tr bgcolor="###Request.GetColors.outputtaltcolor#">
		</cfif>
		<td>#Coup_Code#</td>
		<td align="center">#NumSales#</td>
		<td align="center">#LSCurrencyFormat(TotalSales)#</td>
		<td align="center">#LSCurrencyFormat(TotalDisc)#</td>
		<td align="center">#LSCurrencyFormat(TotalSales-TotalDisc)#</td>
		</tr>
		</cfoutput>
		</table><br/>&nbsp;
		</td></tr>
	</cfif>

	<cfif ProductDiscounts.RecordCount>
		<tr><td align="center"><strong>PRODUCT DISCOUNTS</strong></td></tr>
		<tr><td align="center">
		<cfoutput><table width="95%" border="0" cellspacing="0" cellpadding="5" bgcolor="###Request.GetColors.OutputTbgcolor#" align="center" class="formtext" style="color:###Request.GetColors.OutputTText#"> </cfoutput>
		<tr>
		<td><b>Coupon Code</b></td>
		<td><b>Orders</b></td>
		<td><b>Disc. Items Sold</b></td>
		<td><b>Amount Sold</b></td>
		<td><b>Discount</b></td>
		<td><b>Net Sales</b></td>
		</tr>
		<cfoutput query="ProductDiscounts">
			<!--- Extra query needed due to Access not supporting "Disinct" for aggregate functions --->
			<cfquery name="CountOrders" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			SELECT COUNT(Order_No) AS NumOrders
			FROM (SELECT DISTINCT O.Order_No FROM #Request.DB_Prefix#Order_Items O, #Request.DB_Prefix#Order_No N
				WHERE N.Order_No = O.Order_No
				AND N.DateOrdered >= #CreateODBCDateTime(StartDate)# 
				AND N.DateOrdered <= #CreateODBCDateTime(ToDate)# 
				AND N.Void = 0
				AND O.Disc_Code = '#ProductDiscounts.Disc_Code#') AS OrderSums
			</cfquery>
		<cfif CurrentRow MOD 2 IS 0>
			<tr>
		<cfelse>
			<tr bgcolor="###Request.GetColors.outputtaltcolor#">
		</cfif>
		<td>#Disc_Code#</td>
		<td align="center">#CountOrders.NumOrders#</td>
		<td align="center">#TotalItems#</td>
		<td align="center">#LSCurrencyFormat(TotalSales)#</td>
		<td align="center">#LSCurrencyFormat(TotalDisc)#</td>
		<td align="center">#LSCurrencyFormat(TotalSales-TotalDisc)#</td>
		</tr>
		</cfoutput>
		</table><br/>&nbsp;
		</td></tr>
	
	</cfif>
	
	<cfif Promotions.RecordCount>
	
		<tr><td align="center"><strong>PROMOTIONS</strong></td></tr>
		<tr><td align="center">
		<cfoutput><table width="95%" border="0" cellspacing="0" cellpadding="5" bgcolor="###Request.GetColors.OutputTbgcolor#" align="center" class="formtext" style="color:###Request.GetColors.OutputTText#"> </cfoutput>
		<tr>
		<td><b>Coupon Code</b></td>
		<td><b>Orders</b></td>
		<td><b>Promotional Items</b></td>
		<td><b>Total Promo Amount</b></td>
		</tr>
		<cfoutput query="Promotions">
			<!--- Extra query needed due to Access not supporting "Disinct" for aggregate functions --->
			<cfquery name="CountOrders" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			SELECT COUNT(Order_No) AS NumOrders
			FROM (SELECT DISTINCT O.Order_No FROM #Request.DB_Prefix#Order_Items O, #Request.DB_Prefix#Order_No N
				WHERE N.Order_No = O.Order_No
				AND N.DateOrdered >= #CreateODBCDateTime(StartDate)# 
				AND N.DateOrdered <= #CreateODBCDateTime(ToDate)# 
				AND N.Void = 0
				AND O.Promo_Code = '#Promotions.Promo_Code#') AS OrderSums
			</cfquery>
		<cfif CurrentRow MOD 2 IS 0>
			<tr>
		<cfelse>
			<tr bgcolor="###Request.GetColors.outputtaltcolor#">
		</cfif>
		<td>#Promo_Code#</td>
		<td align="center">#CountOrders.NumOrders#</td>
		<td align="center">#TotalItems#</td>
		<td align="center">#LSCurrencyFormat(TotalDisc)#</td>
		</tr>
		</cfoutput>
		</table><br/>&nbsp;
		</td></tr>
	
	</cfif>

</cfif>

