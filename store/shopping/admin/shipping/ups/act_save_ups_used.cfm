
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page is used to process the complete list of shipping methods, to set which ones are being used by the store. Called by shopping.admin&shipping=method --->

<cfloop index="ID" list="#attributes.ID_List#">

	<cfset Priority = Evaluate("attributes.Priority#ID#")>
		
	<cfif NOT isNumeric(Priority) OR Priority IS 0>
		<cfset Priority = 99>
	</cfif>	

	<cfif isDefined("attributes.Used#ID#")>

		<cfquery name="UpdateMethod" datasource="#Request.DS#" 
		username="#Request.user#" password="#Request.pass#">
		UPDATE #Request.DB_Prefix#UPSMethods
		SET Used = 1,
		Priority = #Priority#
		WHERE ID = #ID#
		</cfquery>

	<cfelse>
		<cfquery name="UpdateMethod2" datasource="#Request.DS#" 
		username="#Request.user#" password="#Request.pass#">
		UPDATE #Request.DB_Prefix#UPSMethods
		SET Used = 0,
		Priority = #Priority#
		WHERE ID = #ID#
		</cfquery>
	</cfif>

</cfloop>

<!--- Refresh cached Query for UPS shipping methods --->
<cfinclude template="act_refresh_queries.cfm">

<!---------------------------->
<cfoutput>
<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
alert('Your changes have been saved!');
location.href = "#self#?fuseaction=shopping.admin&shipping=settings&redirect=yes#request.token2#";
</script>
</cfprocessingdirective>
</cfoutput>


