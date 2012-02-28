
<h2>Government, Legal and Non-Profit</h2>
<br />
<h3>Instructions</h3>
<p>Pick the two sub-spheres you are drawn to impact. Only use undecided if You're really not sure.</p>

<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
	<div class="controls">
		<div class="inputs-list">
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1" value="Political Office and Campaigning">Political Office and Campaigning</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1" value="Military Service">Military Service</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1" value="Civil Service">Civil Service</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1" value="Law Enforcement">Law Enforcement</label>
			<label class="checkbox"><input type="text" name="sphere_sub1" placeholder="Other impact sphere"/></label>
		</div>
	</div>


	<!---CLIP #1--->
	<div class="form-actions"><input class="btn btn-primary" type="submit" name="submit" value="Next Step" /></div>
	<input type="hidden" value="<cfoutput>#Encrypt('6,causes_societal-2-1,sphere_sub1,sphere_sub1','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
</form>
<br class="clear"/>