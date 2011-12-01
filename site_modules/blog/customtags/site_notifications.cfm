<cfoutput>
	
	<cfparam name="ATTRIBUTES.message" default="">
	
	<div class="site_notification">
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
		
		<cfcase value="username exists">
			An account has already been created with that email address.  Please try again.
		</cfcase>
		
		<cfcase value="upload fail">
			Your file could not be uploaded properly, please try again.
		</cfcase>
		
	</cfswitch>
	</div>
	
</cfoutput>