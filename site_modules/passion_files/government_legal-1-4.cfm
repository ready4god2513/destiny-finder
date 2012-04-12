<h5>2. Government, Legal and Non-Profit</h5>
<cfinclude template="instructions.cfm">

<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
	<div class="controls">
		<div class="inputs-list">
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1" value="Political Office and Campaigning">Political Office (elected office, from city council to US President, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1" value="Military Service">Military Service (including reserves, Coast Guard, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1" value="Civil Service">Civil Service (including local, state and federal government; government transportation and infrastructure, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1" value="Justice System, Law Enforcement & Fire/Rescue ">Justice System, Law Enforcement & Fire/Rescue (including, police, attorneys, judicial, firefighters, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1" value="Non-Profit">Non-Profit (including non-governmental organizations, foundations, Red Cross, GreenPeace, etc.)</label>
			<label class="checkbox"><input type="text" name="sphere_sub1" placeholder="Other sphere"/></label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1" value="undecided">Undecided</label>
		</div>
	</div>


	<!---CLIP #1--->
	<div class="form-actions"><input class="btn btn-primary" type="submit" name="submit" value="Next Step" /></div>
	<input type="hidden" value="<cfoutput>#Encrypt('6,causes_societal-2-1,sphere_sub1,sphere_sub1','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
</form>
<br class="clear"/>