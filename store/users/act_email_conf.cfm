<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- If email confirmations are enabled, this template will email the new user a code which must be entered into the site to verify that their email address is valid. This template is called from act_register.cfm and do_register.cfm as well as manager\act_email_update.cfm --->


<cfset new_password = qry_get_user.emailLock>

<cfif not len(new_password)>

	<!--- Create a random email validation code --->
	<cfinvoke component="#Request.CFCMapping#.global" method="randomPassword" 
	returnvariable="GetPass" Length="6" AllowNums="no" Case="Upper">

	<!--- Enter the new validation code into the user record --->
	<cfquery name="UpdateLock" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	UPDATE #Request.DB_Prefix#Users
	SET EmailIsBad = 0,
	EmailLock = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#GetPass.new_password#">
	WHERE User_ID = <cfqueryparam value="#Session.User_ID#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>

<cfelseif qry_get_user.emailLock is 'verified'>

	<cflocation url="#request.self#?fuseaction=users.manager#Request.Token2#" addtoken="No">

</cfif>


<!--- Email the new validation code to the user --->			
<cfinvoke component="#Request.CFCMapping#.global" 
	method="sendAutoEmail" UID="#qry_get_user.User_ID#" 
	MailAction="EmailConfirmation">
	
	
