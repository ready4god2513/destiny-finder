
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to print customer information to the invoice or email receipt --->

<!--- Called from dsp_invoice_header.cfm and post_processing\act_mailorder.cfm and shopping\admin\order\act_maildrop.cfm --->

<cfparam name="mail" default="No">
<cfparam name="PayPalExpress" default="No">
<cfset LineBreak = Chr(13) & Chr(10)>
<cfset String = "">

<cfif GetCustomer.Company IS "PayPal Account">
	<cfset PayPalExpress = "Yes">
</cfif>

<cfif NOT Compare(mail, "No")>
	<cfset String = String & "<p><b><i>">
</cfif>

<cfif NOT GetShipTo.RecordCount>
	<cfset String = String & "Bill/Ship To:" & LineBreak>
<cfelse>
	<cfset String = String & "Bill To:" & LineBreak>
</cfif>

<cfif NOT Compare(mail, "No")>
	<cfset String = String & "</i></b><br/>">
</cfif>

<cfset String = String & GetCustomer.FirstName & " " & GetCustomer.LastName>

<cfif NOT Compare(mail, "No")>
	<cfset String = String & "<br/>">
</cfif>
<cfset String = String & LineBreak>

<cfif len(GetCustomer.Company)>
	<cfset String = String & GetCustomer.Company>
	
	<cfif NOT Compare(mail, "No")>
		<cfset String = String & "<br/>">
	</cfif>
	<cfset String = String & LineBreak>
</cfif>


<cfif NOT PayPalExpress>	
	<cfset String = String & GetCustomer.Address1>
	
	<cfif NOT Compare(mail, "No")>
		<cfset String = String & "<br/>">
	</cfif>
	<cfset String = String & LineBreak>
	
	<cfif len(GetCustomer.Address2)>
		<cfset String = String & GetCustomer.Address2>
		<cfif NOT Compare(mail, "No")>
			<cfset String = String & "<br/>">
		</cfif>
		<cfset String = String & LineBreak>
	</cfif>
	
	<cfif len(GetCustomer.County)>
		<cfset String = String & GetCustomer.County & " County">
		<cfif NOT Compare(mail, "No")>
			<cfset String = String & "<br/>">
		</cfif>
		<cfset String = String & LineBreak>
	</cfif>
	
	<cfset String = String & GetCustomer.City & ", ">
	
	<cfif Compare(GetCustomer.State, "Unlisted")>
		<cfset String = String & GetCustomer.State>
	<cfelse>
		<cfset String = String & GetCustomer.State2>
	</cfif>
	
	<cfset String = String & " " & GetCustomer.Zip>
	<cfif NOT Compare(mail, "No")>
		<cfset String = String & "<br/>">
	</cfif>
	<cfset String = String & LineBreak>
	
	<cfif len(GetCustomer.Country) AND Compare(GetCustomer.Country, Request.AppSettings.HomeCountry)>
		<cfset String = String & ListGetAt(GetCustomer.Country, 2, "^")>
		<cfif NOT Compare(mail, "No")>
			<cfset String = String & "<br/>">
		</cfif>
		<cfset String = String & LineBreak>
	</cfif>
	
	<cfset String = String & "Phone: " & GetCustomer.Phone>
	
	<cfif NOT Compare(mail, "No")>
		<cfset String = String & "<br/>">
	</cfif>
	<cfset String = String & LineBreak>

</cfif>

<cfif NOT Compare(mail, "No")>
	<cfset String = String & "<a href='mailto:" & GetCustomer.Email & "'>">
</cfif>

<cfset String = String & GetCustomer.Email>

<cfif NOT Compare(mail, "No")>
	<cfset String = String & "</a><br/>">
</cfif>
<cfset String = String & LineBreak>

<cfif NOT Compare(mail, "No")>
	<cfset String = String & "</p>">
</cfif>
