
<div class="sort_name">Culture and Lifestyle</div>
        <br />
        
        <h3>Instructions</h3>
<p>Pick the two sub-spheres you are drawn to impact. Only use undecided if you’re really not sure.</p>
		<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
			
					<label><input type="checkbox" name="culture_lifestyle" value="Cultural Expression">Cultural Expression</label>
					<label><input type="checkbox" name="culture_lifestyle" value="Entertainment, Sports and Games">Entertainment, Sports and Games </label>
					<label><input type="checkbox" name="culture_lifestyle" value="Performing and Visual Arts">Performing and Visual Arts</label>
					<label><input type="checkbox" name="culture_lifestyle" value="Traditional Media">Traditional Media</label>
					<label><input type="checkbox" name="culture_lifestyle" value="Digital Media">Digital Media</label>
                    <label><input type="checkbox" name="culture_lifestyle" value="Undecided">Undecided</label>
                   <!--- <label><input type="checkbox" name="culture_lifestyle" value="Other">Other&nbsp;<input name="culture_lifestyle" style="border:hidden; background-color:#F7F1E4; margin-left:5px; width:220px;" †ype="text" maxlength="30" placeholder="(limit 30 characters)" a></label>--->
		
		
				
			
             <!---CLIP #1--->
			<input class="btn primary" type="submit" name="submit" value="Next Step" />
           <input type="hidden" value="<cfoutput>#Encrypt('4,causes_societal-2-1,culture_lifestyle,sphere_sub1','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
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