
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page is used to process the complete list of FedEx methods, to set which ones are being used by the store. Called by shopping.admin&shipping=fedex_methods --->

<cfquery name="GetMethods" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT ID FROM #Request.DB_Prefix#FedExMethods
</cfquery>

<cfloop query="GetMethods">
	
	<cfset Priority = Evaluate("attributes.Priority#ID#")>
		
	<cfif NOT isNumeric(Priority) OR Priority IS 0>
		<cfset Priority = 99>
	</cfif>
	

	<cfif isDefined("attributes.Used#ID#")>
	<cfset Used = 1>
	
	<cfquery name="UpdateMethod" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	UPDATE #Request.DB_Prefix#FedExMethods
	SET Used = #Used#,
	Priority = #Priority#
	WHERE ID = #ID#
	</cfquery>
	
	<cfelse>
		<cfquery name="UpdateMethod2" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		UPDATE #Request.DB_Prefix#FedExMethods
		SET Used = 0,
		Priority = #Priority#
		WHERE ID = #ID#
		</cfquery>
	</cfif>

</cfloop>

<cfset Request.Cache = CreateTimeSpan(0, 0, 0, 0)>
<cfinclude template="act_reset_fedex.cfm">



<cfoutput>
<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
alert('Your changes have been saved!');
location.href = "#self#?fuseaction=shopping.admin&shipping=fedex_methods&redirect=yes#request.token2#";
</script>
</cfprocessingdirective>
</cfoutput>



