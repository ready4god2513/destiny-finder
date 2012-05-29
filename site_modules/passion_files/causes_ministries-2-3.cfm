<h5>5. I am most passionate serving others INSIDE my church or group through the following types of ministries:  </h5>

<cfinclude template="instructions-multiple.cfm">

<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
	<div class="controls">
		<div class="inputs-list">
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_ministries" value="Conceptual" />Conceptual (teaching, Bible study, apologetics, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_ministries" value="Emotional" />Emotional (counseling, inner healing, comfort, visitation, grief ministry, divorce care, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_ministries" value="Practical" />Practical (compassion, repair, cooking, driving, building, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_ministries" value="Spiritual" />Spiritual (healing, fasting, prayer, intercession, deliverance, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_ministries" value="Public Celebration" />Public celebration (preaching, worship team, choir, creative arts, children, youth, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_ministries" value="Support" />Support (administration, ushering, preparation, communion, baptism, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_ministries" value="Relational" />Relational (small groups, one on one, discipling, mentoring, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_ministries" value="Social" />Social (dinners, events, parties, birthdays, holidays, festivals, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_ministries"><input type="text" name="causes_ministries" placeholder="other"/></label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_ministries" value="undecided">Undecided</label>
		</ul>
	</div>

	<!---CLIP #1--->
	<div class="form-actions"><input class="btn btn-primary" type="submit" name="submit" value="Next Step" /></div>
	<input type="hidden" value="<cfoutput>#Encrypt('10,causes_ministry_activities-2-4,causes_ministries,causes_ministries','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
</form>