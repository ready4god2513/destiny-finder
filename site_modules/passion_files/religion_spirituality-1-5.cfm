
<div class="sort_name">Religion and Spirituality</div>
        <br />
        <h3>Instructions</h3>
<p>Pick the two sub-spheres you are drawn to impact. Only use undecided if you’re really not sure.</p>
        
		<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
			
					<label><input type="checkbox" name="religion_spirituality" value="Administration">Administration</label>
					<label><input type="checkbox" name="religion_spirituality" value="Education and Training">Education and Training</label>
					<label><input type="checkbox" name="religion_spirituality" value="Church Leadership">Church Leadership</label>
					<label><input type="checkbox" name="religion_spirituality" value="Non-Profit Organizations">Non-Profit Organizations</label>
					<label><input type="checkbox" name="religion_spirituality" value="Para-church Ministry">Para-church Ministry</label>
					<label><input type="checkbox" name="religion_spirituality" value="Outreach and Missions">Outreach and Missions</label>
                    <label><input type="checkbox" name="religion_spirituality" value="Undecided">Undecided</label>
                    <!---<label><input type="radio" name="religion_spirituality" value="Other">Other&nbsp;<input name="religion_spirituality" style="border:hidden; background-color:#F7F1E4; margin-left:5px; width:220px;" †ype="text" maxlength="30" placeholder="(limit 30 characters)" a></label>--->
		
		
				
			
             <!---CLIP #1--->
			<input style="margin:20px 0px 20px 250px; float:left" type="image" src="/site_images/next_btn.jpg" name="submit" value="Submit"/>
            <input type="hidden" value="<cfoutput>#Encrypt('7,causes_societal-2-1,religion_spirituality,sphere_sub1','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
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