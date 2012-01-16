<cfcomponent displayname="ContactsCollection" initmethod="init">		
	<cffunction name="init" access="public" output="false">
		<cfreturn this>
	</cffunction>
	
	<cffunction name="addContact" access="public" output="false" returnType="Contact"
		hint="Adds a Contact object to your Constant Contact account">
		<cfargument name="contact" type="Contact" required="true">
		
		<!--- Create XML necessary for adding a contact --->
		<cfset local.contactXml = createContactXml(arguments.contact)>
		
		<!--- Make HTTP request to Constant Contact --->
		<cfinvoke component="Utility"
				method="CTCTRequest"
				requestMethod="POST"
				address="#application.apiPath#/contacts"
				requestValue="#local.contactXml#"
				returnVariable="local.responseXml">
				
		<!--- Parse the XML into a struct able to be digested by a contact object --->
		<cfset local.contactStruct = createContactStruct(local.responseXml)>
		<cfset local.newContact = createObject("component", "Contact").init(argumentCollection = local.contactStruct)>
		
		<cfreturn local.newContact>				
	</cffunction>
	
	<cffunction name="deleteContact" output="false" access="public" returnType="string"
		hint="Deletes the Contact, opting it out of all lists. Use for unsubscribes">
		<cfargument name="Contact" type="contact" required="true">
		
		<!--- Make HTTP Request to Constant Contact --->
		<cfinvoke component="Utility"
				method="CTCTRequest"
				requestMethod="DELETE"
				address="#arguments.contact.contactLink#"
				returnVariable = "local.httpResponse"/>
				
		<cfreturn local.httpResponse>
	</cffunction>
		
	<cffunction name="doesContactExist" access="public" output="false" returnType="boolean"
		hint="returns true is a contact exists, or false if not">
		<cfargument name="emailAddress" type="string" required="true">
		
		<!--- Make HTTP Request to Constant Contact --->
		<cfinvoke component="Utility" 
				method="CTCTRequest" 
				requestMethod="GET" 
				address="#application.apiPath#/contacts?email=#arguments.emailAddress#" 
				returnVariable="local.httpResponse"/>
				
		<!--- Determine if the contact has been found --->
		<cfset local.httpResponse = xmlParse(local.httpResponse)>
		<cfif (isdefined('local.httpResponse.feed.entry'))>
			<cfreturn true>
		<cfelse>
			<cfreturn false>
		</cfif>
	</cffunction>
	
	<cffunction name="getContactDetails" access="public" output="false" returnType="Contact"
		hint="Returns a full contact object containing all details of the provided contact" >
		<cfargument name="contact" type="Contact" required="true">

		<!--- Make HTTP request to Constant Contact --->
		<cfinvoke component="Utility"
				method="CTCTRequest"
				requestMethod="GET"
				address="#arguments.contact.contactLink#" 
				returnVariable="local.contactXml" />
				
		<!--- Create a new contact object with the returned results--->		
		<cfset local.contactStruct = createContactStruct('#local.contactXml#')>
		<cfset local.newContact = createObject("component", "Contact").init(argumentCollection = local.contactStruct)>
		
		<cfreturn local.newContact>
	</cffunction>
	
	<cffunction name="getContactId" access="public" output="false" returnType="any"
		hint="Returns a string of the contact ID for the provided email address, if one exists">
		<cfargument name="contactEmail" type="string" required="true">
		
		<!--- Create search URL --->
		<cfset local.url = '#application.apiPath#/contacts?email=#arguments.contactEmail#'>
		
		<!--- Make HTTP request to Constant Contact --->
		<cfinvoke component="Utility"
					method="CTCTRequest"
					requestMethod="GET"
					address="#local.url#" 
					returnVariable = "local.getContacts" />
					
		<!--- Find the contact ID in the returned XML --->			
		<cfset local.subscriberXml = xmlParse(local.getContacts)>
		<cfif (structKeyExists(local.subscriberxml.feed, "entry"))>
			<cfreturn local.subscriberxml.feed.entry.id.xmltext>
		<cfelse>
			<cfreturn 0>
		</cfif>
	</cffunction>
	
	<cffunction name="getContacts" access="public" output="false" returnType="array"
		hint="Returns array of Contact objects from your account as well as a link to the next page of Contacts if one exists">
		<cfargument name="page" type="string" default="#application.apiPath#/contacts">
		
		<!--- Setup variables --->
		<cfset local.nextAddress = "">
		<cfset local.linkArray = arrayNew(1)>
		<cfset local.contactArray = arrayNew(1)>
		<cfset local.fullContactArray = arrayNew(1)>
		
		<!--- Make HTTP request to Constant Contact and parse the result as XML --->
		<cfinvoke component="Utility"
					method="CTCTRequest"
					requestMethod="GET"
					address="#arguments.page#" 
					returnVariable = "local.getContacts" />
		
		<cfset local.contactsXml = xmlParse(local.getContacts)>
		
		<!--- For each entry returned, create a Contact object --->
		<cfloop from="1" to="#arrayLen(local.contactsXml.feed.entry)#" index="i">
			<cfset local.contact.id = local.contactsXml.feed.entry[i].id.xmlText>
			<cfset local.contact.contactLink = application.path & local.contactsXml.feed.entry[i].link.XmlAttributes.href>
			<cfset local.contact.name = local.contactsXml.feed.entry[i].Content.contact.Name.XmlText>
			<cfset local.contact.emailaddress = local.contactsXml.feed.entry[i].Content.contact.EmailAddress.XmlText>
			<cfset local.contact.status = local.contactsXml.feed.entry[i].Content.contact.Status.XmlText>
			<cfset local.contact.updated = local.contactsXml.feed.entry[i].Updated.XmlText>
			<cfset local.newContact = createObject("component", "Contact").init(argumentCollection = local.contact)>
			<cfset arrayAppend(local.contactArray, local.newContact)>
		</cfloop>
		
		<!--- Add all contacts found to the 'fullContactArray' --->		
		<cfset arrayAppend(local.fullContactArray, local.contactArray)>
		
		<!--- Search for a 'next' link and store it as 'nextAddress' --->
		<cfset local.nextLinkSearch = xmlSearch (local.contactsXml, "//*[@rel='next']")>
	
		<cfif (!ArrayIsEmpty(local.nextLinkSearch))>
			<cfset local.nextAddress = application.path & local.nextLinkSearch[1].xmlAttributes.href>
		</cfif>
		
		<!--- Add 'nextAddress' to the 'linkArray' --->
		<cfset local.linkArray[1] = local.nextAddress>
		<cfset arrayAppend(local.fullContactArray, local.linkArray)>
		
		<cfreturn local.fullContactArray>	
	</cffunction>
	
	<cffunction name="removeContact" output="false" access="public" returnType="string"
		hint="Removes the contact from all lists, however the Contact is not opted out">
		<cfargument name="contact" type="contact" required="true">
		
		<!--- Create XML from the contact argument --->
		<cfset contactXml = createContactXml(contact)>
		
		<!--- Clear the ContactLists node and set the status to 'Removed' --->
		<cfset arrayClear(contactXml.entry.content.Contact.ContactLists.XmlChildren)>
		<cfset arguments.contact.status = 'Removed'>
		<cfset arguments.contact.contactLists = arrayNew(1)>
		
		<!--- Make HTTP Request to Constant Contact --->
		<cfinvoke component="Utility"
				method="CTCTRequest"
				requestMethod="PUT"
				address="#arguments.contact.contactLink#"
				requestValue="#contactXml#" 
				returnVariable = "local.httpResponse"/>
				
		<cfreturn local.httpResponse>
	</cffunction>
	
	<cffunction name="searchByEmail" access="public" output="true" returnType="array"
		hint="Retruns an array from the provided string or array of email addresses">
		<cfargument name="emailAddress" type="any" required="true">
		
		<!--- Setup variables --->
		<cfset local.returnArray = arrayNew(1)>
		
		<!--- Make HTTP request to Constant Contact and parse the result as XML --->
		<cfinvoke component="Utility" 
				method="CTCTRequest" 
				requestMethod="GET" 
				address="#application.apiPath#/contacts?email=#URLEncodedFormat(arguments.emailAddress)#" 
				returnVariable="local.contactsXml"/>
		
		<cfset local.searchXml = xmlParse(local.contactsXml)>
		
		<!--- For each entry returned, create a Contact object --->
		<cfif (isdefined('local.searchXml.feed.entry'))>
			<cfloop from="1" to="#arrayLen(local.searchXml.feed.entry)#" index="i">
				<cfset local.contact.id = local.searchXml.feed.entry[i].id.xmlText>
				<cfset local.contact.contactLink = "https://api.constantcontact.com#local.searchXml.feed.entry[i].link.xmlAttributes.href#">
				<cfset local.contact.updated = local.searchXml.feed.entry[i].updated.xmlText>
				<cfset local.contact.status = local.searchXml.feed.entry[i].content.Contact.status.xmlText>
				<cfset local.contact.emailAddress = local.searchXml.feed.entry[i].content.Contact.emailAddress.xmlText>
				<cfset local.contact.emailType = local.searchXml.feed.entry[i].content.Contact.emailtype.xmlText>
				<cfset local.contact.fullname = local.searchXml.feed.entry[i].content.Contact.name.xmlText>
				
				<!--- Set the opt in/out source of the Contact --->
				<cfif (structKeyExists(local.searchXml.feed.entry.content.Contact, "OptInSource"))>
					<cfset local.contact.optInSource = local.searchXml.feed.entry[i].content.Contact.optInSource.xmlText>
				<cfelseif (structKeyExists(local.searchXml.feed.entry.content.Contact, "OptOutSource"))>
					<cfset local.contact.optOutSource = local.searchXml.feed.entry[i].content.Contact.optOutSource.xmlText>
				</cfif>
				
				<!--- Create an array of the found Contacts --->
				<cfset local.foundContact = createObject("component", "Contact").init(argumentCollection = local.contact)>
				<cfset arrayAppend(local.returnArray, local.foundContact)>
			</cfloop>				
		</cfif>
		
		<cfreturn local.returnArray>	
	</cffunction>

	<cffunction name="updateContact" output="false" access="public" returnType="string"
		hint="Updates a Contact with the current data stored in the provided Contact">
		<cfargument name="contact" type="Contact" required="true">
		
		<!--- Create XML from the contact argument --->
		<cfset contactXml = createContactXml(arguments.contact)>
		
		<!--- Make HTTP Request to Constant Contact --->
		<cfinvoke component="Utility"
				method="CTCTRequest"
				requestMethod="PUT"
				address="#arguments.contact.contactLink#"
				requestValue="#contactXml#" 
				returnVariable = "httpResponse"/>
	
		<cfreturn httpResponse>
	</cffunction>

	
	<cffunction name="createContactStruct" output="false" access="private" returnType="Struct"
		hint="Creates a struct from Constant Contact's XML responses representing a full Contact">
		<cfargument name="contactXml" required="true">
		
		<!--- Setup variables --->
		<cfset local.subscriberXml = xmlParse(arguments.contactXml)>
		<cfset local.contactLists = arrayNew(1)>
		<cfset local.searchLink = xmlSearch (local.subscriberXml, "//*[@rel='edit']")>	
		
		<!--- Create 'tempStruct' of the results for processing --->
		<cfset local.tempStruct = local.subscriberXml.entry.content.Contact>

		<!--- Parse the XML into 'subscriberDetails' struct to be digested by a contact object --->
		<cfset local.subscriberDetails.contactLink = "https://api.constantcontact.com#local.searchlink[1].xmlAttributes.href#">
		<cfset local.subscriberDetails.id = local.subscriberXml.entry.id.xmlText>
		<cfset local.subscriberDetails.emailAddress = local.tempStruct.emailAddress.xmlText>
		<cfset local.subscriberDetails.emailType = local.tempStruct.emailType.xmlText>
		<cfset local.subscriberDetails.status = local.tempStruct.status.xmlText>
		<cfset local.subscriberDetails.firstName = local.tempStruct.firstName.xmlText>
		<cfset local.subscriberDetails.lastName = local.tempStruct.lastName.xmlText>
		<cfset local.subscriberDetails.fullName = local.tempStruct.name.xmlText>
		<cfset local.subscriberDetails.jobTitle = local.tempStruct.jobTitle.xmlText>
		<cfset local.subscriberDetails.companyName= local.tempStruct.companyName.xmlText>
		<cfset local.subscriberDetails.homePhone = local.tempStruct.homePhone.xmlText>
		<cfset local.subscriberDetails.workPhone = local.tempStruct.workPhone.xmlText>
		<cfset local.subscriberDetails.addr1 = local.tempStruct.addr1.xmlText>
		<cfset local.subscriberDetails.addr2 = local.tempStruct.addr2.xmlText>
		<cfset local.subscriberDetails.addr3 = local.tempStruct.addr3.xmlText>
		<cfset local.subscriberDetails.city = local.tempStruct.city.xmlText>
		<cfset local.subscriberDetails.stateCode = local.tempStruct.stateCode.xmlText>
		<cfset local.subscriberDetails.stateName = local.tempStruct.stateName.xmlText>
		<cfset local.subscriberDetails.countryCode = local.tempStruct.countryCode.xmlText>
		<cfset local.subscriberDetails.postalCode = local.tempStruct.postalCode.xmlText>
		<cfset local.subscriberDetails.subPostalCode = local.tempStruct.subPostalCode.xmlText>
		<cfset local.subscriberDetails.customField1 = local.tempStruct.customField1.xmlText>
		<cfset local.subscriberDetails.customField2 = local.tempStruct.customField2.xmlText>
		<cfset local.subscriberDetails.customField3 = local.tempStruct.customField3.xmlText>
		<cfset local.subscriberDetails.customField4 = local.tempStruct.customField4.xmlText>
		<cfset local.subscriberDetails.customField5 = local.tempStruct.customField5.xmlText>
		<cfset local.subscriberDetails.customField6 = local.tempStruct.customField6.xmlText>
		<cfset local.subscriberDetails.customField7 = local.tempStruct.customField7.xmlText>
		<cfset local.subscriberDetails.customField8 = local.tempStruct.customField8.xmlText>
		<cfset local.subscriberDetails.customField9 = local.tempStruct.customField9.xmlText>
		<cfset local.subscriberDetails.customField10 = local.tempStruct.customField10.xmlText>
		<cfset local.subscriberDetails.customField11 = local.tempStruct.customField11.xmlText>
		<cfset local.subscriberDetails.customField12 = local.tempStruct.customField12.xmlText>
		<cfset local.subscriberDetails.customField13 = local.tempStruct.customField13.xmlText>
		<cfset local.subscriberDetails.customField14 = local.tempStruct.customField14.xmlText>
		<cfset local.subscriberDetails.customField15 = local.tempStruct.customField15.xmlText>
		
		<!--- Add each contact lists to the 'contactLists' array if any are present --->
		<cfif isdefined('local.tempStruct.ContactLists')>
			<cfloop from="1" to ="#arrayLen(local.tempStruct.ContactLists.ContactList)#" index="i">
				<cfset local.contactLists[i] = local.tempStruct.ContactLists.ContactList[i].xmlAttributes.id>
			</cfloop>
		</cfif>
		<cfset local.subscriberDetails.contactLists = local.contactLists>
		
		<cfreturn local.subscriberDetails>
	</cffunction>
	
	<cffunction name="createContactXml" access="private" output="false" returnType="xml"
		hint="Create XML from the provided Contact Object">
		<cfargument name="contact" required="true" type="contact">
		
		<!--- Create CFXML Variable of the Contact's details --->
		<cfxml variable="local.contactXml">
		<cfoutput>
		<entry xmlns="http://www.w3.org/2005/Atom">
			<title type="text"> </title>
			<updated>12/12/2010</updated>
			<author></author>
		    <id>#arguments.contact.Id#</id>
			<summary type="text">Contact</summary>
			<content type="application/vnd.ctct+xml">
				<Contact xmlns="http://ws.constantcontact.com/ns/1.0/">
					<EmailAddress>#arguments.contact.EmailAddress#</EmailAddress>
					<EmailType>#arguments.contact.EmailType#</EmailType>
					<FirstName>#arguments.contact.FirstName#</FirstName>						
					<MiddleName>#arguments.contact.MiddleName#</MiddleName>
					<LastName>#arguments.contact.LastName#</LastName>
					<JobTitle>#arguments.contact.JobTitle#</JobTitle>
					<CompanyName>#arguments.contact.CompanyName#</CompanyName>
					<WorkPhone>#arguments.contact.WorkPhone#</WorkPhone>
					<HomePhone>#arguments.contact.HomePhone#</HomePhone>
					<Addr1>#arguments.contact.Addr1#</Addr1>
					<Addr2>#arguments.contact.Addr2#</Addr2>
					<Addr3>#arguments.contact.Addr3#</Addr3>
					<City>#arguments.contact.City#</City>
					<OptInSource>#arguments.contact.OptInSource#</OptInSource>
					<StateCode>#arguments.contact.StateCode#</StateCode>
					<StateName>#arguments.contact.StateName#</StateName>
					<CountryCode>#arguments.contact.CountryCode#</CountryCode>
					<PostalCode>#arguments.contact.PostalCode#</PostalCode>
					<SubPostalCode>#arguments.contact.SubPostalCode#</SubPostalCode>
					<CustomField1>#arguments.contact.CustomField1#</CustomField1>
					<CustomField2>#arguments.contact.CustomField2#</CustomField2>
					<CustomField3>#arguments.contact.CustomField3#</CustomField3>
					<CustomField4>#arguments.contact.CustomField4#</CustomField4>
					<CustomField5>#arguments.contact.CustomField5#</CustomField5>
					<CustomField6>#arguments.contact.CustomField6#</CustomField6>
					<CustomField7>#arguments.contact.CustomField7#</CustomField7>
					<CustomField8>#arguments.contact.CustomField8#</CustomField8>
					<CustomField9>#arguments.contact.CustomField9#</CustomField9>
					<CustomField10>#arguments.contact.CustomField10#</CustomField10>
					<CustomField11>#arguments.contact.CustomField11#</CustomField11>
					<CustomField12>#arguments.contact.CustomField12#</CustomField12>
					<CustomField13>#arguments.contact.CustomField13#</CustomField13>
					<CustomField14>#arguments.contact.CustomField14#</CustomField14>
					<CustomField15>#arguments.contact.CustomField15#</CustomField15>
					<Note>#arguments.contact.Note#</Note>
					<OptInSource>#arguments.contact.OptInSource#</OptInSource>
					<ContactLists>
					<cfloop from="1" to="#arrayLen(arguments.contact.contactLists)#" index="i">
						<ContactList id="#arguments.contact.contactLists[i]#"/>
					</cfloop>
					</ContactLists>
				</Contact>
			</content>
		</entry>
		</cfoutput>
		</cfxml>
		
		<cfreturn local.contactXml>
	</cffunction>
</cfcomponent>