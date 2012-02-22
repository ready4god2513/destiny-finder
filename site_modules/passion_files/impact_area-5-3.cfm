
<h2>I feel most drawn to impact the following area(s)</h2>
<br />
<h3>Instructions</h3>
<p>Select one that is truest for you.</p>
<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
	<div class="controls">
		<div class="inputs-list">
			<label class="radio"><input name="area" type="radio" value="inner city">Inner City </label>
			<label class="radio"><input name="area" type="radio" value="urban">Urban </label>
			<label class="radio"><input name="area" type="radio" value="suburban">Suburban </label>
			<label class="radio"><input name="area" type="radio" value="undecided">Undecided </label>
		</div>
	</div>

	<!---CLIP #1--->
	<div class="form-actions"><input class="btn btn-primary" type="submit" name="submit" value="Next Step" /></div>
	<input type="hidden" value="<cfoutput>#Encrypt('20,impact_ethnicity-5-4,area,impact_area','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
</form>
<br class="clear"/>

	