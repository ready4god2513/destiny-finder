<h2>The church role I feel most comfortable with is:</h2>
<br />
<h3>Instructions</h3>
<p>Choose two answers that are truest for you.</p>


<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
	<div class="controls">
		<div class="inputs-list">
			<label class="checkbox"><input type="checkbox" class="checkbox" name="role_church" value="Worker or Helper">Worker or Helper</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="role_church" value="Deacon or Administrator">Deacon or Administrator</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="role_church" value="Elder or Ministry Leader">Elder or Ministry Leader</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="role_church" value="Associate or Assistant Pastor">Associate or Assistant Pastor</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="role_church" value="Senior or Lead Pastor">Senior or Lead Pastor</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="role_church" value="None/Other">None/Other</label>
			<label class="checkbox"><input type="text" name="role_church" placeholder="Other church role"/></label>
		</div>
	</div>

	<!---CLIP #1--->
	<div class="form-actions"><input class="btn btn-primary" type="submit" name="submit" value="Next Step" /></div>
	<input type="hidden" value="<cfoutput>#Encrypt('17,role_workplace-4-2,role_church,role_church','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
</form>
<br class="clear"/>

	

<!---
<div style="float:left;margin:10px 40px 0px 40px;">
Instructions:<br />
Pick the one sphere (A-E) you're drawn to impact. Then pick the two sub-spheres you are drawn to impact. Only use undecided if you're really not sure.
Fill in the "Other" blank if you don't find an answer close enough to your interest.
</div>

--->