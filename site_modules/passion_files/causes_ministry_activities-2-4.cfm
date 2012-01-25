
<h2>I am most passionate about impacting others through the following ministry activities.</h2>
<br />
<h3>Instructions</h3>
<p>Select two that are truest for you.</p>

<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">

	<div class="input">
		<ul class="inputs-list">
			<li><label><input type="checkbox" name="ministry_activities" value="Reaching the lost" />Reaching the lost </label></li>
			<li><label><input type="checkbox" name="ministry_activities" value="Healing the sick" />Healing the sick</label></li>
			<li><label><input type="checkbox" name="ministry_activities" value="Casting out demons" />Casting out demons </label></li>
			<li><label><input type="checkbox" name="ministry_activities" value="Intercession and prayer" />Intercession and prayer</label></li>
			<li><label><input type="checkbox" name="ministry_activities" value="Healing the brokenhearted" />Healing the brokenhearted</label></li>
			<li><label><input type="checkbox" name="ministry_activities" value="Serving the poor" />Serving the poor</label></li>
			<li><label><input type="checkbox" name="ministry_activities" value="Caring for widows and orphans" />Caring for widows and orphans </label></li>
			<li><label><input type="checkbox" name="ministry_activities" value="None" />None</label></li>
		</ul>
	</div>

	<!---CLIP #1--->
	<div class="actions"><input class="btn primary" type="submit" name="submit" value="Next Step" /></div>
	<input type="hidden" value="<cfoutput>#Encrypt('11,causes_communication-2-5,ministry_activities,causes_ministry_activities','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
</form>
<br class="clear"/>
<cfset progbar= (308 / 27) * (VARIABLES.vCount - 1)>
	<div class="percent_complete_label">% of survey completed</div><div class="percent_completed"><img src="/assets/images/progbar_pix.png" width="<cfoutput>#progbar#</cfoutput>" height="21"></div>

<!---
<div style="float:left;margin:10px 40px 0px 40px;">
Instructions:<br />
Pick the one sphere (A-E) you're drawn to impact. Then pick the two sub-spheres you are drawn to impact. Only use undecided if you're really not sure.
Fill in the "Other" blank if you don't find an answer close enough to your interest.
</div>

--->