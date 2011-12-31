
<div class="sort_name">The workplace role I feel most comfortable with is:</div>
        <br />
        <h3>Instructions</h3>
		<p>Choose two answers that are truest for you.</p>
     
		<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
			
					<label><input type="checkbox" name="workplace_role" value="Worker or Laborer">Worker or Laborer</label>
					<label><input type="checkbox" name="workplace_role" value="Administrator or Facilitator">Administrator or Facilitator</label>
					<label><input type="checkbox" name="workplace_role" value="Manager or Director">Manager or Director</label>
					<label><input type="checkbox" name="workplace_role" value="Associate Leader">Associate Leader</label>
					<label><input type="checkbox" name="workplace_role" value="Primary Leader">Primary Leader</label>
					<label><input type="checkbox" name="workplace_role" value="Regional Leader">Regional Leader</label>
                    <label><input type="checkbox" name="workplace_role" value="None">None</label>
			
				
			
             <!---CLIP #1--->
			<input style="margin:20px 0px 20px 250px; float:left" type="image" src="/site_images/next_btn.jpg" name="submit" value="Submit"/>
            <input type="hidden" value="<cfoutput>#Encrypt('18,impact_age_group-5-1,workplace_role,role_workplace','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
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