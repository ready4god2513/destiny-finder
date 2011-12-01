<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This is the form displayed to users verifying their email address. Called by users.unlock circuit. --->

<cfparam name="attributes.Error_Message" default="">
<cfparam name="attributes.email" default="">
<cfparam name="attributes.xfa_submit_unlock" default="fuseaction=users.unlock">
<cfparam name="attributes.xfa_success" default="#self#?fuseaction=users.manager">
	
	
<!--- Add an auto-refresh to page. Most users will click the link in the email sent to them to confirm their email address. That will open the site in a new window. This page often gets left open and it confuses users. Auto-refresh will forward OFF this form if the confirmation is handeled by the link. --->	
<cfhtmlhead text="<meta http-equiv=""refresh"" content=""60"">"> 	

<!--- Directions above form --->
<cfoutput>
<p class="cat_text_small">
An email was sent to #qry_get_user.email# containing your Email Confirmation code. Please enter that code in the form below. If you did not receive an email (please allow up to 10 minutes), please verify that your email address is correct and that your email account settings allow you to receive emails from this site, then click the link below.</p>

<p class="formtitle" align="center">
<a href="#XHTMLFormat('#request.self#?fuseaction=users.sendlock#request.token2#')#">Send Another Confirmation Email to <u>#qry_get_user.email#</u> Now</a></p> 
</cfoutput>

<cfoutput>
<form action="#XHTMLFormat('#request.self#?#attributes.xfa_submit_unlock##request.token2#')#" method="post" name="theForm">
<input type="hidden" name="xfa_success" value="#HTMLEditFormat(attributes.xfa_success)#"/>
<input type="hidden" name="email" value="#HTMLEditFormat(attributes.email)#"/>
	
<cfmodule template="../customtags/format_input_form.cfm"
box_title="Email Confirmation"
width="400"
required_fields="0">	
	
	<cfif len(attributes.Error_Message)>
	<tr>
		<td colspan="2" align="center"><br/><span class="formerror">#attributes.Error_Message#</span><br/><br/></td></tr>
	</cfif>

	<tr align="left">
		<td align="right"><br/><span class="formtext">Email Confirmation Code:</span> </td>
		<td><br/><input name="emailLock" type="text" size="20" value="#HTMLEditFormat(attributes.emailLock)#"/></td></tr>
	
	<tr><td align="center" colspan="2"><br/><input type="submit" value="Unlock" class="formbutton"/><br/><br/></td></tr>

</cfmodule>

</form>
	
<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
<!--//
objForm = new qForm("theForm");

objForm.required("emailLock");

objForm.emailLock.description = "lockcode that was emailed to you at the time of registration";
objForm.emailLock.focus();

qFormAPI.errorColor = "###Request.GetColors.formreq#";
//-->
</script>
</cfprocessingdirective>
</cfoutput>
