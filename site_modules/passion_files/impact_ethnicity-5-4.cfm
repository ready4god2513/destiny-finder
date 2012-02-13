
<h2><cfoutput>#(VARIABLES.vCount - 1)#</cfoutput>. I feel most drawn to impact people with the following ethnicity:</h2>
<br />
<h3>Instructions</h3>
<p>Select one that is truest for you.</p>

<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
	<div class="input">
		<ul class="inputs-list">
			<li><label><input type="radio" name="ethnicity" value="Caucasian">Caucasian</label></li>
			<li><label><input type="radio" name="ethnicity" value="Black">Black</label></li>
			<li><label><input type="radio" name="ethnicity" value="Hispanic">Hispanic</label></li>
			<li><label><input type="radio" name="ethnicity" value="Asian and Pacific Islander">Asian and Pacific Islander</label></li>
			<li><label><input type="radio" name="ethnicity" value="Middle Eastern/Arabic">Middle Eastern/Arabic</label></li>
			<li><label><input type="radio" name="ethnicity" value="Mixed">Mixed</label></li>
			<li><label><input type="radio" name="ethnicity" value="Any">Any</label></li>
			<li><label><input type="radio" name="ethnicity" value="None">None</label></li>
		</ul>
	</div>

	<!---CLIP #1--->
	<div class="actions"><input class="btn primary" type="submit" name="submit" value="Next Step" /></div>
	<input type="hidden" value="<cfoutput>#Encrypt('21,impact_subculture-5-5,ethnicity,impact_ethnicity','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
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