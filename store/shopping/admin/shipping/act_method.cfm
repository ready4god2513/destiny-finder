
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Runs the admin actions for custom shipping methods: add, edit, delete. Called by shopping.admin&shipping=methods --->

<!--- Prepare priority --->
<cfif NOT isNumeric(attributes.Priority) OR attributes.Priority IS 0>
	<cfset attributes.Priority = 99>
</cfif>

<cfif attributes.submit_method is "Delete">

	<cfquery name="DeleteShip" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	DELETE FROM #Request.DB_Prefix#CustomMethods
	WHERE ID = #attributes.ID#
	</cfquery>

<cfelseif attributes.ID IS 0>

	<cfquery name="AddMethod" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	INSERT INTO #Request.DB_Prefix#CustomMethods
		(Name, Amount, Used, Domestic, International, Priority)
	VALUES(
		'#Trim(attributes.Name)#',
		#attributes.Amount#,
		#attributes.Used#,
		#attributes.Domestic#,
		#attributes.International#,
		#attributes.Priority#)
	</cfquery>

<cfelse>

	<cfquery name="UpdateMethod" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	UPDATE #Request.DB_Prefix#CustomMethods
	SET Name = '#Trim(attributes.Name)#', 
	Amount = #attributes.Amount#, 
	Used = #Used#,
	Domestic = #attributes.Domestic#, 
	International = #attributes.International#, 
	Priority = #attributes.Priority#
	WHERE ID = #attributes.ID#
	</cfquery>

</cfif>

<cfset Request.Cache = CreateTimeSpan(0, 0, 0, 0)>
<cfset Application.objShipping.getCustomMethods()>



	


