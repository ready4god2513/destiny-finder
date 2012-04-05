
<h5>The organizational type I'm most comfortable in is:</h5>
<br />
<h6>Instructions</h6>
<p>Choose one answer that is truest for you.</p>


<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
	<div class="controls">
		<div class="inputs-list">
			<label class="radio"><input type="radio" name="scope_org" value="Self-employed">Self-employed</label>
			<label class="radio"><input type="radio" name="scope_org" value="Pioneer / Start-up">Pioneer / Start-up </label>
			<label class="radio"><input type="radio" name="scope_org" value="Small and Adaptive">Small and Adaptive</label>
			<label class="radio"><input type="radio" name="scope_org" value="Mid-sized and Growing">Mid-sized and Growing</label>
			<label class="radio"><input type="radio" name="scope_org" value="Large and Stable">Large and Stable</label>
			<label class="checkbox"><input type="text" name="scope_org" placeholder="Other organizational type"/></label>
		</div>
	</div>


	<!---CLIP #1--->
	<div class="form-actions"><input class="btn btn-primary" type="submit" name="submit" value="Next Step" /></div>
	<input type="hidden" value="<cfoutput>#Encrypt('15,scope_group-3-2,scope_org,scope_org','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
</form>
<br class="clear"/>

	