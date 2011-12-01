<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the Sales Summary Report. Called by dsp_reports.cfm --->


<tr><td colspan="2" align="CENTER"><cfoutput>
<strong>SALES SUMMARY - #LSDateFormat(StartDate, "mmm d, yyyy")# - #LSDateFormat(ToDate, "mmm d, yyyy")#</strong><br/>&nbsp;
</td></tr>
</cfoutput>

<cfif GetOrders.TotalSales IS "">
<tr><td align="center">No orders found for this date range.</td></tr>

<cfelse>
<tr><td align="center">
<cfoutput><table width="250" border="0" cellspacing="0" cellpadding="5" bgcolor="###Request.GetColors.OutputTbgcolor#" align="center" class="formtext" style="color:###Request.GetColors.OutputTText#"> 
<tr bgcolor="###Request.GetColors.outputtaltcolor#">
<td align="left"><b>Total Orders:</b></td>
<td align="right">#GetOrders.NumOrders#</td>
<td width="10">&nbsp;</td>
</tr>

<tr>
<td align="left"><b>Total Sales:</b></td>
<td align="right">&nbsp;&nbsp;&nbsp;#LSCurrencyFormat(GetOrders.TotalSales + GetOrders.TotalCredit - GetOrders.TotalTax - GetOrders.TotalShipping)#</td>
<td width="10">&nbsp;</td>
</tr>

<tr bgcolor="###Request.GetColors.outputtaltcolor#">
<td align="left"><b>Pending Sales:</b></td>
<cfif PendingOrders.TotalPending IS "">
	<td align="right">&nbsp;&nbsp;&nbsp;-#LSCurrencyFormat(0)#</td>
	<cfset FinalTax = GetOrders.TotalTax>
	<cfset FinalShipping = GetOrders.TotalShipping>
	<cfset FinalCredit = GetOrders.TotalCredit>
	<cfset FinalTotal = GetOrders.TotalSales>
<cfelse>
	<td align="right">&nbsp;&nbsp;&nbsp;-#LSCurrencyFormat(PendingOrders.TotalPending + PendingOrders.PendingCredit -PendingOrders.PendingTax - PendingOrders.PendingShipping)#</td>
	<cfset FinalTax = GetOrders.TotalTax-PendingOrders.PendingTax>
	<cfset FinalShipping = GetOrders.TotalShipping-PendingOrders.PendingShipping>
	<cfset FinalCredit = GetOrders.TotalCredit-PendingOrders.PendingCredit>
	<cfset FinalTotal = GetOrders.TotalSales-PendingOrders.TotalPending>
</cfif>
<td width="10">&nbsp;</td>
</tr>

<tr>
<td align="left"><b>Tax Collected:</b></td>
<td align="right"> #LSCurrencyFormat(FinalTax)#</td>
<td width="10">&nbsp;</td>
</tr>

<tr bgcolor="###Request.GetColors.outputtaltcolor#">
<td align="left"><b>Shipping Collected:</b></td>
<td align="right"> #LSCurrencyFormat(FinalShipping)#</td>
<td width="10">&nbsp;</td>
</tr>

<tr>
<td align="left"><b>Credits Given:</b></td>
<td align="right"> -#LSCurrencyFormat(FinalCredit)#</td>
<td width="10">&nbsp;</td>
</tr>

<tr bgcolor="###Request.GetColors.outputtaltcolor#">
<td align="left"><b>Total Collected:</b></td>
<td align="right"> #LSCurrencyFormat(FinalTotal)#</td>
<td width="10">&nbsp;</td>
</tr>

</table>
</cfoutput>
</td></tr>
</cfif>


