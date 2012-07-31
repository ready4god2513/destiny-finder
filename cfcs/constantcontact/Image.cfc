<cfcomponent displayname="Image" initmethod="init">
	<cfproperty name="imageName">
	<cfproperty name="imageUrl">
	<cfproperty name="imageId">
	<cfproperty name="height">
	<cfproperty name="width">
	<cfproperty name="description">
	<cfproperty name="folderName">
	<cfproperty name="folderId">
	<cfproperty name="md5hash">
	<cfproperty name="fileSize">
	<cfproperty name="updated">
	<cfproperty name="imageLink">
	<cfproperty name="fileType">
	<cfproperty name="imageUsages">
	
	<cffunction name="init" access="public" output="false">
		<cfargument name="imageName" type="string" required="true">
		<cfargument name="imageId" type="string" default="">
		<cfargument name="imageUrl" type="string" default="">
		<cfargument name="height" type="string" default="">
		<cfargument name="width" type="string" default="">
		<cfargument name="description" type="string" default="">
		<cfargument name="folderName" type="string" default="">
		<cfargument name="folderId" type="string" default="">
		<cfargument name="md5hash" type="string" default="">
		<cfargument name="fileSize" type="string" default="">
		<cfargument name="updated" type="string" default="">
		<cfargument name="imageLink" type="string" default="">
		<cfargument name="fileType" type="string" default="">
		<cfargument name="imageUsages" type="struct" default="#structNew()#">
	
		<cfset this.imageName = arguments.imageName>
		<cfset this.imageUrl = arguments.imageUrl>
		<cfset this.imageId = arguments.imageId>
		<cfset this.height = arguments.height>
		<cfset this.width = arguments.width>
		<cfset this.description = arguments.description>
		<cfset this.folderName = arguments.folderName>
		<cfset this.folderId = arguments.folderId>
		<cfset this.md5hash = arguments.md5hash>
		<cfset this.fileSize = arguments.fileSize>
		<cfset this.updated = arguments.updated>
		<cfset this.imageLink = arguments.imageLink>
		<cfset this.fileType = arguments.fileType>
		<cfset this.imageUsages = arguments.imageUsages>
		
		<cfreturn this>
		
	</cffunction>
</cfcomponent>