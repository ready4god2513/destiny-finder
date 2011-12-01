<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the list of purchase orders, with filters to search for specific records. Called by shopping.admin&po=list --->

<!--- Create the string with the filter parameters --->	
<cfset addedpath="&fuseaction=shopping.admin&po=list">
	<cfloop list="order_no,order_num,po_no,account_id,printdate,status,shipdate,open" index="counter">
		<cfif isdefined('attributes.' & counter) and len(evaluate('attributes.' & counter))>
			<cfset addedpath="#addedpath#&#counter#=" & evaluate('attributes.' & counter)>
		</cfif>
	</cfloop>
	
	
<cfparam name="currentpage" default="1">	

<!--- see if user has permission to edit account information --->
<cfmodule template="../../../access/secure.cfm"
keyname="users"
requiredPermission="4"
>
<cfif ispermitted>
	<cfset editaccount = 1>
<cfelse>
	<cfset editaccount = 0>
</cfif>	

<!--- Create the page through links, max records set to 20 --->
<cfmodule template="../../../customtags/pagethru.cfm" 
	totalrecords="#qry_get_order_po.recordcount#" 
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
<cfinclude template="../../../users/account/qry_get_vendors.cfm">		

<cfmodule template="../../../customtags/format_output_admin.cfm"
	box_title="Order Manager"
	Width="650"
	menutabs="yes">
	
	<cfinclude template="../order/dsp_menu.cfm">
	
<cfoutput>
<table width="100%" cellspacing="4" border="0" cellpadding="0" class="formtext" style="color:###Request.GetColors.InputTText#">	

	<cfif len(pt_pagethru)>
	<tr>
		<td colspan="8" align="right">#pt_pagethru#</td>
	</tr>
	</cfif>

	<form action="#self#?fuseaction=shopping.admin&po=list#request.token2#" method="post">
	
	<tr>
	
		<td><span class="formtextsmall"><br/></span>
		<input type="submit" value="Search" class="formbutton"/></td>

		<!---- Order number - order_num is order_no plus base ---->
		<td><span class="formtextsmall">order no.<br/></span>
			<input type="text" name="order_num" size="5" maxlength="10" class="formfield" value="#attributes.order_num#"/></td>	

		<!---- PO number 
		<td><span class="formtextsmall">po no.<br/></span>
			<input type="text" name="po_no" size="5" maxlength="10" class="formfield" value="<cfoutput>#attributes.po_no#</cfoutput>"></td>	
		---->
	
		<!--- vendor --->
		<td><span class="formtextsmall">account<br/></span>
			<select name="Account_ID" class="formfield">
				<option value="" #doSelected(attributes.account_ID,'')#></option>
				<cfloop query="qry_get_vendors">
				<option value="#Account_ID#" #doSelected(attributes.Account_ID,qry_get_vendors.account_ID)#>#Account_name#</option>
			 	</cfloop>
			 </select>			
		</td>	
		
		<td><span class="formtextsmall">date created<br/></span>
		<input type="text" name="printdate" size="8" maxlength="12" class="formfield" value="#attributes.printdate#"/>
		</td>	
	
		<td><span class="formtextsmall">status<br/></span>
		<select name="status"  class="formfield">
			<option value="" #doSelected(attributes.status,'')#>All</option>
			<option value="none" #doSelected(attributes.status,'none')#>none</option>
			<cfmodule template="../../../customtags/form/dropdown.cfm"
			mode="valuelist"
			valuelist="#qry_getpicklists.po_status#"
			selected="#attributes.status#"
			/>
		</select></td>	

		<td><span class="formtextsmall">date shipped<br/></span>
		<input type="text" name="shipdate" size="8" maxlength="12" class="formfield" value="#attributes.shipdate#"/>
		</td>	
	
		<td><span class="formtextsmall">open<br/></span>
		<select name="open"  class="formfield">
		<option value="" #doSelected(attributes.open,'')#>All</option>
		<option value="1" #doSelected(attributes.open,1)#>Yes</option>
		<option value="0" #doSelected(attributes.open,0)#>No</option>
		</select></td>								
						
		<td><br/><a href="#self#?fuseaction=shopping.admin&po=#attributes.po##Request.Token2#">ALL</a><br/>
		</td></tr>
		</form>	
	
	<tr>
		<td colspan="8" style="BACKGROUND-COLOR: ###Request.GetColors.inputHBgcolor#;">
		<img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="1" width="1" /></td>
	</tr>		
	
<cfif qry_get_Order_PO.recordcount gt 0>					

	<form action="#self#?currentpage=#currentpage##addedpath##request.token2#" method="post" name="editform">

	<cfloop query="qry_get_Order_PO" startrow="#PT_StartRow#" endrow="#PT_Endrow#">
		<tr>
		<td align="center"><a href="#self#?fuseaction=shopping.admin&po=edit&order_po_id=#order_po_id#&xfa_success=#URLEncodedFormat(addedpath)##Request.Token2#">#po_no#</a></td>
				
		<td align="center"><a href="#self#?fuseaction=shopping.admin&order=display&order_no=#order_no##Request.Token2#">
			 #(order_No + Get_Order_Settings.BaseorderNum)#</a></td>
			 
		<!----
		<td>#account_name#</td>---->
<td><cfif editaccount><a
href="#self#?fuseaction=users.admin&account=edit&account_ID=#account_ID#&XFA_success=#URLEncodedFormat(addedpath)##Request.Token2#">#account_name#</a><cfelse>#account_name#</cfif>
		</td>
		
		<td nowrap="nowrap">#dateformat(printdate,"yyyy-mm-dd")#</td>
		
		<td>#po_status#</td>
		
		<td nowrap="nowrap">#dateformat(shipdate,"yyyy-mm-dd")#</td>
		
		<td> <cfif po_open is "1"><a href="#self#?fuseaction=shopping.admin&po=ship&order_po_id=#order_po_id##Request.Token2#">
			Fill</a><cfelse>Closed</cfif>
		
			
		</td>

		<td>	
		<a href="JavaScript:newWindow=window.open( '#self#?fuseaction=shopping.admin&order=print&print=po&Order_No=#order_no#&account_id=#account_id##Request.Token2#', 'PO', 'width=570,height=400,toolbar=1,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1' ); newWindow.focus()">view</a>
		</td>	

	</tr>
	
	</cfloop>					

			
	<tr><td colspan="8" align="right" class="formtext">
	<cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/>
		#pt_pagethru#
	</td></tr>

	</form>
	</table>
		
	<cfelse>	
		<td colspan="8">
		<br/>
		No records selected
		</td>
	</table>	
	</cfif>

</cfoutput>
<!---- CLOSE MODULE ----->
</cfmodule>

		
