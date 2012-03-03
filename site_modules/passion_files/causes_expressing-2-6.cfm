<h2>I feel most fulfilled when communicating with others through the following means: </h2>
        <br />
        <h3>Instructions</h3>
		<p>Select two that are truest for you.</p>

		<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
			
			<div class="controls">
				<div class="inputs-list">
					<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_expressing" value="Film" />Film </label>
					<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_expressing" value="Performing Arts" />Performing Arts</label>
					<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_expressing" value="Musical Arts" />Musical Arts </label>
					<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_expressing" value="Visual Arts" />Visual Arts </label>
					<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_expressing" value="Crafts and Decorative Arts" />Crafts and Decorative Arts </label>
                    <label class="checkbox"><input type="checkbox" class="checkbox" name="causes_expressing" value="Literature and Poetry" />Literature and Poetry</label>
                    <label class="checkbox"><input type="checkbox" class="checkbox" name="causes_expressing" value="None/Other">None/Other</label>
					<label class="checkbox"><input type="text" name="causes_expressing" placeholder="Other causes"/></label>
				</ul>
			</div>
				
			
             <!---CLIP #1--->
			<div class="form-actions"><input class="btn btn-primary" type="submit" name="submit" value="Next Step" /></div>
            <input type="hidden" value="<cfoutput>#Encrypt('13,causes_heart-2-7,causes_expressing,causes_expressing','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
		</form>
<br class="clear"/>
        
        
         
<!---
	   <div style="float:left;margin:10px 40px 0px 40px;">
          Instructions:<br />
            Pick the one sphere (A-E) you're drawn to impact. Then pick the two sub-spheres you are drawn to impact. Only use undecided if you're really not sure.
Fill in the "Other" blank if you don't find an answer close enough to your interest.
 </div>
 
 --->