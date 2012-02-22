<cfoutput>
	
	<cfparam name="ATTRIBUTES.message" default="" />
	<cfparam name="ATTRIBUTES.success" default="" />
	
	<cfif Len(ATTRIBUTES.success) GT 0>
		<div class="alert alert-success">
			<cfswitch expression="#ATTRIBUTES.success#">
				<cfcase value="password_reset">
					You will receive an email with instructions about how to reset your password in a few minutes.
				</cfcase>
				
				<cfcase value="profile_updated">
					Your profile has been updated.
				</cfcase>
			</cfswitch>
		</div>
	</cfif>
		
	<cfif Len(ATTRIBUTES.message) GT 0>
		<div class="alert alert-error">
			<cfswitch expression="#ATTRIBUTES.message#">

				<cfcase value="login_fail">
					Login Failed.  Please Try Again
				</cfcase>

				<cfcase value="profile_created">
					Your profile has been created.
				</cfcase>

				<cfcase value="profile_updated">
					Your profile has been updated.
				</cfcase>

				<cfcase value="password_mismatch">
					Your passwords did not match.  Please try again.
				</cfcase>

				<cfcase value="email_not_found">
					We couldn't find an account for the requested e-mail address
				</cfcase>

				<cfcase value="password_reset">
					An account has already been created with that email address.  Please try again.
				</cfcase>

				<cfcase value="username exists">
					An account has already been created with that email address.  Please try again.
				</cfcase>

				<cfcase value="upload fail">
					Your file could not be uploaded properly, please try again.
				</cfcase>

			</cfswitch>
		</div>
	</cfif>
	
	
	
</cfoutput>