
<div class="sort_name">I feel drawn to work with people of the following religious orientation </div>
        <br />
        <h3>Instructions</h3>
		<p>Select one that is truest for you.</p>
		<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
			
					<label><input type="radio" name="religion" value="Hindu">Hindu</label>
					<label><input type="radio" name="religion" value="Buddhist">Buddhist</label>
					<label><input type="radio" name="religion" value="Moslem">Moslem</label>
					<label><input type="radio" name="religion" value="Jewish">Jewish</label>
					<label><input type="radio" name="religion" value="Christian">Christian</label>
                    <label><input type="radio" name="religion" value="Atheist/Post-Christian">Atheist/Post-Christian</label>
                    <label><input type="radio" name="religion" value="Agnostic">Agnostic</label>
                    <label><input type="radio" name="religion" value="Higher Power/Mishmash">Higher Power/Mishmash</label>
                    <label><input type="radio" name="religion" value="New Age">New Age</label>
                    <label><input type="radio" name="religion" value="Occult/Wicca/Satanic">Occult/Wicca/Satanic</label>
                    <label><input type="radio" name="religion" value="None">None</label>
	
		
				
			
             <!---CLIP #1--->
			<input class="btn primary" type="submit" name="submit" value="Next Step" />
            <input type="hidden" value="<cfoutput>#Encrypt('23,development-6-1,religion,impact_religious','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
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