<h5>13. The church role I feel most comfortable with is:</h5>
<cfinclude template="instructions-multiple.cfm">


<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
	<div class="controls">
		<div class="inputs-list">
			<label class="checkbox"><input type="checkbox" class="checkbox" name="role_church" value="Worker or Helper">Worker or Helper</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="role_church" value="Deacon or Administrator">Deacon or Administrator</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="role_church" value="Ministry Leader or Elder">Ministry Leader or Elder</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="role_church" value="Associate or Assistant Pastor">Associate or Assistant Pastor</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="role_church" value="Senior or Lead Pastor">Senior or Lead Pastor</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="role_church"><input type="text" name="role_church" placeholder="other"/></label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="role_church" value="undecided">Undecided</label>
		</div>
	</div>

	<!---CLIP #1--->
	<div class="form-actions"><input class="btn btn-primary" type="submit" name="submit" value="Next Step" /></div>
	<input type="hidden" value="<cfoutput>#Encrypt('17,role_workplace-4-2,role_church,role_church','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
</form>