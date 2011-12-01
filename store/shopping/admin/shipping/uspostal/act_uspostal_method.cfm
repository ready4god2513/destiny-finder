
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Runs the admin actions for U.S.P.S. shipping rates: add, edit, delete. Called by shopping.admin&shipping=usps_method --->

<!--- Prepare priority --->
<cfif NOT isNumeric(attributes.Priority) OR attributes.Priority IS 0>
	<cfset attributes.Priority = 99>
</cfif>

<cfif attributes.submit_method is "Delete">

	<cfquery name="DeleteShip" datasource="#Request.DS#" 
	username="#Request.user#" password="#Request.pass#">
	DELETE FROM #Request.DB_Prefix#USPSMethods
	WHERE ID = #attributes.ID#
	</cfquery>

<cfelseif attributes.ID IS 0>

	<cfquery name="AddMethod" datasource="#Request.DS#" 
	username="#Request.user#" password="#Request.pass#">
	INSERT INTO #Request.DB_Prefix#USPSMethods
	(Type, Name, Code, Priority, Used)
	VALUES
	('#attributes.Type#',
	'#Trim(attributes.Name)#',	
	'#Trim(attributes.Code)#',	
	#attributes.Priority#,
	#attributes.Used#)
	</cfquery>

<cfelse>

	<cfquery name="UpdateMethod" datasource="#Request.DS#" 
	username="#Request.user#" password="#Request.pass#">
	UPDATE #Request.DB_Prefix#USPSMethods
	SET Type = '#attributes.Type#',
	Name = '#Trim(attributes.Name)#', 
	Code = '#Trim(attributes.Code)#', 
	Priority = #attributes.Priority#,
	Used = #attributes.Used#
	WHERE ID = #attributes.ID#
	</cfquery>

</cfif>


<cfinclude template="act_reset_uspostal.cfm">

	


	<cfmodule template="../../../../customtags/format_admin_form.cfm"
		box_title="U.S.P.S. Shipping Methods"
		width="400"
		required_fields="0"
		>
	
	<tr><td align="center" class="formtitle">
		<br/>
		Changes Saved
		<cfoutput>
		<form action="#self#?fuseaction=shopping.admin&shipping=usps_methods#request.token2#" method="post">
		</cfoutput>
		<input class="formbutton" type="submit" value="Back To List"/>
		</form>
	</td></tr>	
			
	</cfmodule> 
	