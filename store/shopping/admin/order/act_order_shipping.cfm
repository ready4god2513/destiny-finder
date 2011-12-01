<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Processes the Order Shipping Screen. Updates the order information and sends emails. Called by shopping.admin&order=shipping --->

<!--- First, retrieve the current status of this order, used for inventory tracking purposes --->
<cfquery name="GetInfo" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">	
	SELECT Process, Filled, Void, InvDone FROM #Request.DB_Prefix#Order_No
	WHERE Order_No = #attributes.Order_No#
	</cfquery>
	
<!--- By default, do not add or remove inventory --->
<cfset RemoveInt = "No">
	
	<!--- Update Order --->
	<cfquery name="UpdateOrder" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	UPDATE #Request.DB_Prefix#Order_No
	SET Filled = 1,
	Process = 1,
	Tracking = <cfif len(Trim(attributes.Tracking))>'#Trim(attributes.Tracking)#'<cfelse>NULL</cfif>,
	Shipper = '#attributes.Shipper#',
	DateFilled = #CreateODBCDate(Now())#
	WHERE Order_No = #attributes.Order_No#
	</cfquery>
	
	<!--- Remove full credit card information --->
	<cfinclude template="act_update_card.cfm">

	<!--- If set to email dropshipper when order filled, send emails --->
	<cfif get_order_settings.EmailDrop and len(get_order_settings.DropEmail) AND
	 get_order_settings.EmailDropWhen IS "Filled">
		<cfset Order_No = attributes.Order_No>
		<cfinclude template="act_maildrop.cfm">
	</cfif>
 
	<!--- If Email customer check, send email with tracking numbers --->
	<cfif attributes.EmailCustomer is "1">
		<cfinclude template="act_emailtrack.cfm"> 
	</cfif>	
	
	<!--- Check if we need to remove inventory --->
	<cfif GetInfo.Process IS 0 AND GetInfo.Filled IS 0>
		<cfset RemoveInt = "Yes">
	<cfelseif GetInfo.Void IS 1>
		<cfset RemoveInt = "Yes">
	</cfif>
	
	<cfif RemoveInt AND NOT GetInfo.InvDone>
		<cfinclude template="act_remove_inventory.cfm">
	</cfif>
	

