<h5>11. The organizational type I'm most comfortable in is:</h5>
<cfinclude template="instructions.cfm">

<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
	<div class="controls">
		<div class="inputs-list">
			<label class="radio"><input type="radio" name="scope_org" value="Self-employed">Self-employed</label>
			<label class="radio"><input type="radio" name="scope_org" value="Pioneer / Start-up">Pioneer or Start-up (usually under 50 employees)</label>
			<label class="radio"><input type="radio" name="scope_org" value="Small and Adaptive">Small and Adaptive (usually under 100 employees)</label>
			<label class="radio"><input type="radio" name="scope_org" value="Mid-sized and Growing">Mid-sized and Growing (usually 100 - 500 employees)</label>
			<label class="radio"><input type="radio" name="scope_org" value="Large and Stable">Large and Stable (usually over 1,000 employees)</label>
		</div>
	</div>


	<!---CLIP #1--->
	<div class="form-actions"><input class="btn btn-primary" type="submit" name="submit" value="Next Step" /></div>
	<input type="hidden" value="<cfoutput>#Encrypt('15,scope_group-3-2,scope_org,scope_org','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
</form>