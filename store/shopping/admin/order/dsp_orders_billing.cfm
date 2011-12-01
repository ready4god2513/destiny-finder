<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the list of filled orders with payment pending, with filters to search for certain orders and batch actions to collect payment and/or mark the orders as paid. Called by shopping.admin&order=billing --->

<!--- Create the string with the filter parameters --->	
<cfset addedpath="&fuseaction=shopping.admin&order=#attributes.order#">
	<cfloop list="order_no,customer,orderdate,filled,paid,affiliate,status,sort,sortorder,offlinepayment" index="counter">
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

<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
 function CheckAll() {
   var ml = document.orderform;
   var len = ml.elements.length;
   for ( var i=0; i < len; i++)
     ml.elements[i].checked = true;
 }
 
 function UnCheckAll()
 {
   var ml = document.orderform;
   var len = ml.elements.length;
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
<table width="100%" cellspacing="4" border="0" cellpadding="0" class="formtext" style="color:###Request.GetColors.InputTText#">	</cfoutput>

	<cfif len(pt_pagethru)>
	<tr>
		<td colspan="7" align="right"><cfoutput>#pt_pagethru#</cfoutput></td>
	</tr>
	</cfif>

	<cfoutput>
	<form action="#self#?fuseaction=shopping.admin&order=#attributes.order##request.token2#" method="post">
	<tr>
	
		<td><span class="formtextsmall"><br/></span>
		<input type="submit" value="Search" class="formbutton"/></td>
		
		<!---- Invoice number ---->
		<td><span class="formtextsmall">order no.<br/></span>
			<input type="text" name="order_no" size="8" maxlength="10" class="formfield" value="#attributes.order_no#"/></td>	
		
		<!--- name field spans date & customer in list--->
		<td><span class="formtextsmall">customer<br/></span>
			<input type="text" name="customer" size="30" maxlength="25" class="formfield" value="#HTMLEditFormat(attributes.customer)#"/></td>				

		<td><span class="formtextsmall">date filled<br/></span>
		<input type="text" name="datefilled" size="8" maxlength="12" class="formfield" value="#attributes.datefilled#"/>
		</td>		
	
		<td colspan="2"><span class="formtextsmall">payment<br/></span>
<select name="offlinepayment"  class="formfield">
   <option value="" #doSelected(attributes.offlinepayment,'')#>All</option>
   <option value="Online" #doSelected(attributes.offlinepayment,'Online')#>Online</option>
   <option value="Offline" #doSelected(attributes.offlinepayment,'Offline')#>Offline</option>
   <option value="PayPal" #doSelected(attributes.offlinepayment,'PayPal')#>PayPal</option>
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
		<tr>
		<td align="center"><a href="#self#?fuseaction=shopping.admin&order=display&order_no=#order_no##Request.Token2#">
			 #(Order_No + Get_Order_Settings.BaseOrderNum)#</a></td>
		
		<td>#dateformat(DateOrdered,"mm/dd/yy")#</td>
		
		<td><cfif edituser><cfif uid><a href="#Request.StoreURL##self#?fuseaction=users.admin&user=edit&uid=#uid#&XFA_success=#URLEncodedFormat(addedpath)##Request.Token2#"><cfelse><a href="##" onclick="Guest(); return false;"></cfif>#firstname#  #lastname#</a>	
		<cfelse>#firstname#  #lastname#</cfif></td>
		
		<td>#dateformat(datefilled,"yyyy-mm-dd")#</td>
		
		<td>#OfflinePayment#</td>
			
		<td><cfif len(paypalstatus)>#paypalstatus#<cfelseif authnumber is not 0>#authnumber#</cfif></td>
		
		
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
			
	<tr>
		<td colspan="7" align="right" class="formtext">
			<select name="act" class="formfield">
			<option value="">select action...</option>
			<option value="paid">mark as paid</option>
			<option value="charge">charge credit cards</option>
			</select>
			<input type="submit" name="billprocess" value="process checked" class="formbutton"/>&nbsp;
		</td>
	</tr>	
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

		
