<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Called from dsp_manager.cfm to display the users default billing and shipping address.
Required: attributes.Customer_ID --->

<cfinclude template="../qry_get_customer.cfm">

<cfoutput>
#qry_get_customer.FirstName# #qry_get_customer.LastName#<br/>
<cfif qry_get_customer.Company IS NOT "">#qry_get_customer.Company#<br/></cfif>
#qry_get_customer.Address1# <br/>
 <cfif qry_get_customer.Address2 IS NOT "">#qry_get_customer.Address2#<br/></cfif>
#qry_get_customer.City#, <cfif Compare(qry_get_customer.State, "Unlisted")>#qry_get_customer.State# <cfelse>#qry_get_customer.State2# </cfif> #qry_get_customer.Zip#<br/>
<cfif qry_get_customer.Country IS NOT "" AND qry_get_customer.Country IS NOT "US^United States">#ListGetAt(qry_get_customer.Country, 2, "^")#<br/></cfif>

Phone: #qry_get_customer.Phone#<br/>
 <cfif qry_get_customer.Email IS NOT ""><a href="mailto:#qry_get_customer.Email#">#qry_get_customer.Email#</a><br/></cfif>
</cfoutput>