 <h2><cfoutput>#(VARIABLES.vCount - 1)#</cfoutput>. I really enjoy being involved in the following types of ministries: </h2>
        <br />
        <h3>Instructions</h3>
		<p>Select two that are truest for you.</p>
        
		<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
			<div class="input">
				<ul class="inputs-list">
					<li><label><input type="checkbox" name="ministries" value="Conceptual" />Conceptual (Teaching, Bible study, apologetics, etc.) </label></li>
					<li><label><input type="checkbox" name="ministries" value="Emotional" />Emotional (Counseling, comfort, visitation, grief ministry, etc.)</label></li>
					<li><label><input type="checkbox" name="ministries" value="Practical" />Practical (Repair, cooking, driving, building, etc.) </label></li>
					<li><label><input type="checkbox" name="ministries" value="Spiritual" />Spiritual (Healing, fasting, prayer, intercession, deliverance, exorcism, etc)</label></li>
					<li><label><input type="checkbox" name="ministries" value="Pulpit" />Preaching/Worship (Preaching, worship team, choir, etc.)</label></li>
                    <li><label><input type="checkbox" name="ministries" value="Church service support" />Church service support (Ushering, preparation, communion, baptism, etc.)</label></li>
                    <li><label><input type="checkbox" name="ministries" value="Relational" />Relational (Small groups, one on one, accountability partners, discipling, mentoring, etc.) </label></li>
                    <li><label><input type="checkbox" name="ministries" value="Social" />Social (Dinners, events, parties, birthdays, holidays, etc)</label></li>
				</ul>
			</div>
			
             <!---CLIP #1--->
			<div class="form-actions"><input class="btn primary" type="submit" name="submit" value="Next Step" /></div>
            <input type="hidden" value="<cfoutput>#Encrypt('10,causes_ministry_activities-2-4,ministries,causes_ministries','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
		</form>
<br class="clear"/>
        <cfset progbar= (308 / 27) * (VARIABLES.vCount - 1)>
        <div class="percent_complete_label">% of survey completed</div><div class="percent_completed"><img src="/assets/images/progbar_pix.png" width="<cfoutput>#progbar#</cfoutput>" height="21"></div>
     
<!---
	   <div style="float:left;margin:10px 40px 0px 40px;">
          Instructions:<br />
            Pick the one sphere (A-E) you're drawn to impact. Then pick the two sub-spheres you are drawn to impact. Only use undecided if you're really not sure.
Fill in the "Other" blank if you don't find an answer close enough to your interest.
 </div>
 
 --->