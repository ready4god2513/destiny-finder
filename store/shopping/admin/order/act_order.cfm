<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template provides order processing functions. It can be called from order listings or detail page 
	attributes.order_no:	required
	attributes.act:			invoice - display invoice for printing
							packlist - display packing list for printing
							fill - set filled = 1; email
							process - set process =1; email
							pending - set process = 0
							void-cancelled 
							void-fraud
							delete
							update - process the order status screen
 --->
 
 <!--- Called by shopping.admin&order=display and from act_orders.cfm for bulk order processing --->
 
 <!--- First, retrieve the current status of this order, used for inventory tracking purposes --->
<cfquery name="GetInfo" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">	
	SELECT Process, Filled, Void, InvDone, OfflinePayment, PayPalStatus 
	FROM #Request.DB_Prefix#Order_No
	WHERE Order_No = #attributes.Order_No#
</cfquery>
	
<!--- By default, do not add or remove inventory --->
<cfset RemoveInt = "No">
<cfset ReturnInt = "No">
<cfset VoidOrder = "No">
<!--- Default is to remove credit card data --->
<cfset RemoveCard = "Yes">

<cfswitch expression="#attributes.act#">

	<!--- Print Invoice --->
	<cfcase value="invoice">
		<cfset browser=Trim(cgi.http_user_agent)>
			
		<cfprocessingdirective suppresswhitespace="no">
		<script type="text/javascript">
			function openWin( windowURL, windowName, windowFeatures ) { 
			return window.open( windowURL, windowName, windowFeatures ) ; 
			} 
	
			<cfif NOT cgi.http_user_agent CONTAINS "MSIE" AND NOT cgi.http_user_agent CONTAINS "Firefox" >
				alert('Please note that MSIE or Firefox is required for correct printing of multiple orders!') ;
			</cfif>					
			window.open('<cfoutput>#request.self#?fuseaction=shopping.admin&order=print&print=invoice&Order_No=#attributes.order_no##Request.Token2#</cfoutput>', 'order');
		</script>
	</cfprocessingdirective>
		
		<!-------------- Handled in index page above 
		<cfquery name="getinvoice" datasource="#Request.DS#" 
			username="#Request.user#" password="#Request.pass#">	
			SELECT Print FROM #Request.DB_Prefix#Order_No
			WHERE Order_No = #attributes.Order_No#
			</cfquery>

		<cfif getinvoice.print is not 1 and getinvoice.print is not 3>
			<cfquery name="invoice" datasource="#Request.DS#" 
				username="#Request.user#" password="#Request.pass#">	
				UPDATE #Request.DB_Prefix#Order_No
				Set Print = #evaluate(getinvoice.print + 1)#
				WHERE Order_No = #attributes.Order_No#
				</cfquery>
		</cfif>
		--------->
			
		<cfset RemoveCard = "No">
			
	</cfcase>
 

 
	<!--- Print Pick List --->
 	<cfcase value="packlist">
		<cfset browser=Trim(cgi.http_user_agent)>
			
		<cfprocessingdirective suppresswhitespace="no">
		<script type="text/javascript">
			function openWin( windowURL, windowName, windowFeatures ) { 
			return window.open( windowURL, windowName, windowFeatures ) ; 
			} 
	
			<cfif NOT cgi.http_user_agent CONTAINS "MSIE">
				alert('Please note that IE 4 or better is required for correct printing of multiple orders!') ;
			</cfif>				
			window.open('<cfoutput>#self#?fuseaction=shopping.admin&order=print&print=invoice&Order_No=#attributes.order_no##Request.Token2#</cfoutput>', 'order');
		</script>
		</cfprocessingdirective>
		
		<!---------------- handled within the index page above 
		<cfquery name="getinvoice" datasource="#Request.DS#" 
		username="#Request.user#" password="#Request.pass#">	
			SELECT Print FROM #Request.DB_Prefix#Order_No
			WHERE Order_No = #attributes.Order_No#
			</cfquery>

		<cfif getinvoice.print lt 2>
			<cfquery name="invoice" datasource="#Request.DS#" 
			username="#Request.user#" password="#Request.pass#">	
				UPDATE #Request.DB_Prefix#Order_No
				Set Print = #evaluate(getinvoice.print + 2)#
				WHERE Order_No = #attributes.Order_No#
			</cfquery>
		</cfif>
		--------------->
		
		<cfset RemoveCard = "No">
		
	</cfcase>
	
	
	<cfcase value="Fill">

		<cfquery name="fillorder" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			UPDATE #Request.DB_Prefix#Order_No
			SET Process = 1,
			Filled = 1,
			DateFilled = #CreateODBCDate(Now())#
			WHERE Order_No = #attributes.Order_No#
		</cfquery>
		
		<!--- Check if we need to remove inventory --->
		<cfif GetInfo.Process IS 0 AND GetInfo.Filled IS 0>
			<cfset RemoveInt = "Yes">
		<cfelseif GetInfo.Void IS 1>
			<cfset RemoveInt = "Yes">
		</cfif>

		<!--- If set to email dropshipper when order filled, send emails --->
		<cfif get_order_settings.EmailDrop and len(get_order_settings.DropEmail) AND
		 get_order_settings.EmailDropWhen IS "Filled">
			<cfinclude template="act_maildrop.cfm">
		</cfif>

	</cfcase>
	
	
	<cfcase value="Process">
		<cfquery name="processorder" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">	
			UPDATE #Request.DB_Prefix#Order_No
			SET Process = 1,
			Filled = 0,
			DateFilled = NULL
			WHERE Order_No = #attributes.Order_No#
		</cfquery>
		
		<!--- Check if we need to remove inventory --->
		<cfif GetInfo.Process IS 0 AND GetInfo.Filled IS 0>
			<cfset RemoveInt = "Yes">
		<cfelseif GetInfo.Void IS 1>
			<cfset RemoveInt = "Yes">
		</cfif>
		
		<!--- If set to email dropshipper when order processed, send emails --->
		<cfif get_order_settings.EmailDrop and len(get_order_settings.DropEmail) AND 
		get_order_settings.EmailDropWhen IS "Processed">
			<cfinclude template="act_maildrop.cfm">
		</cfif>

	</cfcase>

	
	
	<cfcase value="Pending">
		<cfquery name="pendingorder" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">	
			UPDATE #Request.DB_Prefix#Order_No
			SET Process = 0,		
			Filled = 0,
			DateFilled = NULL
			WHERE Order_No = #attributes.Order_No#
		</cfquery>
		
		<!--- Check if we need to return inventory --->
		<cfif (GetInfo.Process IS 1 OR GetInfo.Filled IS 1) AND GetInfo.Void IS 0>
			<cfset ReturnInt = "Yes">
		</cfif>

	</cfcase>
	
	
	<cfcase value="Update">
		<!---- processes the 'edit status' form on order managers edit order template.
		Attributes.void is either 0 or a void status (fraud,cancelled) ----->
		<cfif NOT len(Trim(attributes.Affiliate))>
			<cfset Affiliate = 0>
		<cfelse>
			<cfset Affiliate = attributes.Affiliate>
		</cfif>
		
		<cfparam name="attributes.printed" default="0">
		<cfif listlen(attributes.printed) is 2>
			<cfset attributes.printed = 3>
		</cfif>
		
		<cfset attributes.act = attributes.moveto>

		<cfquery name="Update" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">	
			UPDATE #Request.DB_Prefix#Order_No
			SET 

			<cfif attributes.moveto is "pending">
				Process = 0,
				Filled = 0,
				DateFilled = NULL,
				Void = 0,
				Status = '#attributes.status#',
			<cfelseif attributes.moveto is "process">
				Process = 1,
				Filled = 0,
				DateFilled = NULL,
				Void = 0,
				Status = '#attributes.status#',
			<cfelseif attributes.moveto is "fill">
				Process = 1,
				Filled = 1,
				<cfif GetInfo.Filled IS 0>DateFilled = #CreateODBCDate(Now())#,</cfif> 
				Void = 0,
				Status = '#attributes.status#',
			<cfelseif attributes.moveto is "cancelled" or attributes.moveto is "fraud">
				Process = 1,
				Filled = 1,
				Void = 1,
				Status = '#attributes.moveto#',
			</cfif>	
				Paid = #attributes.paid#,
				Affiliate = #Affiliate#,
				Printed = #attributes.printed#,
				Notes = '#attributes.notes#',
				Admin_Name = '#Session.Realname#',
				Admin_Updated = #createodbcdatetime(Now())#
			WHERE Order_No = #attributes.Order_No#
		</cfquery>
		
		<!--- Check if we need to remove inventory --->
		<cfif attributes.moveto is "process" OR attributes.moveto is "fill">
			<cfif GetInfo.Process IS 0 AND GetInfo.Filled IS 0>
				<cfset RemoveInt = "Yes">
			<cfelseif GetInfo.Void IS 1>
				<cfset RemoveInt = "Yes">
			</cfif>
		<cfelseif attributes.moveto is "pending">
			<!--- Check if we need to return inventory --->
			<cfif (GetInfo.Process IS 1 OR GetInfo.Filled IS 1) AND GetInfo.Void IS 0>
				<cfset ReturnInt = "Yes">
			<!--- Check if this is a pending order that is staying pending --->
			<cfelseif GetInfo.Process IS 0 AND GetInfo.Filled IS 0 AND GetInfo.Void IS 0>
				<cfset RemoveCard = "No">
			</cfif>
		<cfelseif attributes.moveto is "cancelled" or attributes.moveto is "fraud" AND GetInfo.Void IS 0>
			<cfset ReturnInt = "Yes">
			<cfset VoidOrder = "Yes">
		</cfif>
		
		<!--- Send drop-shipper emails --->
		<cfif attributes.moveto is "process" AND get_order_settings.EmailDrop 
			AND len(get_order_settings.DropEmail) AND get_order_settings.EmailDropWhen IS "Processed">
			<cfinclude template="act_maildrop.cfm">
		<cfelseif attributes.moveto is "fill" AND get_order_settings.EmailDrop AND 
			len(get_order_settings.DropEmail) AND get_order_settings.EmailDropWhen IS "Filled">
			<cfinclude template="act_maildrop.cfm">
		</cfif>
		
	</cfcase>
	
		
	<cfcase value="edit">
		<cfquery name="editorder" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">	
			UPDATE #Request.DB_Prefix#Order_No
			SET 
				Shipping = #attributes.shipping#,
				Tax = #attributes.tax#,
				AdminCreditText = '#attributes.adminCredittext#',
				AdminCredit = #attributes.adminCredit#,
				Admin_Name = '#Session.Realname#',
				Admin_Updated = #CreateODBCDateTime(Now())#
			WHERE Order_No = #attributes.Order_No#
		</cfquery>
		
		<cfset RemoveCard = "No">
	</cfcase>
	
	
	<cfcase value="Delete">
		<cfset ReturnInt = "Yes">
		<cfset VoidOrder = "Yes">
		<cfinclude template="act_delete_order.cfm">		
	</cfcase>
	
	<cfdefaultcase>
		<cfset RemoveCard = "No">
	</cfdefaultcase>

</cfswitch> 


<!--- Check for voided order --->
<cfif left(attributes.act,4) is "Void">
			
	<cfquery name="voidorder" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">	
		UPDATE #Request.DB_Prefix#Order_No
		SET Void = 1,
		Process = 1,
		Filled = 1,
		Status = '#listlast(attributes.act,"-")#',
		DateFilled = #CreateODBCDate(Now())#
		WHERE Order_No = #attributes.Order_No#
	</cfquery>
	
	<!--- Check if we need to return inventory --->
	<cfif GetInfo.Void IS 0>
		<cfset ReturnInt = "Yes">
		<cfset VoidOrder = "Yes">
	</cfif>
		
</cfif>  
 
 
<!--- Remove full credit card information --->
<cfif RemoveCard>
	<cfinclude template="act_update_card.cfm"> 
</cfif> 

<!--- Double-check that inventory not removed yet and inventory management is turned on --->
<cfif RemoveInt AND NOT GetInfo.InvDone AND Request.AppSettings.InvLevel IS NOT "None">
	<cfinclude template="act_remove_inventory.cfm">
</cfif>


<!--- Only return inventory if it has previously been removed --->
<cfif ReturnInt AND GetInfo.InvDone>
	<cfinclude template="act_reverse_inventory.cfm">
</cfif>



