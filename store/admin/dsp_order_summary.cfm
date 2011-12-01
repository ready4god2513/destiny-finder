
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the order sales summary on the main admin home page.  Called by dsp_admin_home.cfm --->

<!--- Order reports permissions --->
<cfmodule template="../access/secure.cfm"
	keyname="shopping"
	requiredPermission="128"
	>
	<cfif ispermitted>
	
	<cfoutput>
	<span class="mainpage">
	<table cellspacing="2" cellpadding="2" border="0" class="mainpage">
	<tr>
	    <td align="right"><strong>Today: </strong></td>
	    <td>#OrdersToday.NumOrders# Order<cfif OrdersToday.NumOrders IS NOT 1>s</cfif>, 
			#LSCurrencyFormat(Val(OrdersToday.TotalSales))# Total</td>
	</tr>
	<tr>
	    <td align="right"><strong>Yesterday: </strong></td>
	    <td>#OrdersYester.NumOrders# Order<cfif OrdersYester.NumOrders IS NOT 1>s</cfif>, 
			#LSCurrencyFormat(Val(OrdersYester.TotalSales))# Total</td>
	</tr>
	<tr>
	    <td align="right"><br/><strong>This Month: </strong></td>
	    <td><br/>#OrdersMonth.NumOrders# Order<cfif OrdersMonth.NumOrders IS NOT 1>s</cfif>, 
			#LSCurrencyFormat(Val(OrdersMonth.TotalSales))# Total</td>
	</tr>
	<tr>
	    <td align="right"><strong>Last Month: </strong></td>
	    <td>#OrdersLastMonth.NumOrders# Order<cfif OrdersLastMonth.NumOrders IS NOT 1>s</cfif>, 
			#LSCurrencyFormat(Val(OrdersLastMonth.TotalSales))# Total</td>
	</tr>
	<tr align="right">
	    <td><br/><strong>This Year: </strong></td>
	    <td><br/>#OrdersYear.NumOrders# Order<cfif OrdersYear.NumOrders IS NOT 1>s</cfif>, 
			#LSCurrencyFormat(Val(OrdersYear.TotalSales))# Total</td>
	</tr>
	<tr  align="right">
	    <td><strong>Last Year: </strong></td>
	    <td>#OrdersLastYear.NumOrders# Order<cfif OrdersLastYear.NumOrders IS NOT 1>s</cfif>, 
			#LSCurrencyFormat(Val(OrdersLastYear.TotalSales))# Total</td>
	</tr>
	</table>

	</cfoutput>
	
	<cfelse>
	<span class="mainpage">	
	Order Reports not available.<br/><br/>
	</span>
	</cfif>
	
	