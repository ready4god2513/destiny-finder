
<div class="sort_name">I feel most drawn to impact the following subculture:</div>
        <br />
        
		<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
			
					<label><input type="radio" name="drawn_to_impact_ethnicity" checked value="Metro Urban/Hipster,">Metro Urban/Hipster,</label>
					<label><input type="radio" name="drawn_to_impact_ethnicity" value="Yuppie">Yuppie</label>
					<label><input type="radio" name="drawn_to_impact_ethnicity" value="Student">Student</label>
					<label><input type="radio" name="drawn_to_impact_ethnicity" value="Punk/Hardcore/Skater">Punk/Hardcore/Skater</label>
					<label><input type="radio" name="drawn_to_impact_ethnicity" value="Rave/Dance Club">Rave/Dance Club</label>
                    <label><input type="radio" name="drawn_to_impact_ethnicity" value="Rap/Hip Hop">Rap/Hip Hop</label>
                    <label><input type="radio" name="drawn_to_impact_ethnicity" value="Young Adult">Young Adult</label>
                    <label><input type="radio" name="drawn_to_impact_ethnicity" value="Country/Western">Country/Western</label>
                    <label><input type="radio" name="drawn_to_impact_ethnicity" value="LGBT">LGBT</label>
                    <label><input type="radio" name="drawn_to_impact_ethnicity" value="High Society">High Society</label>
                    <label><input type="radio" name="drawn_to_impact_ethnicity" value="Celebrity">Celebrity</label>
                    <label><input type="radio" name="drawn_to_impact_ethnicity" value="None">None</label>
	
		
				
			
             <!---CLIP #1--->
			<input class="btn primary" type="submit" name="submit" value="Next Step" />
            <input type="hidden" value="<cfoutput>#Encrypt('22,impact_religious-5-5','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
		</form>
<br class="clear"/>
        <cfset progbar= (308 / 26) * (VARIABLES.vCount - 1)>
        <div class="percent_complete_label">% of survey completed</div><div class="percent_completed"><img src="/site_images/progbar_pix.png" width="#progbar#" height="21"></div>
       
<!---#1
	   <div style="float:left;margin:10px 40px 0px 40px;">
          Instructions:<br />
            Pick the one sphere (A-E) you're drawn to impact. Then pick the two sub-spheres you are drawn to impact. Only use undecided if you're really not sure.
Fill in the "Other" blank if you don't find an answer close enough to your interest.
 </div>
 
 --->