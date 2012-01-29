<cfset obj_queries = CreateObject("component","cfcs.queries") />
<cfset user = CreateObject("component","cfcs.users") />

<cfparam name="URL.gateway" default="1">
<cfparam name="VARIABLES.page" default="user">
<cfparam name="VARIABLES.gateway_id" default="">
<cfparam name="VARIABLES.subtitle" default="Profile">

<cfparam name="URL.page" default="#VARIABLES.page#">

<!--- RETRIEVE THE PAGE CONTENT --->
<cfset qContent = obj_queries.get_content(page="#URL.page#")>
	
<cfif isDefined("URL.reset") AND isDefined("URL.id") AND isDefined("URL.key")>
	<cfset authUser = user.findUserByIdAndResetKey(id = URL.id, key = URL.key) />
	<cfset login = CreateObject("component","cfcs.login") />
	<cfset login.forceLogin(user = authUser, redirect_after = "/auth/?page=user") />
</cfif>

<cfmodule template="../../templates/site_wrapper.cfm"
	page_name="#qContent.content_name#"
    url_page="#URL.page#"
	gateway_id="#URL.gateway#"
	header_image="#qContent.content_header_img#"
	html_title="#qContent.content_html_title#"
	meta_desc="#qContent.content_meta_desc#">
	
	<section id="main">
		
		<cfif isDefined("FORM.user_name")>
			<cfif user.sendResetInstructions(email = #FORM.user_name#)>
				<cfmodule 
					template="/site_modules/site_notifications.cfm" 
					success="password_reset">
			<cfelse>
				<cfmodule 
					template="/site_modules/site_notifications.cfm" 
					message="email_not_found">
			</cfif>
		</cfif>
		
		<div class="row">
			<h2 class="span6">Password Reset</h2>
			<div class="pull-right">
				<a href="/auth/index.cfm?page=user" class="btn info">Back to Login</a>
			</div>
		</div>
		
		<p>
			Just let us know what e-mail address you used when you signed
			up for a <strong>Destiny Finder</strong> account and we will
			e-mail you instructions to login and reset your password.
		</p>
		
		<form action="/auth/password-reset/" method="POST">
			<fieldset>
				<div class="clearfix">
					<label for="user_name">Email Address</label>
					<div class="input">
						<input type="email" name="user_name" id="user_name" required="required" />
					</div>
				</div>
			</fieldset>

			<div class="actions">
				<input type="submit" name="submit" value="Send me Reset Instructions" class="btn primary" />
			</div>
		</form>
	</section>

</cfmodule>