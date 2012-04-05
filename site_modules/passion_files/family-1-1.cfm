<h5>Family and Individual</h5>
<br />
<h6>Instructions</h6>
<p>Pick the two sub-spheres you are drawn to impact. Only use undecided if You're really not sure.</p>

<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
	<div class="controls">
		<div class="inputs-list">
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1" value="Family">Family (Marriage, parenting, children, orphans, foster care, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1" value="Education">Education (Teaching, administration, support, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1" value="Health and Wellness">Health and Wellness (Health, medical, wellness, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1" value="Therapy and Social Work">Therapy and Social Work (Counseling, family support, bereavement, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1" value="Senior Care">Senior Care (Retirement, senior care, hospice, etc.)</label>
			<label class="checkbox"><input type="text" name="sphere_sub1" placeholder="Other sphere"/></label>
		</div>
	</div>

	<!---CLIP #1--->
	<div class="form-actions"><input class="btn btn-primary" type="submit" name="submit" value="Next Step" /></div>
	<input type="hidden" value="<cfoutput>#Encrypt('3,causes_societal-2-1,sphere_sub1,sphere_sub1','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
</form>
<br class="clear"/>
<br class="clear"/>

	

