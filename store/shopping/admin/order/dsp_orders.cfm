<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the list of orders, with filters to search for certain orders and batch actions to perform on the orders. Called by shopping.admin&order=pending|process --->

<!--- Create the string with the filter parameters --->	
<cfset addedpath="&fuseaction=shopping.admin&order=#attributes.order#">
	<cfloop list="order_no,customer,orderdate,startdate,todate,filled,paid,affiliate,status,sort,sortorder" index="counter">
		<cfif isdefined('attributes.' & counter) and len(evaluate('attributes.' & counter))>
			<cfset addedpath="#addedpath#&#counter#=" & evaluate('attributes.' & counter)>
		</cfif>
	</cfloop>
	
<!----- Set this page for return to list ------->
<cfset Session.Page="#self#?#right(addedpath,len(addedpath)-1)##Request.Token2#">
	
<cfparam name="attributes.orderlist" default="">
<cfparam name="currentpage" default="1">	

<!--- Create the page through links, max records set to 20 --->
<cfmodule template="../../../customtags/pagethru.cfm" 
	totalrecords="#qry_get_orders.recordcount#" 
	currentpage="#currentpage#"
	templateurl="#self#"
	addedpath="#addedpath##request.token2#"
	displaycount="20" 
	imagepath="#request.appsettings.defaultimages#/icons/" 
	imageheight="12" 
	imagewidth="12"
	hilightcolor="###request.getcolors.mainlink#" 
	>
		
<cfinclude template="../../../queries/qry_getpicklists.cfm">		


<!--- see if user has permission to edit user information --->
<cfmodule template="../../../access/secure.cfm"
keyname="users"
requiredPermission="4"
>
<cfif ispermitted>
	<cfset edituser = 1>
<cfelse>
	<cfset edituser = 0>
</cfif>	

<cfmodule template="../../../access/secure.cfm"
	keyname="shopping"
	requiredPermission="2"
	>
<cfif ispermitted>
	<cfset orderaccess = 1>
<cfelse>
	<cfset orderaccess = 0>
</cfif>

<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
	function CheckAll() {
  	var ml = document.orderform;
  	var len = ml.elements.length-2;
 	 for ( var i=0; i < len; i++)
     ml.elements[i].checked = true;
	}

	function UnCheckAll()
	{
  	var ml = document.orderform;
 	 var len = ml.elements.length-3;
  	for ( var i=0; i < len; i++)
   	  ml.elements[i].checked = false;
	}
	
	function Guest()
	{
  	alert('Guest account, no user information');
	}
	
</script>
</cfprocessingdirective>


<cfmodule template="../../../customtags/format_output_admin.cfm"
	box_title="Order Manager"
	Width="650"
	menutabs="yes">

<cfinclude template="dsp_menu.cfm">
	
<cfoutput>	
<table width="100%" cellspacing="4" border="0" cellpadding="0" class="formtext" style="color:###Request.GetColors.InputTText#">	

	<cfif len(pt_pagethru)>
	<tr>
		<td colspan="7" align="right">#pt_pagethru#</td>
	</tr>
	</cfif>

	<form action="#self#?fuseaction=shopping.admin&order=#attributes.order##request.token2#" method="post">
	
	<tr>
		<td><span class="formtextsmall"><br/></span>
		<input type="submit" value="Search" class="formbutton"/></td>
			
		<!------------		----------->
		<td><span class="formtextsmall">order date<br/></span>
		<select name="orderdate"  class="formfield">
		<option value="" #doSelected(attributes.orderdate,'')#>All</option>
			<cfset datecheck = dateformat(now(),'yyyy-mm-dd')>
		<option value="#datecheck#" #doSelected(attributes.orderdate, datecheck)#>today</option>
			<cfset datecheck = dateformat(DateAdd('d',-1,now()),'yyyy-mm-dd')>
		<option value="#datecheck#" #doSelected(attributes.orderdate, datecheck)#>yesterday</option>
			<cfset datecheck = dateformat(now(),'yyyy-mm')>
		<option value="#datecheck#" #doSelected(attributes.orderdate, datecheck)#>this month</option>
			<cfset datecheck = dateformat(DateAdd('m',-1,now()),'yyyy-mm')>
		<option value="#datecheck#" #doSelected(attributes.orderdate, datecheck)#>last month</option>
			<cfset datecheck = dateformat(now(),'yyyy')>
		<option value="#datecheck#" #doSelected(attributes.orderdate, datecheck)#>this year</option>
		</select></td>	
		
		<!--- name field spans date & customer in list--->
		<td><span class="formtextsmall">customer<br/></span>
			<input type="text" name="customer" size="25" maxlength="25" class="formfield" value="#HTMLEditFormat(attributes.customer)#"/></td>		

		<td><span class="formtextsmall">paid<br/></span>
		<select name="paid"  class="formfield">
		<option value="" #doSelected(attributes.paid,'')#>All</option>
		<option value="1" #doSelected(attributes.paid,1)#>Yes</option>
		<option value="0" #doSelected(attributes.paid,0)#>No</option>
		</select></td>			
	
		<td><span class="formtextsmall">shipping status<br/></span>
		<select name="status"  class="formfield">
			<option value="" #doSelected(attributes.status,'')#>All</option>
			<option value="none" #doSelected(attributes.status,"none")#>none</option>
			<cfmodule template="../../../customtags/form/dropdown.cfm"
			mode="valuelist"
			valuelist="#qry_getpicklists.shipping_status#"
			selected="#attributes.status#"
			/>
		</select></td>				
	
		<td><span class="formtextsmall">sort<br/></span>
		<select name="sort"  class="formfield">
		<option value="" #doSelected(attributes.sort,'')#>Order No</option>
		<option value="printinv" #doSelected(attributes.sort,'printinv')#>Print Inv</option>
		<option value="printpack" #doSelected(attributes.sort,'printpack')#>Print Pack</option>
		<option value="customer" #doSelected(attributes.sort,'customer')#>Customer</option>
		<option value="paytype" #doSelected(attributes.sort,'paytype')#>Payment</option>
		<option value="shiptype" #doSelected(attributes.sort,'shiptype')#>Shipping</option>
		<option value="status" #doSelected(attributes.sort,'status')#>Status</option>	
		</select></td>					
						
		<td><br/><a href="#self#?fuseaction=shopping.admin&order=#attributes.order##Request.Token2#">ALL</a><br/>
		</td></tr>
		</form>
	
	<tr>
		<td colspan="7" style="BACKGROUND-COLOR: ###Request.GetColors.inputHBgcolor#;">
		<img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="1" width="1" /></td>	
</tr>
	
<cfif qry_get_Orders.recordcount gt 0>					

	<form action="#self#?currentpage=#currentpage##addedpath##request.token2#" method="post" name="orderform">

	<cfloop query="qry_get_Orders" startrow="#PT_StartRow#" endrow="#PT_Endrow#">
	<!--- Extra query needed due to Access not supporting "Distinct" for aggregate functions --->
		<cfquery name="getProds" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			SELECT Count(Product_ID) As TotalProds, SUM(Items) AS TotalItems
			FROM (SELECT DISTINCT Product_ID, SUM(Quantity) AS Items FROM #Request.DB_Prefix#Order_Items
					WHERE Order_No = #qry_get_Orders.Order_No#
					GROUP BY Product_ID) AS ProdSums
		</cfquery>
		
		<tr>
		<td align="center" valign="top"><cfif orderaccess><a href="#self#?fuseaction=shopping.admin&order=display&order_no=#order_no##Request.Token2#"></cfif>
			 #(Order_No + Get_Order_Settings.BaseOrderNum)#<cfif orderaccess></a></cfif></td>
		
		<td valign="top">#dateformat(DateOrdered,"mm/dd/yy")#</td>
		<td><cfif edituser><cfif uid><a href="#Request.StoreURL##self#?fuseaction=users.admin&user=summary&newWindow=yes&uid=#uid##Request.Token2#" target="user"><cfelse><a href="##" onclick="Guest();return false;"></cfif>#firstname# #lastname#</a>		
		<cfelse>#firstname#  #lastname#</cfif><br/>
		<div style="font-size:9px;">#getProds.TotalProds# product<cfif getProds.TotalProds GT 1>s</cfif> (#getProds.TotalItems# items total)</div>
		</td>		

		<td align="center" valign="top"><cfif paid is 1>Yes<cfelse>No</cfif></td>		
		
		<td valign="top">#status#</td>		
				
		<td valign="top"><cfif attributes.sort is "printinv">
				<cfif printed is 1 or printed is 3>inv printed</cfif>
			<cfelseif attributes.sort is "printpack">
				<cfif printed gte 2>packlist</cfif>
			<cfelseif attributes.sort is "paytype">	
				#OfflinePayment#
			<cfelseif attributes.sort is "shiptype">
				<cfif shiptype is not "No Shipping">
					<a href="#self#?fuseaction=shopping.admin&order=shipping&order_no=#qry_get_Orders.Order_No#&xfa_success=#URLEncodedFormat(right(addedpath,len(addedpath)-1))##request.token2#">#shiptype#</a>
				<cfelse>
					#shiptype#
				</cfif>			
				
			<cfelseif attributes.sort is "customer">
				<a href="#self#?fuseaction=shopping.admin&order=filled&UID=#UID#">history</a>
			</cfif></td>			
		
		<td><input type="checkbox" name="orderlist" value="#order_no#" #doChecked(listfind(attributes.orderlist,order_no))# /></td>
	</tr>
	
	</cfloop>					
	
		<tr><td colspan="7" align="right" class="formtext">
			<a href="javascript:CheckAll();">Check All</a> | 
			<a href="javascript:UnCheckAll();">Uncheck All</a>
			<!---<br/>#pt_pagethru# --->
		</td></tr>			
			
	<tr>
		<td colspan="7" style="BACKGROUND-COLOR: ###Request.GetColors.inputHBgcolor#;">
		<img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="1" width="1" /></td>
	</tr>
	
			<tr><td colspan="8" align="right" class="formtext">
			#pt_pagethru#
			</td></tr>			
			
	<tr><td colspan="8" align="center" class="formtext">
			<select name="act" class="formfield">
			<option value="">select action...</option>
			<option value="invoice">print invoices</option>
			<option value="packlist">print packlists</option>
			<cfif attributes.order is "pending">
			<option value="process">Move to In Process</option>
			<cfelse>
			<option value="pending">Move to Pending</option>
			</cfif>
			<option value="fill">Move to Filled </option>
			<option value="void-cancelled">Void - cancelled</option>
			<option value="void-fraud">Void - fraud</option>
			</select>
			&nbsp;for &nbsp;<input type="radio" name="selected_orders" value="orderlist" checked="checked" />checked orders only &nbsp;
			<input type="radio" name="selected_orders" value="#attributes.order#" />all <cfif attributes.order is "pending">Pending<cfelse>In Process</cfif> orders
	</td></tr>
			
	<tr><td colspan="8" align="center" class="formtext">
		<input type="submit" name="batchprocess" value="batch process" class="formbutton"/>
		</td></tr>	
	</form>
	</table>
		
	<cfelse>	
		<td colspan="7">
		<br/>
		No records selected
		</td>
	</table>	
	</cfif>
	
</cfoutput>

<!---- CLOSE MODULE ----->
</cfmodule>

		
