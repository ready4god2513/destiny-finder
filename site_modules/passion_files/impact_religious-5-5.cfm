<h5>20. I feel drawn to work with people of the following religious orientation:</h5>
<cfinclude template="instructions.cfm">
	
<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
	<div class="controls">
		<div class="inputs-list">
			<label class="radio"><input type="radio" name="impact_religious" checked value="Hindu">Hindu</label>
			<label class="radio"><input type="radio" name="impact_religious" value="Buddhist">Buddhist</label>
			<label class="radio"><input type="radio" name="impact_religious" value="Moslem">Islamic</label>
			<label class="radio"><input type="radio" name="impact_religious" value="Jewish">Jewish</label>
			<label class="radio"><input type="radio" name="impact_religious" value="Christian">Christian</label>
			<label class="radio"><input type="radio" name="impact_religious" value="Atheist/Post-Christian">Atheist</label>
			<label class="radio"><input type="radio" name="impact_religious" value="Agnostic">Agnostic</label>
			<label class="radio"><input type="radio" name="impact_religious" value="Postmodern">Postmodern</label>
			<label class="radio"><input type="radio" name="impact_religious" value="New Age">New Age</label>
			<label class="radio"><input type="radio" name="impact_religious" value="Occult, Wicca, Satanic">Occult, Wicca, Satanic</label>
			<label class="radio"><input type="text" name="impact_religious" placeholder="other"/></label>
			<label class="radio"><input type="radio" name="impact_religious" value="undecided">Undecided</label>
		</div>
	</div>


	<!---CLIP #1--->
	<div class="form-actions"><input class="btn btn-primary" type="submit" name="submit" value="Next Step" /></div>
	<input type="hidden" value="1" name="surveydone" />
	<input type="hidden" value="<cfoutput>#Encrypt('23,surveydone','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
</form>