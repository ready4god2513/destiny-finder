
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This is the access.admin circuit. It runs all the admin functions for the access circuit --->

<!--- Store Memberships --->			
<cfif isdefined("attributes.membership")>		

	<cfset Webpage_title = "Membership #attributes.membership#">

	<!--- Access Permission 4 = memberhip admin --->
	<cfmodule template="../secure.cfm"
		keyname="access"
		requiredPermission="4"
		>		
		<cfif ispermitted>
		
	<cfswitch expression = "#attributes.membership#">
				
		<cfcase value="list">
			<cfinclude template="membership/qry_get_memberships.cfm">
			<cfinclude template="membership/dsp_membership_list.cfm">
		</cfcase>
			
		<cfcase value="add">
			<cfinclude template="membership/dsp_membership_form.cfm">
		</cfcase>
			
		<cfcase value="edit">
			<cfinclude template="membership/qry_get_membership.cfm"> 
			<cfinclude template="../../shopping/qry_get_order_settings.cfm">
			<cfinclude template="membership/dsp_membership_form.cfm">
		</cfcase>
			
		<cfcase value="act">
			<cfinclude template="membership/act_membership.cfm">
			<cfset attributes.XFA_success="fuseaction=access.admin&membership=list">
			<cfset attributes.box_title="Membership">
			<cfinclude template="../../includes/admin_confirmation.cfm">
		</cfcase>			
		
		<cfcase value="approve">
			<cfinclude template="membership/act_approve_membership.cfm">
			<cfset attributes.XFA_success="fuseaction=access.admin&membership=list">
			<cfset attributes.box_title="Membership">
			<cfinclude template="../../includes/admin_confirmation.cfm">
		</cfcase>	
		
		<cfcase value="bill_recurring">
			<cfinclude template="membership/act_bill_recurring.cfm">
			
			<cfset attributes.XFA_success="fuseaction=access.admin&membership=list">
			<cfset attributes.box_title="Membership">
			<cfinclude template="../../includes/admin_confirmation.cfm">
		</cfcase>		
		
		<cfcase value="renew_reminder">
			<cfinclude template="membership/act_expiration_notice.cfm">
			<cfset attributes.XFA_success="fuseaction=home.admin">
			<cfset attributes.box_title="Done">
			<cfset attributes.message="#Membership_list.recordcount# Reminders Sent!">
			<cfinclude template="../../includes/admin_confirmation.cfm">
		</cfcase>	
		
		<cfdefaultcase><!--- List --->
			<cfinclude template="membership/qry_get_memberships.cfm">
			<cfinclude template="membership/dsp_membership_list.cfm">
		</CFdefaultCASE>		
	</CFSWITCH>
	
	</cfif>

	
<!--- Membership Reports --->	
<cfelseif isdefined("attributes.report")>

	<cfif attributes.report is "recurring">
			<cfinclude template="membership/qry_RecurringReport.cfm">
			<cfinclude template="membership/dsp_RecurringReport.cfm">
	</cfif>


<!--- Access Keys --->	
<cfelseif isdefined("attributes.accessKey")>

	<cfset Webpage_title = "Access Key #attributes.accessKey#">
	
	<!--- Access Permission 2 = access key admin --->
	<cfmodule template="../secure.cfm"
		keyname="access"
		requiredPermission="2"
		>		
		<cfif ispermitted>
		
	<cfswitch expression = "#attributes.accessKey#">
		<cfcase value="list">
			<cfinclude template="accesskey/qry_get_accesskeys.cfm">
			<cfinclude template="accesskey/dsp_accesskey_list.cfm">
		</cfcase>
			
		<cfcase value="add">
			<cfinclude template="accesskey/dsp_accesskey_form.cfm">
		</cfcase>
			
		<cfcase value="edit">
			<cfinclude template="accesskey/qry_get_accesskey.cfm"> 
			<cfinclude template="accesskey/dsp_accesskey_form.cfm">
		</cfcase>
		
		<cfcase value="act">
			<cfinclude template="accesskey/act_accesskey.cfm">
			<cfset attributes.XFA_success="fuseaction=access.admin&accesskey=list">
			<cfset attributes.box_title="Access Key">
			<cfinclude template="../../includes/admin_confirmation.cfm"> 
		</cfcase>
			
		<cfdefaultcase><!--- List --->
			<cfinclude template="accesskey/qry_get_accesskeys.cfm">
			<cfinclude template="accesskey/dsp_accesskey_list.cfm">
		</cfdefaultcase>
	</cfswitch>		
	
		</cfif>
			
<cfelse><!--- MENU --->	
	<cfinclude template="dsp_menu.cfm">
</cfif>


