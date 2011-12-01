<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template performs batch processing of order from the pending and in process order lists.
	attributes.selected_orders:	 	orderlist | pending | process
	
	attributes.do:			invoice
							packlist
							fill - set filled = 1; email
							process - set process =1; email
							pending - set process = 0
							void-cancelled 
							void-fraud
							delete
 --->
 
 <!--- Called by shopping.admin&order=pending|process --->
 
<cfparam name="attributes.orderlist" default="">
<cfparam name="attributes.selected_orders" default="orderlist">

 
<!--- selected_orders will ether be 'orderlist' or 'pending' or 'process' --->
<cfif attributes.selected_orders is not "orderlist">
	
		<cfquery name="getorders" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT Order_No
		FROM #Request.DB_Prefix#Order_No 
		<cfif attributes.selected_orders is "pending">
			WHERE NOT Process = 1
		<cfelse>
			WHERE process = 1
			AND filled = 0
		</cfif>
		</cfquery>
	
		<cfset attributes.orderlist = valuelist(getorders.order_no)>

</cfif> 

 <!----------- 
<cfoutput>ORDERLIST: #attributes.orderlist#</cfoutput> 
 ---->

<cfif len(attributes.orderlist)>
	
	<cfif attributes.act is "invoice" or attributes.act is "packlist">
				
			<!--- Set list for next item in order detail page --->
			<cfset Session.orderlist="#attributes.orderlist#">
			
			<cfset browser=Trim(cgi.http_user_agent)>
			
			<cfprocessingdirective suppresswhitespace="no">
			<script type="text/javascript">
			function openWin( windowURL, windowName, windowFeatures ) { 
			return window.open( windowURL, windowName, windowFeatures ) ; 
			} 
	
			<cfif NOT cgi.http_user_agent CONTAINS "MSIE" AND NOT cgi.http_user_agent CONTAINS "Firefox">
				alert('Please note that IE 4 or better is required for correct printing of multiple orders!') ;
			</cfif>				
			window.open('<cfoutput>#self#?fuseaction=shopping.admin&order=print&print=#attributes.act#&redirect=yes&Order_No=orderlist#Request.Token2#</cfoutput>', 'order');
			</script>
			</cfprocessingdirective>
		

	<cfelse>

		<cfloop index="order_no" list="#attributes.orderlist#">
			<cfset attributes.order_no = order_no>
			<cfinclude template="act_order.cfm">
		</cfloop>
	
	</cfif>

</cfif>

<cfset attributes.order_no = "">

<!--- Refresh the admin menu --->
<cfinclude template="put_adminrefresh.cfm">

<cfif isDefined("attributes.message") AND len(attributes.message)>
	<cfset attributes.XFA_success="fuseaction=shopping.admin&order=#attributes.order#">
	<cfset attributes.box_title="Delete Orders">
	<cfinclude template="../../../includes/admin_confirmation.cfm">	
</cfif>

