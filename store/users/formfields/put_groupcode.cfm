<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->
	
<!--- Inserts group code form field. Called during user registration from the users\dsp_account_form.cfm, users\dsp_member_form.cfm and users\dsp_registration_form.cfm templates. ---->


<cfif get_User_Settings.UseGroupCode>
<cfoutput>
	<tr align="left">
		<td align="right">Group Code (if any):</td>
		<td></td>
		<td><input type="text" size="30" name="groupcode" value="#HTMLEditFormat(attributes.groupcode)#" class="formfield"/></td></tr>
</cfoutput>
</cfif>
	