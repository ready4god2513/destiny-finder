<cfcomponent displayname="CampaignsCollection" initmethod="init">
	<!--- Constructor --->
	<cffunction name="init" access="public" output="false">
		<cfreturn this>
	</cffunction>
	
	<cffunction name="addCampaign" access="public" output="false" returnType="Campaign"
		hint="Adds a campaign object to your Constant Contact account">
		<cfargument name="campaign" type="Campaign" required="true">

		<!--- Create campaign XML from the campaign argument --->
		<cfset local.campaignXml = createCampaignXml(arguments.campaign)>
		
		<cfdump var="#local.campaignXml#" output="C:\Users\David\Desktop\rawr.txt">
		
		<!--- Make HTTP request to Constant Contact --->
		<cfinvoke component="Utility"
				method="CTCTRequest"
				requestMethod="POST"
				address="#application.apiPath#/campaigns"
				requestValue="#local.campaignXml#"
				returnVariable="local.httpResponse">

		<!--- Create a campaign object from the returned XML --->
		<cfset local.campaignStruct = createCampaignStruct(local.httpResponse)>
		<cfset local.newCampaign = createObject("component", "Campaign").init(argumentCollection = local.campaignStruct)>
		
		<cfreturn local.newCampaign>
	</cffunction>
	
	<cffunction name="deleteCampaign" access="public" output="false"
		hint="Deletes the provided campaign">
		<cfargument name="campaign" type="Campaign" required="true">

		<!--- Create campaign XML from the campaign argument --->
		<cfset local.campaignXml = createCampaignXml(arguments.campaign)>
		
		<!--- Make HTTP request to Constant Contact --->		
		<cfinvoke component="Utility"
				method="CTCTRequest"
				requestMethod="DELETE"
				address="#arguments.campaign.campaignLink#"
				requestValue="local.campaignXml"
				returnVariable="local.httpResponse">
				
		<cfreturn local.httpResponse>
	</cffunction>
	
	<cffunction name="getCampaigns" access="public" output="false" returnType="array"
		hint="Returns array of campaign objects from your account as well as a link to the next page of campaigns if one exists">
		<cfargument name="page" type="string" default="#application.apiPath#/campaigns">
		
		<!--- Setup Variables --->
		<cfset local.fullArray = arrayNew(1)>
		<cfset local.campaignsArray = arrayNew(1)>
		<cfset local.linkArray = arrayNew(1)>
		<cfset local.nextAddress = ''>
		
		<!--- Make HTTP request to Constant Contact --->
		<cfinvoke component="Utility"
				method="CTCTRequest"
				requestMethod="get"
				address="#application.apiPath#/campaigns"
				requestValue="local.campaignXml"
				returnVariable="local.httpResponse">
				
		<cfset local.campaignsXml = xmlParse(local.httpResponse)>
		
		<!--- Create an array of campaign objects containing the overview of their data returned --->
		<cfloop from="1" to="#arrayLen(local.campaignsXml.feed.entry)#" index="i">
			<cfset local.campaign.campaignLink = application.path & local.campaignsXml.feed.entry[i].link.xmlattributes.href>
			<cfset local.campaign.campaignId = local.campaignsXml.feed.entry[i].id.xmlText>
			<cfset local.campaign.campaignName = local.campaignsXml.feed.entry[i].title.XmlText>
			<cfset local.campaign.updated = local.campaignsXml.feed.entry[i].updated.XmlText>
			<cfset local.campaign.status = local.campaignsXml.feed.entry[i].content.Campaign.status.xmlText>
			<cfset local.newCampaign = createObject("component", "Campaign").init(argumentCollection=local.campaign)>
			<cfset arrayAppend(local.campaignsArray, local.newCampaign)>
		</cfloop>
		
		<!--- Append array of campaigns to the fullArray of data to be returned --->
		<cfset arrayAppend(local.fullArray, local.campaignsArray)>
		
		<!--- Find the link to the next page if one exists --->
		<cfset local.nextLinkSearch = xmlSearch(local.campaignsXml, "//*[@rel='next']")>
		<cfif(!arrayIsEmpty(local.nextLinkSearch))>
			<cfset local.nextAddress = application.path & local.nextLinkSearch[1].xmlattributes.href>
		</cfif>
		
		<!--- Append array containing a link to the next page of campaigns if one exists --->
		<cfset local.linkArray[1] = local.nextAddress>
		<cfset arrayAppend(local.fullArray, local.linkarray)>
		
		<cfreturn local.fullArray>
	</cffunction>
	
	<cffunction name="getCampaignDetails" access="public" output="false" returnType="Campaign">
		<cfargument name="campaign" type="Campaign" required="true">
		
		<!--- Make HTTP request to Constant Contact --->
		<cfinvoke component="Utility"
				method="CTCTRequest"
				requestMethod="GET"
				address="#arguments.campaign.campaignLink#"
				returnVariable="local.httpResponse">
	
		<!--- Create campaign object representing the full details of the provided campaign --->
		<cfset local.campaignXml = xmlParse(local.httpResponse)>
		<cfset local.campaignStruct = createCampaignStruct(local.campaignXml)>
		<cfset local.newCampaign = createObject("component", "Campaign").init(argumentCollection = local.campaignStruct)>
		
		<cfreturn local.newCampaign>
	</cffunction>
	
	<cffunction name="searchCampaigns" access="public" output="false" returnType="array"
		hint="returns an array of campaigns fitting the provided status">
		<cfargument name="status" type="string" required="true" hint="Valid Options: DRAFT, RUNNING, SENT,SCHEDULED">
	
		<!--- Create string of the URI to be searched --->
		<cfset local.searchUrl = application.apiPath & '/campaigns?status=' & arguments.status>
		
		<!--- Obtain array of search results --->
		<cfset local.foundCampaigns = getCampaigns(local.searchUrl)>
	
		<cfreturn local.foundCampaigns>
	</cffunction>
	
	<cffunction name="updateCampaign" access="public" output="false" returnType="string"
		hint="Updates a campaign with the current data stored in the provided campaign">
		<cfargument name="campaign" type="Campaign" required="true">

		<!--- Create campaign XML from the campaign argument --->
		<cfset local.campaignXml = createCampaignXml(arguments.campaign)>
		
		<!--- Make HTTP request to Constant Contact --->
		<cfinvoke component="Utility"
				method="CTCTRequest"
				requestMethod="PUT"
				address="#arguments.campaign.campaignLink#"
				requestValue="#local.campaignXml#"
				returnVariable="local.httpResponse">
				
		<cfreturn local.httpResponse>
	</cffunction>
	
	<cffunction name="createCampaignXml" access="private" output="false" returnType="xml" 
		hint="Creates XML necessary for creating/updating a campaign object">
		<cfargument name="campaign" type="campaign" required="true">
		
		<!--- Create CFXML object of campaign --->
		<cfxml variable="local.campaignXml">
		<cfoutput>
		<entry xmlns="http://www.w3.org/2005/Atom">
		  <link href="/ws/customers/#application.ccusername#/campaigns" rel="edit" />
		  <id>#arguments.campaign.CampaignId#</id>
		  <title type="text"></title>
		  <updated>#dateformat(now(), "yyyy-mm-dd")#T#TimeFormat(now(), "HH:mm:ss:l")#Z</updated>
		  <author>
		    <name></name>
		  </author>
		  <content type="application/vnd.ctct+xml">
		    <Campaign xmlns="http://ws.constantcontact.com/ns/1.0/" id="#arguments.campaign.CampaignId#">
		      <Name>#arguments.campaign.CampaignName#</Name>
		      <Status>#arguments.campaign.Status#</Status>
		      <Date>#dateformat(now(), "yyyy-mm-dd")#T#TimeFormat(now(), "HH:mm:ss:l")#Z</Date>
		      <Subject>#arguments.campaign.Subject#</Subject>
		      <FromName>#arguments.campaign.FromName#</FromName>
		      <ViewAsWebpage>#arguments.campaign.ViewAsWebpage#</ViewAsWebpage>
		      <ViewAsWebpageLinkText>#arguments.campaign.ViewAsWebpageLinkText#</ViewAsWebpageLinkText>
		      <ViewAsWebpageText>#arguments.campaign.ViewAsWebpageText#</ViewAsWebpageText>
		      <PermissionReminder>#arguments.campaign.PermissionReminder#</PermissionReminder>
		      <PermissionReminderText>#arguments.campaign.PermissionReminderText#</PermissionReminderText>
		      <GreetingSalutation>#arguments.campaign.GreetingSalutation#</GreetingSalutation>
		      <GreetingName>#arguments.campaign.GreetingName#</GreetingName>
		      <GreetingString>#arguments.campaign.GreetingString#</GreetingString>
		      <OrganizationName>#arguments.campaign.OrganizationName#</OrganizationName>
		      <OrganizationAddress1>#arguments.campaign.OrganizationAddress1#</OrganizationAddress1>
		      <OrganizationAddress2>#arguments.campaign.OrganizationAddress2#</OrganizationAddress2>
		      <OrganizationAddress3>#arguments.campaign.OrganizationAddress3#</OrganizationAddress3>
		      <OrganizationCity>#arguments.campaign.OrganizationCity#</OrganizationCity>
		      <OrganizationState>#arguments.campaign.OrganizationState#</OrganizationState>
		      <OrganizationInternationalState>#arguments.campaign.OrganizationInternationalState#</OrganizationInternationalState>
		      <OrganizationCountry>#arguments.campaign.OrganizationCountry#</OrganizationCountry>
		      <OrganizationPostalCode>#arguments.campaign.OrganizationPostalCode#</OrganizationPostalCode>
		      <IncludeForwardEmail>#arguments.campaign.IncludeForwardEmail#</IncludeForwardEmail>
		      <ForwardEmailLinkText>#arguments.campaign.ForwardEmailLinkText#</ForwardEmailLinkText>
		      <IncludeSubscribeLink>#arguments.campaign.IncludeSubscribeLink#</IncludeSubscribeLink>
		      <SubscribeLinkText>#arguments.campaign.SubscribeLinkText#</SubscribeLinkText>
		      <EmailContentFormat>#arguments.campaign.EmailContentFormat#</EmailContentFormat>
		      <EmailContent>#xmlFormat(arguments.campaign.EmailContent)#</EmailContent>
		      <EmailTextContent>#xmlFormat(arguments.campaign.EmailTextContent)#</EmailTextContent>
		      <StyleSheet></StyleSheet>
		      <ContactLists>
				<cfloop from="1" to="#arrayLen(arguments.campaign.contactLists)#" index="i">
					<ContactList id="#arguments.contact.contactLists[i]#"/>
				</cfloop>
			</ContactLists>
		      <FromEmail>
		        <Email id="#arguments.campaign.FromEmailId#">
		        </Email>
		        <EmailAddress>#arguments.campaign.FromEmail#</EmailAddress>
		      </FromEmail>
		      <ReplyToEmail>
		        <Email id="#arguments.campaign.ReplyToEmailId#">
		        </Email>
		        <EmailAddress>#arguments.campaign.ReplyToEmail#</EmailAddress>
		      </ReplyToEmail>
		    </Campaign>
		  </content>
		  <source>
		    <id>http://api.constantcontact.com/ws/customers/#application.ccUsername#/campaigns</id>
		    <title type="text">Campaigns for customer: #application.ccUsername#</title>
		    <link href="campaigns" />
		    <link href="campaigns" rel="self" />
		    <author>
		      <name>#application.ccUsername#</name>
		    </author>
		    <updated>#dateformat(now(), "yyyy-mm-dd")#T#TimeFormat(now(), "HH:mm:ss:l")#Z</updated>
		  </source>
		</entry>
		</cfoutput>
		</cfxml>	
		
		<cfreturn local.campaignXml>
	</cffunction>
	
	<cffunction name="createCampaignStruct" access="private" output="false" returnType="struct"
		hint="Creates a struct from Constant Contact's XML responses representing a full campaign">
		<cfargument name="campaignXml" type="any" required="true">
		
		<cfset local.campaignXml = xmlParse(campaignXml)>
		<cfset local.tempStruct = local.campaignXml.entry.content.Campaign>
		<cfset local.campaign.campaignName = local.tempStruct.name.xmlText>
			<cfset local.campaign.campaignId = local.campaignXml.entry.id.xmlText>
			<cfset local.campaign.campaignLink = application.path & local.campaignXml.entry.link.xmlattributes.href>
			<cfset local.campaign.updated = local.campaignXml.entry.updated.xmltext>
			<cfset local.campaign.status = local.tempStruct.status.xmltext>
			<cfset local.campaign.sent = local.tempStruct.sent.xmltext>
			<cfset local.campaign.opens = local.tempStruct.opens.xmltext>
			<cfset local.campaign.clicks = local.tempStruct.clicks.xmltext>
			<cfset local.campaign.optOuts = local.tempStruct.optouts.xmltext>
			<cfset local.campaign.bounces = local.tempStruct.bounces.xmltext>
			<cfset local.campaign.forwards = local.tempStruct.forwards.xmltext>
			<cfset local.campaign.spamReports = local.tempStruct.spamreports.xmltext>
			<cfset local.campaign.subject = local.tempStruct.subject.xmltext>
			<cfset local.campaign.fromName = local.tempStruct.fromname.xmltext>
			<cfset local.campaign.fromEmail = local.tempStruct.fromemail.emailaddress.xmltext>
			<cfset local.campaign.replyToEmail = local.tempStruct.replytoemail.emailaddress.xmltext>
			<cfset local.campaign.campaignType = local.tempStruct.campaigntype.xmltext>
			<cfset local.campaign.viewAsWebpage = local.tempStruct.viewaswebpage.xmltext>
			<cfset local.campaign.viewAsWebpageLinkText = local.tempStruct.viewaswebpagelinktext.xmltext>
			<cfset local.campaign.viewAsWebpageText = local.tempStruct.viewaswebpagetext.xmltext>
			<cfset local.campaign.permissionReminder = local.tempStruct.permissionreminder.xmltext>
			<cfset local.campaign.greetingSalutation = local.tempStruct.greetingsalutation.xmltext>
			<cfset local.campaign.greetingString = local.tempStruct.greetingstring.xmltext>
			<cfset local.campaign.organizationName = local.tempStruct.organizationname.xmltext>
			<cfset local.campaign.organizationAddress1 = local.tempStruct.organizationaddress1.xmltext>
			<cfset local.campaign.organizationAddress2 = local.tempStruct.organizationaddress2.xmltext>
			<cfset local.campaign.organizationAddress3 = local.tempStruct.organizationaddress3.xmltext>
			<cfset local.campaign.organizationCity = local.tempStruct.organizationcity.xmltext>
			<cfset local.campaign.organizationState  = local.tempStruct.organizationstate.xmltext>
			<cfset local.campaign.organizationInternationalState  = local.tempStruct.organizationinternationalstate.xmltext>
			<cfset local.campaign.organizationPostalCode = local.tempStruct.organizationpostalcode.xmltext>
			<cfset local.campaign.organizationCountry = local.tempStruct.organizationcountry.xmltext>
			<cfset local.campaign.includeForwardEmail = local.tempStruct.includeforwardemail.xmltext>
			<cfset local.campaign.forwardEmailLinkText = local.tempStruct.forwardemaillinktext.xmltext>
			<cfset local.campaign.includeSubscribeLink = local.tempStruct.includesubscribelink.xmltext>
			<cfset local.campaign.subscribeLinkText = local.tempStruct.subscribelinktext.xmltext>
			<cfset local.campaign.archiveStatus = local.tempStruct.archivestatus.xmltext>
			<cfset local.campaign.archiveUrl = local.tempStruct.archiveurl.xmltext>
			
			<!--- Obtain a date the campaign was last edited if one exists --->
			<cfif(isdefined('local.tempStruct.LastEditDate.xmltext'))>
				<cfset local.campaign.lastEditDate = local.tempStruct.lastEditDate.xmlText>
			</cfif>
				
			<!--- Get data if it is a CUSTOM campaign, which is not returned from a STOCK campaign --->	
			<cfif(local.campaign.CampaignType EQ "CUSTOM")>
				<cfset local.campaign.greetingName = local.tempStruct.greetingname.xmltext>
				<cfset local.campaign.emailContentFormat = local.tempStruct.emailcontentformat.xmltext>
				<cfset local.campaign.emailContent = local.tempStruct.emailcontent.xmltext>
				<cfset local.campaign.emailTextContent = local.tempStruct.emailtextcontent.xmltext>
				<cfset local.campaign.styleSheet = local.tempStruct.stylesheet.xmltext>
			</cfif>
			
			<!--- Get data from a campaign that has been sent--->
			<cfif(local.campaign.CampaignType EQ "Sent")>
				<cfset local.campaign.urls = arrayNew(1)>
				<cfset local.tempUrl = structNew()>
				<cfloop from="1" to="#arrayLen(local.tempstruct.urls.url)#" index="i">
					<cfset local.tempUrl.value = local.tempStruct.urls.url.value.xmltext>
					<cfset local.tempUrl.clicks = local.tempStruct.urls.url.clicks.xmltext>
					<cfset local.tempUrl.id = local.tempStruct.urls.url.xmlattributes.id>
					<!--- Added this --->
					<cfset arrayAppend(local.campaign.urls, local.tempUrl)>
				</cfloop>
			</cfif>

		<cfreturn local.campaign>
	</cffunction>

</cfcomponent>
