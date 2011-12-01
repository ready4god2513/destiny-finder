<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the affiliate order report. Called from dsp_report.cfm --->

<cfquery name="GetOrders" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT * FROM #Request.DB_Prefix#Order_No
WHERE MONTH(DateOrdered) = <cfqueryparam value="#ListGetAt(attributes.Month, 1)#" cfsqltype="CF_SQL_INTEGER">
AND YEAR(DateOrdered) = <cfqueryparam value="#ListGetAt(attributes.Month, 2)#" cfsqltype="CF_SQL_INTEGER">
AND Affiliate = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#GetInfo.AffCode#">
AND Void = 0
ORDER BY Order_No
</CFQUERY>


<cfif NOT GetOrders.Recordcount>
	<tr>
		<td align="center" class="formtitle">
			No affiliate orders were found for this month.<br/><br/>
		</td>
	</tr>

<cfelse>

	<tr>
		<td>
		
<cfoutput>
<cfif len(GetInfo.FirstName)>
	Name: #GetInfo.FirstName# #GetInfo.LastName#<br/>
	<cfif len(GetInfo.Company)>Company: #GetInfo.Company#<br/></cfif>
<cfelse>
	User: #GetInfo.Username#<br/>
</cfif>
Affiliate ID: #GetInfo.AffCode#<br/>
Commission: <cfset Pct = (GetInfo.AffPercent * 100)>#Pct#%<p>
You generated #GetOrders.RecordCount# sale<cfif GetOrders.RecordCount GT 1>s</cfif> for this month.<p>
</cfoutput>
	
		<table cellspacing="2" cellpadding="5" border="0" class="formtextsmall">
			<tr>
   				<td>Order</td>
    			<td>Date</td>
    			<td>Filled?</td>
				<td>Gross</td>
  			    <td>Shipping</td>
    			<td>Tax</td>
				<td>Discounts</td>
   			    <td>Net</td>
				<td>Commission</td>
			</tr>
			
		<cfset SubTotal = 0>
		<cfset NetTotal = 0>

		<cfoutput query="GetOrders">
			<cfset itemnumber = GetOrders.CurrentRow>

			<!--- Output Information for Each Sale --->
			<tr>
    			<td>#(GetOrders.Order_No + Get_Order_Settings.BaseOrderNum)#</td>
    			<td>#DateFormat(GetOrders.DateOrdered,"MM/DD/YY")#</td>
				<td>#YesNoFormat(GetOrders.Filled)#</td>
    			<td>#LSCurrencyFormat(GetOrders.OrderTotal+GetOrders.OrderDisc+GetOrders.Credits)#</td>
    			<td>#LSCurrencyFormat(GetOrders.Shipping)#</td>
    			<td>#LSCurrencyFormat(GetOrders.Tax)#</td>
				<td>#LSCurrencyFormat(GetOrders.OrderDisc)#</td>
    			<td><cfset Net = (GetOrders.OrderTotal - GetOrders.Shipping - GetOrders.Tax + GetOrders.Credits)>#LSCurrencyFormat(Net)#</td>
				<td align="right"><cfset Ext = (Net * (GetInfo.AffPercent))> #LSCurrencyFormat(Ext)#</font></td>
			</tr>

			<cfset SubTotal = SubTotal + Ext>
			<cfset NetTotal = NetTotal + Net>
		</cfoutput>

		<!--- Output Basket Total --->
		<cfoutput>
		<tr>
			<td colspan="7" align="right"><b>Totals:</b></td>
			<td align="right">#LSCurrencyFormat(NetTotal)#</td>
			<td align="right">#LSCurrencyFormat(SubTotal)#</td>
		</tr>
		</cfoutput>

	</table>
	<br/>
	</cfif>

	</td></tr>
