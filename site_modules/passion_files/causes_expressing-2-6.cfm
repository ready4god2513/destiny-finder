<h5>8. I feel most alive expressing myself through the following creative media:</h5>
<cfinclude template="instructions-multiple.cfm">

<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">

	<div class="controls">
		<div class="inputs-list">
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_expressing" value="Film" />Film </label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_expressing" value="Performing Arts" />Performing Arts</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_expressing" value="Musical Arts" />Musical Arts </label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_expressing" value="Visual Arts" />Visual Arts </label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_expressing" value="Crafts and Decorative Arts" />Crafts and Decorative Arts </label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_expressing" value="Literature and Poetry" />Literature and Poetry</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_expressing"><input type="text" name="causes_expressing" placeholder="Other sphere"/></label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_expressing" value="undecided">Undecided</label>
		</ul>
	</div>


	<!---CLIP #1--->
	<div class="form-actions"><input class="btn btn-primary" type="submit" name="submit" value="Next Step" /></div>
	<input type="hidden" value="<cfoutput>#Encrypt('13,causes_heart-2-7,causes_expressing,causes_expressing','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
</form>