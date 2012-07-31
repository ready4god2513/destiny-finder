<cfcomponent displayname="VerifiedEmail" initmethod="init">
	<cfproperty name="emailAddress">
	<cfproperty name="id">
	<cfproperty name="verifiedTime">
	<cfproperty name="status">
	
	<cffunction name="init" access="public" output="false">
		<cfargument name="emailAddress" type="string" required="true">
		<cfargument name="id" type="string" default="">
		<cfargument name="verifiedTime" type="string" default="">
		<cfargument name="status" type="string" default="">
		
		<cfset this.emailAddress = arguments.emailAddress>
		<cfset this.id = arguments.id>
		<cfset this.verifiedTime = arguments.verifiedTime>
		<cfset this.status = arguments.status>
		
		<cfreturn this>
	</cffunction>
	
</cfcomponent>
