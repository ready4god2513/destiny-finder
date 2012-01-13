<cfcomponent displayname="List" initmethod="init">
	<cfproperty name="listName">
	<cfproperty name="id">
	<cfproperty name="listLink">
	<cfproperty name="updated">
	<cfproperty name="optInDefault">
	<cfproperty name="displayOnSignup">
	<cfproperty name="sortOrder">
	<cfproperty name="contactCount">
	<cfproperty name="membersLink">

	<cffunction name="init" access="public" output="false">
		<cfargument name="listName" type="string" required="true">
		<cfargument name="id" type="string" required="false" default="data:,none">
		<cfargument name="listLink" type="string" required="false" default="">
		<cfargument name="updated" type="string" required="false" default="">
		<cfargument name="optInDefault" type="string" required="false" default="">
		<cfargument name="displayOnSignup" type="string" required="false" default="">
		<cfargument name="sortOrder" type="string" required="false" default="99">
		<cfargument name="contactCount" type="string" required="false" default="">
		<cfargument name="membersLink" type="string" required="false" default="#listLink#/members">
		
		<cfset this.listName = arguments.listName>
		<cfset this.id = arguments.id>
		<cfset this.listLink = arguments.listLink>
		<cfset this.updated = arguments.updated>
		<cfset this.optInDefault = arguments.optInDefault>
		<cfset this.displayOnSignup = arguments.displayOnSignup>
		<cfset this.sortOrder = arguments.sortOrder>
		<cfset this.contactCount = arguments.contactCount>
		<cfset this.membersLink = arguments.membersLink>
		
		<cfreturn this>
	</cffunction>
</cfcomponent>
