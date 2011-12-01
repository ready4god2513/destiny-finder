<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page is called by the users.forgot circuit and is used to email a user their username and password. --->

<cfmodule template="../../customtags/format_input_form.cfm"
box_title="Login Request Form"
width="400"
required_fields="0"
>
<tr><td align="center">
<cfoutput>
<form name="editform" action="#XHTMLFormat('#self#?fuseaction=users.forgot#request.token2#')#" method="post" class="margins">
</cfoutput>
If you forgot your login information, enter the email address you used when registering,
and your username and a new randomly generated password will be emailed to you:
<br/><br/>
<input type="text" name="email" size="30" class="formfield"/>
<br/><br/>
<input type="submit" value="Submit" class="formbutton"/>
</form>
</td>
</tr>
</cfmodule>

<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
<!--//
// initialize the qForm object
objForm = new qForm("editform");

// make these fields required
objForm.required("email");

objForm.email.validateEmail();

qFormAPI.errorColor = "<cfoutput>###Request.GetColors.formreq#</cfoutput>";
//-->
</script>
</cfprocessingdirective>


