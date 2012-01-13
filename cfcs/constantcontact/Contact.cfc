<cfcomponent displayname="Contact" initmethod="init">
	<cfproperty name="emailAddress">
	<cfproperty name="status">
	<cfproperty name="id">
	<cfproperty name="contactLink">
	<cfproperty name="firstName">
	<cfproperty name="middleName">
	<cfproperty name="lastName">
	<cfproperty name="fullName">
	<cfproperty name="emailType">
	<cfproperty name="jobTitle">
	<cfproperty name="companyName">
	<cfproperty name="workPhone">
	<cfproperty name="homePhone">
	<cfproperty name="addr1">
	<cfproperty name="addr2">
	<cfproperty name="addr3">
	<cfproperty name="city">
	<cfproperty name="stateCode">
	<cfproperty name="stateName">
	<cfproperty name="countryCode">
	<cfproperty name="postalCode">
	<cfproperty name="subPostalCode">
	<cfproperty name="note">
	<cfproperty name="optInSource">
	<cfproperty name="optOutSource">
	<cfproperty name="customField1">
	<cfproperty name="customField2">
	<cfproperty name="customField3">
	<cfproperty name="customField4">
	<cfproperty name="customField5">
	<cfproperty name="customField6">
	<cfproperty name="customField7">
	<cfproperty name="customField8">
	<cfproperty name="customField9">
	<cfproperty name="customField10">
	<cfproperty name="customField11">
	<cfproperty name="customField12">
	<cfproperty name="customField13">
	<cfproperty name="customField14">
	<cfproperty name="customField15">
	<cfproperty name="contactLists">	
	
	<cffunction name="init" access="public" output="false">
		<cfargument name="emailAddress" type="string" required="true">
		<cfargument name="status" type="string" required="false" default="">
		<cfargument name="id" type="string" required="false" default="data:,none">
		<cfargument name="contactLink" type="string" required="false" default="">
		<cfargument name="firstName" type="string" required="false" default="">
		<cfargument name="middleName" type="string" required="false" default="">
		<cfargument name="lastName" type="string" required="false" default="">
		<cfargument name="fullName" type="string" required="false" default="">
		<cfargument name="emailType" type="string" required="false" default="">
		<cfargument name="jobTitle" type="string" required="false" default="">
		<cfargument name="companyName" type="string" required="false" default="">
		<cfargument name="workPhone" type="string" required="false" default="">
		<cfargument name="homePhone" type="string" required="false" default="">
		<cfargument name="addr1" type="string" required="false" default="">
		<cfargument name="addr2" type="string" required="false" default="">
		<cfargument name="addr3" type="string" required="false" default="">
		<cfargument name="city" type="string" required="false" default="">
		<cfargument name="stateCode" type="string" required="false" default="">
		<cfargument name="stateName" type="string" required="false" default="">
		<cfargument name="countryCode" type="string" required="false" default="">
		<cfargument name="postalCode" type="string" required="false" default="">
		<cfargument name="subPostalCode" type="string" required="false" default="">
		<cfargument name="note" type="string" required="false" default="">
		<cfargument name="optInSource" type="string" required="false" default="ACTION_BY_CUSTOMER">
		<cfargument name="optOutSource" type="string" required="false" default="">
		<cfargument name="customField1" type="string" required="false" default="">
		<cfargument name="customField2" type="string" required="false" default="">
		<cfargument name="customField3" type="string" required="false" default="">
		<cfargument name="customField4" type="string" required="false" default="">
		<cfargument name="customField5" type="string" required="false" default="">
		<cfargument name="customField6" type="string" required="false" default="">
		<cfargument name="customField7" type="string" required="false" default="">
		<cfargument name="customField8" type="string" required="false" default="">
		<cfargument name="customField9" type="string" required="false" default="">
		<cfargument name="customField10" type="string" required="false" default="">
		<cfargument name="customField11" type="string" required="false" default="">
		<cfargument name="customField12" type="string" required="false" default="">
		<cfargument name="customField13" type="string" required="false" default="">
		<cfargument name="customField14" type="string" required="false" default="">
		<cfargument name="customField15" type="string" required="false" default="">
		<cfargument name="contactLists" type="array" required="false" default="#arrayNew(1)#">
		

		<cfset this.emailAddress = arguments.emailAddress>
		<cfset this.status = arguments.status>
		<cfset this.id = arguments.id>
		<cfset this.contactLink = arguments.contactLink>
		<cfset this.firstName = arguments.firstName>
		<cfset this.middleName = arguments.middleName>
		<cfset this.lastName = arguments.lastName>
		<cfset this.fullName = arguments.fullName>
		<cfset this.emailType = arguments.emailType>
		<cfset this.jobTitle = arguments.jobTitle>
		<cfset this.companyName = arguments.companyName>
		<cfset this.workPhone = arguments.workPhone>
		<cfset this.homePhone = arguments.homePhone>
		<cfset this.addr1 = arguments.addr1>
		<cfset this.addr2 = arguments.addr2>
		<cfset this.addr3 = arguments.addr3>
		<cfset this.city = arguments.city>
		<cfset this.stateCode = arguments.stateCode>
		<cfset this.stateName = arguments.stateName>
		<cfset this.countryCode = arguments.countryCode>
		<cfset this.postalCode = arguments.postalCode>
		<cfset this.subPostalCode = arguments.subPostalCode>
		<cfset this.note = arguments.note>
		<cfset this.optInSource = arguments.optInSource>
		<cfset this.optOutSource = arguments.optOutSource>
		<cfset this.customField1 = arguments.customField1>
		<cfset this.customField2 = arguments.customField2>
		<cfset this.customField3 = arguments.customField3>
		<cfset this.customField4 = arguments.customField4>
		<cfset this.customField5 = arguments.customField5>
		<cfset this.customField6 = arguments.customField6>
		<cfset this.customField7 = arguments.customField7>
		<cfset this.customField8 = arguments.customField8>
		<cfset this.customField9 = arguments.customField9>
		<cfset this.customField10 = arguments.customField10>
		<cfset this.customField11 = arguments.customField11>
		<cfset this.customField12 = arguments.customField12>
		<cfset this.customField13 = arguments.customField13>
		<cfset this.customField14 = arguments.customField14>
		<cfset this.customField15 = arguments.customField15>
		<cfset this.contactLists = arguments.contactLists>
		
		<cfreturn this>
	</cffunction>
</cfcomponent>
