<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template allows a member to cancel the auto-renewal of a membership. Called by access.cancelrecur. --->

<cfquery name="UpdateParentMembership" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	UPDATE #Request.DB_Prefix#Memberships
	SET Recur = 0
	Where Membership_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.Membership_ID#">
	AND User_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#Session.User_ID#">
</cfquery>
	
<cfinclude template="../users/qry_get_user.cfm">
	
<!--- Make a note in the User's Notes that they cancelled --->
<cfquery name="UpdateUserNotes" datasource="#Request.DS#" username="#Request.user#" 
	password="#Request.pass#">
	UPDATE #Request.DB_Prefix#Users 
	SET AdminNotes = '#DateFormat(Now(),"mm/dd/yy")#: User Cancelled recurring membership #Val(attributes.Membership_ID)#. <br/>#qry_get_user.AdminNotes#'
	WHERE User_ID = <cfqueryparam value="#Session.User_ID#" cfsqltype="CF_SQL_INTEGER">
</cfquery>		

<!--- Send Email to Admin --->
<cfmail to="#request.appsettings.merchantemail#" from="#request.appsettings.merchantemail#" subject="#request.appsettings.sitename# Alert - #qry_get_user.username# Recurring Membership Cancellation" 
	server="#request.appsettings.email_server#" port="#request.appsettings.email_port#">
User #qry_get_user.username# ID (User ID #qry_get_user.user_id#)
cancelled recurring membership #Val(attributes.Membership_ID)#.
</cfmail>

<!--- Send Email to User --->
<cfinvoke component="#Request.CFCMapping#.global" 
	method="sendAutoEmail" UID="#Session.User_ID#" 
	Email="auto" MailAction="MembershipAutoRenewCancel">


		