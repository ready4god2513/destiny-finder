

<h2>Family and Individual</h2>
<br />
<h3>Instructions</h3>
<p>Pick the two sub-spheres you are drawn to impact. Only use undecided if You're really not sure.</p>

<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
	<div class="input">
		<ul class="inputs-list">
			<li><label><input type="checkbox" name="family" value="Family">Family</label></li>
			<li><label><input type="checkbox" name="family" value="Education">Education</label></li>
			<li><label><input type="checkbox" name="family" value="Health and Wellness">Health and Wellness</label></li>
			<li><label><input type="checkbox" name="family" value="Therapy and Social Work">Therapy and Social Work</label></li>
			<li><label><input type="checkbox" name="family" value="Senior Care">Senior Care</label></li>
			<li><label><input type="checkbox" name="family" value="Undecided">Undecided</label></li>
		</ul>
	</div>

	<!---CLIP #1--->
	<div class="actions"><input class="btn primary" type="submit" name="submit" value="Next Step" /></div>
	<input type="hidden" value="<cfoutput>#Encrypt('3,causes_societal-2-1,family,sphere_sub1','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
</form>
<br class="clear"/>
<br class="clear"/>
<cfset progbar= (308 / 27) * (VARIABLES.vCount - 1)>
	<div class="percent_complete_label">% of survey completed</div><div class="percent_completed"><img src="/site_images/progbar_pix.png" width="<cfoutput>#progbar#</cfoutput>" height="21"></div>

