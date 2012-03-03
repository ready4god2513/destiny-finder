
<h2>I feel most drawn to impact people with the following ethnicity:</h2>
<br />
<h3>Instructions</h3>
<p>Select one that is truest for you.</p>

<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
	<div class="controls">
		<div class="inputs-list">
			<label class="radio"><input type="radio" name="impact_ethnicity" value="Caucasian">Caucasian</label>
			<label class="radio"><input type="radio" name="impact_ethnicity" value="Black">Black</label>
			<label class="radio"><input type="radio" name="impact_ethnicity" value="Hispanic">Hispanic</label>
			<label class="radio"><input type="radio" name="impact_ethnicity" value="Asian and Pacific Islander">Asian and Pacific Islander</label>
			<label class="radio"><input type="radio" name="impact_ethnicity" value="Middle Eastern/Arabic">Middle Eastern/Arabic</label>
			<label class="radio"><input type="radio" name="impact_ethnicity" value="Mixed">Mixed</label>
			<label class="radio"><input type="radio" name="impact_ethnicity" value="Any">Any</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="impact_ethnicity" value="None/Other">None/Other</label>
			<label class="checkbox"><input type="text" name="impact_ethnicity" placeholder="Other ethnicity"/></label>
		</div>
	</div>

	<!---CLIP #1--->
	<div class="form-actions"><input class="btn btn-primary" type="submit" name="submit" value="Next Step" /></div>
	<input type="hidden" value="<cfoutput>#Encrypt('21,impact_subculture-5-5,impact_ethnicity,impact_ethnicity','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
</form>
<br class="clear"/>

	

<!---
<div style="float:left;margin:10px 40px 0px 40px;">
Instructions:<br />
Pick the one sphere (A-E) you're drawn to impact. Then pick the two sub-spheres you are drawn to impact. Only use undecided if you're really not sure.
Fill in the "Other" blank if you don't find an answer close enough to your interest.
</div>

--->