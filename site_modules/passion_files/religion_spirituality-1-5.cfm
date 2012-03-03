
<h2>Religion and Spirituality</h2>
<br />
<h3>Instructions</h3>
<p>Pick the two sub-spheres you are drawn to impact. Only use undecided if You're really not sure.</p>

<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
	<div class="controls">
		<div class="inputs-list">
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1" value="Administration">Administration</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1" value="Education and Training">Education and Training</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1" value="Church Leadership">Church Leadership</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1" value="Non-Profit Organizations">Non-Profit Organizations</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1" value="Para-church Ministry">Para-church Ministry</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1" value="Outreach and Missions">Outreach and Missions</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1" value="None/Other">None/Other</label>
			<label class="checkbox"><input type="text" name="sphere_sub1" placeholder="Other sphere(s)"/></label>
		</div>
	</div>

	<!---CLIP #1--->
	<div class="form-actions"><input class="btn btn-primary" type="submit" name="submit" value="Next Step" /></div>
	<input type="hidden" value="<cfoutput>#Encrypt('7,causes_societal-2-1,sphere_sub1,sphere_sub1','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
</form>
<br class="clear"/>

	

<!---
<div style="float:left;margin:10px 40px 0px 40px;">
Instructions:<br />
Pick the one sphere (A-E) you're drawn to impact. Then pick the two sub-spheres you are drawn to impact. Only use undecided if you're really not sure.
Fill in the "Other" blank if you don't find an answer close enough to your interest.
</div>

--->