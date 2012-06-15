<h5>18. I feel most drawn to impact people with the following ethnicity:</h5>
<cfinclude template="instructions.cfm">

<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
	<div class="controls">
		<div class="inputs-list">
			<label class="radio"><input type="radio" name="impact_ethnicity" value="Caucasian">Caucasian</label>
			<label class="radio"><input type="radio" name="impact_ethnicity" value="Black">Black</label>
			<label class="radio"><input type="radio" name="impact_ethnicity" value="Hispanic">Hispanic</label>
			<label class="radio"><input type="radio" name="impact_ethnicity" value="Asian and Pacific Islander">Asian and Pacific Islander</label>
			<label class="radio"><input type="radio" name="impact_ethnicity" value="Middle Eastern/Arabic">Middle Eastern</label>
			<label class="radio"><input type="radio" name="impact_ethnicity" value="Mixed">Mixed</label>
			<label class="radio"><input type="radio" name="impact_ethnicity" value="Any">Any</label>
			<label class="radio"><input type="text" name="impact_ethnicity" placeholder="other"/></label>
			<label class="radio"><input type="radio" name="impact_ethnicity" value="undecided">Undecided</label>
		</div>
	</div>

	<!---CLIP #1--->
	<div class="form-actions"><input class="btn btn-primary" type="submit" name="submit" value="Next Step" /></div>
	<input type="hidden" value="<cfoutput>#Encrypt('21,impact_subculture-5-5,impact_ethnicity,impact_ethnicity','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
</form>