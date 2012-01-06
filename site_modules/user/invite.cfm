<cfset objAssessment = CreateObject('component','cfcs.assessment')>

<cfoutput>
	<cfif isDefined('FORM.submit')>
		#objAssessment.invite_friend(user_id="#REQUEST.user_id#")#
		Submitted
	</cfif>


	<form action="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#" method="post" name="profile" enctype="multipart/form-data">
		<fieldset>
			<div class="form-field">
				<label for="user_first_name">First Name</label>
				<input type="text" name="user_first_name" id="user_first_name" required="required" />
			</div>
			<div class="form-field">
				<label for="user_last_name">Last Name</label>
				<input type="text" name="user_last_name" id="user_last_name" required="required" />
			</div>
			<div class="form-field">
				<label for="user_email">Email Address</label>
				<input type="email" name="user_email" id="user_email" required="required" />
			</div>
		</fieldset>
		<div class="actions">
			<input type="submit" name="submit" value="Invite Friend" class="btn primary" />
		</div>
	</form>
</cfoutput>