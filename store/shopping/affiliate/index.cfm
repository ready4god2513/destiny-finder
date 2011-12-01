
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This is the shopping.affiliate circuit. It runs the functions for the store affiliates --->

<cfset Webpage_title = "Affiliate #attributes.do#">

<cfmodule template="../../access/secure.cfm"
keyname="login"
requiredPermission="0"
>
	
<cfif ispermitted>	
	<cfswitch expression="#attributes.do#">
	
		<cfcase value="register">
			<cfif isDefined("attributes.sub_affiliate")>
				<cfinclude template="act_register.cfm">
				<cfinclude template="dsp_register.cfm">	
			<cfelse>
				<cfinclude template="dsp_register_form.cfm">
			</cfif>				
		</cfcase>
	
		<cfcase value="report">
			<cfinclude template="dsp_report.cfm">			
		</cfcase>

		<cfcase value="links">
			<cfinclude template="dsp_links.cfm">
		</cfcase>
			
	</cfswitch>
</cfif>


