
<h2>Culture and Lifestyle</h2>
<br />

<h3>Instructions</h3>
<p>Pick the two sub-spheres you are drawn to impact. Only use undecided if You're really not sure.</p>
<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
	<div class="input">
		<ul class="inputs-list">
			<li><label><input type="checkbox" name="culture_lifestyle" value="Cultural Expression">Cultural Expression</label></li>
			<li><label><input type="checkbox" name="culture_lifestyle" value="Entertainment, Sports and Games">Entertainment, Sports and Games </label></li>
			<li><label><input type="checkbox" name="culture_lifestyle" value="Performing and Visual Arts">Performing and Visual Arts</label></li>
			<li><label><input type="checkbox" name="culture_lifestyle" value="Traditional Media">Traditional Media</label></li>
			<li><label><input type="checkbox" name="culture_lifestyle" value="Digital Media">Digital Media</label></li>
			<li><label><input type="checkbox" name="culture_lifestyle" value="Undecided">Undecided</label></li>
		</ul>
	</div>

	<!---CLIP #1--->
	<div class="actions"><input class="btn primary" type="submit" name="submit" value="Next Step" /></div>
	<input type="hidden" value="<cfoutput>#Encrypt('4,causes_societal-2-1,culture_lifestyle,sphere_sub1','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
</form>
<br class="clear"/>
<cfset progbar= (308 / 27) * (VARIABLES.vCount - 1)>
	<div class="percent_complete_label">% of survey completed</div><div class="percent_completed"><img src="/site_images/progbar_pix.png" width="<cfoutput>#progbar#</cfoutput>" height="21"></div>

<!---
<div style="float:left;margin:10px 40px 0px 40px;">
Instructions:<br />
Pick the one sphere (A-E) you're drawn to impact. Then pick the two sub-spheres you are drawn to impact. Only use undecided if you're really not sure.
Fill in the "Other" blank if you don't find an answer close enough to your interest.
</div>

--->