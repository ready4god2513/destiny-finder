
<h2>I feel most drawn to impact the following area(s)</h2>
<br />
<h3>Instructions</h3>
<p>Select one that is truest for you.</p>
<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
	<div class="input">
		<ul class="inputs-list">
			<li><label><input name="area" type="radio" value="inner city">inner city </label></li>
			<li><label><input name="area" type="radio" value="urban">urban </label></li>
			<li><label><input name="area" type="radio" value="suburban">suburban </label></li>
			<li><label><input name="area" type="radio" value="undecided">undecided </label></li>
		</ul>
	</div>

	<!---CLIP #1--->
	<div class="actions"><input class="btn primary" type="submit" name="submit" value="Next Step" /></div>
	<input type="hidden" value="<cfoutput>#Encrypt('20,impact_ethnicity-5-4,area,impact_area','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
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