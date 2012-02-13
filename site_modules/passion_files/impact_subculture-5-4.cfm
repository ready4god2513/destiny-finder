
<h2><cfoutput>#(VARIABLES.vCount - 1)#</cfoutput>. I feel most drawn to impact the following subculture:</h2>
<br />

<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
	<div class="input">
		<ul class="inputs-list">
			<li><label><input type="radio" name="drawn_to_impact_ethnicity" checked value="Metro Urban/Hipster">Metro Urban/Hipster</label></li>
			<li><label><input type="radio" name="drawn_to_impact_ethnicity" value="Yuppie">Yuppie</label></li>
			<li><label><input type="radio" name="drawn_to_impact_ethnicity" value="Student">Student</label></li>
			<li><label><input type="radio" name="drawn_to_impact_ethnicity" value="Punk/Hardcore/Skater">Punk/Hardcore/Skater</label></li>
			<li><label><input type="radio" name="drawn_to_impact_ethnicity" value="Rave/Dance Club">Rave/Dance Club</label></li>
			<li><label><input type="radio" name="drawn_to_impact_ethnicity" value="Rap/Hip Hop">Rap/Hip Hop</label></li>
			<li><label><input type="radio" name="drawn_to_impact_ethnicity" value="Young Adult">Young Adult</label></li>
			<li><label><input type="radio" name="drawn_to_impact_ethnicity" value="Country/Western">Country/Western</label></li>
			<li><label><input type="radio" name="drawn_to_impact_ethnicity" value="LGBT">LGBT</label></li>
			<li><label><input type="radio" name="drawn_to_impact_ethnicity" value="High Society">High Society</label></li>
			<li><label><input type="radio" name="drawn_to_impact_ethnicity" value="Celebrity">Celebrity</label></li>
			<li><label><input type="radio" name="drawn_to_impact_ethnicity" value="None">None</label></li>
		</ul>
	</div>
	
	<!---CLIP #1--->
	<div class="actions"><input class="btn primary" type="submit" name="submit" value="Next Step" /></div>
	<input type="hidden" value="<cfoutput>#Encrypt('22,impact_religious-5-5','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
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