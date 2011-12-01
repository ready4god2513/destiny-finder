
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template processes the deletion of orders from the Filled Order Manager page. 
	  Either a list of orders (attributes.orderlist) are selected OR a month (attributes.month)
----->

<!--- Called by shopping.admin&order=filled --->

<cfparam name="attributes.orderlist" default="">
<cfparam name="attributes.message" default="">

<cfif attributes.purge is "delete checked">

	<cfif listlen(attributes.orderlist)>
	
		<cfloop index="order_no" list="#attributes.orderlist#">
		
			<cfinclude template="act_delete_order.cfm">
		
		</cfloop>
	
	</cfif>
	
<cfelseif attributes.purge is "clear month">
	
	<cfinclude template="act_purge_month.cfm">
	
</cfif>

<cfif len(attributes.message)>
	<cfset attributes.XFA_success=attributes.addedpath>
	<cfset attributes.box_title="Delete Orders">
	<cfinclude template="../../../includes/admin_confirmation.cfm">	
</cfif>

