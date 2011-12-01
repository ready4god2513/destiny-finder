
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template sends an email to all members whose membership will expire in 3 days --->

<cfquery name="Membership_list"  datasource="#Request.DS#" username="#Request.user#"	 password="#Request.pass#">
	SELECT M.*, U.*
	FROM #Request.DB_Prefix#Memberships M 
	INNER JOIN #Request.DB_Prefix#Users U ON M.User_ID = U.User_ID 
	WHERE  M.Recur <> 1
		AND M.Expire = #CreateODBCDate(DateAdd('d',3,Now()))#
		AND M.Valid = 1
</cfquery>


<!--- Go through the list ---->
<cfif Membership_list.recordcount>

	<!--- Loop through the query --->
	<cfloop query="Membership_list">
	
		Membership expiration notice sent to User "#Membership_list.Username#"<br/>
		<cfinvoke component="#Request.CFCMapping#.global" 
			method="sendAutoEmail" UID="#User_ID#" 
			Email="auto" MailAction="MembershipRenewReminder">

	</cfloop>
	
<cfelse>
	No expiring membership notices sent.<br/>
	
	
</cfif><!--- memberships recordcount --->


<cfsetting enablecfoutputonly="no">