<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the admin menu for shopping. Called by shopping.admin --->

<cfparam name="totaltabs" default="0">
<cfparam name="shoppingmenu" default="">
<cfset shopping_tab = 0>

<cfsavecontent variable="shoppingmenu">

<cfoutput>

	<!--- Shopping Permission 2 = order access --->
	<cfmodule template="../../access/secure.cfm"
	keyname="shopping"
	requiredPermission="2"
	/>
	<cfif ispermitted>
	<form name="orderjump" action="#self#?fuseaction=shopping.admin&order=display#request.token2#" method="post" target="AdminContent" class="nomargins">
	<input type="text" name="string" value="enter Order No..." size="20" maxlength="100" class="accordionTextBox" onfocus="orderjump.string.value = '';" onchange="submit();" />
	</form>
	</cfif>

	<!--- shopping permissions 2 = Order Access --->
	<cfmodule template="../../access/secure.cfm"
	keyname="shopping"
	requiredPermission="56"
	>
	<cfset shopping_tab = 1>
	<!--- mjs 09-26-2006 New code to correctly set links for order admins, according to permissions --->
	<cfinclude template="act_orderlink.cfm">

	<cfif order_pending>
		<cfset innertext = Application.objMenus.getPendingOrders()>
		<div id="Orders_Div" spry:region="txtPending"><a href="#linkURL#" onmouseover="return escape(shopping1)" target="AdminContent">Orders</a>: <span style="color: red"><span id="ordercount" spry:content="{Orders}">#innertext#</span> Pending.</span>
		</div>

	<cfelseif order_process>
		<!--- Check for new in-process orders --->
		<cfquery name="NewOrders" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT Order_No FROM #Request.DB_Prefix#Order_No 
		WHERE NOT Filled = 1 AND Process = 1
	</cfquery>
		<br/><a href="#linkURL#" onmouseover="return escape(shopping2)" target="AdminContent">Orders</a>

	<cfelseif order_po>
		<!--- Check for new POs --->
		<cfquery name="NewOrders" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT Order_PO_ID FROM #Request.DB_Prefix#Order_PO 
		WHERE PO_Open = 1
		</cfquery>
		<br/><a href="#linkURL#" onmouseover="return escape(shopping3)" target="AdminContent">Purchase Orders</strong></a>

	</cfif>
	<!--- end changes --->
	
	<!--- Order Reports --->
	<cfmodule template="../../access/secure.cfm"
	keyname="shopping"
	requiredPermission="128"
	>
	<cfset shopping_tab = 1>
	<br/><a href="#self#?fuseaction=shopping.admin&order=reports#Request.Token2#" onmouseover="return escape(shopping12)" target="AdminContent">Sales Reports</a>
	</cfmodule>
	
	<br/><a href="#self#?fuseaction=shopping.admin&order=cleartemp#Request.Token2#" onmouseover="return escape(shopping5)" target="AdminContent">Clear Temporary Tables</a>
	</cfmodule>
	
	<cfmodule template="../../access/secure.cfm"
	keyname="product"
	requiredPermission="4"
	> 
	<cfset shopping_tab = 1>
	<br/><a href="#self#?fuseaction=product.admin&discount=list#Request.Token2#" onmouseover="return escape(shopping10)" target="AdminContent">Discounts</a>
	</cfmodule>
	
	<cfmodule template="../../access/secure.cfm"
		keyname="product"
		requiredPermission="4"
		> 
		<cfset shopping_tab = 1>
		<br/><a href="#self#?fuseaction=product.admin&promotion=list#Request.Token2#" onmouseover="return escape(shopping11)" target="AdminContent">Promotions</a>
	</cfmodule>

	<!--- shopping permissions 1 = cart admin --->
	<cfmodule template="../../access/secure.cfm"
	keyname="shopping"
	requiredPermission="1"
	>
	<cfset shopping_tab = 1><br/>
	<a href="#self#?fuseaction=shopping.admin&payment=cards#Request.Token2#" onmouseover="return escape(shopping6)" target="AdminContent">Payment Settings</a><br/>
	<a href="#self#?fuseaction=shopping.admin&shipping=settings#Request.Token2#" onmouseover="return escape(shopping7)" target="AdminContent">Shipping Settings</a><br/>
	<a href="#self#?fuseaction=shopping.admin&taxes=codes#Request.Token2#" onmouseover="return escape(shopping8)" target="AdminContent">Tax Settings</a><br/>
	<a href="#self#?fuseaction=shopping.admin&cart=edit#Request.Token2#" onmouseover="return escape(shopping9)" target="AdminContent">Shopping Settings</a><br/>
	</cfmodule>

</cfoutput>

</cfsavecontent>

<cfif shopping_tab>
	<!--- If page being called is a shopping admin page, set tabs open on Shopping menu --->
	<cfif (FindNoCase("shopping.admin", attributes.xfa_admin_link))>
		<cfset tabstart = totaltabs>
	</cfif>
	
	<cfset totaltabs = totaltabs + 1>
</cfif>