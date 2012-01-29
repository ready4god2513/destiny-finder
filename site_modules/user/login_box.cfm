<cfset obj_login = CreateObject("component","cfcs.login")>

<cfif isDefined("FORM.user_name")>
	<!--- RUN THE LOGIN FUNCTION --->
    <cfset VARIABLES.process_login = obj_login.login_form_action()>
    
    <cfif VARIABLES.process_login EQ "login_fail">
		<div class="alert-message block-message error">
			<p><strong>Login Failed.</strong> We couldn't find an account in our system with the username and password you provided.</p>
		</div>
    <cfelse>
        <cflocation url="/profile/?page=profiler" addtoken="no">
        <cfabort>
    </cfif>
</cfif>

<div class="row">
	
	<div class="span7">
		<h2>Sign up for a Free Account</h2>
		<p>
			
			We need some info to get you started. This account 
			will be used for all your DestinyFinder activity. It's 
			totally confidential
		</p>
		<form action="/auth/?page=user&amp;create=1" method="POST" id="signup-form">
			<fieldset>
				<div class="clearfix">
					<label for="user_first_name">First Name</label>
					<div class="input">
						<input type="text" name="user_first_name" id="user_first_name" required="required" />
					</div>
				</div>

				<div class="clearfix">

					<label for="user_last_name">Last Name</label>
					<div class="input">
						<input type="text" name="user_last_name" id="user_last_name" required="required" />
					</div>
				</div>


				<div class="clearfix">
					<label for="user_email">Email Address</label>
					<div class="input">
						<input type="email" name="user_email" id="user_email" required="required" />
						<span class="help-inline">Your e-mail is used for logging in</span>
					</div>
				</div>


				<cfif REQUEST.user_id EQ 0>
					<div class="clearfix">
						<label for="user_email2">Confirm Email</label>
						<div class="input">
							<input type="email" name="user_email2" id="user_email2" required="required" />
						</div>
					</div>
				</cfif>

				<div class="clearfix">
					<label for="user_password">Password</label>
					<div class="input">
						<input type="password" name="user_password" id="user_password" required="required" />
					</div>
				</div>

				<div class="clearfix">
					<label for="user_password2">Confirm Password</label>
					<div class="input">
						<input type="password" name="user_password2" id="user_password2" required="required" />
					</div>
				</div>

				<div class="clearfix">
					<div class="input">
						<ul class="inputs-list">
							<li>
								<label>
									<input type="checkbox" name="agree_to_terms" value="1" id="agree-to-terms" />
									<span>I agree to the <a href="/profile/?gateway=1" target="_blank">Terms of Use</a></span>
								</label>
							</li>
							<li>
								<label>
									<input type="checkbox" name="marketing_opt_in" value="1" id="marketing-opt-in" />
									<span>Yes, I want to receive updates from Destiny Finder</span>
								</label>
							</li>
						</ul>
					</div>
				</div>
			</fieldset>

			<div class="actions">
				<input type="submit" name="submit" value="Create Account" class="btn primary" />
			</div>
		</form>
	</div>
	
	<div class="span7 offset1">
		<h2>Login to Existing Account</h2>
		<form action="/auth/" method="POST" id="login-form">
			<fieldset>
				<div class="clearfix">
					<label for="user_name">Email Address</label>
					<div class="input">
						<input type="email" name="user_name" id="user_name" required="required" />
					</div>
				</div>
				<div class="clearfix">
					<label for="user_password">Password</label>
					<div class="input">
						<input type="password" name="password" id="user_password" required="required" />
					</div>
				</div>
			</fieldset>

			<div class="actions">
				<input type="submit" name="submit" value="Login" class="btn primary" />
			</div>
		</form>
		
		<p>Forget your password?  <a href="/auth/password-reset">Reset it here</a></p>
	</div>
</div>
	
