
<div class="sort_name">I feel most fulfilled when communicating with others through the following means: </div>
        <br />
        <h3>Instructions</h3>
		<p>Select two that are truest for you.</p>

		<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
			
					<label><input type="checkbox" name="expressing" value="Film" />Film </label>
					<label><input type="checkbox" name="expressing" value="Performing Arts" />Performing Arts</label>
					<label><input type="checkbox" name="expressing" value="Musical Arts" />Musical Arts </label>
					<label><input type="checkbox" name="expressing" value="Visual Arts" />Visual Arts </label>
					<label><input type="checkbox" name="expressing" value="Crafts and Decorative Arts" />Crafts and Decorative Arts </label>
                    <label><input type="checkbox" name="expressing" value="Literature and Poetry" />Literature and Poetry</label>
                    <label><input type="checkbox" name="expressing" value="None" />None</label>
		
		
				
			
             <!---CLIP #1--->
			<input class="btn primary" type="submit" name="submit" value="Next Step" />
            <input type="hidden" value="<cfoutput>#Encrypt('13,causes_heart-2-7,expressing,causes_expressing','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
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