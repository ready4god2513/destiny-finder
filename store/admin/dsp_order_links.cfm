

<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to display the links for the last 10 orders on the admin homepage, according to permissions. Called from dsp_admin_home.cfm --->

<!--- Check for order viewing permission level--->
<cfset order_pending = 0>
<cfset order_process = 0>
	
<cfinclude template="../shopping/qry_get_order_settings.cfm">	

<cfset linkURL = "#self#?fuseaction=shopping.admin&order=display#Request.Token2#">

<cfmodule template="../access/secure.cfm" keyname="shopping" requiredPermission="2">
<cfif ispermitted>
	<cfset orderaccess = 1>
<cfelse>
	<cfset orderaccess = 0>
</cfif>

<cfmodule template="../access/secure.cfm" keyname="shopping" requiredPermission="8">

<cfif ispermitted>

	<cfset order_pending = 1>	
	
<cfelse>
	<cfmodule template="../access/secure.cfm" keyname="shopping" requiredPermission="16">
	
	<cfif ispermitted>
		
		<cfset order_process = 1>
		
	</cfif>

</cfif>

<cfinclude template="qry_recent_orders.cfm">

<table border="0" cellpadding="2" cellspacing="2" class="mainpage">
<cfoutput query="qry_get_Orders">
<tr><td><cfif orderaccess><a href="#linkURL#&order_no=#order_no#"></cfif>Order #(Order_No + Get_Order_Settings.BaseOrderNum)#:<cfif orderaccess></a></cfif></td>
	<td>#DateFormat(DateOrdered, "mmm dd")#</td> <td align="right">#LSCurrencyFormat(OrderTotal)#</td>
<td>#FirstName# #LastName#</td></tr>	
</cfoutput>	
</table>

