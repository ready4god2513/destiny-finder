
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Called from users.addressbook circuit, displays all the addresses (customer records) that a user has created. The 'show' parameter sets which address is shown as chosen. 

show = 	customer - update default customer address (users.customer_ID) from user.manager
		ship - update default shipping address (users.shipto) from user.manager
		bill - update default account address (account.customer_ID) from user.manager
		billto - selects a billing address during checkout
		shipto - select a shipping address during checkout 
--->

<cfparam name="ErrorMessage" default="">
<cfparam name="attributes.xfa_submit_addressbook" default="fuseaction=users.addressbook">

<cfset addresslink = "#self#?fuseaction=users.addressbook#Request.Token2#">
<cfset editlink = "#self#?fuseaction=users.address#Request.Token2#">

<cfinclude template="../qry_get_user.cfm">
<cfinclude template="qry_get_addressbook.cfm">
	
<cfif qry_get_addressbook.recordcount lt 3>
	<cfparam name="attributes.col_num" default="#qry_get_addressbook.recordcount#">
<cfelse>
	<cfparam name="attributes.col_num" default="3">
</cfif>	
	
<cfhtmlhead text="
 <script type=""text/javascript"">
 <!--
 function CancelForm() {
 location.href='#self#?fuseaction=users.manager&redirect=yes#request.token2#';
 }
 // --> 
 </script>
">


<cfif qry_get_addressbook.recordcount>
	<cfoutput>
	<form action="#XHTMLFormat('#request.self#?#attributes.xfa_submit_addressbook##request.token2#')#"
	 name="addressbook" method="post">
	<input type="hidden" name="show" value="#HTMLEditFormat(attributes.show)#"/>
	<cfif isdefined("attributes.xfa_success")>
		<input type="hidden" name="xfa_success" value="#HTMLEditFormat(attributes.xfa_success)#"/>
	</cfif>
	<cfif isdefined("attributes.order_no")>
		<input type="hidden" name="order_no" value="#HTMLEditFormat(attributes.order_no)#"/>
	</cfif>
	</cfoutput>
</cfif>


<cfmodule template="../../customtags/format_input_form.cfm"
box_title="Address Book"
width="560"
required_fields="0"
>

<!--- Top row provides navigation links. ---->
<cfoutput>
	<tr>
		<td>		
	
	<!--- No default address links when using the addressbook to select the billing or shipping addresses during checkout --->	
	<cfif attributes.show is not "billto" and attributes.show is not "shipto">
		
		<cfif attributes.show is "customer">
			<cfset selected_id = qry_get_user.customer_id>
			<b>Default Billing</b>
		<cfelse><a href="#XHTMLFormat('#addresslink#&show=customer')#">Default Billing</a></cfif> | 
		
		<cfif attributes.show is "ship">
			<b>Default Shipping</b> |
			<cfset selected_id = qry_get_user.shipto>
		<cfelseif get_User_Settings.UseShipTo><a href="#XHTMLFormat('#addresslink#&show=ship')#">Default Shipping</a> |</cfif> 

		<cfif len(qry_get_user.account_id) and qry_get_user.account_id neq 0>
			<cfif attributes.show is "bill">
				<b>Directory Listing</b>
				<cfset attributes.account_id = qry_get_user.account_id>
				<cfinclude template="../qry_get_account.cfm">
				<cfset selected_id = qry_get_account.customer_id>
			<cfelse><a href="#XHTMLFormat('#addresslink#&show=bill')#">Directory Listing</a></cfif>
		</cfif>
	<cfelse>	
		<cfif attributes.show is "billto">
			<cfset selected_id = qry_get_user.customer_id>
		<cfelse>
			<cfset selected_id = qry_get_user.shipto>
		</cfif>
	</cfif>
	
		</td>
   		<td align="right">
		<!--- No new address option when using the addressbook for order editing from the admin Order Manager. --->	
		<cfif not isdefined("attributes.order_no")>
		<a href="#XHTMLFormat('#editlink#&show=#attributes.show#&customer_id=0')#">Add New Address</a></cfif></td></tr>
	
	<tr><td colspan="2">
	<cfif attributes.show is "Customer">Select your default billing address. You will always have the opportunity to select a different billing address when placing an order.  <!---- Optional note to users: This address must be the same address that appears on the statement of your credit card that you use when making a payment on the site.----></cfif>	
	<cfif attributes.show is "ship">Select your default shipping address. You will be able to select a different shipping address when placing an order.</cfif>
	<cfif attributes.show is "bill">Select the Account Billing address. Payments and sales reports will be sent to this address.</cfif>
	<cfif attributes.show is "billto">Select the Billing Address for this order.</cfif>
	<cfif attributes.show is "shipto">Select the Shipping Address for this order.</cfif>
	
	<cfif attributes.show is "bill">
	<table cellspacing="0" cellpadding="8" border="0" width="95%" style="color:###Request.GetColors.InputTText#"><tr><td>
		<input type="radio" name="selected_ID" value="0"/> Do not list in directory.
	</td></tr></table>
	</cfif>
		
	<cfif len(ErrorMessage)>
		<div align="center" class="formerror"><b>#ErrorMessage#</b></div>
	</cfif>

</cfoutput>
	
<cfif qry_get_addressbook.recordcount>
	<cfoutput>
	<cfloop query="qry_get_addressbook">	
		<cfif attributes.col_num LTE 1 OR qry_get_addressbook.CurrentRow MOD attributes.col_num IS 1>
			<table cellspacing="2" cellpadding="2" border="0" width="95%"><tr>
		</cfif> 
			<td valign="top" width="#ceiling(100/attributes.col_num)#%">
				<table class="formtextsmall" style="color:###Request.GetColors.InputTText#"><tr><td valign="top">
				<!--- button --->
				<input type="radio" name="selected_ID" value="#qry_get_addressbook.customer_ID#" #doChecked(qry_get_addressbook.customer_ID,selected_id)# />
				</td><td align="left" valign="top">
					<!--- address --->
					#qry_get_addressbook.FirstName# #qry_get_addressbook.LastName#<br/>
				<cfif qry_get_addressbook.Company IS NOT "">
					#qry_get_addressbook.Company#<br/></cfif>
					#qry_get_addressbook.Address1# <br/>
 				<cfif qry_get_addressbook.Address2 IS NOT "">
					#qry_get_addressbook.Address2#<br/></cfif>
				<cfif qry_get_addressbook.County IS NOT "">
					#qry_get_addressbook.County# County<br/></cfif>
					#qry_get_addressbook.City#, 
				<cfif Compare(qry_get_addressbook.State, "Unlisted")>
					#qry_get_addressbook.State# <cfelse>
					#qry_get_addressbook.State2# </cfif>
					#qry_get_addressbook.Zip#<br/>
				<cfif qry_get_addressbook.Country IS NOT "" AND 
				qry_get_addressbook.Country IS NOT "US^United States">
					#ListGetAt(qry_get_addressbook.Country, 2, "^")#<br/></cfif>
				<cfif qry_get_addressbook.Phone IS NOT "">
					Phone: #qry_get_addressbook.Phone#<br/>
				</cfif>
 				<cfif qry_get_addressbook.Email IS NOT "">
					<a href="mailto:#qry_get_addressbook.Email#">
					#qry_get_addressbook.Email#</a><br/></cfif>
					<br/>
				
				<cfif not isdefined("attributes.order_no")>
				[<a href="#XHTMLFormat('#editlink#&show=#attributes.show#&customer_ID=#customer_ID#')#">edit</a>]<br/>
				</cfif>
				
				</td></tr></table></td>
			<cfif attributes.col_num LTE 1 OR qry_get_addressbook.CurrentRow MOD attributes.col_num IS 0>
				</tr></table>
			<cfelseif qry_get_addressbook.CurrentRow IS qry_get_addressbook.RecordCount>
				<cfloop index = "num" from="1" to="#(attributes.col_num - qry_get_addressbook.CurrentRow MOD attributes.col_num)#">
					<td>&nbsp;</td>
				</cfloop>
				</tr></table>
			</cfif>	
		</cfloop>
		</cfoutput>
	</td></tr>
	<tr>
   		<td colspan="2" align="center"><br/>
			<input type="submit" name="submit_addressbook" value="Select" class="formbutton"/> 
			<cfif attributes.show is not "billto" and attributes.show is not "shipto">
			<input type="button" name="Cancel" value="Back to My Account" class="formbutton" onclick="CancelForm();"/></cfif> 
		</td>	
	</tr>	
	
	
<cfelse><!--- no addresses found --->
	<tr>
   		<td colspan="2" align="center">		
			<table width="530"><tr><td class="formtitle" align="center">
			<br/>
			You have no current contacts.
			<cfoutput>
			<form action="#XHTMLFormat('#self#?fuseaction=users.manager#request.token2#')#" 
			method="post" name="back" id="back" class="margins">
			</cfoutput>
			<input type="hidden" name="fuseaction" value="users.manager"/>
			<input type="button" name="Cancel" value="Back to My Account" class="formbutton" onclick="CancelForm();"/>
			</form>
			</td></tr></table>
		</td>	
	</tr>	
</cfif>

</cfmodule>

<cfif qry_get_addressbook.recordcount>
</form>
</cfif>