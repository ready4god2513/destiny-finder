<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Inserts the subscribe form field. Called during user registration from the users\dsp_account_form.cfm, users\dsp_member_form.cfm and users\dsp_registration_form.cfm templates. ---->


<cfif get_User_Settings.ShowSubscribe>	
	<cfoutput>
		<tr align="left">
		<td align="right" valign="baseline">Join our email list? </td><td></td>
		<td><input type="radio" name="subscribe" value="1" class="formtext" #doChecked(attributes.subscribe)# /> Yes
		 <input type="radio" name="subscribe" value="0" class="formtext" #doChecked(attributes.subscribe,0)# /> No
		<br/><span class="formtextsmall">Receive news and special offers.</span>
		</td></tr>
	</cfoutput>
</cfif>