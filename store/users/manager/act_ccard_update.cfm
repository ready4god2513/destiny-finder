
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Called from the users.ccard circuit. This template processes the dsp_ccard_update form to update the user's credit card information stored in the user table. --->

<cfparam name="attributes.xfa_success" default="#self#?fuseaction=users.manager">	
<cfparam name="attributes.CVV2" default="">
	
<!--- Update the user account --->
<cfset attributes.UID = Session.User_ID>
<cfset attributes.CardisValid = 1>
<cfset attributes.edittype = "cc">
	
<cfset Application.objUsers.UpdateUser(argumentcollection=attributes)>

<cfinclude template="../qry_get_user.cfm">	
<cfinclude template="../act_use_ccard.cfm">	

<cfinclude template="../act_set_registration_permissions.cfm">

<cfset attributes.message = "Card Information Updated">		
<cfinclude template="../../includes/form_confirmation.cfm">
	
