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

<div class="box">
	<h2>Beta Version Launches!</h2>
	<p>
		We're excited to unveil the first stage of 
		destinyfinder.com with the Free Destiny Survey! <br />
		Take the first step to discover your destiny.<br />
		We'll be rolling out the rest of this amazing system shortly.
	</p>
	<form action="/auth/index.cfm" method="POST" id="login-form">
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
	
	<p>Don't have an account yet? <a href="/auth/?page=user&create=1">Click here to create a free account.</a></p>
</div>
	
