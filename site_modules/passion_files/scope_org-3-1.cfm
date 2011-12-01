
<div class="sort_name">The organizational type I’m most comfortable in is:</div>
        <br />
        <h3>Instructions</h3>
		<p>Choose one answer that is truest for you.</p>

        
		<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
			
					<label><input type="radio" name="organizational_type" value="Self-employed">Self-employed</label>
					<label><input type="radio" name="organizational_type" value="Pioneer / Start-up">Pioneer / Start-up </label>
					<label><input type="radio" name="organizational_type" value="Small and Adaptive">Small and Adaptive</label>
					<label><input type="radio" name="organizational_type" value="Mid-sized and Growing">Mid-sized and Growing</label>
					<label><input type="radio" name="organizational_type" value="Large and Stable">Large and Stable</label>
		
             <!---CLIP #1--->
			<input style="margin:20px 0px 20px 250px; float:left" type="image" src="/site_images/next_btn.jpg" name="submit" value="Submit"/>
            <input type="hidden" value="<cfoutput>#Encrypt('15,scope_group-3-2,organizational_type,scope_org','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
		</form>
<br class="clear"/>
        <cfset progbar= (308 / 27) * (VARIABLES.vCount - 1)>
        <div class="percent_complete_label">% of survey completed</div><div class="percent_completed"><img src="../site_images/progbar_pix.png" width="<cfoutput>#progbar#</cfoutput>" height="21"></div>

<!--- #1
	   <div style="float:left;margin:10px 40px 0px 40px;">
          Instructions:<br />
            Pick the one sphere (A-E) you're drawn to impact. Then pick the two sub-spheres you are drawn to impact. Only use undecided if you're really not sure.
Fill in the "Other" blank if you don't find an answer close enough to your interest.
 </div>
 
 --->