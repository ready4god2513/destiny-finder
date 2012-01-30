<cfset objAssessment = CreateObject('component','cfcs.assessment')>

<cfoutput>
<cfif isDefined('FORM.submit')>
	#objAssessment.invite_friend(user_id="#REQUEST.user_id#")#
	<cflocation url="index.cfm?page=invmod&assessment_id=1&gift_type_id=1">
	<cfabort>
</cfif>

<p><a href="index.cfm?page=invmod&amp;assessment_id=1&amp;gift_type_id=1" class="btn info">Back</a></p>

<form action="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#" method="post" name="profile">
	<fieldset>
		<div class="clearfix">
			<label for="user_first_name">First Name</label>
			<div class="input">
				<input type="email" name="user_first_name" id="user_first_name" required="required" />
			</div>
		</div>
		<div class="clearfix">
			<label for="user_last_name">Last Name</label>
			<div class="input">
				<input type="email" name="user_last_name" id="user_last_name" required="required" />
			</div>
		</div>
		<div class="clearfix">
			<label for="user_email">Email Address</label>
			<div class="input">
				<input type="email" name="user_email" id="user_email" required="required" />
			</div>
		</div>
	</fieldset>
	
	<div class="actions">
		<input type="submit" name="submit" value="Send Invitation" class="btn primary" />
	</div>
</form>

</cfoutput>