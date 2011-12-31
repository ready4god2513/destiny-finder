
<div class="sort_name">The group size I prefer to work with is</div>
        <br />
        <h3>Instructions</h3>
		<p>Choose one answer that is truest for you.</p>
        
		<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
			
					<label><input type="radio" name="group_size" value="One-on-one">One-on-one</label>
					<label><input type="radio" name="group_size" value="Small Group">Small Group (10+)</label>
					<label><input type="radio" name="group_size" value="Mid-sized Group">Mid-sized Group (50+)</label>
					<label><input type="radio" name="group_size" value="Large Group">Large Group (100+)</label>
					<label><input type="radio" name="group_size" value="Mega-size Group">Mega-size Group (1000+)</label>
                    <label><input type="radio" name="group_size" value="International – Itinerate">International – Itinerate</label>
		
		
				
			
             <!---CLIP #1--->
			<input style="margin:20px 0px 20px 250px; float:left" type="image" src="/site_images/next_btn.jpg" name="submit" value="Submit"/>
            <input type="hidden" value="<cfoutput>#Encrypt('16,role_church-4-1,group_size,scope_group','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
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