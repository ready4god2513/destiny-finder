
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->


<!--- This is a Cold Fusion Form Auto-Email page. The page displays a form which is submitted to itself. The page then processes the form field and displays a "thank you" section. This is a standard HTML page except for the commented section which holds the Cold Fusion code
--->

<cfparam name="attributes.EmailTo" default="#request.appsettings.merchantemail#">
<cfparam name="attributes.BoxTitle" default="Contact Us">
<cfparam name="attributes.Subject" default="A message from #request.appsettings.sitename#">

<!--- Set mime types allowed for upload --->
<cfset mimetypes = "image/gif,image/jpeg,image/pjpeg,image/png,application/msword,application/pdf,text/plain,application/x-zip-compressed,application/zip">
<cfset allowextensions = "gif,jpg,jpeg,png,doc,pdf,txt,csv,zip">
<cfset attributes.error_message = "">
<cfset Success = 0>
<cfset MyFile = "">

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
<cfset attributes.Subject = replace(attributes.Subject,linefeed,"","all")>

<cfset FormCheck = CreateObject("component", "#Request.CFCMapping#.tags.cffpVerify").init()>

<!--- Make sure all required fields are filled in. ---->
<cfif not len(attributes.emailer_name) OR not len(attributes.emailer_email) or not len(attributes.emailer_message)>
	<cfset attributes.error_message = "Please fill out the form completely">
<!--- Check for spam --->
<cfelseif NOT isEmail(attributes.emailer_email) OR NOT FormCheck.testSubmission(form) OR NOT isDefined("attributes.emailer_attachment")>
	<cfset attributes.error_message = "This email was marked as spam and removed.">
</cfif>

<!--- Upload any file attached to the email--->
<cfif len(trim(attributes.emailer_attachment)) AND attributes.error_message is "">
	
	<!--- Determine current directory for uploads. This template requires using a temp directory, which should be outside the webroot for security --->
	<cfset theDirectory = Request.TempPath>
		<!--- <cfset theDirectory = GetDirectoryFromPath(ExpandPath("*.*"))>
		<cfset theDirectory =  theDirectory & "email#Request.Slash#attachment"> --->

	<!--- Remove old uploads --->
	<cfdirectory action="LIST" directory="#theDirectory#" name="attachment_list" sort="datelastmodified">

	<cfloop query="attachment_list">
		<cfif attachment_list.datelastModified LT dateAdd('n',-9,now())>
			<cffile action="DELETE" file="#theDirectory##Request.Slash##attachment_list.name#">
		</cfif>
	</cfloop>
	
	<!--- Upload the file ---->
	<cftry>
		<cffile action="UPLOAD" filefield="emailer_attachment" destination="#theDirectory#" nameconflict="MAKEUNIQUE" accept="#mimetypes#">

		<cfset myFile = File.ServerFile> 
		
		<cfif NOT ListFind(allowextensions,File.serverFileExt)>
			<cfset attributes.error_message= "There was a problem uploading your file. Please make sure you are uploading a image (.jpg, .png or .gif), Word document (.doc), Adobe Acrobat document (.pdf) or a plain text file (.txt).">
			<cffile action="DELETE" File="#theDirectory##request.slash##File.ServerFile#">
		</cfif>

	<cfcatch type="Any">
		<cfset attributes.error_message= "There was a problem uploading your file. Please make sure you are uploading a image (.jpg, .png or .gif), Word document (.doc), Adobe Acrobat document (.pdf) or a plain text file (.txt).">
	</cfcatch>

	</cftry>
	
	<!---- DEBUG
	<cfoutput>#emailer_attachment#<br/>#theDirectory#<br/>#myFile#<br/></cfoutput>
	<cfabort>--->

</cfif><!--- submitted attachment  --->

<!--- If no form errors, do the mailing ---->
<cfif not len(attributes.error_message)>
	
		<!--- this code creates and sends the email #attributes.EmailTo# --->
					  
<cfmail to="#attributes.EmailTo#" from="#attributes.emailer_email#" subject="#attributes.Subject#"
	server="#request.appsettings.email_server#" port="#request.appsettings.email_port#">
<cfmailparam name="Message-id" value="<#CreateUUID()#@#ListGetAt(request.appsettings.merchantemail, 2, "@")#>">
<cfmailparam name="Reply-To" Value="#attributes.emailer_email#">
The follow message with attachment was sent from your web site:

From:    #attributes.emailer_name#
Phone:   #attributes.emailer_phone#
Email:   #attributes.emailer_email#

#attributes.emailer_message#

<cfif len(trim(attributes.emailer_attachment))>
(Please note that files attached are received from unknown web users and should be treated with suspicion and care. Be sure to use an up-to-date virus checker to protect your system from any possible infected files.)
<cfmailparam file="#theDirectory##request.slash##myFile#">
</cfif>
</cfmail>

		<cfset Success = 1>

	</cfif>

</cfif>
	
	
	
<!--- Display email form or "thank you" --->
<cfif Success is 1>

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
		<span class="title2">Your Message Was Sent.</span>
		<p><p>
		</div>
		</td></tr>
	</cfmodule>

<cfelse><!--- display the form --->

	<cfloop list="emailer_name,emailer_phone,emailer_email,emailer_message" index="counter">
		<cfparam name="attributes.#counter#" default="">
	</cfloop>   	

	<cfoutput>
	<form action="#XHTMLFormat('#Request.currentURL#')#" method="post" enctype="multipart/form-data" name="emailform" id="emailform">
	<input type="hidden" name="ActionPage" value="Yes">
	
	<cfmodule template="../customtags/format_input_form.cfm"
	box_title="#attributes.BoxTitle#"
	width="500"
	required_fields="1"
	>		
	
	<cfif len(attributes.error_message)>
	<tr>
		<td colspan="3" class="formerror">#attributes.error_message#</td>
	</tr>
	</cfif>
	<cfinclude template="../includes/cffp/cfformprotect/cffp.cfm">
	<tr>
		<td colspan="3"><img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="5" width="1" /></td>
	</tr>
     <tr align="left">
	  <td width="25%" align="right">Your&nbsp;Name</td>
	  <td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
      <td width="75%"><input type="text" name="emailer_name" size="40" value="#attributes.emailer_name#" class="formfield"/></td>
    </tr>
     <tr align="left">
	  <td align="right">Phone</td>
  	  <td></td>
      <td ><input type="text" name="emailer_phone" size="40" value="#attributes.emailer_phone#"  class="formfield"/></td>
    </tr>
	
    <tr align="left">
      <td align="right">Email</td>
      <td style="background-color: ###Request.GetColors.formreq#;"></td>
      <td ><input type="text" name="emailer_email" size="40" value="#attributes.emailer_email#"  class="formfield"/>
	  </td>
    </tr>
    <tr align="left">
      <td valign="top" align="right">Message </td>
	  <td style="background-color: ###Request.GetColors.formreq#;"></td>
      <td ><textarea rows="8" name="emailer_message" cols="50" class="formfield">#attributes.emailer_message#</textarea></td>
    </tr>
    <tr align="left">
      <td valign="top" align="right">Attachment </td>
	  <td></td>
      <td>
		<cfif Request.DemoMode>
		File attachments not supported in demo store mode. 
		<input type="hidden" name="emailer_attachment" value="">
		<cfelseif NOT len(Request.TempPath)>
		This store is not configured to receive file attachments. 
		<input type="hidden" name="emailer_attachment" value="">
		<cfelse>
		<input type="file" size="40" name="emailer_attachment" accept="#mimetypes#" class="formfield"/><br/>
	  <span class="formtextsmall">Click the Browse button to select an image (.jpg, .png or .gif), Microsoft Word (.doc), Adobe Acrobat (.pdf), or text (.txt) file to send with this message.</span>
		</cfif>
		</td>
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
objForm.emailer_email.description = "email";
objForm.emailer_message.description = "message";
objForm.emailer_name.description = "name";

objForm.emailer_email.validateEmail();
objForm.emailer_name.focus();

qFormAPI.errorColor = "###Request.GetColors.formreq#";
</script>
</cfprocessingdirective>
</cfoutput>	

</cfif><!--- end form check --->