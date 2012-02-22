
<h2><cfoutput>#(VARIABLES.vCount - 1)#</cfoutput>. Religious Orientation</h2>
<br />
<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
	<div class="input">
		<ul class="inputs-list">
			<li><label><input type="radio" name="family_individual" checked value="Hindu">Hindu</label></li>
			<li><label><input type="radio" name="family_individual" value="Buddhist">Buddhist</label></li>
			<li><label><input type="radio" name="family_individual" value="Moslem">Moslem</label></li>
			<li><label><input type="radio" name="family_individual" value="Jewish">Jewish</label></li>
			<li><label><input type="radio" name="family_individual" value="Christian">Christian</label></li>
			<li><label><input type="radio" name="family_individual" value="Atheist/Post-Christian">Atheist/Post-Christian</label></li>
			<li><label><input type="radio" name="family_individual" value="Agnostic">Agnostic</label></li>
			<li><label><input type="radio" name="family_individual" value="Higher Power/Mishmash">Higher Power/Mishmash</label></li>
			<li><label><input type="radio" name="family_individual" value="New Age">New Age</label></li>
			<li><label><input type="radio" name="family_individual" value="Occult/Wicca/Satanic">Occult/Wicca/Satanic</label></li>
			<li><label><input type="radio" name="family_individual" value="None">None</label></li>
		</ul>
	</div>


	<!---CLIP #1--->
	<div class="form-actions"><input class="btn primary" type="submit" name="submit" value="Next Step" /></div>
	<input type="hidden" value="<cfoutput>#Encrypt('23,development-6-1','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
</form>
<br class="clear"/>
<cfset progbar= (308 / 26) * (VARIABLES.vCount - 1)>
	<div class="percent_complete_label">% of survey completed</div><div class="percent_completed"><img src="/assets/images/progbar_pix.png" width="#progbar#" height="21"></div>

<!---
<div style="float:left;margin:10px 40px 0px 40px;">
Instructions:<br />
Pick the one sphere (A-E) you're drawn to impact. Then pick the two sub-spheres you are drawn to impact. Only use undecided if you're really not sure.
Fill in the "Other" blank if you don't find an answer close enough to your interest.
</div>

--->