<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to print the shipping address information to the invoice or email receipt --->

<!--- Called from dsp_invoice_header.cfm and post_processing\act_mailorder.cfm and shopping\admin\order\act_maildrop.cfm --->

<cfparam name="mail" default="No">
<cfset LineBreak = Chr(13) & Chr(10)>
<cfset String = LineBreak>

<cfif NOT Compare(mail, "No")>
	<cfset String = String & "<p><b><i>">
</cfif>

<cfset String = String & "Ship To:" & LineBreak>

<cfif NOT Compare(mail, "No")>
	<cfset String = String & "</i></b><br/>">
</cfif>

<cfset String = String & GetShipTo.FirstName & " " & GetShipTo.LastName>

<cfif NOT Compare(mail, "No")>
	<cfset String = String & "<br/>">
</cfif>
<cfset String = String & LineBreak>


<cfif len(GetShipTo.Company)>
	<cfset String = String & GetShipTo.Company>
	<cfif NOT Compare(mail, "No")>
		<cfset String = String & "<br/>">
	</cfif>
	<cfset String = String & LineBreak>
</cfif>

<cfset String = String & GetShipTo.Address1>

<cfif NOT Compare(mail, "No")>
	<cfset String = String & "<br/>">
</cfif>
<cfset String = String & LineBreak>

<cfif len(GetShipTo.Address2)>
	<cfset String = String & GetShipTo.Address2>
	<cfif NOT Compare(mail, "No")>
		<cfset String = String & "<br/>">
	</cfif>
	<cfset String = String & LineBreak>
</cfif>

<cfif len(GetShipTo.County)>
	<cfset String = String & GetShipTo.County & " County">
	<cfif NOT Compare(mail, "No")>
		<cfset String = String & "<br/>">
	</cfif>
	<cfset String = String & LineBreak>
</cfif>

<cfset String = String & GetShipTo.City & ", ">

<cfif Compare(GetShipTo.State, "Unlisted")>
	<cfset String = String & GetShipTo.State>
<cfelse>
	<cfset String = String & GetShipTo.State2>
</cfif>

<cfset String = String & " " & GetShipTo.Zip>
<cfif NOT Compare(mail, "No")>
	<cfset String = String & "<br/>">
</cfif>
<cfset String = String & LineBreak>

<cfif len(GetShipTo.Country) AND Compare(GetShipTo.Country, Request.AppSettings.HomeCountry)>
	<cfset String = String & ListGetAt(GetShipTo.Country, 2, "^")>
	<cfif NOT Compare(mail, "No")>
		<cfset String = String & "<br/>">
	</cfif>
	<cfset String = String & LineBreak>
</cfif>


<cfif len(GetShipTo.Phone)>
	<cfset String = String & GetShipTo.Phone>
	<cfif NOT Compare(mail, "No")>
		<cfset String = String & "<br/>">
	</cfif>
	<cfset String = String & LineBreak>
</cfif>


<cfif NOT Compare(mail, "No")>
	<cfset String = String & "</p>">
</cfif>
