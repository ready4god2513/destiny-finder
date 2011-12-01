
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template is linked in the site to allow user to email the editor or "tell a friend". It pops up in its own window.

Including mailto=editor in the link's url, the form will be directed to the editor.
Including page=xx in the link will forward the page name.. replace & with ^ in address.

Tell a Friend: 
<a href="javascript:newWindow=openWin('#request.self#?fuseaction=home.email&page=#self#?fuseaction=feature.display^feature_id=#attributes.feature_id#','Email','width=500,height=400,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1'); newWindow.focus()" class="section_footer">email page</a>

Email the Editor:
<a href="javascript:newWindow=openWin('#request.self#?fuseaction=home.email&?mailto=editor&page=#self#?#cgi.query_string#','Email','width=500,height=360,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1'); newWindow.focus()" class="section_footer">email editor</a>

---->

<cfparam name="form.page" default="">
<cfparam name="form.mailto" default="">
<cfparam name="form.mailfrom" default="">
<cfparam name="form.fromemail" default="">
<cfparam name="form.mailtext" default="">

<cfif isdefined("url.mailto")>
	<cfset form.mailto = url.mailto>
</cfif>

<cfif isdefined("url.page")>
	<cfset form.page = Request.StoreURL & url.page>
</cfif>

<cfset message = "">
<cfset sent = 0>
<cfset form.page="#replace(form.page,'^','&')#">	




<!---- PROCESS FORM ----->
<cfif cgi.request_method is "post">

	<!--- check to see if fields are empty --->
	<cfif form.mailto is not "" and form.mailfrom is not "" and form.mailtext is not ""
	and form.fromemail is not "">
	
		<cfif form.mailto is "Editor">

			<!--- SEND MAIL TO EDITOR------------->
			<cfmail to="#request.appsettings.merchantemail#" from="#form.fromemail#" 
			subject="A message from #request.appsettings.sitename#"
			server="#request.appsettings.email_server#" port="#request.appsettings.email_port#">
			<cfmailparam name="Message-id" value="<#CreateUUID()#@#ListGetAt(request.appsettings.merchantemail, 2, "@")#>">
			<cfmailparam name="Reply-To" Value="#form.fromemail#">
	
			#form.mailtext#

			-- #form.mailfrom#, #form.fromemail#
			------------------------------------------------------
			This email was sent from #request.AppSettings.sitename#: #form.page#
			</cfmail>

			<cfset sent=1>

		<cfelse>
		
			<!--- SEND MAIL TO A FRIEND (NON-MEMBER) ------------->
			<cfmail to="#form.mailto#" from="#form.fromemail#" 
			subject="A message from #form.mailfrom# about #request.appsettings.sitename#"
			server="#request.appsettings.email_server#" port="#request.appsettings.email_port#">
			<cfmailparam name="Message-id" value="<#CreateUUID()#@#ListGetAt(request.appsettings.merchantemail, 2, "@")#>">
			<cfmailparam name="Reply-To" Value="#form.fromemail#">
The following message was sent to you from the #request.appsettings.sitename# web site by #form.mailfrom#:
			
#form.mailtext#

-- #form.mailfrom#
------------------------------------------------------
This email was sent from the following page on #request.appsettings.sitename#: #form.page#

Visit #request.appsettings.sitename# online at #Request.StoreURL#.
</cfmail>

			<cfset sent=1>

		</cfif>
	<cfelse>
		<cfset message="Please fill out the form entirely.">
	</cfif>
	
</cfif>


<!--- Application stuff ---------------------------------------->


<!---- Display Form if mail was not just sent ------>	
<cfif sent is 0>

	<div class="formtext">
	<cfif mailto is "Editor"><cfset boxtitle="Email The Editor">
	<p><b>Do you have a comment? A request? A question?</b> Please let us know!</p>
	<p><b>Your Privacy is assured.</b> Your email will not be stored or used in any other way than to respond to your inquiry.</p>
	<cfelse><cfset boxtitle="Tell A Friend">
	<p><strong>Email a Friend!</strong> Simply enter your message and we'll send it to your friend along with a link back to this page of our site.</p>
	<p><b>Privacy is assured.</b> The email addresses are never stored or used in any way other than to send this email. Your privacy, and the privacy of your friends, is very important to us!</p>
	</cfif>
	</div>

<cfoutput>
<form action="#XHTMLFormat('#request.self#?#cgi.query_string#')#" method="post" name="MailForm">
<input type="hidden" name="page" value="#XHTMLFormat('#form.page#')#"/>
<cfmodule template="../customtags/format_input_form.cfm"
box_title="#boxtitle#" required_fields="0">

<cfif len(message)>
	<cfoutput><br/><div class="formerror" align="center">#message#</div></cfoutput>
</cfif>

<tr align="left">
	<td align="right">Email To:</td>
	<td>&nbsp;</td>
	<td>
	<cfif form.mailto is "Editor">
		The Editor
		<input type="hidden" name="mailto" value="Editor"/>
		
	<cfelse>
		<input type="text" name="mailto" value="#form.mailto#" size="40" maxlength="150" class="formfield"/>
	</cfif>
	</td></tr>

<tr align="left">
	<td align="right">Your Name:</td>
	<td>&nbsp;</td>
	<td><input type="text" name="mailfrom" value="#form.mailfrom#" size="40" maxlength="150" class="formfield"/></td></tr>

<tr align="left">
	<td align="right">Your Email:</td>
	<td>&nbsp;</td>
	<td><input type="text" name="fromemail" value="#form.fromemail#" size="40" maxlength="150" class="formfield"/></td></tr>

<tr align="left">
	<td align="right" valign="top">Message:</td>
	<td>&nbsp;</td>
	<td><textarea cols="48" rows="6" name="mailtext" class="formfield">#form.mailtext#</textarea>
	</td></tr>

<tr align="left">
	<td colspan="2">&nbsp;</td><td><input type="submit" value="Send Message" class="formbutton"/> &nbsp; 
	<button name="Cancel" value="Cancel" class="formbutton" onclick="window.close();">Cancel</button>
	
	
	</td></tr>

</cfmodule>

</form>
	
<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
objForm = new qForm("MailForm");

objForm.required("mailto,mailfrom,fromemail,mailtext");

objForm.mailto.description = "the email address";
objForm.mailfrom.description = "your name";
objForm.fromemail.description = "your email address";
objForm.mailtext.description = "your message";

<cfif form.mailto is not "Editor">
objForm.mailto.validateEmail();
</cfif>
objForm.fromemail.validateEmail();
objForm.mailfrom.validateNotEmpty();
objForm.mailtext.validateNotEmpty();

qFormAPI.errorColor = "###Request.GetColors.formreq#";
</script>
</cfprocessingdirective>
</cfoutput>


	
<cfelse>

<cfmodule template="../customtags/format_input_form.cfm"
box_title="Contact Form"
align="left"
border="1"
required_fields="0"
>

<tr><td align="center" class="formtitle">
		<br/>
<p class="cat_title_large">Thank You</p>
Your email has been sent.

<p>
<button name="Cancel" value="Cancel" class="formbutton" onclick="window.close();">Close Window</button>
<p>

	</td></tr>

</cfmodule>
	
</cfif>
