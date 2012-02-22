<cfset objAssessment = CreateObject('component','cfcs.assessment')>

<cfoutput>
	<cfif isDefined('FORM.submit')>
		#objAssessment.invite_friend(user_id="#REQUEST.user_id#")#
		
		<div class="alert-message block-message success">
			Awesome!  Thank you.  <strong>Your friend will be notified.</strong>  
			You will be sent the results as soon as your friend completes the test.
		</div>
		
	</cfif>
	
	<h2>Invite a Friend</h2>
	<p>
		Ask a friend to take the test on your behalf to gain a better understanding of how
		your gifts are viewed by your peers.
	</p>
	
	<form action="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#" method="post" name="profile" enctype="multipart/form-data">
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
				</div>
			</div>
		</fieldset>
		<div class="form-actions">
			<input type="submit" name="submit" value="Invite Friend" class="btn primary" />
		</div>
	</form>
</cfoutput>