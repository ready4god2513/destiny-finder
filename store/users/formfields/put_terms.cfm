<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Inserts the terms & conditions form fields. Called during user registration from the users\dsp_account_form.cfm, users\dsp_member_form.cfm and users\dsp_registration_form.cfm templates. 
NOTE: The form action must include the onsubmit parameter: <form action="#request.self#?#attributes.xfa_submit_login#" method="post"<cfif attributes.use_terms> onsubmit="return checkCheckBox(this)"</cfif>> --->

<cfif get_User_Settings.UseTerms>

<cfprocessingdirective suppresswhitespace="no">
<cfHTMLhead text="
<script language=""JavaScript"">
	function checkCheckBox(f){
	if (f.agree.checked == false )
	{
	alert('You must read and agree to the Terms and Conditions to proceed.');
	return false;
	}else
	return true;
	}
	</script>
">
</cfprocessingdirective>

<cfoutput>
	<tr><td colspan="3"><img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="6" width="1" /></td></tr>
	<tr><td valign="top" align="center" colspan="3">

<textarea cols="55" rows="6" class="formfield">#get_User_Settings.TermsText#</textarea>
	</td></tr>
	
	<tr>
	<td colspan="3" align="center"><input type="checkbox" value="1" name="agree" #doChecked(attributes.agree)# /> 
	I have read and agree to the above Terms and Conditions</td>
	</tr>
</cfoutput>
</cfif>


