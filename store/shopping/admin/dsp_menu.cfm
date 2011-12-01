<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the admin menu for shopping. Called by shopping.admin --->

<cfmodule template="../../access/secure.cfm"
keyname="shopping"
requiredPermission="1,4,2"
>
<cfoutput>

	<table width="90%" class="mainpage"><tr><td><strong>Shopping</strong></td>
		<!--- Shopping Permission 2 = order access --->
		<cfmodule template="../../access/secure.cfm"
		keyname="shopping"
		requiredPermission="2"
		/>
		<cfif ispermitted>
		<form name="orderjump" action="#self#?fuseaction=shopping.admin&order=display#request.token2#" method="post">
		<td align="right"><input type="text" name="string" value="enter Order No..." size="20" maxlength="100" class="formfield" onfocus="orderjump.string.value = '';" onchange="submit();" />
		</td></form>
		</cfif>
	</tr></table>

<ul>

	<!--- shopping permissions 2 = Order Access --->
	<cfmodule template="../../access/secure.cfm"
	keyname="shopping"
	requiredPermission="2"
	>
	
	<!--- mjs 09-26-2006 New code to correctly set links for order admins, according to permissions --->
	<cfinclude template="act_orderlink.cfm">

	<cfif order_pending>
	<!--- Check for new orders --->
		<cfquery name="NewOrders" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT Order_No FROM #Request.DB_Prefix#Order_No 
		WHERE NOT Filled = 1 AND NOT Process = 1
		</cfquery>
		<li><a href="#linkURL#"><strong>Orders</strong></a><cfif neworders.recordcount>:<span class="formerror"><strong>#neworders.recordcount# Order(s) Pending.</strong></span></cfif></li>

	<cfelseif order_process>
		<!--- Check for new in-process orders --->
		<cfquery name="NewOrders" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT Order_No FROM #Request.DB_Prefix#Order_No 
		WHERE NOT Filled = 1 AND Process = 1
	</cfquery>
		<li><a href="#linkURL#"><strong>Orders</strong></a><cfif neworders.recordcount>:<span class="formerror"><strong>#neworders.recordcount# Order(s) In-Process.</strong></span></cfif></li>

	<cfelseif order_po>
		<!--- Check for new POs --->
		<cfquery name="NewOrders" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT Order_PO_ID FROM #Request.DB_Prefix#Order_PO 
		WHERE PO_Open = 1
		</cfquery>
		<li><a href="#linkURL#"><strong>Purchase Orders</strong></a><cfif neworders.recordcount>:<span class="formerror"><strong>#neworders.recordcount# Open PO(s) In-Process.</strong></span></cfif></li>

	</cfif>
	<!--- end changes --->
	
	<li><a href="#self#?fuseaction=shopping.admin&order=download#Request.Token2#">Download Orders</a>: Download order information in CVS format.</li>
	<li><a href="#self#?fuseaction=shopping.admin&order=cleartemp#Request.Token2#">Clear Temporary Tables</a>: Removes temporary shopping cart and order information that is over 30 days old.</li>
	</cfmodule>

	<!--- shopping permissions 4 = gift certificates --->
	<cfmodule template="../../access/secure.cfm"
	keyname="shopping"
	requiredPermission="4"
	>
	<li><a href="#self#?fuseaction=shopping.admin&certificate=list#Request.Token2#">Gift Certificates</a>: Generate a code that users can enter into the shopping cart to get a discount.</li>
	</cfmodule>
	
	
	<!--- shopping permissions 1 = cart admin --->
	<cfmodule template="../../access/secure.cfm"
	keyname="shopping"
	requiredPermission="1"
	>

	<li><a href="#self#?fuseaction=shopping.admin&payment=cards#Request.Token2#">Payment Settings</a>: Define payment and online credit card processing options.</li>
	<li><a href="#self#?fuseaction=shopping.admin&shipping=settings#Request.Token2#">Shipping Settings</a>: Define how shipping is calculated for orders.</li>
	<li><a href="#self#?fuseaction=shopping.admin&taxes=codes#Request.Token2#">Tax Settings</a>: Define the store tax codes and rates.</li>
	<!--- Giftwrapping Options ------>
	<cfinclude template="../qry_get_order_settings.cfm">
	<cfif get_order_settings.giftwrap is 1>
	<li><a href="#self#?fuseaction=shopping.admin&giftwrap=list#Request.Token2#">Giftwrapping Options</a>: Define giftwrapping options available at checkout.</li>
	</cfif>
	<li><a href="#self#?fuseaction=shopping.admin&cart=edit#Request.Token2#">Shopping Settings</a>: Shopping, checkout and email confirmation options.</li>
	</cfmodule>
	
	
</ul>
</cfoutput>

<!--- CUSTOM CODE - Gift Registry ------>
<cfif Request.AppSettings.GiftRegistry>
	<cfinclude template="giftregistry/dsp_menu.cfm">
</cfif>
<!---- End Custom Code --->	
</cfmodule>