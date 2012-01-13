<cfcomponent displayname="Campaign" initmethod="init">
	<cfproperty name="campaignName">
	<cfproperty name="campaignId">
	<cfproperty name="campaignLink">
	<cfproperty name="lastEditDate">
	<cfproperty name="lastRunDate">
	<cfproperty name="status">
	<cfproperty name="updated">
	<cfproperty name="sent">
	<cfproperty name="opens">
	<cfproperty name="clicks">
	<cfproperty name="optOuts">
	<cfproperty name="bounces">
	<cfproperty name="forwards">
	<cfproperty name="spamReports">
	<cfproperty name="subject">
	<cfproperty name="fromName">
	<cfproperty name="fromEmail">
	<cfproperty name="fromEmailId">
	<cfproperty name="replyToEmail">
	<cfproperty name="replyToEmailId">
	<cfproperty name="campaignType">
	<cfproperty name="viewAsWebpage">
	<cfproperty name="viewAsWebpageLinkText">
	<cfproperty name="viewAsWebpageText">
	<cfproperty name="permissionReminder">
	<cfproperty name="permissionReminderText">
	<cfproperty name="greetingSalutation">
	<cfproperty name="greetingName">
	<cfproperty name="greetingString">
	<cfproperty name="organizationName">
	<cfproperty name="organizationAddress1">
	<cfproperty name="organizationAddress2">
	<cfproperty name="organizationAddress3">
	<cfproperty name="organizationCity">
	<cfproperty name="organizationState">
	<cfproperty name="organizationInternationalState">
	<cfproperty name="organizationPostalCode">
	<cfproperty name="organizationCountry">
	<cfproperty name="includeForwardEmail">
	<cfproperty name="forwardEmailLinkText">
	<cfproperty name="includeSubscribeLInk">
	<cfproperty name="subscribeLinkText">
	<cfproperty name="archiveStatus">
	<cfproperty name="archiveUrl">
	<cfproperty name="emailContentFormat">
	<cfproperty name="emailContent">
	<cfproperty name="emailTextContent">
	<cfproperty name="styleSheet">
	<cfproperty name="urls">
	<cfproperty name="contactLists">
	
	<cffunction name="init" access="public" output="false">
		<cfargument name="campaignName" type="string" required="true">
		<cfargument name="campaignId" type="string" default="http://api.constantcontact.com/ws/customers/#application.ccUsername#/campaigns">
		<cfargument name="campaignLink" type="string" default="">
		<cfargument name="lastEditDate" type="string" default="">
		<cfargument name="lastRunDate" type="string" default="">
		<cfargument name="status" type="string" default='Draft'>
		<cfargument name="updated" type="string" default="">
		<cfargument name="sent" type="string" default="">
		<cfargument name="opens" type="string" default="">
		<cfargument name="clicks" type="string" default="">
		<cfargument name="optOuts" type="string" default="">
		<cfargument name="bounces" type="string" default="">
		<cfargument name="forwards" type="string" default="">
		<cfargument name="spamReports" type="string" default="">
		<cfargument name="subject" type="string" default="Default Subject Line">
		<cfargument name="fromName" type="string" default="From Name">
		<cfargument name="fromEmail" type="string" default="fromemail@example.com">
		<cfargument name="fromEmailId" type="string" default="http://api.constantcontact.com/ws/customers/#application.ccUsername#/settings/emailaddresses/1">
		<cfargument name="replyToEmail" type="string" default="fromemail@example.com">
		<cfargument name="replyToEmailId" type="string" default="http://api.constantcontact.com/ws/customers/#application.ccUsername#/settings/emailaddresses/1">
		<cfargument name="campaignType" type="string" default="CUSTOM">
		<cfargument name="viewAsWebpage" type="string" default="NO">
		<cfargument name="viewAsWebpageLinkText" type="string" default="">
		<cfargument name="viewAsWebpageText" type="string" default="">
		<cfargument name="permissionReminder" type="string" default="NO">
		<cfargument name="permissionReminderText" type="string" default="Permission Reminder">
		<cfargument name="greetingSalutation" type="string" default="Dear">
		<cfargument name="greetingName" type="string" default="FirstName">
		<cfargument name="greetingString" type="string" default="">
		<cfargument name="organizationName" type="string" default="$ACCOUNT.ORGANIZATIONNAME">
		<cfargument name="organizationAddress1" type="string" default="$ACCOUNT.ADDRESS_LINE_1">
		<cfargument name="organizationAddress2" type="string" default="$ACCOUNT.ADDRESS_LINE_2">
		<cfargument name="organizationAddress3" type="string" default="$ACCOUNT.ADDRESS_LINE_3">
		<cfargument name="organizationState" type="string" default="$ACCOUNT.US_STATE">
		<cfargument name="organizationCity" type="string" default="$ACCOUNT.CITY">
		<cfargument name="organizationInternationalState" type="string" default="$ACCOUNT.STATE">
		<cfargument name="organizationPostalCode" type="string" default="$ACCOUNT.POSTAL_CODE">
		<cfargument name="organizationCountry" type="string" default="$ACCOUNT.COUNTRY_CODE">
		<cfargument name="includeForwardEmail" type="string" default="NO">
		<cfargument name="forwardEmailLinkText" type="string" default="">
		<cfargument name="includeSubscribeLink" type="string" default="NO">
		<cfargument name="subscribeLinkText" type="string" default="">
		<cfargument name="archiveStatus" type="string" default="">
		<cfargument name="archiveUrl" type="string" default="">
		<cfargument name="emailContentFormat" type="string" default="XHTML">
		<cfargument name="emailTextContent" type="string" default="<Text>This is the text version.</Text>">
		<cfargument name="emailContent" type="string" default='<html lang="en" xml:lang="en" xmlns="http://www.w3.org/1999/xhtml" 
			xmlns:cctd="http://www.constantcontact.com/cctd">
			<body><CopyRight>Copyright (c) 1996-2009 Constant Contact. All rights reserved.  Except as permitted under a
			separate
			written agreement with Constant Contact, neither the Constant Contact software, nor any content that appears on any
			Constant Contact site,
			including but not limited to, web pages, newsletters, or templates may be reproduced, republished, repurposed, or
			distributed without the
			prior written permission of Constant Contact.  For inquiries regarding reproduction or distribution of any Constant
			Contact material, please
			contact joesflowers@example.com.</CopyRight>
			<OpenTracking/>
			<!--  Do NOT delete previous line if you want to get statistics on the number of opened emails -->
			<CustomBlock name="letter.intro" title="Personalization">
			    <Greeting/>
			</CustomBlock>
			</body>
			</html>'>
		<cfargument name="styleSheet" type="string" default="">
		<cfargument name="urls" type="array" default= '#arrayNew(1)#'>
		<cfargument name="contactLists" type="array" default="#arrayNew(1)#">
		
		
			<cfset this.CampaignName = arguments.campaignName>
			<cfset this.CampaignLink = arguments.campaignLink>
			<cfset this.CampaignId = arguments.campaignId>
			<cfset this.LastEditDate = arguments.lastEditDate>
			<cfset this.Updated = arguments.updated>
			<cfset this.LastRunDate = arguments.lastRunDate>
			<cfset this.Status = arguments.status>
			<cfset this.Sent = arguments.sent>
			<cfset this.Opens = arguments.opens>
			<cfset this.Clicks = arguments.clicks>
			<cfset this.OptOuts = arguments.optOuts>
			<cfset this.Bounces = arguments.bounces>
			<cfset this.SpamReports = arguments.spamReports>
			<cfset this.Forwards = arguments.forwards>
			<cfset this.Subject = arguments.subject>
			<cfset this.FromName = arguments.fromName>
			<cfset this.FromEmail = arguments.fromEmail>
			<cfset this.FromEmailId = arguments.fromEmailId>
			<cfset this.ReplyToEmail = arguments.replyToEmail>
			<cfset this.ReplyToEmailId = arguments.replyToEmailId>
			<cfset this.CampaignType = arguments.campaignType>
			<cfset this.ViewAsWebpage = arguments.viewAsWebpage>
			<cfset this.ViewAsWebpageLinkText = arguments.viewAsWebpageLinkText>
			<cfset this.ViewAsWebpageText = arguments.viewAsWebpageText>
			<cfset this.PermissionReminder = arguments.permissionReminder>
			<cfset this.PermissionReminderText = arguments.permissionReminderText>
			<cfset this.GreetingSalutation = arguments.greetingSalutation>
			<cfset this.GreetingName = arguments.greetingName>
			<cfset this.GreetingString = arguments.greetingString>
			<cfset this.OrganizationName = arguments.organizationName>
			<cfset this.OrganizationAddress1 = arguments.organizationAddress1>
			<cfset this.OrganizationAddress2 = arguments.organizationAddress2>
			<cfset this.OrganizationAddress3 = arguments.organizationAddress3>
			<cfset this.OrganizationCity = arguments.organizationCity>
			<cfset this.OrganizationState = arguments.organizationState>
			<cfset this.OrganizationInternationalState = arguments.organizationInternationalState>
			<cfset this.OrganizationPostalCode = arguments.organizationPostalCode>
			<cfset this.OrganizationCountry = arguments.organizationCountry>
			<cfset this.IncludeForwardEmail = arguments.includeForwardEmail>
			<cfset this.ForwardEmailLinkText = arguments.forwardEmailLinkText>
			<cfset this.IncludeSubscribeLink = arguments.includeSubscribeLink>
			<cfset this.SubscribeLinkText = arguments.subscribeLinkText>
			<cfset this.ArchiveStatus = arguments.archiveStatus>
			<cfset this.ArchiveUrl = arguments.archiveUrl>
			<cfset this.EmailContentFormat = arguments.emailContentFormat>
			<cfset this.EmailContent = arguments.emailContent>
			<cfset this.EmailTextContent = arguments.emailTextContent>
			<cfset this.StyleSheet = arguments.styleSheet>
			<cfset this.Urls = arguments.urls>
			<cfset this.ContactLists = arguments.ContactLists>
		
		<cfreturn this>	
	</cffunction>
</cfcomponent>
