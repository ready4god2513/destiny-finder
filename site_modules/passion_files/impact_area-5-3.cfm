<h5>16. I feel most drawn to impact the following area(s):</h5>
<cfinclude template="instructions.cfm">
<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
	<div class="controls">
		<div class="inputs-list">
			<label class="radio"><input name="impact_area" type="radio" value="Inner City or Downtown">Inner City or Downtown</label>
			<label class="radio"><input name="impact_area" type="radio" value="Urban or City">Urban or City</label>
			<label class="radio"><input name="impact_area" type="radio" value="Suburban or Residential">Suburban or Residential</label>
			<label class="radio"><input name="impact_area" type="radio" value="Rural or Country">Rural or Country</label>
			<label class="radio"><input type="text" name="impact_area" placeholder="Other sphere"/></label>
			<label class="radio"><input type="radio" name="impact_area" value="undecided">Undecided</label>
		</div>
	</div>

	<!---CLIP #1--->
	<div class="form-actions"><input class="btn btn-primary" type="submit" name="submit" value="Next Step" /></div>
	<input type="hidden" value="<cfoutput>#Encrypt('20,impact_ethnicity-5-4,impact_area,impact_area','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
</form>