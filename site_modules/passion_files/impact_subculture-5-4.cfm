
<h2>I feel most drawn to impact the following subculture:</h2>
<br />

<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
	<div class="controls">
		<div class="inputs-list">
			<label class="radio"><input type="radio" name="drawn_to_impact_ethnicity" checked value="Metro Urban/Hipster">Metro Urban/Hipster</label>
			<label class="radio"><input type="radio" name="drawn_to_impact_ethnicity" value="Yuppie">Yuppie</label>
			<label class="radio"><input type="radio" name="drawn_to_impact_ethnicity" value="Student">Student</label>
			<label class="radio"><input type="radio" name="drawn_to_impact_ethnicity" value="Punk/Hardcore/Skater">Punk/Hardcore/Skater</label>
			<label class="radio"><input type="radio" name="drawn_to_impact_ethnicity" value="Rave/Dance Club">Rave/Dance Club</label>
			<label class="radio"><input type="radio" name="drawn_to_impact_ethnicity" value="Rap/Hip Hop">Rap/Hip Hop</label>
			<label class="radio"><input type="radio" name="drawn_to_impact_ethnicity" value="Young Adult">Young Adult</label>
			<label class="radio"><input type="radio" name="drawn_to_impact_ethnicity" value="Country/Western">Country/Western</label>
			<label class="radio"><input type="radio" name="drawn_to_impact_ethnicity" value="LGBT">LGBT</label>
			<label class="radio"><input type="radio" name="drawn_to_impact_ethnicity" value="High Society">High Society</label>
			<label class="radio"><input type="radio" name="drawn_to_impact_ethnicity" value="Celebrity">Celebrity</label>
			<label class="checkbox"><input type="text" name="drawn_to_impact_ethnicity" placeholder="Other subculture"/></label>
		</div>
	</div>
	
	<!---CLIP #1--->
	<div class="form-actions"><input class="btn btn-primary" type="submit" name="submit" value="Next Step" /></div>
	<input type="hidden" value="<cfoutput>#Encrypt('22,impact_religious-5-5','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
</form>