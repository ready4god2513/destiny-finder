<h5>2. Religion and Spirituality</h5>
<cfinclude template="instructions-multiple.cfm">

<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
	<div class="controls">
		<div class="inputs-list">
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1" value="Church Ministry">Church Ministry (including administration, children, youth, worship, discipleship, teaching, small group, counseling, healing, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1" value="Church Outreach">Church Outreach (including evangelism, church missions and compassion ministry, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1" value="Church Leadership">Church Leadership (including pastor, elder, director, associate positions, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1" value="Education and Training">Education and Training (including ministry school, Christian college, seminary, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1" value="Para-church Ministry">Para-church Ministry (including mission organizations, campus ministry, non-profit organizations, non-church compassion ministry, music and arts ministry, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1" value="Outreach and Missions">Outreach and Missions</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1"><input type="text" name="sphere_sub1" placeholder="Other sphere"/></label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1" value="undecided">Undecided</label>
		</div>
	</div>

	<!---CLIP #1--->
	<div class="form-actions"><input class="btn btn-primary" type="submit" name="submit" value="Next Step" /></div>
	<input type="hidden" value="<cfoutput>#Encrypt('7,causes_societal-2-1,sphere_sub1,sphere_sub1','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
</form>
<br class="clear"/>

	

<!---
<div style="float:left;margin:10px 40px 0px 40px;">
Instructions:<br />
Pick the one sphere (A-E) you're drawn to impact. Then pick the two sub-spheres you are drawn to impact. Only use undecided if you're really not sure.
Fill in the "Other" blank if you don't find an answer close enough to your interest.
</div>

--->