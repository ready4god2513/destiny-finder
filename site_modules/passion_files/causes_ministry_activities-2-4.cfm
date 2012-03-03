<h2>I am most passionate about impacting others through the following ministry activities.</h2>
<br />
<h3>Instructions</h3>
<p>Select two that are truest for you.</p>

<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">

	<div class="controls">
		<div class="inputs-list">
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_ministry_activities" value="Reaching the lost" />Reaching the lost </label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_ministry_activities" value="Healing the sick" />Healing the sick</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_ministry_activities" value="Casting out demons" />Casting out demons </label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_ministry_activities" value="Intercession and prayer" />Intercession and prayer</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_ministry_activities" value="Healing the brokenhearted" />Healing the brokenhearted</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_ministry_activities" value="Serving the poor" />Serving the poor</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_ministry_activities" value="Caring for widows and orphans" />Caring for widows and orphans </label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_ministry_activities" value="None/Other">None/Other</label>
			<label class="checkbox"><input type="text" name="causes_ministry_activities" placeholder="Other ministry activity"/></label>
		</div>
	</div>

	<!---CLIP #1--->
	<div class="form-actions"><input class="btn btn-primary" type="submit" name="submit" value="Next Step" /></div>
	<input type="hidden" value="<cfoutput>#Encrypt('11,causes_communication-2-5,causes_ministry_activities,causes_ministry_activities','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
</form>
<br class="clear"/>

	

<!---
<div style="float:left;margin:10px 40px 0px 40px;">
Instructions:<br />
Pick the one sphere (A-E) you're drawn to impact. Then pick the two sub-spheres you are drawn to impact. Only use undecided if you're really not sure.
Fill in the "Other" blank if you don't find an answer close enough to your interest.
</div>

--->