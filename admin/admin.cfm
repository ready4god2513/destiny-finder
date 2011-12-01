<cfparam name="action" default="">

<cfswitch expression="#action#">
	
	<cfcase value="validate_login">
		<cfinclude template="validate_login.cfm">
	</cfcase>
	
	<cfcase value="validated">
		<cfinclude template="index.cfm">
	</cfcase>
	
	<cfdefaultcase>
		<cfinclude template="login.cfm">
	</cfdefaultcase>

</cfswitch>

