<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the Affiliate Sales Report. Called by dsp_reports.cfm --->

<tr><td colspan="2" align="CENTER"><cfoutput>
<strong>AFFILIATE REPORT - #LSDateFormat(StartDate, "mmm d, yyyy")# - #LSDateFormat(ToDate, "mmm d, yyyy")#</strong><br/>&nbsp;
</td></tr>
</cfoutput>

<cfif NOT GetOrders.RecordCount>
<tr><td align="center">No orders for affiliates found for this date range.</td></tr>

<cfelse>

<tr><td align="center">
<cfoutput><table width="95%" border="0" cellspacing="0" cellpadding="5" bgcolor="###Request.GetColors.OutputTbgcolor#" align="center" class="formtext" style="color:###Request.GetColors.OutputTText#"> </cfoutput>
<tr>
<td><b>Affiliate</b></td>
<td><b>Affiliate Code</b></td>
<td><b>Percentage</b></td>
<td><b>Total Sales</b></td>
<td><b>Referral Fee</b></td>
</tr>
<cfset counter = 0>
<cfoutput query="GetOrders">
<cfquery name="GetAffiliate" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT A.*, U.Username, C.FirstName, C.LastName
FROM (#Request.DB_Prefix#Affiliates A 
		INNER JOIN #Request.DB_Prefix#Users U ON A.Affiliate_ID = U.Affiliate_ID)
LEFT JOIN #Request.DB_Prefix#Customers C ON U.Customer_ID = C.Customer_ID
WHERE #GetOrders.Affiliate# = A.AffCode
</cfquery>

<cfif GetAffiliate.RecordCount>
<cfset counter = counter + 1>
<cfif counter MOD 2 IS 0>
	<tr>
<cfelse>
	<tr bgcolor="###Request.GetColors.outputtaltcolor#">
</cfif>
<cfif len(GetAffiliate.FirstName)>
	<td>#GetAffiliate.FirstName# #GetAffiliate.LastName#</td>
<cfelse>
	<td>#GetAffiliate.Username#</td>
</cfif>
<td align="center">#GetAffiliate.AffCode#</td>
<td align="center">#(GetAffiliate.AffPercent * 100)#%</td>
<cfset AffTotal = (TotalSales + TotalCredit - TotalTax - TotalShipping)>
<td align="center">#LSCurrencyFormat(AffTotal)#</td>
<td align="center">#LSCurrencyFormat(Evaluate(AffTotal*GetAffiliate.Affpercent))#</td>
</tr>
</cfif>

</cfoutput>
</table>
</td></tr>

</cfif>

