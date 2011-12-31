
<div class="sort_name">I feel most fulfilled when communicating with others through the following means:</div>
        <br />
        <h3>Instructions</h3>
		<p>Select two that are truest for you.</p>
        
		<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
			
					<label><input type="checkbox" name="communication" value="Teaching and Training" />Teaching and Training</label>
					<label><input type="checkbox" name="communication" value="Counseling and Consulting" />Counseling and Consulting</label>
					<label><input type="checkbox" name="communication" value="Leading and Guiding" />Leading and Guiding</label>
					<label><input type="checkbox" name="communication" value="Mentoring and Coaching" />Mentoring and Coaching </label>
					<label><input type="checkbox" name="communication" value="Writing and Publishing" />Writing and Publishing</label>
                    <label><input type="checkbox" name="communication" value="Public Speaking and Motivating" />Public Speaking and Motivating</label>
                    <label><input type="checkbox" name="communication" value="None" />None</label>
		
		
				
			
             <!---CLIP #1--->
			<input style="margin:20px 0px 20px 250px; float:left" type="image" src="/site_images/next_btn.jpg" name="submit" value="Submit"/>
            <input type="hidden" value="<cfoutput>#Encrypt('12,causes_expressing-2-6,communication,causes_communication','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
		</form>
<br class="clear"/>
        <cfset progbar= (308 / 27) * (VARIABLES.vCount - 1)>
        <div class="percent_complete_label">% of survey completed</div><div class="percent_completed"><img src="/site_images/progbar_pix.png" width="<cfoutput>#progbar#</cfoutput>" height="21"></div>

            
<!---#1
	   <div style="float:left;margin:10px 40px 0px 40px;">
          Instructions:<br />
            Pick the one sphere (A-E) you're drawn to impact. Then pick the two sub-spheres you are drawn to impact. Only use undecided if you're really not sure.
Fill in the "Other" blank if you don't find an answer close enough to your interest.
 </div>
 
 --->