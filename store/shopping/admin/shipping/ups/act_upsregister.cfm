<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to process the UPS registration form. Called by shopping.admin&shipping=upsregister --->

<!--- Get UPS Settings --->
<cfquery name="UPS" datasource="#Request.DS#" username="#Request.user#" 
password="#Request.pass#" maxrows="1">
SELECT Debug FROM #Request.DB_Prefix#UPS_Settings
</cfquery>

<cfparam name="ErrorMessage" default="">

<!--- Make sure registration request only started once --->
<cfif NOT isDefined("Session.StartRegister")>

<cftry>

<cfinvoke component="#Request.CFCMapping#.shipping.upssecurity" 
	method="getAccessKey" 
	returnvariable="getKey" 
	argumentcollection="#Form#"
	debug="#UPS.Debug#">
	
<!--- Output debug if returned --->
<cfif len(getKey.Debug)>
	<cfinvoke component="#Request.CFCMapping#.global" method="putDebug" debugtext="#getKey.Debug#">
</cfif>

<!--- If registration is successful, save the access key to the database --->
<cfif getKey.Success>

	<cfquery name="UpdUPS" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	UPDATE #Request.DB_Prefix#UPS_Settings
	SET AccessKey = '#getKey.AccessKey#'
	</cfquery>

	<!--- Process the Registration --->
	
	<cfinvoke component="#Request.CFCMapping#.shipping.upssecurity" 
		method="doUPSRegister" 
		returnvariable="Register" 
		argumentcollection="#Form#"
		debug="#UPS.Debug#">
		
		<!--- Output debug if returned --->
		<cfif len(Register.Debug)>
			<cfinvoke component="#Request.CFCMapping#.global" method="putDebug" debugtext="#Register.Debug#">
		</cfif>
	
	<!--- If registration is successful, save the username and password to the database --->
	<cfif Register.Success>
	
		<cfparam name="Session.StartRegister" default="Yes">
	
		<cfquery name="UpdUPS" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		UPDATE #Request.DB_Prefix#UPS_Settings
		SET Username = '#Register.username#',
		Password = '#Register.Password#'
		<cfif len(Register.AccountNo)>, AccountNo = '#Register.AccountNo#'</cfif>
		</cfquery>
	
	<cfelse>
	
		<cfset ErrorMessage = Register.ErrorMessage>
	
	</cfif>

<cfelse>

	<cfset ErrorMessage = getKey.ErrorMessage>

</cfif>


<cfcatch type="Any">
	<cfset ErrorMessage = "There was an error in running the UPS Registration Tool. Please contact the system administrator for assistance.">
</cfcatch>
</cftry>

<cfelse>

	<cfset ErrorMessage = "The registration request has already been processed. Please do not submit the registration more than once.">

</cfif>

