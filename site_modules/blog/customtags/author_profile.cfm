<cfset obj_user = CreateObject("component","site_modules.blog.cfcs.users")>
<cfset obj_queries = CreateObject("component","site_modules.blog.cfcs.queries")>

<cfif isDefined('FORM.submit')>
 	<cfset VARIABLES.create_account_message = obj_user.process_user_form(process="#FORM.submit#")> 
</cfif>

<cfif REQUEST.user_id NEQ 0>
	<cfset qAuthor = obj_queries.author_detail(author_id="#REQUEST.user_id#")>
</cfif>


<cfif isDefined('VARIABLES.create_account_message')>

	<cfif isDefined('URL.fileerror')>
		<cfset VARIABLES.create_account_message = "upload fail">
	</cfif>

	<cfmodule template="site_notifications.cfm" message="#VARIABLES.create_account_message#">
		
	<cfset qAuthor.user_first_name = "#FORM.user_first_name#">	
	<cfset qAuthor.user_last_name = "#FORM.user_last_name#">	
	<cfset qAuthor.user_address1 = "#FORM.user_address1#">	
	<cfset qAuthor.user_address2 = "#FORM.user_address2#">	
	<cfset qAuthor.user_city = "#FORM.user_city#">	
	<cfset qAuthor.user_state = "#FORM.user_state#">	
	<cfset qAuthor.user_zip = "#FORM.user_zip#">	
	<cfset qAuthor.user_phone = "#FORM.user_phone#">	
	<cfset qAuthor.user_description = "#FORM.user_description#">	
		
</cfif>

	<cfparam name="qAuthor.user_first_name" default="">	
	<cfparam name="qAuthor.user_last_name" default="">	
	<cfparam name="qAuthor.user_email" default="">	
	<cfparam name="qAuthor.user_address1" default="">	
	<cfparam name="qAuthor.user_address2" default="">	
	<cfparam name="qAuthor.user_city" default="">	
	<cfparam name="qAuthor.user_state" default="">	
	<cfparam name="qAuthor.user_zip" default="">	
	<cfparam name="qAuthor.user_phone" default="">	
	<cfparam name="qAuthor.user_image" default="">	
	<cfparam name="qAuthor.user_description" default="">	

<cfif REQUEST.user_id EQ 0>
	<cfset VARIABLES.action_url = "index.cfm?page=blog&newuser=1">
<cfelse>
	<cfset VARIABLES.action_url = "index.cfm?page=blog&admin=1&profile=1">
</cfif>



<cfoutput>
	<form action="#VARIABLES.action_url#" method="post" name="profile" enctype="multipart/form-data">
		<table width="400" border="0" cellspacing="3" cellpadding="0" class="table_reset">
		  <tr>
			<td width="144" class="form_label">First Name:</td>
			<td width="256"><input type="text" name="user_first_name" size="20" value="#qAuthor.user_first_name#"> </td>
		  </tr>
		  <tr>
			<td class="form_label">Last Name:</td>
			<td><input type="text" name="user_last_name" size="20" value="#qAuthor.user_last_name#"></td>
		  </tr>
		  <tr>
			<td class="form_label">Email Address:<br>
			  [Used for your login] </td>
			<td><input type="text" name="user_email" size="20" value="#qAuthor.user_email#"></td>
		  </tr>
		  <cfif REQUEST.user_id EQ 0>
			   <tr>
				<td class="form_label">Confirm Email Address:<br></td>
				<td><input type="text" name="user_email2" size="20" value=""></td>
			  </tr>
		  </cfif>
		  <tr>
			<td class="form_label">Address:</td>
			<td><input type="text" name="user_address1" size="20" value="#qAuthor.user_address1#"></td>
		  </tr>
		  <tr>
			<td class="form_label">Address 2: </td>
			<td><input type="text" name="user_address2" size="20" value="#qAuthor.user_address2#"></td>
		  </tr>
		  <tr>
			<td class="form_label">City:</td>
			<td><input type="text" name="user_city" size="20" value="#qAuthor.user_city#"></td>
		  </tr>
		  <tr>
			<td class="form_label">State:</td>
			<td><cfmodule template="state_list.cfm" select_name="user_state" selected_state="#qAuthor.user_state#"></td>
		  </tr>
		  <tr>
			<td class="form_label">Zip:</td>
			<td><input type="text" name="user_zip" size="20" value="#qAuthor.user_zip#"></td>
		  </tr>
		  <tr>
			<td class="form_label">Phone Number: </td>
			<td><input type="text" name="user_phone" size="20" value="#qAuthor.user_phone#"></td>
		  </tr>
			<cfif REQUEST.user_id EQ 0>
		  <tr>
			<td class="form_label">Password:</td>
			<td><input type="password" name="user_password" size="20" value=""></td>
		  </tr>
		  <tr>
			<td class="form_label">Confirm Password:</td>
			<td><input type="password" name="user_password2" size="20" value=""></td>
		  </tr>
		  <cfelse>
			<tr>
				<td colspan="2" style="padding:5px 0px 5px 0px;font-weight:bold;">If you want to change your password-</td>
			</tr>
			<tr>
			  <td class="form_label">New Password:</td>
			  <td><input type="password" name="user_password" size="20"></td>
			</tr>
			<tr>
			  <td class="form_label">Confirm New Password: </td>
			  <td><input type="password" name="user_password2" size="20"></td>
			</tr>
		</cfif>
		  <tr>
			<td class="form_label">Short Description: </td>
			<td>&nbsp;</td>
		  </tr>
		  <tr>
			<td colspan="2">
					<div align="center">
					  <cfscript>
						// Calculate basepath for FCKeditor. It's in the folder right above _samples
					
						basePath = '/editor/';
						fckEditor = createObject("component", "#basePath#fckeditor");
						fckEditor.instanceName	= "user_description";
						fckEditor.value			= '#qAuthor.user_description#';
						fckEditor.basePath		= basePath;
						fckEditor.width			= 450;
						fckEditor.height		= 300;
						fckeditor.ToolbarSet = "Blog";
						fckEditor.create(); // create the editor.
					</cfscript>
					  </div></td>
		  </tr>
		   <tr>
			<td valign="top" class="form_label">Profile Image:</td>
			<td valign="top">
			<cfif LEN(qAuthor.user_image) GT 0>
				Uploaded Image:<br/>
					<img src="#qAuthor.user_image#">
					<br/>
					Replace:
			</cfif>
				<input type="file" name="add_profile_pic">
			</td>
		  </tr>
		   <tr>
		     <td colspan="2">
			 <div style="width:300px;margin-left:auto;margin-right:auto;border:1px dotted ##ff0000;padding:5px;">
			 <span style="color:##ff0000;font-weight:bold;">IMPORTANT PROFILE IMAGE RESTRICTIONS</span><br/>
			   <strong>File Types Accepted:</strong> GIF,JPG,PNG<br>
		      <strong> Dimensions:</strong> <em>122px x 93px</em><br>
			   </div>
			   </td>
	      </tr>
		  <tr>
			<td colspan="2">
				<div align="center">
				<cfif REQUEST.user_id EQ 0>
					  <input type="submit" name="submit" value="Create Account">
				<cfelse>
					  <input type="submit" name="submit" value="Update Profile">
					  <input type="hidden" name="user_id" value="#REQUEST.user_id#">
				</cfif>
				  </div></td>
		  </tr>
		</table>
	</form>
	
	<SCRIPT language="JavaScript">
		var frmvalidator  = new Validator("profile");
		frmvalidator.EnableMsgsTogether();
		frmvalidator.addValidation("user_first_name","req","First Name: Cannot Be Blank!");
		frmvalidator.addValidation("user_last_name","req","Last Name: Cannot Be Blank!");
		frmvalidator.addValidation("user_email","req","Email Address: Cannot Be Blank!");
		frmvalidator.addValidation("user_email","email","Email Address: Must Be A Valid Email Address!");
		<cfif REQUEST.user_id EQ 0>
			frmvalidator.addValidation("user_password","req","Password: Cannot Be Blank!");
			frmvalidator.addValidation("user_password2","req","Password Confirm: Cannot Be Blank!");		
			frmvalidator.addValidation("user_email2","req","Email Confirm: Cannot Be Blank!");		
		</cfif>
		frmvalidator.addValidation("user_address1","req","Address 1: Cannot Be Blank!");
		frmvalidator.addValidation("user_city","req","City: Cannot Be Blank!");
		frmvalidator.addValidation("user_state","req","State: Cannot Be Blank!");
		frmvalidator.addValidation("user_zip","req","Zip: Cannot Be Blank!");
	
		function DoCustomValidation()
				{
				  var frm = document.forms["profile"];
				  var password1 = frm.user_password.value;
				  var password2 = frm.user_password2.value;
				  <cfif REQUEST.user_id EQ 0>
					  var email1 = frm.user_email.value;
					  var email2 = frm.user_email2.value;
				</cfif>
							
				 if (password1 != password2)
				   { 
					alert("Your passwords did not match. Please re-enter and try again.");
					return false;
				  } 
				  <cfif REQUEST.user_id EQ 0>
					  else if (email1 != email2)
					  {
						alert("Your emails did not match. Please re-enter and try again.");
						return false;
					  }
				  </cfif>
				  else {
					return true;
				  }
				 
				 }
				
			frmvalidator.setAddnlValidationFunction("DoCustomValidation");	
				
	</script>

</cfoutput>