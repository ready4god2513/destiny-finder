<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the admin menu for the access circuit. Called from the home.admin fuseaction --->

<cfmodule template="../secure.cfm"
keyname="access"
requiredPermission="2"
>  
	<b>Content Access</b> 
	<ul><cfoutput> 

	<cfmodule template="../secure.cfm"
	keyname="access"
	requiredPermission="4"
	>  
		<cfset attributes.valid = 0>
		<cfset attributes.show = "all">
		<cfinclude template="membership/qry_get_memberships.cfm">
		
		<cfif qry_get_memberships.recordcount>
			<li><a href="#self#?fuseaction=access.admin&membership=list&show=all&valid=0#Request.Token2#"><strong>Validate Memberships</strong></a>: <span class="formerror"><strong>#qry_get_memberships.recordcount# Membership requires validation.</strong></span></li>
		</cfif>
		
		<li><a href="#self#?fuseaction=access.admin&membership=list#Request.Token2#">Memberships</a>: Users who have purchased access (keys) to site content.</li>

		<li><a href="#self#?fuseaction=access.admin&report=recurring#Request.Token2#">Recurring Billing Report</a>: A report of upcoming recurring billing by date.</li>

		<li><a href="#self#?fuseaction=access.admin&membership=renew_reminder#Request.Token2#">Expiring Membership Emails</a>: Send a renewal reminder email to members whose membership will expire in 3 days.</li>

		<li><a href="#self#?fuseaction=access.admin&membership=bill_recurring#Request.Token2#">Bill Recurring</a>: Process any recurring billing orders due. This template is scheduled to run daily.</li>

	</cfmodule>
	
	
	<li><a href="#self#?fuseaction=access.admin&accesskey=list#Request.Token2#">Access Keys</a>: Create access keys to protect site content.</li>
	
	</cfoutput> 
	
	</ul>
</cfmodule>

