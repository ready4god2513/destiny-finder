<h5>19. I feel most drawn to impact the following subculture:</h5>
<cfinclude template="instructions.cfm">

<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
	<div class="controls">
		<div class="inputs-list">
			<label class="radio"><input type="radio" name="drawn_to_impact_ethnicity" checked value="Urban Hipster">Urban Hipster</label>
			<label class="radio"><input type="radio" name="drawn_to_impact_ethnicity" checked value="Urban Professional">Urban Professional</label>
			<label class="radio"><input type="radio" name="drawn_to_impact_ethnicity" checked value="High School">High School</label>
			<label class="radio"><input type="radio" name="drawn_to_impact_ethnicity" checked value="Young Adult">Young Adult</label>
			<label class="radio"><input type="radio" name="drawn_to_impact_ethnicity" checked value="College Student">College Student</label>
			<label class="radio"><input type="radio" name="drawn_to_impact_ethnicity" checked value="Hardcore or Skater">Hardcore or Skater</label>
			<label class="radio"><input type="radio" name="drawn_to_impact_ethnicity" checked value="Dance Club Scene">Dance Club Scene</label>
			<label class="radio"><input type="radio" name="drawn_to_impact_ethnicity" checked value="Rap and Hip Hop">Rap and Hip Hop</label>
			<label class="radio"><input type="radio" name="drawn_to_impact_ethnicity" checked value="Country Western">Country Western</label>
			<label class="radio"><input type="radio" name="drawn_to_impact_ethnicity" checked value="LGBT (Lesbian, Gay, Bi-sexual, Transgender)">LGBT (Lesbian, Gay, Bi-sexual, Transgender)</label>
			<label class="radio"><input type="radio" name="drawn_to_impact_ethnicity" checked value="Wealthy and Influential">Wealthy and Influential</label>
			<label class="radio"><input type="radio" name="drawn_to_impact_ethnicity" checked value="Celebrity">Celebrity</label>
			<label class="radio"><input type="radio" name="drawn_to_impact_ethnicity"><input type="text" name="drawn_to_impact_ethnicity" placeholder="Other sphere"/></label>
			<label class="radio"><input type="radio" name="drawn_to_impact_ethnicity" value="undecided">Undecided</label>
		</div>
	</div>
	
	<!---CLIP #1--->
	<div class="form-actions"><input class="btn btn-primary" type="submit" name="submit" value="Next Step" /></div>
	<input type="hidden" value="<cfoutput>#Encrypt('22,impact_religious-5-5','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
</form>