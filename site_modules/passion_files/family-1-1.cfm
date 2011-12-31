

<div class="sort_name">Family and Individual</div>
        <br />
        <h3>Instructions</h3>
<p>Pick the two sub-spheres you are drawn to impact. Only use undecided if you’re really not sure.</p>

		<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
			
					<label><input type="checkbox" name="family" value="Family">Family</label>
					<label><input type="checkbox" name="family" value="Education">Education</label>
					<label><input type="checkbox" name="family" value="Health and Wellness">Health and Wellness</label>
					<label><input type="checkbox" name="family" value="Therapy and Social Work">Therapy and Social Work</label>
					<label><input type="checkbox" name="family" value="Senior Care">Senior Care</label>
                    <label><input type="checkbox" name="family" value="Undecided">Undecided</label>
                    <!---<label>Other&nbsp;<input name="family" style="border:hidden; background-color:#FFFFFF; margin-left:5px; width:220px;" †ype="text" maxlength="30" placeholder="(limit 30 characters)"></label>--->
		
		
				
			
             <!---CLIP #1--->
			<input style="margin:20px 0px 20px 250px; float:left" type="image" src="/site_images/next_btn.jpg" name="submit" value="Submit"/>
            <input type="hidden" value="<cfoutput>#Encrypt('3,causes_societal-2-1,family,sphere_sub1','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
		</form>
<br class="clear"/>
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