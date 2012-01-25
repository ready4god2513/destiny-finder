
<h2>I feel most fulfilled when communicating with others through the following means:</h2>
        <br />
        <h3>Instructions</h3>
		<p>Select two that are truest for you.</p>
        
		<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
			<div class="input">
				<ul class="inputs-list">
					<li><label><input type="checkbox" name="communication" value="Teaching and Training" />Teaching and Training</label></li>
					<li><label><input type="checkbox" name="communication" value="Counseling and Consulting" />Counseling and Consulting</label></li>
					<li><label><input type="checkbox" name="communication" value="Leading and Guiding" />Leading and Guiding</label></li>
					<li><label><input type="checkbox" name="communication" value="Mentoring and Coaching" />Mentoring and Coaching </label></li>
					<li><label><input type="checkbox" name="communication" value="Writing and Publishing" />Writing and Publishing</label></li>
                    <li><label><input type="checkbox" name="communication" value="Public Speaking and Motivating" />Public Speaking and Motivating</label></li>
                    <li><label><input type="checkbox" name="communication" value="None" />None</label></li>
				</ul>
			</div>
			
             <!---CLIP #1--->
			<div class="actions"><input class="btn primary" type="submit" name="submit" value="Next Step" /></div>
            <input type="hidden" value="<cfoutput>#Encrypt('12,causes_expressing-2-6,communication,causes_communication','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
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