<h5>12. The group size I feel most comfortable working with is:</h5>
<cfinclude template="instructions.cfm">

<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
	<div class="controls">
		<div class="inputs-list">
			<label class="radio"><input type="radio" name="scope_group" value="One-on-one">One-on-one</label>
			<label class="radio"><input type="radio" name="scope_group" value="Small Group">Small Group (10+)</label>
			<label class="radio"><input type="radio" name="scope_group" value="Mid-sized Group">Mid-sized Group (50+)</label>
			<label class="radio"><input type="radio" name="scope_group" value="Large Group">Large Group (100+)</label>
			<label class="radio"><input type="radio" name="scope_group" value="Mega-size Group">Mega-size Group (1000+)</label>
			<label class="radio"><input type="text" name="scope_group" placeholder="Other sphere"/></label>
			<label class="radio"><input type="radio" name="scope_group" value="undecided">Undecided</label>
		</ul>
	</div>

	<!---CLIP #1--->
	<div class="form-actions"><input class="btn btn-primary" type="submit" name="submit" value="Next Step" /></div>
	<input type="hidden" value="<cfoutput>#Encrypt('16,role_church-4-1,scope_group,scope_group','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
</form>