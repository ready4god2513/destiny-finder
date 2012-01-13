<cfcomponent displayname="Activity" initmethod="init">
	<cfproperty name="activityId">
	<cfproperty name="activityName">
	<cfproperty name="updated">
	<cfproperty name="activityLink">
	<cfproperty name="fileName">
	<cfproperty name="type">
	<cfproperty name="status">
	<cfproperty name="transactionCount">
	<cfproperty name="errors">
	<cfproperty name="runStartTime">
	<cfproperty name="runFinishTime">
	<cfproperty name="insertTime">
	
	<cffunction name="init" access="public" output="false">
		<cfargument name="activityId" type="string" required="true">
		<cfargument name="activityName" type="string" default="">
		<cfargument name="updated" type="string" default="">
		<cfargument name="activityLink" type="string" default="">
		<cfargument name="fileName" type="string" default="">
		<cfargument name="type" type="string" default="">
		<cfargument name="status" type="string" default="">
		<cfargument name="transactionCount" type="string" default="">
		<cfargument name="errors" type="string" default="">
		<cfargument name="runStartTime" type="string" default="">
		<cfargument name="runFinishTime" type="string" default="">
		<cfargument name="insertTime" type="string" default="">
		
		<cfset this.activityId = arguments.activityId>
		<cfset this.activityName = arguments.activityName>
		<cfset this.updated = arguments.updated>
		<cfset this.activityLink = arguments.activityLink>
		<cfset this.fileName = arguments.fileName>
		<cfset this.type = arguments.type>
		<cfset this.status = arguments.status>
		<cfset this.transactionCount = arguments.transactionCount>
		<cfset this.errors = arguments.errors>
		<cfset this.runStartTime = arguments.runStartTime>
		<cfset this.runFinishTime = arguments.runFinishTime>
		<cfset this.insertTime = arguments.insertTime>
		
		<cfreturn this>
	
	</cffunction>
</cfcomponent>