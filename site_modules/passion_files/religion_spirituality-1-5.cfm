
<h2><cfoutput>#(VARIABLES.vCount - 1)#</cfoutput>. Religion and Spirituality</h2>
<br />
<h3>Instructions</h3>
<p>Pick the two sub-spheres you are drawn to impact. Only use undecided if You're really not sure.</p>

<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
	<div class="input">
		<ul class="inputs-list">
			<li><label><input type="checkbox" name="religion_spirituality" value="Administration">Administration</label></li>
			<li><label><input type="checkbox" name="religion_spirituality" value="Education and Training">Education and Training</label></li>
			<li><label><input type="checkbox" name="religion_spirituality" value="Church Leadership">Church Leadership</label></li>
			<li><label><input type="checkbox" name="religion_spirituality" value="Non-Profit Organizations">Non-Profit Organizations</label></li>
			<li><label><input type="checkbox" name="religion_spirituality" value="Para-church Ministry">Para-church Ministry</label></li>
			<li><label><input type="checkbox" name="religion_spirituality" value="Outreach and Missions">Outreach and Missions</label></li>
			<li><label><input type="checkbox" name="religion_spirituality" value="Undecided">Undecided</label></li>
		</ul>
	</div>

	<!---CLIP #1--->
	<div class="form-actions"><input class="btn primary" type="submit" name="submit" value="Next Step" /></div>
	<input type="hidden" value="<cfoutput>#Encrypt('7,causes_societal-2-1,religion_spirituality,sphere_sub1','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
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