<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page is called by the users.forgot circuit and is used to email a user their username and password. --->

<!--- lookup user by email address submitted --->
<cfquery name="GetCustInfo" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows=1>
SELECT User_ID, EmailIsBad, Disable FROM #Request.DB_Prefix#Users
WHERE Email = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#attributes.email#">
</cfquery>

<cfif GetCustInfo.RecordCount is 1>
	
	<!--- Make sure account is active --->
	<cfif GetCustInfo.EmailIsBad OR GetCustInfo.Disable>
		
		<cfset errormess = "This email account is not currently active. Please contact us for assistance.">
		
	<cfelse>

		<!--- Get Password --->
		<cfinvoke component="#Request.CFCMapping#.global" method="randomPassword" 
		returnvariable="GetPass" Length="8" ExcludedValues="O,I,L,0,i,l">
	
		<!--- Update password with new random password ---->
		<cfquery name="UpdatePassword" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			UPDATE #Request.DB_Prefix#Users 
			SET Password = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Hash(GetPass.new_password)#">
			WHERE User_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#GetCustInfo.user_ID#">
		</cfquery>		
	
		<!--- Send Confirmation Email --->
		<!--- BlueDragon was passing URL variable into the module call, so we'll delete it. ---> 
		<cfset variables.Result = StructDelete(url, "user")>
		
		<cfinvoke component="#Request.CFCMapping#.global" 
			method="sendAutoEmail" UID="#GetCustInfo.User_ID#" 
			MailAction="ForgotPassword" MergeContent="#GetPass.new_password#">
		
	</cfif>

</cfif>




