<cfcomponent displayname="ActivitiesCollection" initmethod="init">
	<!--- Constructor --->
	<cffunction name="init" access="public" output="false">
		<cfreturn this>
	</cffunction>
	
	<cffunction name="bulkExportContacts" access="public" output="false" returnType="Activity"
		hint="Exports a list of contacts to a file based on the arguments provided">
		<cfargument name="columns" type="array" required="true">
		<cfargument name="listId" type="string" required="true">
		<cfargument name="fileType" type="string" default="CSV">
		<cfargument name="exportOptDate" type="boolean" default="true">
		<cfargument name="exportOptSource" type="boolean" default="true">
		<cfargument name="exportListName" type="boolean" default="true">
		<cfargument name="sortBy" type="string" default="EMAIL_ADDRESS">
		
		<!--- Setup Variables --->
		<cfset local.bulkPost.columns = arguments.columns>
		<cfset local.bulkPost.listId = arguments.listId>
		<cfset local.bulkPost.fileType = arguments.fileType>
		<cfset local.bulkPost.exportOptDate = arguments.exportOptDate>
		<cfset local.bulkPost.exportOptSource = arguments.exportOptSource>
		<cfset local.bulkPost.exportListName = arguments.exportListName>
		<cfset local.bulkPost.sortBy = arguments.sortBy>

		<!--- Make an HTTP request to Constant Contact for an export contacts bulk activity --->
		<cfset local.httpResponse = createObject("component", "Utility").exportContactsPost(argumentCollection = local.bulkPost)>
		
		<!--- Parse the XML into a struct able to be digested by an activity object --->
		<cfset local.activityStruct = createActivityStruct(local.httpResponse)>
		<cfset local.activity = createObject("component", "Activity").init(argumentCollection = local.activityStruct)>
		
		<cfreturn local.activity>
	</cffunction>
	
	<cffunction name="bulkMultiPart" access="public" output="false" returnType="Activity"
		hint="Creates a multipart post to upload file contents" >
		<cfargument name="activityType" type="string" required="true">
		<cfargument name="lists" type="array" required="true">
		<cfargument name="fileContents" type="string" required="false">
		
		<!--- Setup Variables --->
		<cfset local.bulkUpload.activityType = arguments.activityType>
		<cfset local.bulkUpload.lists = arguments.lists>
		<cfset local.bulkUpload.dataFile = arguments.fileContents>
		
		<!--- Make a multipart HTTP request to Constant Contact --->
		<cfinvoke component="Utility"
				method="multiPartPost"
				argumentcollection="#local.bulkUpload#"
				returnvariable="local.httpResponse" />
				
		<!--- Parse the XML into a struct able to be digested by an activity object --->
		<cfset local.activityStruct = createActivityStruct(local.httpResponse)>
		<cfset local.createdActivity = createObject("component", "Activity").init(argumentCollection = local.activityStruct)>
		
		<cfreturn local.createdActivity>
	</cffunction>
	
	<cffunction name="bulkUrlEncoded" access="public" output="false" returnType="Activity"
		hint="Uploads a URL encoded string to Constant Contact">
		<cfargument name="uploadString" type="string" required="true">
		
		<!--- Make a url encoded HTTP request to Constant Contact --->
			<cfinvoke component="Utility"
					method="urlEncodedPost"
					uploadString="#uploadString#"
					returnVariable="local.httpResponse" />
		
			<!--- Parse the XML into a struct able to be digested by an activity object --->
			<cfset local.activityStruct = createActivityStruct(local.httpResponse)>
			<cfset local.activity = createObject("component", "Activity").init(argumentCollection = local.activityStruct)>
			
			<cfreturn local.activity>
	</cffunction>
	
	<cffunction name="clearContactsFromLists" access="public" output="true"
		hint="Clears all contacts from a provided array of contact lists">
		<cfargument name="lists" type="array" required="true">

		<!--- Setup Variables --->
		<cfset local.clearRequest.activityType = 'CLEAR_CONTACTS_FROM_LISTS'>
		<cfset local.clearRequest.lists = arguments.lists>
		
		<!--- Make a multipart HTTP request to Constant Contact --->
		<cfinvoke component="Utility"
			method="multiPartPost"
			argumentCollection="#local.clearRequest#"
			returnvariable="local.httpResponse" />

		<!--- Parse the XML into a struct able to be digested by an activity object --->
		<cfset local.activityStruct = createActivityStruct(local.httpResponse)>
		<cfset local.createdActivity = createObject("component", "Activity").init(argumentCollection = local.activityStruct)>
		
		<cfreturn local.createdActivity>
	</cffunction>
	
	<cffunction name="getActivities" access="public"  output="true" returnType="array">
		<cfargument name="page" type="string" default="#application.apiPath#/activities"
		hint="Returns recent bulk activities as well as a link to the next page if one exists">
		
		<!--- Setup variables --->
		<cfset local.activitiesArray = arrayNew(1)>
		<cfset local.nextAddress = "">
		<cfset local.fullArray = arrayNew(1)>
		<cfset local.linkArray = arrayNew(1)>
		
		<!--- Make HTTP request to Constant Contact --->
		<cfinvoke component="Utility"
				method="CTCTRequest"
				requestMethod="get"
				address="#arguments.page#"
				returnVariable="local.httpResponse" />
		
		<cfset local.activityXml = xmlParse(local.httpResponse)>
		
		<!--- Create an activity object for each entry returned from the XML in the HTTP request --->
		<cfloop from="1" to ="#arrayLen(local.activityXml.feed.entry)#" index="i">
			<cfset local.activity = createObject("component", "ActivitiesCollection").createActivityStruct(local.activityXml.feed.entry[i])>	
			<cfset local.newActivity = createObject("component", "Activity").init(argumentCollection = local.activity)>
			<cfset arrayAppend(local.activitiesArray, local.newActivity)>
		</cfloop>
		
		<!--- Aggregate all activities found into one array --->
		<cfset arrayAppend(local.fullArray, local.activitiesArray)>
		<cfset local.nextLinkSearch = xmlSearch(local.activityXml, "//*[@rel='next']")>
		
		<!--- Find a link to the next page of activities if one exists --->
		<cfif !arrayIsEmpty(local.nextLinkSearch)>
			<cfset local.nextAddress = application.apiPath & local.nextLinkSearch[1].XmlAttributes.href>
		</cfif>		
		<cfset local.linkArray[1] = local.nextAddress>
		<cfset arrayAppend(local.fullArray, local.linkArray)>

		<cfreturn local.fullArray>  
	</cffunction>
	
	<cffunction name="getActivityDetails" access="public" output="false" returnType="Activity"
		hint="Returns an activity object with full details of the activity provided">
		<cfargument name="activity" type="Activity" required="true">
		
		<!--- Make HTTP request to Constant Contact --->
		<cfinvoke component="Utility"
				method="CTCTRequest"
				requestMethod="get"
				address="#arguments.activity.activityLink#"
				returnVariable="local.httpResponse" />
				
				
		<!--- Parse the XML into a struct able to be digested by an activity object --->		
		<cfset local.activityStruct = createActivityStruct(local.httpResponse)>
		<cfset local.activity = createObject("component", "Activity").init(argumentCollection = local.activityStruct)>
				
		<cfreturn local.activity>
	</cffunction>

	<cffunction name="createActivityStruct" access="public" output="false" returntype="Struct"
		hint="Creates an activity struct from XML returned by Constant Contact">
		<cfargument name="activityXml" type="xml" required="true">
		
		<!--- Parse XML into a structure able to be digested by an activity object --->
		<cfset local.activityXml = xmlParse(arguments.activityXml)>
		<cfset local.activity.activityName = local.activityXml.entry.title.xmlText>
		<cfset local.activity.activityId = local.activityXml.entry.id.xmlText>
		<cfset local.activity.activityLink = application.path & local.activityXml.entry.link.xmlAttributes.href>
		<cfset local.activity.updated = local.activityxml.entry.updated.xmlText>
		<cfset local.activity.type = local.activityXml.entry.content.activity.type.xmlText>
		<cfset local.activity.status = local.activityXml.entry.content.activity.status.xmlText>
		<cfset local.activity.transactionCount = local.activityXml.entry.content.activity.transactionCount.xmlText>
		<cfset local.activity.errors = local.activityXml.entry.content.activity.errors.xmlText>
		<cfset local.activity.insertTime = local.activityXml.entry.content.activity.insertTime.xmlText>
		
		<!--- Set the activity run start time if that information is available --->
		<cfif (isdefined('local.activityXml.entry.content.activity.runStartTime'))>
			<cfset local.activity.runStartTime = local.activityXml.entry.content.activity.runStartTime.xmlText>
			<cfset local.activity.runFinishTime = local.activityXml.entry.content.activity.runFinishTime.xmlText>
		</cfif>
		
		<!--- Set the activity file name if that information is available --->
		<cfif (isdefined('local.activityXml.entry.content.activity.FileName'))>
			<cfset local.activity.fileName = local.activityXml.entry.content.activity.fileName.xmlText>
		</cfif>
		
		<cfreturn local.activity>
	</cffunction>
	
</cfcomponent>
