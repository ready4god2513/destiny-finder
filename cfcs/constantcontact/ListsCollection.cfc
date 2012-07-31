<cfcomponent displayname="ListsCollection" initmethod="init">
	<!--- Constructor --->
	<cffunction name="init" access="public" output="false">
		<cfreturn this>
	</cffunction>
	
	<cffunction name="addList" access="public" output="true" returnType="List"
		hint="Adds the current List object to your Constant Contact account">
		<cfargument name="list" type="list" required="true">
		
		<!--- Create XML representing the current List object --->
		<cfset local.listXml = createListXml(arguments.list)>
		
		<cfinvoke component="Utility"
				method="CTCTRequest"
				requestMethod="post"
				address="#application.apiPath#/lists"
				requestValue="#local.listXml#"
				returnVariable="local.httpResponse" />
				
		<!--- Create List object from XML returned by Constant Contact --->
		<cfset local.listStruct = createListStruct(local.httpResponse)>
		<cfset local.newList = createObject("component", "List").init(argumentCollection = local.listStruct)>
		
		<cfreturn local.newList>
	</cffunction>
	
	<cffunction name="deleteList" access="public" output="false" returnType="string"
		hint="Delete the current list from your Constant Contact account">
		<cfargument name="list" type="list" required="true">
				
		<!--- Make HTTP request to Constant Contact --->
		<cfinvoke component="Utility"
				method="CTCTRequest"
				requestMethod="delete"
				address="#arguments.list.listLink#"
				returnVariable="local.httpResponse" />
				
		<cfreturn local.httpResponse>
	</cffunction>
	
	<cffunction name="getListDetails" access="public" output="false" returnType="List"
		hint="Returns full details from the provided List">
		<cfargument name="list" type="list" required="true">
		
		<!--- Make HTTP request to Constant Contact --->
		<cfinvoke component="Utility"
				method="CTCTRequest"
				requestMethod="GET"
				address="#arguments.list.listLink#"
				returnVariable="local.httpResponse" />
				
		<!--- Create a List object from the returned XML --->
		<cfset local.listXml = xmlParse(local.httpResponse)>
		<cfset local.listStruct = createListStruct(local.listXml)>
		<cfset local.newList = createObject("component", "List").init(argumentCollection = local.listStruct)>
		
		<cfreturn local.newList>
	</cffunction>
	
	<cffunction name="getListMembers" access="public" output="false" returnType="array"
		hint="Returns array of all Contact's that exist in the provided List">
		<cfargument name="list" type="List" required="true">
		
		<!--- Setup Variables --->
		<cfset local.memberArray = arrayNew(1)>
		<cfset local.fullMembersArray = arrayNew(1)>
		<cfset local.linkArray = arrayNew(1)>
		<cfset local.nextAddress = "">
		
		<!--- Make HTTP request to Constant Contact --->
		<cfinvoke component="Utility"
				method="CTCTRequest"
				requestMethod="GET"
				address="#arguments.list.membersLink#"
				returnVariable="local.listsXml" />
				
		<!--- Create Contact objects from the overview of details returned for list members--->
		<cfset local.contactsXml = xmlParse(local.listsXml)>
		<cfif (isdefined('local.contactsXml.feed.entry'))>
		
			<cfloop from="1" to="#arrayLen(local.contactsXml.feed.entry)#" index="i">
				<cfset local.contact.contactLink = application.path & local.contactsXml.feed.entry[i].link.xmlattributes.href>
				<cfset local.contact.contactId = local.contactsXml.feed.entry[i].id.xmltext>
				<cfset local.contact.updated = local.contactsXml.feed.entry[i].updated.xmltext>
				<cfset local.contact.emailAddress = local.contactsXml.feed.entry[i].content.contactlistmember.emailaddress.xmlText>
				<cfset local.listMember = createObject("component", "Contact").init(argumentCollection=local.contact)>
				<cfset arrayAppend(local.memberArray, local.listMember)>
			</cfloop>

			<cfset arrayAppend(local.fullMembersArray, local.memberArray)>
			
			<!--- Find and append array containing the next link if one exists --->
			<cfset local.nextLinkSearch = xmlSearch (local.contactsXml, "//*[@rel='next']")>
			<cfif (!arrayIsEmpty(local.nextLinkSearch))>
				<cfset local.nextAddress = application.path & local.nextLinkSearch[1].xmlAttributes.href>
			</cfif>
			
			<cfset local.linkArray[1] = local.nextAddress>
			<cfset arrayAppend(local.fullMembersArray, local.linkArray)>
		</cfif>
		
		<cfreturn local.fullMembersArray>
	</cffunction>

	<cffunction name="getLists" access="public" output="true" returnType="array"
		hint="Returns array of List objects and link to next page of 50 Lists if one exists">
		<cfargument name="page" type="string" required="true" default="#application.apiPath#/lists">
					
		<!--- Make HTTP request to Constant Contact --->
		<cfinvoke component="Utility"
				method="CTCTRequest"
				requestMethod="GET"
				address="#arguments.page#"
				returnVariable="local.listsXml" />
				
		<!--- Setup Variables --->
		<cfset local.listsXml = xmlParse(local.listsXml)>
		<cfset local.nextAddress = "">
		<cfset local.listArray = arrayNew(1)>
		<cfset local.linkArray = arrayNew(1)>
		<cfset local.getListsArray = arrayNew(1)>
		
		<!--- Create array of List objects from each entry returned --->
		<cfloop from="1" to="#arrayLen(local.listsXml.feed.entry)#" index="i">
			<cfset local.list.listLink = application.path & local.listsXml.feed.entry[i].link.xmlattributes.href>
			<cfset local.list.id = local.listsxml.feed.entry[i].id.xmlText>
			<cfset local.list.listName = local.listsXml.feed.entry[i].content.contactlist.name.xmltext>
			<cfset local.list.updated = local.listsxml.feed.entry[i].updated.xmltext>
			
			<!--- Do not included list names set in 'DoNotInclude' list in Application.cfc --->
			<cfif (!listContains(application.doNotInclude, local.list.listName))>
				<cfset local.list.contactCount = local.listsXml.feed.entry[i].content.contactList.contactCount.xmltext>
				<cfset local.list.displayOnSignup = local.listsxml.feed.entry[i].content.contactList.displayOnSignup.xmlText>
				<cfset local.newList = createObject("component", "List").init(argumentCollection = local.list)>
				<cfset arrayAppend(local.listArray, local.newList)>
			</cfif>
			
		</cfloop>
		
		<!--- Attach Lists array, as well as link to the next page of Lists if one exists --->
		<cfset arrayAppend(local.getListsArray, local.listArray)>
		<cfset local.nextSearchLink = xmlSearch(local.listsXml, "//*[@rel='next']")>
		<cfif (!arrayIsEmpty(local.nextSearchLink))>
			<cfset local.nextAddress = application.path & local.nextLinkSearch[1].xmlAttributes.href>
		</cfif>
		
		<cfset local.linkArray[1] = local.nextAddress>
		<cfset arrayAppend(local.getListsArray, local.linkArray)>	
		
		<cfreturn local.getListsArray>			
	</cffunction>

	<cffunction name="removeListMembers" access="public" output="false" returnType="Activity"
		hint="Creates an activity to remove all of the current list members">
		<cfargument name="list" type="list" required="true">	
		
		<!--- Setup Variables --->
		<cfset local.clearLinkArray = arrayNew(1)>
		<cfset local.clearLinkArray[1] = arguments.list.listLink>
		
		<!--- Create Activity object to remove contacts from the provided list --->
		<cfset local.clearActivity = createObject("component", "ActivitiesCollection").clearContactsFromLists(local.clearLinkArray)>
		
		<cfreturn local.clearActivity>
	</cffunction>
	
	<cffunction name="updateList" access="public" output="false" returnType="string"
		hint="Updates the provided List object with its current details">
		<cfargument name="list" type="list" required="true">
		
		<!--- Create XML for the provided List object --->
		<cfset local.listXml = createListXml(arguments.list)>
		
		<!--- Make HTTP request to Constant Contact--->
		<cfinvoke component="Utility"
				method="CTCTRequest"
				requestMethod="put"
				address="#arguments.list.listLink#"
				requestValue="#local.listXml#"
				returnVariable="local.httpResponse" />
				
		<cfreturn local.httpResponse>
				
	</cffunction>

	<cffunction name="createListXml" access="private" output="false" returnType="xml"
		hint="Create XML representing the provided List object">
		<cfargument name="list" type="list" required="true">
		
		<!--- Create CFXML of the provided List --->
		<cfset local.listObj = arguments.list>
		<cfxml variable="local.listXml">
			<cfoutput>
			<entry xmlns="http://www.w3.org/2005/Atom">
					<id>#local.listObj.Id#</id>
					<title />
					<author />
					<updated>#dateformat(now(), "yyyy-mm-dd")#T#TimeFormat(now(), "HH:mm:ss:l")#Z</updated>
					<content type="application/vnd.ctct+xml">
						<ContactList xmlns="http://ws.constantcontact.com/ns/1.0/">
							<OptInDefault>#local.listObj.optInDefault#</OptInDefault>
							<Name>#local.listObj.listName#</Name>
							<SortOrder>#local.listObj.sortOrder#</SortOrder>
						</ContactList>
					</content>
				</entry>
			</cfoutput>
		</cfxml>
		
		<cfreturn local.listXml>
	</cffunction>
	
	<cffunction name="createListStruct" access="private" output="false" returnType="struct"
		hint="Creates struct representing the provided List object">
		<cfargument name="listXml" type="any" required="true">
		
		<!--- Create struct from provided XML --->
		<cfset local.listXml = xmlParse(arguments.listXml)>
		<cfset local.findLink = xmlSearch(local.listXml, "//*[@rel='edit']")>
		<cfset local.linkStruct.listLink = application.path & local.findLink[1].XmlAttributes.href>
		<cfset local.linkStruct.listName = local.listXml.entry.title.xmlText>
		<cfset local.linkStruct.id = local.listXml.entry.id.xmlText>
		<cfset local.linkStruct.updated = local.listXml.entry.updated.xmlText>
		<cfset local.linkStruct.optInDefault = local.listXml.entry.content.contactlist.optindefault.xmltext>
		<cfset local.linkStruct.displayOnSignup = local.listXml.entry.content.contactlist.displayOnSignup.xmltext>
		<cfset local.linkStruct.sortOrder = local.listXml.entry.content.ContactList.sortOrder.XmlText>
		<cfif (structKeyExists(local.listXml.entry.content.ContactList, "ContactCount"))>
			<cfset local.linkStruct.contactCount = local.listXml.entry.content.ContactList.contactCount.XmlText>
		</cfif>
		
		<cfreturn local.linkStruct>
	</cffunction>
</cfcomponent>

