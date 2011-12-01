<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the list of orders, with filters to search for certain orders. Called by shopping.admin&order=search --->

<!--- Create the string with the filter parameters --->	
<cfset addedpath="&fuseaction=shopping.admin&order=#attributes.order#">
	<cfloop list="order_no,customer,orderdate,startdate,todate,paid,affiliate,prodid,status,ordertype,sort,sortorder,show" index="counter">
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

<cfquery name="GetAffiliates" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT A.AffCode, U.Username
	FROM #Request.DB_Prefix#Affiliates A, #Request.DB_Prefix#Users U
	WHERE U.Affiliate_ID = A.Affiliate_ID
</cfquery>
	
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
	
	<form action="#self#?fuseaction=shopping.admin&order=search#request.token2#" method="post">

	<!--- Search Row 1: inv, from, to, x ----->
	<tr>
	
		<td><span class="formtextsmall"><br/></span>
		<input type="submit" value="Search" class="formbutton"/></td>
	
		<!--- Start Date --->
		<td colspan="2"><span class="formtextsmall">order date from<br/></span>
			<select name="StartMonth" size="1" class="formfield">
				<cfloop index="num" from="1" to="12">
					<option value="#num#" #doSelected(month(attributes.startdate),num)#>#MonthAsString(num)#</option>
				</cfloop>
			</select>

			<select name="StartDay" size="1" class="formfield">
				<cfloop index="num" from="1" to="31">
					<option value="#num#" #doSelected(day(attributes.startdate),num)#>#num#</option>
				</cfloop>
			</select>

			<select name="StartYear" size="1" class="formfield">
				<cfloop index="num" from="#Year(mindate)#" to="#NowYear#">
					<option value="#num#" #doSelected(year(attributes.startdate),num)#>#num#</option>
				</cfloop>
			</select>		
		</td>
	
		<!--- To Date --->
		<td colspan="4"><span class="formtextsmall">order date through<br/></span>
			<select name="ToMonth" size="1" class="formfield">
				<cfloop index="num" from="1" to="12">
				<option value="#num#" #doSelected(month(attributes.todate),num)#>#MonthAsString(num)#</option>
				</cfloop>
			</select>

			<select name="ToDay" size="1" class="formfield">
				<cfloop index="num" from="1" to="31">
				<option value="#num#" #doSelected(day(attributes.todate),num)#>#num#</option>
				</cfloop>
			</select>

			<select name="ToYear" size="1" class="formfield">
				<cfloop index="num" from="#Year(mindate)#" to="#NowYear#">
				<option value="#num#" #doSelected(year(attributes.todate),num)#>#num#</option>
				</cfloop>
			</select>
		</td>
	</tr>

	<!---- Search row 2: submit, prod_id, cust, affiliate, void, sort --->
	<tr>
		
		<!---- Invoice number ---->
		<td><span class="formtextsmall">order no.<br/></span>
			<input type="text" name="order_no" size="7" maxlength="10" class="formfield" value="#attributes.order_no#"/></td>	
			
		<td><span class="formtextsmall">user ID<br/></span>
		<input type="text" name="UID" size="5" maxlength="10" class="formfield" value="#attributes.UID#"/>
		</td>	
	
		<!--- name field spans date & customer in list--->
		<td><span class="formtextsmall">customer<br/></span>
			<input type="text" name="customer" size="30" maxlength="25" class="formfield" value="#HTMLEditFormat(attributes.customer)#"/></td>				

		<td><span class="formtextsmall">product id<br/></span>
		<input type="text" name="prodid" size="8" maxlength="12" class="formfield" value="#attributes.prodid#"/>
		</td>	

		<td><span class="formtextsmall">affiliate<br/></span>
		<input type="text" name="affiliate" size="6" maxlength="12" class="formfield" value="#attributes.affiliate#"/>
		</td>	
			
		<td><span class="formtextsmall">status<br/></span>
		<select name="ordertype" class="formfield">
			<option value="all" #doSelected(attributes.ordertype,'all')#>All</option>
			<option value="pending" #doSelected(attributes.ordertype,'pending')#>pending</option>
			<option value="process" #doSelected(attributes.ordertype,'process')#>in process</option>
			<option value="filled" #doSelected(attributes.ordertype,'filled')#>filled</option>
			<option value="void" #doSelected(attributes.ordertype,'void')#>void</option>
			<option value="cancelled" #doSelected(attributes.ordertype,'cancelled')#>cancelled</option>
			<option value="fraud" #doSelected(attributes.ordertype,'fraud')#>fraud</option>
		</select></td>	
									
		<td><br/><a href="#self#?fuseaction=shopping.admin&order=#attributes.order#&show=All#Request.Token2#">ALL</a><br/>
		</td></tr>
		</form>		
	
	<tr>
		<td colspan="7" style="BACKGROUND-COLOR: ###Request.GetColors.inputHBgcolor#;">
		<img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="1" width="1" /></td>
	</tr>		
	
<cfif qry_get_Orders.recordcount gt 0>		
	<form action="#self#?currentpage=#currentpage##addedpath##request.token2#" method="post" name="orderform">

	<cfloop query="qry_get_Orders" startrow="#PT_StartRow#" endrow="#PT_Endrow#">
<!--- Extra query needed due to Access not supporting "Disinct" for aggregate functions --->
	<cfquery name="getProds" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT Count(Product_ID) As TotalProds, SUM(Items) AS TotalItems
		FROM (SELECT DISTINCT Product_ID, SUM(Quantity) AS Items FROM #Request.DB_Prefix#Order_Items
				WHERE Order_No = #qry_get_Orders.Order_No#
				GROUP BY Product_ID) AS ProdSums
	</cfquery>			

		<tr>
		<td align="center"><a href="#self#?fuseaction=shopping.admin&order=display&order_no=#order_no##Request.Token2#">
			 #(Order_No + Get_Order_Settings.BaseOrderNum)#</a></td>
		
		<td>#dateformat(DateOrdered,"mm/dd/yy")#</td>
		
		<td><cfif edituser><cfif uid><a href="#Request.StoreURL##self#?fuseaction=users.admin&user=summary&newWindow=yes&uid=#uid##Request.Token2#" target="user"><cfelse><a href="##" onclick="Guest();return false;"></cfif>#firstname#  #lastname#</a>	
		<cfelse>#firstname#  #lastname#</cfif></td>
		
		<td align="center" nowrap="nowrap">
		<div style="font-size:9px;">#getProds.TotalProds# product<cfif getProds.TotalProds GT 1>s</cfif> (#getProds.TotalItems# items total)</div></td>
		
		<td><cfif affiliate>#affiliate#</cfif></td>
		
		<td><cfif len(status)>#status#<cfelseif Filled>Filled<cfelseif Process>Processed<cfelse>Pending</cfif></td>
				
		<td></td>
	</tr>
	
	</cfloop>					
	
	<tr>
		<td colspan="7" style="BACKGROUND-COLOR: ###Request.GetColors.inputHBgcolor#;">
		<img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="1" width="1" /></td>
	</tr>
	
	<tr><td colspan="8" align="right" class="formtext">
	#pt_pagethru#
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










