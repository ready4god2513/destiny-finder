<cfset obj_user = CreateObject("component","cfcs.users")>
<cfset obj_queries = CreateObject("component","cfcs.queries")>

<cfif isDefined("FORM.submit")>
    <cfset VARIABLES.create_account_message = obj_user.process_user_form(process="#FORM.submit#") />
</cfif>

<cfif REQUEST.user_id NEQ 0>
	<cfset qUser = obj_queries.user_detail(user_id="#REQUEST.user_id#")>
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
<cfparam name="qUser.marketing_opt_in" default="">
   
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
<cfparam name="FORM.marketing_opt_in" default="">
	
<cfif isDefined('VARIABLES.create_account_message')>
	<cfif VARIABLES.create_account_message EQ "profile_updated">
		<cfmodule 
			template="/site_modules/site_notifications.cfm" 
			success="#VARIABLES.create_account_message#">
	<cfelse>
		<cfmodule 
			template="/site_modules/site_notifications.cfm" 
			message="#VARIABLES.create_account_message#">
	</cfif>
	
	<cfset qUser.user_first_name = "#FORM.user_first_name#">	
	<cfset qUser.user_last_name = "#FORM.user_last_name#">	
	<cfset qUser.user_address1 = "#FORM.user_address1#">	
	<cfset qUser.user_address2 = "#FORM.user_address2#">	
	<cfset qUser.user_city = "#FORM.user_city#">	
	<cfset qUser.user_state = "#FORM.user_state#">	
	<cfset qUser.user_zip = "#FORM.user_zip#">	
	<cfset qUser.user_phone = "#FORM.user_phone#">
	<cfset qUser.marketing_opt_in = "#FORM.marketing_opt_in#">
</cfif>

<cfif REQUEST.user_id EQ 0>
	<cfset VARIABLES.action_url = "create=1">
<cfelse>
	<cfset VARIABLES.action_url = "edit=1">
</cfif>

<div class="box">
	<cfif REQUEST.user_id eq 0>
		<h2>Signup for a Free Account</h2>
		<p>
			
			We need some info to get you started. This account 
			will be used for all your DestinyFinder activity. It's 
			totally confidential
		</p>
	</cfif>

	<cfset form_name = "update-account-form">
	<cfif REQUEST.user_id eq 0>
		<cfset form_name = "signup-form">
	</cfif>
	
	<form action="/auth/?page=user&<cfoutput>#VARIABLES.action_url#</cfoutput>" method="POST" id="<cfoutput>#form_name#</cfoutput>">
		<fieldset>
			<div class="clearfix">
				<label for="user_first_name">First Name</label>
				<div class="input">
					<input type="text" name="user_first_name" id="user_first_name" value="<cfoutput>#HTMLEditFormat(qUser.user_first_name)#</cfoutput>" required="required" />
				</div>
			</div>

			<div class="clearfix">

				<label for="user_last_name">Last Name</label>
				<div class="input">
					<input type="text" name="user_last_name" id="user_last_name" value="<cfoutput>#HTMLEditFormat(qUser.user_last_name)#</cfoutput>" required="required" />
				</div>
			</div>


			<div class="clearfix">
				<label for="user_email">Email Address</label>
				<div class="input">
					<input type="email" name="user_email" id="user_email" value="<cfoutput>#HTMLEditFormat(qUser.user_email)#</cfoutput>" required="required" <cfif REQUEST.user_id GT 0>disabled="disabled"</cfif> />
					<span class="help-inline">Your e-mail is used for logging in</span>
				</div>
			</div>


			<cfif REQUEST.user_id EQ 0>
				<div class="clearfix">
					<label for="user_email2">Confirm Email</label>
					<div class="input">
						<input type="email" name="user_email2" id="user_email2" value="<cfoutput>#HTMLEditFormat(qUser.user_email)#</cfoutput>" required="required" />
					</div>
				</div>
			</cfif>

			<div class="clearfix">
				<label for="user_password">Password</label>
				<div class="input">
					<input type="password" name="user_password" id="user_password"<cfif REQUEST.user_id EQ 0> required="required"</cfif> />
				</div>
			</div>

			<div class="clearfix">
				<label for="user_password2">Confirm Password</label>
				<div class="input">
					<input type="password" name="user_password2" id="user_password2"<cfif REQUEST.user_id EQ 0> required="required"</cfif> />
				</div>
			</div>

			<div class="clearfix">
				<div class="input">
					<ul class="inputs-list">
						<cfif REQUEST.user_id EQ 0>
							<li>
								<label>
									<input type="checkbox" name="agree_to_terms" value="1" id="agree-to-terms" />
									<span>I agree to the <a href="/profile/?gateway=1" target="_blank">Terms of Use</a></span>
								</label>
							</li>
						</cfif>
						<li>
							<label>
								<input type="checkbox" name="marketing_opt_in" value="1" id="marketing-opt-in" <cfif qUser.marketing_opt_in EQ 1>checked="checked"</cfif> />
								<span>Yes, I want to receive updates from Destiny Finder</span>
							</label>
						</li>
					</ul>
				</div>
			</div>
		</fieldset>

		<div class="form-actions">
			<cfif REQUEST.user_id EQ 0>
				<input type="submit" name="submit" value="Create Account" class="btn primary" />
			<cfelse>
				<a href="/profile/?page=profiler" class="btn danger">Cancel Update</a>
 				<input type="submit" name="submit" value="Update Account Settings" class="btn primary" />		
			</cfif>
		</div>

	    <cfif REQUEST.user_id EQ 0>
			<p>Already have an account? <a href="/auth/?page=user">Login here</a></p>
		</cfif>

	</form>
</div>