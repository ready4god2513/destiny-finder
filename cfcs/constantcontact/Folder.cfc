<cfcomponent displayname="folder" initmethod="init">
	<cfproperty name="folderName">
	<cfproperty name="folderLink">
	<cfproperty name="id">
	
	<cffunction name="init" access="public" output="false">
		<cfargument name="folderName" type="string" required="true">
		<cfargument name="folderLink" type="string" default="">
		<cfargument name="id" type="string" default="">
		
		<cfset this.folderName = arguments.folderName>
		<cfset this.folderLink = arguments.folderLink>
		<cfset this.id = arguments.id>
		
		<cfreturn this>
	</cffunction>


</cfcomponent>