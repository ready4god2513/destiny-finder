
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Performs the site search. This page is used as the default file for the 'search results page' page template --->

<cfif request.appsettings.UseVerity>
	<cfinclude template="act_verity_search.cfm">
	<cfinclude template="dsp_verity_results.cfm">
<cfelse>
	<cfinclude template="act_sql_search.cfm">
	<cfinclude template="dsp_sql_results.cfm">
</cfif>



