
<h2><cfoutput>#(VARIABLES.vCount - 1)#</cfoutput>. Religious Orientation</h2>
<br />
<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
	<div class="controls">
		<div class="inputs-list">
			<label class="radio"><input type="radio" name="family_individual" checked value="Hindu">Hindu</label>
			<label class="radio"><input type="radio" name="family_individual" value="Buddhist">Buddhist</label>
			<label class="radio"><input type="radio" name="family_individual" value="Moslem">Moslem</label>
			<label class="radio"><input type="radio" name="family_individual" value="Jewish">Jewish</label>
			<label class="radio"><input type="radio" name="family_individual" value="Christian">Christian</label>
			<label class="radio"><input type="radio" name="family_individual" value="Atheist/Post-Christian">Atheist/Post-Christian</label>
			<label class="radio"><input type="radio" name="family_individual" value="Agnostic">Agnostic</label>
			<label class="radio"><input type="radio" name="family_individual" value="Higher Power/Mishmash">Higher Power/Mishmash</label>
			<label class="radio"><input type="radio" name="family_individual" value="New Age">New Age</label>
			<label class="radio"><input type="radio" name="family_individual" value="Occult/Wicca/Satanic">Occult/Wicca/Satanic</label>
			<label class="radio"><input type="radio" name="family_individual" value="None">None</label>
		</div>
	</div>


	<!---CLIP #1--->
	<div class="form-actions"><input class="btn btn-primary" type="submit" name="submit" value="Next Step" /></div>
	<input type="hidden" value="<cfoutput>#Encrypt('23,development-6-1','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
</form>