<h2>The workplace role I feel most comfortable with is:</h2>
<br />
<h3>Instructions</h3>
<p>Choose two answers that are truest for you.</p>

<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
	<div class="controls">
		<div class="inputs-list">
			<label class="checkbox"><input type="checkbox" class="checkbox" name="role_workplace" value="Worker or Laborer">Worker or Laborer</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="role_workplace" value="Administrator or Facilitator">Administrator or Facilitator</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="role_workplace" value="Manager or Director">Manager or Director</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="role_workplace" value="Associate Leader">Associate Leader</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="role_workplace" value="Primary Leader">Primary Leader</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="role_workplace" value="Regional Leader">Regional Leader</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="role_workplace" value="None/Other">None/Other</label>
			<label class="checkbox"><input type="text" name="role_workplace" placeholder="Other workplace role"/></label>
		</div>
	</div>
	<!---CLIP #1--->
	<div class="form-actions"><input class="btn btn-primary" type="submit" name="submit" value="Next Step" /></div>
	<input type="hidden" value="<cfoutput>#Encrypt('18,impact_age_group-5-1,role_workplace,role_workplace','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
</form>
<br class="clear"/>

	