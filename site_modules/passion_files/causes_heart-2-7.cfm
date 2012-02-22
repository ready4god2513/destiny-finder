
<h2>My heart direction is mostly:</h2>
<br />
<h3>Instructions</h3>
<p>Select one that is truest for you.</p>

<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">

	<div class="controls">
		<div class="inputs-list">
			<label class="radio"><input type="radio" name="heart" value="Outward" />Outward (To reach those outside my group or bring them into my group)</label>
			<label class="radio"><input type="radio" name="heart" value="Inward" />Inward (To build up those inside my group)</label>
			<label class="radio"><input type="radio" name="heart" value="Upward" />Upward (To minister to the Lord, usually alone or in small groups)</label>
			<label class="radio"><input type="radio" name="heart" value="Downward" />Downward (To bring God's heart, message and power to my group)</label>
			<label class="radio"><input type="radio" name="heart" value="Evenly directed between outward, inward, upward and downward." />Evenly directed between outward, inward, upward and downward.</label>
		</div>
	</div>


	<!---CLIP #1--->
	<div class="form-actions"><input class="btn btn-primary" type="submit" name="submit" value="Next Step" /></div>
	<input type="hidden" value="<cfoutput>#Encrypt('14,scope_org-3-1,heart,causes_heart','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
</form>
<br class="clear"/>

	