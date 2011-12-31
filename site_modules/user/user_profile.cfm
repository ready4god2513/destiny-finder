<cfset obj_user = CreateObject("component","cfcs.users")>
<cfset obj_queries = CreateObject("component","cfcs.queries")>

<cfif isDefined('FORM.submit')>
    <cfset Cffp = CreateObject("component","cfformprotect.cffpVerify").init() />
    <!--- now we can test the form submission --->
    <cfif Cffp.testSubmission(form)>
 	 <cfset VARIABLES.create_account_message = obj_user.process_user_form(process="#FORM.submit#")> 
    <cfelse>
      <cflocation url="/index.cfm" addtoken="no">
      <cfabort>	
	</cfif>
</cfif>

<cfif REQUEST.user_id NEQ 0>
	<cfset qUser = obj_queries.user_detail(user_id="#REQUEST.user_id#")>
<cfelse>

	
</cfif>
	<cfparam name="qUser.user_first_name" default="">	
	<cfparam name="qUser.user_last_name" default="">	
	<cfparam name="qUser.user_email" default="">	
	<cfparam name="qUser.user_address1" default="">	
	<cfparam name="qUser.user_address2" default="">	
	<cfparam name="qUser.user_city" default="">	
	<cfparam name="qUser.user_state" default="">	
	<cfparam name="qUser.user_zip" default="">	
	<cfparam name="qUser.user_phone" default="">	
	<cfparam name="qUser.user_image" default="">	
	<cfparam name="qUser.user_description" default="">	
	<cfparam name="qUser.user_store_id" default="">
    
	<cfparam name="FORM.user_first_name" default="">	
	<cfparam name="FORM.user_last_name" default="">	
	<cfparam name="FORM.user_email" default="">	
	<cfparam name="FORM.user_address1" default="">	
	<cfparam name="FORM.user_address2" default="">	
	<cfparam name="FORM.user_city" default="">	
	<cfparam name="FORM.user_state" default="">	
	<cfparam name="FORM.user_zip" default="">	
	<cfparam name="FORM.user_phone" default="">	
	<cfparam name="FORM.user_image" default="">	
	<cfparam name="FORM.user_description" default="">	
<cfif isDefined('VARIABLES.create_account_message')>

	<cfif isDefined('URL.fileerror')>
		<cfset VARIABLES.create_account_message = "upload fail">
	</cfif>

	<cfmodule template="/site_modules/site_notifications.cfm" message="#VARIABLES.create_account_message#">
		
	<cfset qUser.user_first_name = "#FORM.user_first_name#">	
	<cfset qUser.user_last_name = "#FORM.user_last_name#">	
	<cfset qUser.user_address1 = "#FORM.user_address1#">	
	<cfset qUser.user_address2 = "#FORM.user_address2#">	
	<cfset qUser.user_city = "#FORM.user_city#">	
	<cfset qUser.user_state = "#FORM.user_state#">	
	<cfset qUser.user_zip = "#FORM.user_zip#">	
	<cfset qUser.user_phone = "#FORM.user_phone#">	

		
</cfif>

	

<cfif REQUEST.user_id EQ 0>
	<cfset VARIABLES.action_url = "index.cfm?page=user&create=1">
<cfelse>
	<cfset VARIABLES.action_url = "index.cfm?page=user&edit=1">
</cfif>



<cfoutput>
		<p>&nbsp;</p>
		<table width="400" border="0" cellspacing="3" cellpadding="0" class="profile_table">
          <cfset Cffp = CreateObject("component","cfformprotect.cffpVerify").init() />
		  <cfform action="/auth/#VARIABLES.action_url#" method="post" name="profile" enctype="multipart/form-data">
          <cfinclude template="../../cfformprotect/cffp.cfm">
          <tr>
          <td colspan="2"><h2>Beta Version Launches!</h2><br />
We're excited to unveil the first stage of 
destinyfinder.com with the Free Destiny Survey! <br />
Take the first step to discover your destiny.<br />
We'll be rolling out the rest of this amazing system shortly.<br /><br />
          </td>
          </tr>
          <cfif REQUEST.user_id EQ 0><tr>
          <td colspan="2">
          <h2><cfif REQUEST.user_id EQ 0>Create<cfelse>Edit</cfif> Your Account</h2>
          <h2 style="color: black;">Welcome!</h2><br />
Please give us some basic information so we can help you get started on your journey of discovering your destiny. The account you create will be used for all the DestinyFinder products and services. We won�t give your email address away or spam you.
<br />
<br />
<h2 style="color: black;">What you�ll get...</h2><br />

After doing the 5 min free Destiny Survey you�ll receive:
<ul>
<li>Insights on how your design shapes your destiny.</li>
<li>Customized results instantly.</li>
<li>Access to our Resources section - articles, organization profiles, book recommendations, and more.</li>
</ul>

          </td>
          </tr></cfif>
          <tr>
			<td width="144" class="form_label">First Name:</td>
			<td width="256"><cfinput type="text" name="user_first_name" size="20" value="#HTMLEditFormat(qUser.user_first_name)#"  required="yes" message="First Name cannot be blank!"> </td>
		  </tr>
		  <tr>
			<td class="form_label">Last Name:</td>
			<td><cfinput type="text" name="user_last_name" size="20" value="#HTMLEditFormat(qUser.user_last_name)#" required="yes" message="Last Name cannot be blank!"></td>
		  </tr>
		  <tr>
			<td class="form_label">Email Address:<br>
			  [Used for login] </td>
			<td>
			<cfif REQUEST.user_id EQ 0><cfinput type="text" name="user_email" size="20" value="#HTMLEditFormat(qUser.user_email)#" required="yes" message="Email Address cannot be blank!" validate="email">
            <cfelse>
            #HTMLEditFormat(qUser.user_email)#
            </cfif></td>
		  </tr>
		  <cfif REQUEST.user_id EQ 0>
			   <tr>
				<td class="form_label">Confirm Email:<br></td>
				<td><input type="text" name="user_email2" size="20" value=""></td>
			  </tr>
		  </cfif>
		  <!---<tr>
			<td class="form_label">Address:</td>
			<td><input type="text" name="user_address1" size="20" value="#qUser.user_address1#"></td>
		  </trg>
		  <tr>
			<td class="form_label">Address 2: </td>
			<td><input type="text" name="user_address2" size="20" value="#qUser.user_address2#"></td>
		  </tr>
		  <tr>
			<td class="form_label">City:</td>
			<td><input type="text" name="user_city" size="20" value="#qUser.user_city#"></td>
		  </tr>
		  <tr>
			<td class="form_label">State:</td>
			<td><cfmodule template="/customtags/state_list.cfm" select_name="user_state" selected_state="#qUser.user_state#"></td>
		  </tr>
		  <tr>
			<td class="form_label">Zip:</td>
			<td><input type="text" name="user_zip" size="20" value="#qUser.user_zip#"></td>
		  </tr>
		  <tr>
			<td class="form_label">Phone Number: </td>
			<td><input type="text" name="user_phone" size="20" value="#qUser.user_phone#"></td>
		  </tr>--->
			<cfif REQUEST.user_id EQ 0>
		  <tr>
			<td class="form_label">Password:</td>
			<td><cfinput type="password" name="user_password" size="20" value="" required="yes" message="Password cannot be blank!"></td>
		  </tr>
		  <tr>
			<td class="form_label">Confirm Password:</td>
			<td><cfinput type="password" name="user_password2" size="20" value="" required="yes" message="Confirm Password cannot be blank!"></td>
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
		<!---
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
						fckEditor.value			= '#qUser.user_description#';
						fckEditor.basePath		= basePath;
						fckEditor.width			= 450;
						fckEditor.height		= 200;
						fckeditor.ToolbarSet = "Basic";
						fckEditor.create(); // create the editor.
					</cfscript>
					  </div></td>
		  </tr>
		   <tr>
			<td valign="top" class="form_label">Profile Image:</td>
			<td valign="top">
			<cfif LEN(qUser.user_image) GT 0>
				Uploaded Image:<br/>
					<img src="#qUser.user_image#">
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
		  ---->
		  <tr>
			<td colspan="2">
				<div>
				<cfif REQUEST.user_id EQ 0>
                	  <input type="submit" name="submit" value="Create Account"><!---</cfif>--->
				<cfelse>
					  <input type="submit" name="submit" value="Update Profile">			
				</cfif>
                <cfif REQUEST.user_id EQ 0><div><br />Already a User? <a href="/auth/?page=user">Login here</a>.<br /></div></cfif>
					  <!---<div align="center" style="color: ##CC0000;font-size:12px;">We are in the testing phase now. To request test access, please email Glen Reed at <a href="glen.reed@destinyfinder.com">glen.reed@destinyfinder.com</a></div><cfif isDefined("url.testuser")>--->
			    </div></td>
		  </tr>
		</cfform>
        </table>
	
	
</cfoutput>