<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!---  This page is called by access.admin&membership=RecurringReport and displays list of memberships that will recur sorted by date.--->

<cfset AllTotal = 0>


<cfmodule template="../../../customtags/format_output_admin.cfm"
	box_title="Recurring Memberships"
	align="center"
	border="1"
	width="500"
	>
	
<table border="0" cellpadding="3" cellspacing="0" class="formtext" width="100%" align="Center">


<cfif NOT Get_Memberships.RecordCount>
<tr><td align="center">No recurring memberships found.</td></tr>
<cfelse>
<tr><td>
<cfoutput query="Get_Memberships" group="Expire">
	<cfset DayTotal = 0>
<tr><td colspan="4">
	#dateformat(Expire,"mmm dd, yyyy")#<br/>
	<cfmodule template="../../../customtags/putline.cfm" linetype="Thick"/>
</td></tr>	
	<cfoutput>
	<tr><td>
	 <cfif Recur_Product_ID gt 0>
	 	#LSCurrencyFormat(RecurPrice)# </td><td> #RecurProductName# (#Recur_Product_ID#) 
		<cfset dayTotal= dayTotal + RecurPrice>
	 <cfelse>
	 	#LSCurrencyFormat(price)# </td><td> #productName#&nbsp;(#product_ID#) 
		<cfset dayTotal= dayTotal + Price>
	 </cfif>
	 </td><td>#username#</td><td>
	<span class="formerror" style="font-weight:bold;">
	<cfif NOT isDate(CardExpire) OR DateCompare(CardExpire,now(),'d') lt 1 >Card Expired</cfif>
	<cfif NOT CardisValid>Card Inactive</cfif>
	<cfif Disable>User Disabled</cfif></span>
	 </td>
	 </tr>
	</cfoutput>
<tr><td colspan="4">
	Total: #LSCurrencyFormat(DayTotal)#<br/><br/>
</td></tr>	
	<cfset AllTotal= AllTotal + dayTotal>
</cfoutput>
<tr><td colspan="4">
<cfoutput>
<strong>Total: #LSCurrencyFormat(ALLTotal)#</strong>
</cfoutput>
</td></tr>	
</cfif>
</table>


</cfmodule>
