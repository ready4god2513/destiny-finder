
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page is used to process the complete list of tax codes, to set the calculation order and cumulative settings. Called by shopping.admin&taxes=editcode --->

<cfquery name="GetCodes" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT Code_ID FROM #Request.DB_Prefix#TaxCodes
</cfquery>

<cfloop query="GetCodes">

	<cfset CalcOrder = Evaluate("attributes.CalcOrder#Code_ID#")>

	<cfif isDefined("attributes.Cumulative#Code_ID#")>
		<cfset Cumulative = 1>
	<cfelse>
		<cfset Cumulative = 0>
	</cfif>

	<cfquery name="UpdateMethod2" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		UPDATE #Request.DB_Prefix#TaxCodes
		SET CalcOrder = <cfif len(CalcOrder)>#Round(CalcOrder)#,<cfelse>0,</cfif>
		Cumulative = #Cumulative#
		WHERE Code_ID = #Code_ID#
	</cfquery>

</cfloop>

<!---------------------------->
<cfoutput>
<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
alert('Your changes have been saved!');
location.href = "#self#?fuseaction=shopping.admin&taxes=codes&redirect=yes#request.token2#";
</script>
</cfprocessingdirective>
</cfoutput>


