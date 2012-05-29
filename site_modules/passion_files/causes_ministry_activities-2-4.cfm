<h5>6. I am most passionate about impacting others OUTSIDE my church or group through the following activities:</h5>
<cfinclude template="instructions-multiple.cfm">

<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">

	<div class="controls">
		<div class="inputs-list">
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_ministry_activities" value="Conceptual" />Conceptual (presenting the gospel, apologetics, writing, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_ministry_activities" value="Emotional" />Emotional (counseling, comfort, visitation, grief ministry, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_ministry_activities" value="Practical" />Practical (repair, cooking, driving, building, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_ministry_activities" value="Spiritual" />Spiritual (healing, fasting, prayer, intercession, deliverance, exorcism, etc)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_ministry_activities" value="Music and Arts" />Music and Arts (bands, singing, dance, painting, graphics, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_ministry_activities" value="Compassion" />Compassion (feeding the poor, tutoring kids, helping the homeless)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_ministry_activities" value="Justice Miinistry" />Justice Ministry (human trafficking, prison ministry, political causes, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_ministry_activities" value="Social and Relational" />Social and Relational (social networking, events, friendship evangelism, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_ministry_activities"><input type="text" name="causes_ministry_activities" placeholder="Other sphere"/></label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_ministry_activities" value="undecided">Undecided</label>
		</div>
	</div>

	<!---CLIP #1--->
	<div class="form-actions"><input class="btn btn-primary" type="submit" name="submit" value="Next Step" /></div>
	<input type="hidden" value="<cfoutput>#Encrypt('11,causes_communication-2-5,causes_ministry_activities,causes_ministry_activities','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
</form>