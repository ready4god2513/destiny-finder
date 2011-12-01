
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to approve a membership. Called by access.admin&membership=approve --->

<cfif isDefined("attributes.membership_id")>
	<!--- Set a membership to "approved" --->
	<cfquery name="Approve_membership" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	UPDATE #Request.DB_Prefix#Memberships
	SET Valid = 1
	WHERE Membership_ID = #attributes.membership_ID#
	</cfquery>
</cfif>


