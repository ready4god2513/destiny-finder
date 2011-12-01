<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays a summary of information about a particular user --->

<!--- User --->
<cfmodule template="../../../customtags/format_output_admin.cfm"
	box_title="User Summary"
	width="600"
		>
<cfoutput>
<table width="100%" cellspacing="12" cellpadding="0" class="formtext" border="0"
style="BACKGROUND-COLOR: ##F4F4F6; COLOR: ###Request.GetColors.OutputtTEXT#;">
	<tr>
		<td width="50%" valign="top">	 
<strong>User:</strong> <cfif NOT get_User_Settings.EmailAsName><a href="#self#?fuseaction=users.admin&user=edit&UID=#attributes.uid##Request.Token2#">#qry_get_user.Username#</a><br/>
<strong>Email:</strong> </cfif>
<a href="mailto:#qry_get_user.Email#">#qry_get_user.Email#</a>
		</td>
		<td width="50%" valign="top">	 
		[ <a href="#self#?fuseaction=users.admin&user=edit&uid=#attributes.uid#&XFA_success=#URLEncodedFormat(cgi.query_string)##Request.Token2#">Edit User</a> ]<br/>
<cfif len(qry_get_user.emailLock) AND qry_get_user.emailLock is NOT "verified">
					[ <a href="#self#?fuseaction=users.admin&user=unlock&uid=#attributes.uid#&XFA_success=#URLEncodedFormat(cgi.query_string)##Request.Token2#">unlock</a> ]
					[ <a href="#self#?fuseaction=users.admin&email=write&uid=#attributes.uid#&MailText_ID=emaillock&XFA_success=#URLEncodedFormat(cgi.query_string)#">send code</a> ]<br/>
</cfif>		
[ <a href="#self#?fuseaction=users.admin&customer=list&uid=#attributes.uid#&show=#Request.Token2#">Address Book</a> ]
		</td>
	</tr>

	<tr>
		<td valign="top">
<cfif get_User_Settings.ShowSubscribe>
<strong>Subscribe:</strong> <cfif qry_get_user.Subscribe>Yes<cfelse>No</cfif><br/>		
</cfif>
<cfif get_User_Settings.UseBirthdate> 
<strong>Birthdate:</strong> #Dateformat(qry_get_user.Birthdate,"mm/dd/yy")#	<br/>						
</cfif>
<strong>Group:</strong> #qry_get_user.GroupName#<br/>		
		</td>
		<td valign="top">
		<strong>Last login:</strong> #qry_get_user.LoginsDay# on #Dateformat(qry_get_user.LastLogin,"mm/dd/yy")#<br/>
		<strong>Total logins:</strong> #qry_get_user.LoginsTotal# since #Dateformat(qry_get_user.Created,"mm/dd/yy")#<br/>
		<!--- Check if user is currently locked out --->
		<cfif (qry_get_user.FailedLogins GTE get_user_settings.MaxFailures AND DateCompare(qry_get_user.lastattempt, DateAdd("h", -1, now())) GTE 0) OR (get_user_settings.MaxDailyLogins GT 0 AND qry_get_user.loginsDay GT get_user_settings.MaxDailyLogins)>
		<strong><font color="red">BLOCKED</font></strong>&nbsp;&nbsp; [ <a href="#self#?fuseaction=users.admin&user=unblock&uid=#qry_get_user.user_ID##Request.Token2#">Unblock</a> ]
		</cfif>
		</td>
	</tr>
	
<!--- 	<cfif request.appSettings.AllowAffs> --->
	<tr><td><strong>Affiliate:</strong>
		 <cfif len(qry_get_user.affcode)> aff=#qry_get_user.affcode# -  #(qry_get_user.affpercent * 100)#%
		</td><td>[ <a href="#self#?fuseaction=users.admin&user=affiliate&uid=#qry_get_user.user_ID##Request.Token2#">Edit</a> ] 
		[ <a href="#self#?fuseaction=shopping.affiliate&do=report&UID=#qry_get_user.user_ID##Request.Token2#">Report</a> ]
		<cfelse>Not an Affiliate</td>
		<td>[ <a href="#self#?fuseaction=users.admin&user=affiliate&uid=#qry_get_user.user_ID##Request.Token2#">Create</a> ]</cfif>
	</td></tr>
<!--- 	</cfif>		 --->	
	

	<tr>
		<td valign="top"><strong>Billing Address:</strong>
			<blockquote>
			<cfif qry_get_User.customer_id gt 0>
				<cfset attributes.customer_ID = qry_get_User.customer_id>
				<cfinclude template="../../manager/put_customer.cfm">
				[ <a href="#self#?fuseaction=users.admin&customer=edit&Customer_ID=#qry_get_User.customer_id#">Edit</a> ]
			<cfelse>
				No billing address.
			</cfif>
			</blockquote>
		</td>
		<td valign="top">
		<cfif  get_User_Settings.UseShipTo>
			<strong>Ship To:</strong>
			<blockquote>
			<cfif qry_get_user.shipto>
				<cfif qry_get_user.shipto and qry_get_user.shipto is not qry_get_user.customer_id>
					<cfset attributes.customer_ID = qry_get_User.shipto>
					<cfinclude template="../../manager/put_customer.cfm">
					[ <a href="#self#?fuseaction=users.admin&customer=edit&Customer_ID=#qry_get_User.shipto#">Edit</a> ]
				<cfelse>
					Same as billing address
				</cfif>
			<cfelse>
				No shipping address
			</cfif>
			</blockquote>
		</cfif>
		</TD>
	</TR>
	
	<cfif get_User_Settings.UseCCard> 
	
<cfquery name="qry_get_Memberships"  datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT M.*, P.Name as product, P.Prod_Type
	FROM #Request.DB_Prefix#Memberships M 
	LEFT JOIN #Request.DB_Prefix#Products P ON M.Product_ID = P.Product_ID
	WHERE M.User_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.UID#">
		AND Expire >= #CreateODBCDate(now())#
	ORDER BY M.Valid, M.Start DESC
</cfquery>
	
	<tr>
		<td valign="top"><strong>Credit Card on file:</strong>
			<blockquote>
			<cfif len(qry_get_User.NameonCard)>
			#qry_get_User.NameonCard#<br/>
			#qry_get_User.CardType# #qry_get_User.CardNumber#<br/>
			Exp: #Dateformat(qry_get_User.CardExpire,"mm/yy")#<br/>
			
			<cfif DateCompare(qry_get_user.CardExpire,now(),'m') lt 1>
			<span class="formerror"><strong>EXPIRED</strong>
			<cfelseif qry_get_user.CardisValid is 0>
			<span class="formerror"><strong>NOT ACTIVE: </strong><a href="#self#?fuseaction=users.admin&user=authorize&UID=#attributes.UID##request.token2#" class="formerror">Authorize Now</a></span>					
			</cfif>
			
			<cfelse>
			No card on file.
			</cfif>
			</blockquote>
		</td>
		<td valign="top">
			<cfif qry_get_Memberships.Recordcount>
			<strong>Active Memberships:</strong>
			<blockquote>
			<cfloop query="qry_get_Memberships">
				<a href="#self#?fuseaction=access.admin&Membership=edit&Membership_ID=#membership_ID##request.token2#">#product#</a><br/>
				#dateformat(Start, "mm/dd/yyyy")# - #dateformat(expire, "mm/dd/yyyy")# 
				<cfif NOT recur><br/><span class="caution">NON RENEWING</span><cfelse>Auto-Renew</cfif>
				<cfif NOT Valid><br/>
				<a href="#self#?fuseaction=access.admin&membership=list&show=all&valid=0#request.token2#" class="formerror"><strong>VALIDATE</strong></a>
				</cfif>
				<br/><br/>
			</cfloop>	
			</blockquote>
			</cfif>
		</td>
	</tr>
	</cfif>
	

	<cfif len(qry_get_user.AdminNotes)>
	<tr><td colspan="2"><strong>Notes:</strong> #qry_get_user.AdminNotes#</td></tr>
	</cfif>	

	<tr><td colspan="2"><strong>Other:</strong> <a href="#self#?fuseaction=product.reviews&do=list&uid=#qry_get_user.user_ID#">Product Reviews</a> | 

<a href="#self#?fuseaction=feature.reviews&do=list&uid=#qry_get_user.user_ID#">Feature Article Comments</a> </td></tr>



<!--- ACCOUNT --->
<!--- <cfif get_User_Settings.UseAccounts AND qry_get_user.Account_ID>  --->
<cfif len(qry_get_user.Account_ID) and qry_get_user.Account_ID IS NOT 0> 
<cfset account_ID = qry_get_user.Account_ID>
<cfinclude template="../account/qry_get_account.cfm">
<br/>
<tr><td colspan="2"><br/><div class="formtitle">Account</div>
<hr noshade="noshade" size="1" /></td></tr>
	<tr>
		<td>
<strong>Account Name:</strong> #qry_get_account.Account_Name#<br/>
<strong>Type:</strong> #qry_get_account.Type1#<br/>
<cfif len(qry_get_account.Web_URL)>
<strong>Web:</strong> #qry_get_account.Web_URL#<br/></cfif>
<cfif len(qry_get_account.Dropship_Email)>
<strong>Dropship:</strong> <a href="mailto:#qry_get_account.Dropship_Email#">#qry_get_account.Dropship_Email#</a><br/></cfif>
<cfif len(qry_get_account.Rep)>
<strong>Rep:</strong> #qry_get_account.Rep#<br/></cfif>
		[ <a href="#self#?fuseaction=users.admin&account=edit&account_ID=#account_ID##Request.Token2#">Edit Account</a> ]</td>

		<td><strong>Account Address:</strong>
			<blockquote>
			<cfif qry_get_account.customer_id gt 0>
					<cfset attributes.customer_ID = qry_get_account.customer_id>
					<cfinclude template="../../qry_get_customer.cfm">
					<cfif qry_get_customer.Company IS NOT "">#qry_get_customer.Company#<br/></cfif>
					#qry_get_customer.Address1#<br/>
					#qry_get_customer.city#, #qry_get_customer.state# #qry_get_customer.Zip#
			<cfelse>
					Not Listed
			</cfif>
			</blockquote>
		</td>
	</tr>

	</cfif>
</table>	

<!---<div align="center"><input type="button" value="Cancel" onclick="javascript:window.history.go(-1);" class="formbutton"/></div>--->
</cfoutput>	
</cfmodule>


<!--- Get Orders --->
<br/>
<cfquery name="qry_get_Memberships"  datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT M.*, P.Name AS Product, P.Prod_Type
		FROM #Request.DB_Prefix#Memberships M 
		LEFT JOIN #Request.DB_Prefix#Products P ON M.Product_ID = P.Product_ID
		WHERE M.User_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.UID#">		
		ORDER BY M.Expire DESC
</cfquery>

<cfmodule template="../../../customtags/format_output_admin.cfm"
	box_title="User Memberships"
	width="600"
		>
<cfoutput>
<table width="100%" cellspacing="5" cellpadding="0" class="formtext" border="0"
style="BACKGROUND-COLOR: ##F4F4F6; COLOR: ###Request.GetColors.OutputtTEXT#;"></cfoutput>

	<cfif NOT qry_get_Memberships.RecordCount>
		<cfoutput><tr><td align="center" class="formtitle">
			<p><br/>No Memberships</p></td></tr></cfoutput>
			
	<cfelse>
		<tr>		
			<th>ID</th>
			<th>Product</th>
			<th>Start</th>
			<th>Stops</th>
			<th>Status</th>
		</tr>		
			<tr><td colspan="5"><cfmodule template="../../../customtags/putline.cfm" linetype="thin" /></td></tr>

		<cfoutput query="qry_get_Memberships">
		<tr>
			<td valign="top"><a href="#self#?fuseaction=access.admin&Membership=edit&Membership_ID=#membership_ID##Request.Token2#">Edit #membership_ID#</a></td>
	
			<td valign="top">#Prod_Type#: <cfif prod_type is "download" and access_count gt access_used AND Valid AND (NOT isDate(Expire) OR DateCompare(Expire, Now()) GT 0)><a href="#self#?fuseaction=access.download&ID=#membership_id##Request.Token2#">#product#</a>
			<cfelseif len(product)>#product# <cfelse>Membership</cfif></td>
	
				
			<td align="center">#dateformat(Start, "mm/dd/yyyy")# </td>
			<td align="center">#dateformat(Expire, "mm/dd/yyyy")# </td>
			
			<td><cfif prod_type is "download" and access_count lte access_used><span style="color:green;">Downloaded</span>
<cfelseif isDate(Expire) AND DateCompare(Expire,now(),'d') lt 0><font color="red">Expired</font>
<cfelseif qry_get_user.Disable is 1><span style="color:red;">FRAUD</span>
<cfelseif valid is 0><a href="#self#?fuseaction=access.admin&membership=approve&membership_id=#membership_id##Request.Token2#">Validate</a><cfelseif isDate(start) AND DateCompare(start,now()) lt 1><span style="color:green; font-weight:bold;">Current</span><cfelse><span style="color:green;">Future</span></cfif></td>
		</tr>
				
		<cfif recur>
		<tr>
			<td colspan="5" align="center"><span class="caution">
			This membership will auto-renew on #dateformat(expire, "mm/dd/yyyy")#</span>
			&nbsp;&nbsp; Process now: <a href="#self#?fuseaction=access.admin&membership=bill_recurring&membership_ID=#membership_ID#&offline=1#request.token2#">OFFLINE</a> | <a href="#self#?fuseaction=access.admin&membership=bill_recurring&membership_ID=#membership_ID##request.token2#">ONLINE</a>
			<br/><br/></td>
		</tr>
		</cfif>
		
		</cfoutput>
	</cfif>
</table>
</cfmodule>

<!--- Get Orders --->
<br/>
<cfmodule template="../../../customtags/format_output_admin.cfm"
	box_title="Order History"
	width="600"
		>
<!--- Link to customer order history 
<cfoutput><a href="#self#?fuseaction=shopping.history&UID=#qry_get_user.user_ID##Request.Token2#" target="_new">Invoices</a></cfoutput>--->

<cfinclude template="../../../shopping/qry_get_order_settings.cfm">
<cfquery name="GetOrders" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT N.Order_No, N.DateOrdered, N.Filled, N.Process, N.Void, N.Shipper, N.Tracking, N.OrderTotal
	FROM #Request.DB_Prefix#Order_No N
	WHERE N.User_ID = <cfqueryparam value="#Attributes.UID#" cfsqltype="CF_SQL_INTEGER">
	Order By Order_No DESC
</cfquery>
<cfoutput>
<table width="100%" cellspacing="5" cellpadding="0" class="formtext" border="0" style="BACKGROUND-COLOR: ##F4F4F6; COLOR: ###Request.GetColors.OutputtTEXT#;">
</cfoutput>

	<cfif NOT GetOrders.RecordCount>
		<cfoutput><tr><td align="center" class="formtitle">
			<p><br/>No Orders</p></td></tr></cfoutput>
			
	<cfelse>
		<cfoutput>
		<tr>
			<th>Order No.</th>
			<th>Total</th>
			<th>Date</th>
			<th>Status</th>
			<th></th>
		</tr>
		<tr><td colspan="5"><cfmodule template="../../../customtags/putline.cfm" linetype="thin" /></td></tr>
		</cfoutput>

		<cfoutput query="GetOrders">
		<tr>
			<td valign="top"><a href="#self#?fuseaction=shopping.admin&order=display&order_no=#GetOrders.Order_No##Request.Token2#">Edit #(GetOrders.Order_No + Get_Order_Settings.BaseOrderNum)#</a></td>
	
			<td>#LSCurrencyFormat(orderTotal)#</td>
			<td valign="top">
			#LSDateFormat(GetOrders.DateOrdered, "mmm d, yyyy")#</div></td>

			<td>
				<cfif GetOrders.Void>Cancelled
				<cfelseif GetOrders.Filled>Filled
				<cfelseif GetOrders.Process>In Process
				<cfelse>Waiting to be Processed
				</cfif>
			</td>
			<td><a href="#self#?fuseaction=shopping.history&Order=#(GetOrders.Order_No + Get_Order_Settings.BaseOrderNum)##Request.Token2#" target="order">Invoice</a>  </td>
		</tr>
		</cfoutput>
	</cfif>
</table>
</cfmodule>
