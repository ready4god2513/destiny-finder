
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Allows customers to share their gift Registry with friends. --->

<cfset LineBreak = Chr(13) & Chr(10)>

<!--- First, we test to see if the form was submitted back to this page. ---->
<cfif isDefined("attributes.email_submit")><!--- process the form --->

	<cfset attributes.error_Message="">
	
	<!--- Check that all the fields are filled out correctly --->
	<cfif not len(Attributes.emailer_name) or  not len(Attributes.emailer_email) 
	or  not len(Attributes.Emailer_To) or  not len(Attributes.emailer_Subject) 
	or  not len(Attributes.emailer_message)> 
	
		<cfset attributes.error_Message = "Please fill out the required fields.">

	<cfelse>
		
		<cfif not isEmail(Trim(Attributes.emailer_email))>
		
			<cfset attributes.error_Message="Invalid Email Address.">
			
		</cfif>
		
		<cfset emailList = Replace(Attributes.Emailer_To,LineBreak,",","all")>
		
		<cfloop index="ii" list="#emailList#">
		
			<cfif not isEmail(Trim(ii))>
				<cfset attributes.error_Message="Invalid Email Address (#ii#). <br/>">
			</cfif>
		
		</cfloop>
		
	</cfif>
	

	<cfif not len(attributes.error_message)>
	
		<!--- this code creates and sends the email --->
		<cfprocessingdirective suppresswhitespace="No">
		
		<cfloop index="ii" list="#emailList#">

<cfmail to="#trim(ii)#" from="#attributes.emailer_name#[#attributes.emailer_email#]" subject="#attributes.emailer_Subject#"
	server="#request.appsettings.email_server#" port="#request.appsettings.email_port#">
<cfmailparam name="Message-id" value="<#CreateUUID()#@#ListGetAt(request.appsettings.merchantemail, 2, "@")#>">
<cfmailparam name="Reply-To" Value="#attributes.emailer_email#">
#attributes.emailer_message#
</cfmail>
		
		</cfloop>
		
		</cfprocessingdirective>
		
	</cfif>
	
	<!--- Confirmation ---->
	<cfset attributes.XFA_success="fuseaction=shopping.giftregistry&manage=list">
	<cfset attributes.box_title="Gift Registry">
	<cfset attributes.message="Emails Sent.">
	<cfinclude template="../../../includes/form_confirmation.cfm">		
	

<cfelse><!--- display the form --->

<!--- the only field required is "email_to". You can have it as a hidden field or replace this with a pull-down list, etc. This MUST be a required field. To do automatic error check for a required field, use the <cfinput> tag rather than a normal <input> tag. --->


<cfparam name="attributes.emailer_message" default="Gift Registry Link: #Request.StoreURL##request.self#?fuseaction=shopping.giftregistry&ID=#attributes.giftregistry_id#">

<cfoutput>
<form name="emailform" method="post" action="#XHTMLFormat('#request.self#?#cgi.query_string#')#">

<cfmodule template="../../../customtags/format_input_form.cfm"
box_title="Gift Registry"
width="500"
required_fields="1"
>
	<tr align="left">
	<td colspan="3"><div style="margin:10px;">Use this mail form to let people know about your registry. When the registry is hidden, this is the only way for people to reach the registry.</div></td></tr>

	<tr align="left"><td colspan="3" class="formtitle"><div style="margin:10px;">Send Email From</div></td></tr>
     <tr align="left">
	  <td width="25%" align="right">Your name</td>
	  <td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
      <td width="75%"><input type="text" name="emailer_name" size="40" class="formfield"/></td>
    </tr>
	<tr align="left">
      <td align="right">Email</td>
      <td style="background-color: ###Request.GetColors.formreq#;"></td>
      <td ><input type="text" name="emailer_email" size="40" class="formfield"/>
	  </td>
    </tr>
	<tr align="left"><td colspan="3" class="formtitle"><div style="margin:10px;">Send Email To</div></td></tr>
    <tr align="left">
      <td valign="top" align="right">Email Address(es): </td>
	  <td style="background-color: ###Request.GetColors.formreq#;"></td>
      <td ><textarea rows="8" name="Emailer_To" cols="28" class="formfield"></textarea>
	  <br/><span class="formtextsmall">Note: Enter one email address per line.</span>
	  </td>
    </tr>	
	<tr align="left"><td colspan="3" class="formtitle"><div style="margin:10px;">Email Message</div></td></tr>
     <tr align="left">
	  <td align="right">Subject: </td>
	  <td style="background-color: ###Request.GetColors.formreq#;"></td>
      <td ><input type="text" name="emailer_subject" size="60" value="" class="formfield"/></td>
    </tr>
     <tr align="left">
      <td valign="top" align="right">Message: </td>
	  <td style="background-color: ###Request.GetColors.formreq#;"></td>
	  <td></td>
	 </tr>
	 <tr align="left">
      <td colspan="3" align="center"><textarea rows="12" name="emailer_message" cols="60" class="formfield">#HTMLEditFormat(attributes.emailer_message)#</textarea></td>
    </tr>

    <tr align="left">
      <td colspan="2"></td>
      <td ><input type="submit" name="email_submit" value="Send Message" class="formbutton"/> 
	  <input type="button" value="Cancel" onclick="javascript:window.history.go(-1);" class="formbutton"/>

		</td>
    </tr>
	
</cfmodule>

</form>

<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
<!--
objForm = new qForm("emailform");

objForm.required("emailer_name,emailer_email,emailer_message,emailer_subject,Emailer_To");

objForm.emailer_email.description = "Your Email";
objForm.emailer_message.description = "Your Message";
objForm.emailer_name.description =  "Your Name";
objForm.emailer_subject.description =  "subject";
objForm.Emailer_To.description =  "to";

objForm.emailer_email.validateEmail();

qFormAPI.errorColor = "###Request.GetColors.formreq#";

//-->
</script>
</cfprocessingdirective>
</cfoutput>

</cfif><!--- end form check --->



