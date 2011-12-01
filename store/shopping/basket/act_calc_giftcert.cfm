<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page is used to check for a gift certificate and determine if it is valid. Called from do_checkout_basket.cfm and checkout\customer\act_check_code.cfm --->

<cfset Credits = 0>

<cfparam name="GApproved" default="No">

<cfif isDefined("attributes.Coupon") AND len(attributes.Coupon)>
	<cfquery name="GetCert" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT * FROM #Request.DB_Prefix#Certificates
	WHERE Cert_Code = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(attributes.Coupon)#">
	AND (StartDate IS NULL OR StartDate <= #CreateODBCDate(Now())#)
	AND (EndDate IS NULL OR EndDate >= #CreateODBCDate(Now())#)
	AND Valid <> 0
	</cfquery>	
	
	<cfif GetCert.RecordCount>
		<cfset GApproved = "Yes">
		<cfset Credits = GetCert.CertAmount>
	</cfif>	
	
</cfif>
		
<cfif Credits IS 0 AND len(Session.Gift_Cert)>
	<!--- Check any current gift certificate in memory --->
	<cfquery name="GetSavedCert" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT * FROM #Request.DB_Prefix#Certificates
		WHERE Cert_Code = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.Gift_Cert#">
		AND (StartDate IS NULL OR StartDate <= #CreateODBCDate(Now())#)
		AND (EndDate IS NULL OR EndDate >= #CreateODBCDate(Now())#)
		AND Valid <> 0
	</cfquery>	
	
	<cfif GetSavedCert.RecordCount>
		<cfset GApproved = "Yes">
		<cfset Credits = GetSavedCert.CertAmount>
		<cfset CheckCode = Session.Gift_Cert>
	</cfif>


</cfif>	



