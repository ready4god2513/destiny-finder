<h2><cfoutput>#(VARIABLES.vCount - 1)#</cfoutput>. I feel most fulfilled when communicating with others through the following means: </h2>
        <br />
        <h3>Instructions</h3>
		<p>Select two that are truest for you.</p>

		<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
			
			<div class="input">
				<ul class="inputs-list">
					<li><label><input type="checkbox" name="expressing" value="Film" />Film </label></li>
					<li><label><input type="checkbox" name="expressing" value="Performing Arts" />Performing Arts</label></li>
					<li><label><input type="checkbox" name="expressing" value="Musical Arts" />Musical Arts </label></li>
					<li><label><input type="checkbox" name="expressing" value="Visual Arts" />Visual Arts </label></li>
					<li><label><input type="checkbox" name="expressing" value="Crafts and Decorative Arts" />Crafts and Decorative Arts </label></li>
                    <li><label><input type="checkbox" name="expressing" value="Literature and Poetry" />Literature and Poetry</label></li>
                    <li><label><input type="checkbox" name="expressing" value="None" />None</label></li>
				</ul>
			</div>
				
			
             <!---CLIP #1--->
			<div class="actions"><input class="btn primary" type="submit" name="submit" value="Next Step" /></div>
            <input type="hidden" value="<cfoutput>#Encrypt('13,causes_heart-2-7,expressing,causes_expressing','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
		</form>
<br class="clear"/>
        <cfset progbar= (308 / 27) * (VARIABLES.vCount - 1)>
        <div class="percent_complete_label">% of survey completed</div><div class="percent_completed"><img src="/assets/images/progbar_pix.png" width="<cfoutput>#progbar#</cfoutput>" height="21"></div>
         
<!---
	   <div style="float:left;margin:10px 40px 0px 40px;">
          Instructions:<br />
            Pick the one sphere (A-E) you're drawn to impact. Then pick the two sub-spheres you are drawn to impact. Only use undecided if you're really not sure.
Fill in the "Other" blank if you don't find an answer close enough to your interest.
 </div>
 
 --->