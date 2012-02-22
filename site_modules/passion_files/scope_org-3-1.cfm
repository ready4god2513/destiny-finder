
<h2><cfoutput>#(VARIABLES.vCount - 1)#</cfoutput>. The organizational type I'm most comfortable in is:</h2>
<br />
<h3>Instructions</h3>
<p>Choose one answer that is truest for you.</p>


<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
	<div class="controls">
		<div class="inputs-list">
			<label class="radio"><input type="radio" name="organizational_type" value="Self-employed">Self-employed</label>
			<label class="radio"><input type="radio" name="organizational_type" value="Pioneer / Start-up">Pioneer / Start-up </label>
			<label class="radio"><input type="radio" name="organizational_type" value="Small and Adaptive">Small and Adaptive</label>
			<label class="radio"><input type="radio" name="organizational_type" value="Mid-sized and Growing">Mid-sized and Growing</label>
			<label class="radio"><input type="radio" name="organizational_type" value="Large and Stable">Large and Stable</label>
		</div>
	</div>


	<!---CLIP #1--->
	<div class="form-actions"><input class="btn btn-primary" type="submit" name="submit" value="Next Step" /></div>
	<input type="hidden" value="<cfoutput>#Encrypt('15,scope_group-3-2,organizational_type,scope_org','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
</form>
<br class="clear"/>
<cfset progbar= (308 / 27) * (VARIABLES.vCount - 1)>
	<div class="percent_complete_label">% of survey completed</div><div class="percent_completed"><img src="/assets/images/progbar_pix.png" width="<cfoutput>#progbar#</cfoutput>" height="21"></div>