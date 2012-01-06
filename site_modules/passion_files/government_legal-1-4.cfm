
<div class="sort_name">Government, Legal and Non-Profit</div>
        <br />
        <h3>Instructions</h3>
<p>Pick the two sub-spheres you are drawn to impact. Only use undecided if you’re really not sure.</p>
        
		<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
			
					<label><input type="checkbox" name="government_legal" value="Political Office and Campaigning">Political Office and Campaigning</label>
					<label><input type="checkbox" name="government_legal" value="Military Service">Military Service</label>
					<label><input type="checkbox" name="government_legal" value="Civil Service">Civil Service</label>
					<label><input type="checkbox" name="government_legal" value="Law Enforcement">Law Enforcement</label>
		
		
				
			
             <!---CLIP #1--->
			<input class="btn primary" type="submit" name="submit" value="Next Step" />
            <input type="hidden" value="<cfoutput>#Encrypt('6,causes_societal-2-1,government_legal,sphere_sub1','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
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