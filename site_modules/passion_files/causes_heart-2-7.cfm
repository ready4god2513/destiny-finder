<h5>9. My heart direction is mostly:</h5>
<cfinclude template="instructions.cfm">

<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">

	<div class="controls">
		<div class="inputs-list">
			<label class="radio"><input type="radio" name="causes_heart" value="Outward" />Outward beyond my group</label>
			<label class="radio"><input type="radio" name="causes_heart" value="Inward" />Inward within my group</label>
			<label class="radio"><input type="radio" name="causes_heart" value="Upward" />Upward to God</label>
			<label class="radio"><input type="radio" name="causes_heart" value="Downward" />Equal toward all three</label>
			<label class="radio"><input type="radio" name="causes_heart" value="Evenly directed between outward, inward, upward and downward." />Evenly directed between outward, inward, upward and downward.</label>
			<label class="radio"><input type="radio" name="causes_heart" value="undecided">Undecided</label>
		</div>
	</div>


	<!---CLIP #1--->
	<div class="form-actions"><input class="btn btn-primary" type="submit" name="submit" value="Next Step" /></div>
	<input type="hidden" value="<cfoutput>#Encrypt('14,connect_god,causes_heart,causes_heart','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
</form>