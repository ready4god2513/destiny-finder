<h5>7. I feel most fulfilled helping others when using the following means of communication:</h5>
<cfinclude template="instructions-multiple.cfm">

<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
	<div class="controls">
		<div class="inputs-list">
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_communication" value="Teaching and Training" />Teaching and Training</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_communication" value="Counseling and Consulting" />Counseling and Consulting</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_communication" value="Leading and Guiding" />Leading and Guiding</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_communication" value="Mentoring and Coaching" />Mentoring and Coaching </label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_communication" value="Writing and Publishing" />Writing and Publishing</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_communication" value="Public Speaking and Motivating" />Public Speaking and Motivating</label>
			<label class="checkbox"><input type="text" name="causes_communication" placeholder="other"/></label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_communication" value="undecided">Undecided</label>
		</ul>
	</div>

	<!---CLIP #1--->
	<div class="form-actions"><input class="btn btn-primary" type="submit" name="submit" value="Next Step" /></div>
	<input type="hidden" value="<cfoutput>#Encrypt('12,causes_expressing-2-6,causes_communication,causes_communication','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
</form>