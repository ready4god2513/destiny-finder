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

<h2>Beta Version Launches</h2>
<p>
	We're excited to unveil the first stage of 
	destinyfinder.com with the Free Destiny Survey! <br />
	Take the first step to discover your destiny.<br />
	We'll be rolling out the rest of this amazing system shortly.
</p>
<p>
	Please give us some basic information so we can help you get started on your 
	journey of discovering your destiny. The account you create will be used for all 
	the DestinyFinder products and services. We won't give your email address away or spam you.
</p>

<h3>What you'll get</h3>
<p>After doing the 5 min free Destiny Survey you'll receive:</p>
<ul>
	<li>Insights on how your design shapes your destiny.</li>
	<li>Customized results instantly.</li>
	<li>Access to our Resources section - articles, organization profiles, book recommendations, and more.</li>
</ul>

<form action="/auth/<cfoutput>#VARIABLES.action_url#</cfoutput>" method="POST">
	<fieldset>
		<div class="form-field">
			<label for="user_first_name">First Name</label>
			<input type="text" name="user_first_name" id="user_first_name" value="<cfoutput>#HTMLEditFormat(qUser.user_first_name)#</cfoutput>" required="required" />
		</div>
		
		<div class="form-field">
			<label for="user_last_name">Last Name</label>
			<input type="text" name="user_last_name" id="user_last_name" value="<cfoutput>#HTMLEditFormat(qUser.user_last_name)#</cfoutput>" required="required" />
		</div>
		
		<div class="form-field">
			<label for="user_email">Email Address</label>
			<input type="email" name="user_email" id="user_email" value="<cfoutput>#HTMLEditFormat(qUser.user_email)#</cfoutput>" required="required" />
		</div>
		
		<cfif REQUEST.user_id EQ 0>
			<div class="form-field">
				<label for="user_email2">Confirm Email</label>
				<input type="email" name="user_email2" id="user_email2" value="<cfoutput>#HTMLEditFormat(qUser.user_email)#</cfoutput>" required="required" />
			</div>
		</cfif>
		
		<cfif REQUEST.user_id EQ 0>
			<div class="form-field">
				<label for="user_password">Password</label>
				<input type="password" name="user_password" id="user_password" value="<cfoutput>#HTMLEditFormat(qUser.user_password)#</cfoutput>" required="required" />
			</div>
		
			<div class="form-field">
				<label for="user_password2">Confirm Password</label>
				<input type="password" name="user_password2" id="user_password2" value="<cfoutput>#HTMLEditFormat(qUser.user_password2)#</cfoutput>" required="required" />
			</div>
		<cfelse>
			<div class="form-field">
				<label for="user_password">Password</label>
				<input type="password" name="user_password" id="user_password" />
			</div>
		
			<div class="form-field">
				<label for="user_password2">Confirm Password</label>
				<input type="password" name="user_password2" id="user_password2" />
			</div>
		</cfif>
	</fieldset>
	
	<cfif REQUEST.user_id EQ 0>
    	  <input type="submit" name="submit" value="Create Account">
	<cfelse>
		  <input type="submit" name="submit" value="Update Profile">			
	</cfif>
	
    <cfif REQUEST.user_id EQ 0>
		<p>Already a User? <a href="/auth/?page=user">Login here</a></p>
	</cfif>
	
</form>