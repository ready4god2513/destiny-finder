
<h2>I feel most drawn to impact the following age group</h2>
        <br />
        <h3>Instructions</h3>
		<p>Select one that is truest for you.</p>
        
		<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
			<div class="controls">
				<div class="inputs-list">
					<label class="radio"><input type="radio" name="age_group" value="Children (0-12)">0-12 Children</label>
					<label class="radio"><input type="radio" name="age_group" value="Youth (13-18)">13-18 Youth</label>
					<label class="radio"><input type="radio" name="age_group" value="Young Adult (18-29)">18-29 Young Adult</label>
					<label class="radio"><input type="radio" name="age_group" value="Gen X (30-45)">30-45 Gen X </label>
					<label class="radio"><input type="radio" name="age_group" value="Boomer (46-65)">46-65 Boomer</label>
                    <label class="radio"><input type="radio" name="age_group" value="Senior (65+)">65+ Senior</label>
				</ul>
			</div>
				
			
             <!---CLIP #1--->
			<div class="form-actions"><input class="btn btn-primary" type="submit" name="submit" value="Next Step" /></div>
            <input type="hidden" value="<cfoutput>#Encrypt('19,impact_region-5-2,age_group,impact_age_group','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
		</form>
<br class="clear"/>
        
        
      
<!---
	   <div style="float:left;margin:10px 40px 0px 40px;">
          Instructions:<br />
            Pick the one sphere (A-E) you're drawn to impact. Then pick the two sub-spheres you are drawn to impact. Only use undecided if you're really not sure.
Fill in the "Other" blank if you don't find an answer close enough to your interest.
 </div>
 
 --->