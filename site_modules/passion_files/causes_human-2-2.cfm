<h5>4. I'm most drawn to help people with the following human problems:  </h5>
<cfinclude template="instructions.cfm">

<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">

	<div class="controls">
		<div class="inputs-list">
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_human" value="Physical Problems" />Physical Problems (sickness, injury, birth defects, disabilities, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_human" value="Psychological Illness" />Psychological Illness (depression, bipolar disorder, OCD, ADD, neuroses, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_human" value="Addictions" />Addictions (substance abuse, pornography, gambling, eating disorders, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_human" value="Crime and Imprisonment" />Crime and Imprisonment </label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_human" value="Sin Issues" />Sin Issues (immorality, greed, fear, anger, envy, pride, idolatry, rebellion, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_human" value="Spiritual Strongholds " />Spiritual Strongholds (occult, demonic oppression, SRA, etc.)</label>
			<label class="checkbox"><input type="text" name="causes_human" placeholder="Other sphere"/></label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_human" value="undecided">Undecided</label>
		</ul>
	</div>

	<!---CLIP #1--->
	<div class="form-actions"><input class="btn btn-primary" type="submit" name="submit" value="Next Step" /></div>
	<input type="hidden" value="<cfoutput>#Encrypt('9,causes_ministries-2-3,causes_human,causes_human','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
</form>