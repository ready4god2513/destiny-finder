<cfcomponent displayname="LibraryCollection" initmethod="init">
	<!--- Constructor --->
	<cffunction name="init" access="public" output="false" >
		<cfreturn this>	
	</cffunction>
	
	<cffunction name="addFolder" access="public" output="false" returnType="Folder"
		hint="Adds a Folder object to your Constant Contact account">
		<cfargument name="folder" type="Folder" required="true">
		
		<!--- Create XML representing a Folder from provided Folder --->
		<cfset local.newFolderXml = createFolderXml(arguments.folder)>

		<!--- Make HTTP request to Constant Contact --->
		<cfinvoke component="Utility"
				method="CTCTRequest"
				requestMethod="POST"
				address="#application.apiPath#/library/folders"
				requestValue="#local.newFolderXml#"
				returnVariable="local.httpResponse" />
				
		<!--- Create a Folder object from the XML returned by Constant Contact --->
		<cfset local.folderXml = xmlParse(local.httpResponse)>
		<cfset local.folderStruct = createFolderStruct(local.folderXml)>
		<cfset local.newFolder = createObject("component", "Folder").init(argumentCollection = local.folderStruct)>
		
		<cfreturn local.newFolder>
	</cffunction>
	
	<cffunction name="deleteImage" access="public" output="false" returnType="string"
		hint="Deletes the provided image from you Library">
		<cfargument name="image" type="Image" required="true">
		
		<!--- Make HTTP request to Constant Contact --->
		<cfinvoke component="Utility"
				method="CTCTRequest"
				requestMethod="DELETE"
				address="#arguments.image.imageLink#"
				returnVariable="local.httpResponse" />
				
		<cfreturn local.httpResponse>
	</cffunction>
	
	<cffunction name="deleteImagesFromFolder" access="public" output="false" returnType="string"
		hint="Delete all the Images contained in the provided Folder object">
		<cfargument name="folder" type="Folder" required="true">
		
		<!--- Make HTTP request to Constant Contact --->
		<cfinvoke component="Utility"
				method="CTCTRequest"
				requestMethod="DELETE"
				address="#arguments.folder.folderLink#/images"
				returnVariable="local.httpResponse" />
				
		<cfreturn local.httpResponse>
	</cffunction>
	
	
	<cffunction name="getImageDetails" access="public" output="true" returnType="Image"
		hint="Returns an Image object with full details for the provided image">
		<cfargument name="image" type="Image" required="true">
		
		<!--- Make HTTP request to Constant Contact --->
		<cfinvoke component="Utility"
				method="CTCTRequest"
				requestMethod="GET"
				address="#arguments.image.imageLink#"
				returnVariable="local.httpResponse" />
				
		<!--- Create Image object from the data returned from Constant Contact --->
		<cfset local.imageStruct = createImageStruct(local.httpResponse)>
		<cfset local.image = createObject("component", "Image").init(argumentCollection = local.imageStruct)>
		
		<cfreturn local.image>
	</cffunction>
	
	<cffunction name="listFolders" access="public" output="true" returnType="array"
		hint="Returns array of Folder objects from your account as well as a link to the next page of Folders if one exists">
		<cfargument name="page" type="string" default="#application.apiPath#/library/folders">
		
		<!--- Setup Variables --->
		<cfset local.foldersArray = arrayNew(1)>
		<cfset local.linkArray = arrayNew(1)>
		<cfset local.fullArray = arrayNew(1)>
		<cfset local.nextAddress = "">
	
		<!--- Make HTTP request to Constant Contact --->
		<cfinvoke component="Utility"
				method="CTCTRequest"
				requestMethod="GET"
				address="#arguments.page#"
				returnVariable="local.httpResponse" />

			
		<cfset local.foldersXml = xmlParse(local.httpResponse)>
		
		<!--- Create a Folder object for each entry returned --->
		<cfloop from="1" to="#arrayLen(local.foldersXml.feed.entry)#" index="i">
			<cfset local.folder.folderName = local.foldersXml.feed.entry[i].title.xmlText>
			<cfset local.folder.folderLink = application.path & local.foldersXml.feed.entry[i].link.xmlattributes.href>
			<cfset local.folder.id = local.foldersXml.feed.entry[i].id.xmlText>
			<cfset local.newFolder = createObject("component", "Folder").init(argumentCollection=local.folder)>
			<cfset arrayAppend(local.foldersArray, local.newFolder)>
		</cfloop>

		<cfset arrayAppend(local.fullArray, local.foldersArray)>
		
		<!--- Get a link for the next page of Folders, if one exists --->
		<cfset local.nextLinkSearch = xmlSearch (local.foldersXml, "//*[@rel='next']")>
		<cfif (!arrayIsEmpty(local.nextLinkSearch))>
			<cfset local.nextAddress = application.path & local.nextLinkSearch[1].xmlAttributes.href>
		</cfif>
		<cfset local.linkArray[1] = local.nextAddress>
		<cfset arrayAppend(local.fullArray, local.linkArray)>
		
		<cfreturn local.fullArray>
	</cffunction>
		
	<cffunction name="listImagesFromFolder" access="public" output="false" returnType="array"
		hint="Returns an array of Image objects that exist in the provided folder">
		<cfargument name="folder" type="Folder" required="true">
			
			<!--- Setup Variables --->
			<cfset local.imageArray = arrayNew(1)>
			<cfset local.linkArray = arrayNew(1)>
			<cfset local.fullImagesArray = arrayNew(1)>
			<cfset local.nextAddress = "">
			
			<!--- Make HTTP request to Constant Contact --->
			<cfinvoke component="Utility"
				method="CTCTRequest"
				requestMethod="GET"
				address="#arguments.folder.folderLink#/images"
				returnVariable="local.httpResponse" />
				
			<!--- Create array of Image objects with the data returned from Constant Contact --->
			<cfset local.imageXml = xmlParse(local.httpResponse)>
			<cfif(isdefined('local.imageXml.feed.entry'))>
				<cfloop from="1" to="#arrayLen(local.imageXml.feed.entry)#" index="i">
					<cfset local.imageStruct.imageName = local.imageXml.feed.entry[i].content.image.filename.xmlText>
					<cfset local.imageStruct.imageId = local.imageXml.feed.entry[i].id.xmlText>
					<cfset local.imageStruct.imageUrl = local.imageXml.feed.entry[i].content.image.imageurl.xmlText>
					<cfset local.imageStruct.height = local.imageXml.feed.entry[i].content.image.height.xmlText>
					<cfset local.imageStruct.width = local.imageXml.feed.entry[i].content.image.width.xmlText>
					<cfset local.imageStruct.description = local.imageXml.feed.entry[i].content.image.description.xmlText>
					<cfset local.imageStruct.folderName = local.imageXml.feed.entry[i].content.image.folder.name.xmlText>
					<cfset local.imageStruct.folderId = local.imageXml.feed.entry[i].content.image.folder.xmlattributes.id>
					<cfset local.imageStruct.md5hash = local.imageXml.feed.entry[i].content.image.md5hash.xmlText>
					<cfset local.imageStruct.fileSize = local.imageXml.feed.entry[i].content.image.filesize.xmlText>
					<cfset local.imageStruct.updated = local.imageXml.feed.entry[i].content.image.lastupdated.xmlText>
					<cfset local.imageStruct.imageLink = application.path & local.imageXml.feed.entry[i].link.xmlAttributes.href>
					<cfset local.imageStruct.fileType = local.imageXml.feed.entry[i].content.image.filetype.xmlText>
					<cfset local.image = createObject("component", "Image").init(argumentCollection = local.imageStruct)>
					<cfset arrayAppend(local.imageArray, local.image)>
				</cfloop>
				
				<!--- Get link to the next page of Images, if one exists --->
				<cfset arrayAppend(local.fullImagesArray, local.imageArray)>
				<cfset local.nextLinkSearch = xmlSearch (local.imageXml, "//*[@rel='next']")>
				<cfif (!arrayIsEmpty(local.nextLinkSearch))>
					<cfset local.nextAddress = application.path & local.nextLinkSearch[1].xmlAttributes.href>
				</cfif>
				<cfset local.linkArray[1] = local.nextAddress>
				<cfset arrayAppend(local.fullImagesArray, local.linkArray)>
			</cfif>
		
		<cfreturn local.fullImagesArray>
	</cffunction> 
	
	
	
	
	<cffunction name="createFolderXml" access="private" output="false" returnType="xml"
		hint="Creates XML representing a Folder object">
		<cfargument name="folder" type="Folder" required="true">
		
		<!--- Create XML representing a Folder --->
		<cfxml variable="local.folderXml">
		<cfoutput>
			<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
			<atom:entry xmlns:atom="http://www.w3.org/2005/Atom">
				<atom:content>
					<Folder>
						<Name>#arguments.folder.folderName#</Name>
					</Folder>
				</atom:content>
			</atom:entry>
		</cfoutput>
		</cfxml>
	
		<cfreturn local.folderXml>
	</cffunction>
	
	<cffunction name="createImageXml" access="private" output="false" returnType="xml"
		hint="Create XML representing an Image object">
		<cfargument name="image" type="Image" required="true">
		
		<!--- Create Image XML --->
		<cfxml variable="local.imageXml">
			<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
			<atom:entry xmlns:atom="http://www.w3.org/2005/Atom">
			<atom:title>#arguments.image.title#</atom:title>
			<atom:id>#arguments.image.imageid#</atom:id>
			        <atom:content>
			                <Image>
			                <FileName>#arguments.image.imageName#</FileName>
			                <MD5Hash>#arguments.image.md5Hash#</MD5Hash>
			                <Description>#arguments.image.description#</Description>
			                </Image>
			        </atom:content>
			</atom:entry>
		</cfxml>
	
		<cfreturn local.imageXml>
	</cffunction>
	
	<cffunction name="createImageStruct" access="private" output="false" returnType="struct"
		hint="Create a struct representing an Image object">
		<cfargument name="imageXml" type="xml" required="true">
		
		<!--- Create Image struct --->
		<cfset local.imageXml = xmlParse(arguments.imageXml)>
		<cfset local.imageUsages = structNew()>
		<cfif(isdefined('local.imageXml.entry.content.image.imageUsages.imageusage'))>
			<cfloop from="1" to="#arrayLen(local.imageXml.entry.content.image.imageUsages)#" index="i">
				<cfset local.imageUsages.name = local.imageXml.entry.content.image.imageUsages[i].imageusage.name.xmlText>
				<cfset local.imageUsages.campaignLink = application.path & local.imageXml.entry.content.image.imageUsages[i].imageusage.link.href.xmlText>
			</cfloop>
		</cfif>
		<cfset local.imageStruct.imageName = local.imageXml.entry.content.image.filename.xmlText>
		<cfset local.imageStruct.imageUrl = local.imageXml.entry.content.image.imageurl.xmlText>
		<cfset local.imageStruct.height = local.imageXml.entry.content.image.height.xmlText>
		<cfset local.imageStruct.width = local.imageXml.entry.content.image.width.xmlText>
		<cfset local.imageStruct.description = local.imageXml.entry.content.image.description.xmlText>
		<cfset local.imageStruct.md5hash = local.imageXml.entry.content.image.md5hash.xmlText>
		<cfset local.imageStruct.fileSize = local.imageXml.entry.content.image.filesize.xmlText>
		<cfset local.imageStruct.updated = local.imageXml.entry.content.image.lastupdated.xmlText>
		<cfset local.imageStruct.imageUsages = local.imageUsages>
		<cfset local.imageStruct.imageLink = application.path & local.imageXml.entry.link.xmlAttributes.href>
		<cfset local.imageStruct.fileType = local.imageXml.entry.content.image.filetype.xmlText>
			
		<cfreturn local.imageStruct>
	</cffunction>
	
	<cffunction name="createFolderStruct" access="private" output="false" returnType="struct"
		hint="Creates a struct representing a Folder">
		<cfargument name="folderXml" type="xml" required="true">
		
		<!--- Create struct from XML --->
		<cfset local.folderXml = xmlParse(arguments.folderXml)>
		<cfset local.folder.folderName = local.folderXml.entry.content.folder.name.xmltext>
		<cfset local.folder.id = local.folderXml.entry.id.xmlText>
		<cfset local.folder.folderLink = local.folderXml.entry.link.xmlAttributes.href>
		<cfreturn local.folder>
	</cffunction>
	
</cfcomponent>

