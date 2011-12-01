
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the order history for the customer with links to view each order. Called by shopping.history --->

<cfparam name="attributes.XFA_return" default="fuseaction=users.manager">

<!---- check to see if user has permission to view anybody else's order but his own --->
<cfmodule template="../../access/secure.cfm"
  keyname="shopping"
  requiredPermission="2"
  dsp_login_Required=""
 > 
<!--- If allowed, then set User ID to passed value --->	
<cfif ispermitted>   
	<cfparam name="attributes.UID" default="#Session.User_ID#">
<!--- If not permitted to see other people's order, force user ID to session user ID --->
<cfelse>
 	<cfset attributes.UID = Session.User_ID>	
</cfif>		
		  

<!--- Get user information --->
<cfquery name="GetOrders" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT N.Order_No, N.DateOrdered, N.Filled, N.Process, N.Void, N.Shipper, N.Tracking, U.Username, C.Firstname, C.Lastname
	FROM ((#Request.DB_Prefix#Order_No N
		INNER JOIN #Request.DB_Prefix#Users U ON N.User_ID = U.User_ID)
		LEFT JOIN #Request.DB_Prefix#Customers C ON U.Customer_ID = C.Customer_ID)
	WHERE N.User_ID = U.User_ID
	AND N.User_ID = <cfqueryparam value="#attributes.UID#" cfsqltype="CF_SQL_INTEGER">
	ORDER BY DateOrdered DESC
</cfquery>
	


<cfmodule template="../../customtags/format_box.cfm"
	box_title="Order History <cfif len(GetOrders.FirstName)>for #getorders.Firstname# #getorders.Lastname#</cfif>"
	border="1"
	align="left"
	Width="480"
	HBgcolor="#Request.GetColors.InputHBGCOLOR#"
	Htext="#Request.GetColors.InputHtext#"
	TBgcolor="#Request.GetColors.InputTBgcolor#"
	float="center">
	
	
	<cfoutput>
	<form action="#XHTMLFormat('#self#?#attributes.XFA_return##request.token2#')#" method="post">
	<table border="0" cellpadding="0" cellspacing="4" width="100%" class="formtext" style="COLOR: ###Request.GetColors.InputTtext#;">
	</cfoutput>

	<cfif NOT GetOrders.RecordCount>
		<tr><td align="center" colspan="3" class="formtitle">
			<p><br/>There are no orders in the system.</p></td></tr>
			
	<cfelse>
	
	
		<tr>
			<th><br/>Order No.</th>
			<th><br/>Order Date</th>
			<th><br/>Status</th>
		</tr>

		<cfoutput query="GetOrders">
		<tr>
			<td align="center" valign="top" >
			<a href="#XHTMLFormat('#self#?fuseaction=shopping.history&Order=#(GetOrders.Order_No + Get_Order_Settings.BaseOrderNum)##Request.Token2#')#" target="order">View Order  #Evaluate(GetOrders.Order_No + Get_Order_Settings.BaseOrderNum)#</a> </td>
	
			<td align="center" valign="top" class="largerformtext">
			#LSDateFormat(GetOrders.DateOrdered, "mmm d, yyyy")#</div></td>

			<td align="center" class="largerformtext">
				<cfif GetOrders.Void>Cancelled
				<cfelseif GetOrders.Filled>Shipped
				<cfelseif GetOrders.Process>Being Processed
				<cfelse>Waiting to be Processed
				</cfif>
			</td>
		</tr>
		</cfoutput>
	</cfif>
	
	<tr>
		<td align="center" colspan="3" class="formtitle">
			<br/><input type="submit" value="Return" class="formbutton"/><br/><br/>
		</td>
	</tr>
	
	</table>
</form>
</cfmodule>



