<h2>The group size I prefer to work with is</h2>
        <br />
        <h3>Instructions</h3>
		<p>Choose one answer that is truest for you.</p>
        
		<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
			<div class="controls">
				<div class="inputs-list">
					<label class="radio"><input type="radio" name="scope_group" value="One-on-one">One-on-one</label>
					<label class="radio"><input type="radio" name="scope_group" value="Small Group">Small Group (10+)</label>
					<label class="radio"><input type="radio" name="scope_group" value="Mid-sized Group">Mid-sized Group (50+)</label>
					<label class="radio"><input type="radio" name="scope_group" value="Large Group">Large Group (100+)</label>
					<label class="radio"><input type="radio" name="scope_group" value="Mega-size Group">Mega-size Group (1000+)</label>
                    <label class="radio"><input type="radio" name="scope_group" value="International – Itinerate">International – Itinerate</label>
				</ul>
			</div>
			
             <!---CLIP #1--->
			<div class="form-actions"><input class="btn btn-primary" type="submit" name="submit" value="Next Step" /></div>
            <input type="hidden" value="<cfoutput>#Encrypt('16,role_church-4-1,scope_group,scope_group','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
		</form>
<br class="clear"/>
        
        
    
<!---
	   <div style="float:left;margin:10px 40px 0px 40px;">
          Instructions:<br />
            Pick the one sphere (A-E) you're drawn to impact. Then pick the two sub-spheres you are drawn to impact. Only use undecided if you're really not sure.
Fill in the "Other" blank if you don't find an answer close enough to your interest.
 </div>
 
 --->