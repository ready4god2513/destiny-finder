<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This is a Cold Fusion Form Auto-Email page. The page displays a form which is submitted to itself. The page then processes the form field and displays a "thank you" section. This is a standard HTML page except for the commented section which holds the Cold Fusion code
--->

<cfparam name="attributes.EmailTo" default="#request.appsettings.merchantemail#">
<cfparam name="attributes.BoxTitle" default="Send Us an Email">
<cfparam name="attributes.Subject" default="A message from #request.appsettings.sitename#">

<!--- First, we test to see if the form was submitted back to this page. ---->
<cfif isDefined("attributes.email_submit")><!--- process the form --->

<!-- Remove line and carriage breaks from header fields --->

<cfset carrbreak =  Chr(13)>
<cfset attributes.EmailTo= replace(attributes.EmailTo,carrbreak,"","all")>
<cfset attributes.emailer_email= replace(attributes.emailer_email,carrbreak,"","all")>
<cfset attributes.Subject = replace(attributes.Subject,carrbreak,"","all")>

<cfset linefeed =  Chr(10)>
<cfset attributes.EmailTo= replace(attributes.EmailTo,linefeed,"","all")>
<cfset attributes.emailer_email= replace(attributes.emailer_email,linefeed,"","all")>
<cfset attributes.Subject = replace(attributes.Subject,carrbreak,"","all")>

<cfset FormCheck = CreateObject("component", "#Request.CFCMapping#.tags.cffpVerify").init()>

<!--- Check for spam --->
<cfif isEmail(attributes.emailer_email) AND FormCheck.testSubmission(form)>

<!--- this code creates and sends the email --->
<cfmail to="#attributes.EmailTo#" from="#attributes.emailer_email#" subject="#attributes.Subject#"
	server="#request.appsettings.email_server#" port="#request.appsettings.email_port#">
<cfmailparam name="Message-id" value="<#CreateUUID()#@#ListGetAt(request.appsettings.merchantemail, 2, "@")#>">
<cfmailparam name="Reply-To" Value="#attributes.emailer_email#">
<!--- Create your email message here. Use your form fields. --->
The following message was sent from your web site:

From:    #attributes.emailer_name#
Title:   #attributes.emailer_title#
Company: #attributes.emailer_company#
Phone:   #attributes.emailer_phone#
Email:   #attributes.emailer_email#
IP: 	 #CGI.REMOTE_ADDR#

Message: 
#attributes.emailer_message#
</cfmail>
<!--- end of email --->

<!--- send a courtesy copy to the customer  --->

<!--- <cfmail  to="#form.emailer_email#" from="#request.appsettings.MerchantEmail#" subject="#request.appsettings.siteName# email confirmation." 
	server="#request.appsettings.email_server#" port="#request.appsettings.email_port#">
<cfmailparam name="Message-id" value="<#CreateUUID()#@#ListGetAt(request.appsettings.merchantemail, 2, "@")#>">
<cfmailparam name="Reply-To" Value="#request.appsettings.MerchantEmail#">
Thank you for taking the time to contact #request.appsettings.siteName#. We will respond to your email as soon as possible.

Best regards,

#request.appsettings.siteName#

Online Customer Service

</cfmail> --->

<!--- after sending the email, display the following "thank you" html code:--->


<cfmodule template="../customtags/format_input_form.cfm"
box_title="#attributes.BoxTitle#"
width="450"
required_fields="0"
>
<tr><td>
<div align="center">
<br/>
<h2>Thank You</h2>
<span class="title2">Your email has been sent.</span>
<p><p>
</div>
</td></tr>
</cfmodule>

<cfelse>

<cfmodule template="../customtags/format_input_form.cfm"
box_title="#attributes.BoxTitle#"
width="450"
required_fields="0"
>
<tr><td>
<div align="center">
<h2>Spam Detected</h2>
<span class="title2">This email has been marked as spam and removed.</span>
<p><p>
</div>
</td></tr>
</cfmodule>


</cfif>


<cfelse><!--- display the form --->

<!--- the only field required is "email_to". You can have it as a hidden field or replace this with a pull-down list, etc. This MUST be a required field. To do automatic error check for a required field, use the <cfinput> tag rather than a normal <input> tag. --->

<cfoutput>
<form name="emailform" method="post"  action="#XHTMLFormat('#Request.currentURL#')#">
<input type="hidden" name="ActionPage" value="Yes">
<cfmodule template="../customtags/format_input_form.cfm"
box_title="#attributes.BoxTitle#"
width="525"
required_fields="1"
>
<cfinclude template="../includes/cffp/cfformprotect/cffp.cfm">
	<tr>
		<td colspan="3"><img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="5" width="1" /></td></tr>
     <tr align="left">
	  <td width="25%" align="right">Your&nbsp;Name</td>
	  <td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
      <td width="75%"><input type="text" name="emailer_name" size="40" class="formfield"/></td>
    </tr>
     <tr align="left">
	  <td align="right">Title</td>
	  <td></td>
      <td ><input type="text" name="emailer_title" size="40" class="formfield"/></td>
    </tr>
    <tr align="left">
	  <td align="right">Company</td>
  	  <td></td>
      <td ><input type="text" name="emailer_company" size="40" class="formfield"/></td>
    </tr>
     <tr align="left">
	  <td align="right">Phone</td>
  	  <td></td>
      <td ><input type="text" name="emailer_phone" size="40" class="formfield"/></td>
    </tr>
	
    <tr align="left">
      <td align="right">Email</td>
      <td style="background-color: ###Request.GetColors.formreq#;"></td>
      <td ><input type="text" name="emailer_email" size="40" class="formfield"/>
	  </td>
    </tr>
    <tr align="left">
      <td valign="top" align="right">Message </td>
	  <td style="background-color: ###Request.GetColors.formreq#;"></td>
      <td ><textarea rows="8" name="emailer_message" cols="58" class="formfield"></textarea></td>
    </tr>

    <tr align="left">
      <td colspan="2"></td>
      <td ><input type="submit" name="email_submit" value="send message" class="formbutton"/></td>
    </tr>
	
</cfmodule>
</form>

<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
objForm = new qForm("emailform");

objForm.required("emailer_name,emailer_email,emailer_message");
objForm.emailer_email.description = "your email";
objForm.emailer_message.description = "your message";
objForm.emailer_name.description = "your name";

objForm.emailer_email.validateEmail();
objForm.emailer_name.focus();

qFormAPI.errorColor = "###Request.GetColors.formreq#";
</script>
</cfprocessingdirective>
</cfoutput>

</cfif><!--- end form check --->


