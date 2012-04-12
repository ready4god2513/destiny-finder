<h5>15. I feel most drawn to impact the following age group:</h5>
<cfinclude template="instructions.cfm">

<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
	<div class="controls">
		<div class="inputs-list">
			<label class="radio"><input type="radio" name="impact_age_group" value="Children (0-12)">0-12 (Children)</label>
			<label class="radio"><input type="radio" name="impact_age_group" value="Youth (13-18)">13-18 (Youth)</label>
			<label class="radio"><input type="radio" name="impact_age_group" value="Young Adult (18-29)">18-29 (Young Adult)</label>
			<label class="radio"><input type="radio" name="impact_age_group" value="Gen X (30-45)">30-45 (Gen X)</label>
			<label class="radio"><input type="radio" name="impact_age_group" value="Boomer (46-65)">46-65 (Boomer)</label>
			<label class="radio"><input type="radio" name="impact_age_group" value="Senior (65+)">65+ (Senior)</label>
			<label class="radio"><input type="text" name="impact_age_group" placeholder="Other sphere"/></label>
			<label class="radio"><input type="radio" name="impact_age_group" value="undecided">Undecided</label>
		</ul>
	</div>


	<!---CLIP #1--->
	<div class="form-actions"><input class="btn btn-primary" type="submit" name="submit" value="Next Step" /></div>
	<input type="hidden" value="<cfoutput>#Encrypt('19,impact_region-5-2,impact_age_group,impact_age_group','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
</form>