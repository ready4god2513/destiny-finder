<cfparam name="ATTRIBUTES.processing_url" default="index.cfm">
<cfparam name="ATTRIBUTES.destination_url" default="index.cfm">

<cfset obj_login = CreateObject("component","cfcs.login")>


<cfif isDefined('FORM.user_name')>
	<!--- RUN THE LOGIN FUNCTION --->
    <cfset VARIABLES.process_login = obj_login.login_form_action()>
    
    <cfif VARIABLES.process_login EQ "login_fail">
		<div class="alert-message error">
			<a class="close" href="#">×</a>
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
	<form action="<cfoutput>#ATTRIBUTES.processing_url#</cfoutput>" action="POST" id="login-form">
		<fieldset>
			<div class="form-field">
				<label for="user_email">Email Address</label>
				<input type="email" name="user_email" id="user_email" required="required" />
			</div>
			<div class="form-field">
				<label for="user_password">Password</label>
				<input type="password" name="user_password" id="user_password" required="required" />
			</div>
		</fieldset>
		
		<div class="actions">
			<input type="submit" name="submit" value="Create Account" class="btn primary" />
		</div>
	</form>
	
	<p>Not a user yet? <a href="/auth/?page=user&create=1">Click here to create a free account.</a></p>
</div>
	
