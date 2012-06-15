
<h5>19. I feel most drawn to impact the following subculture:</h5>
        <br />
        <h6>Instructions</h6>
		<p>Select one that is truest for you.</p>
        
		<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
			<div class="controls">
				<div class="inputs-list">
					<label class="radio"><input type="radio" name="impact_subculture" value="Metro Urban/Hipster">Metro Urban/Hipster</label>
					<label class="radio"><input type="radio" name="impact_subculture" value="Yuppie">Yuppie</label>
					<label class="radio"><input type="radio" name="impact_subculture" value="Student">Student</label>
					<label class="radio"><input type="radio" name="impact_subculture" value="Punk/Hardcore/Skater">Punk/Hardcore/Skater</label>
					<label class="radio"><input type="radio" name="impact_subculture" value="Rave/Dance Club">Rave/Dance Club</label>
                    <label class="radio"><input type="radio" name="impact_subculture" value="Rap/Hip Hop">Rap/Hip Hop</label>
                    <label class="radio"><input type="radio" name="impact_subculture" value="Young Adult">Young Adult</label>
                    <label class="radio"><input type="radio" name="impact_subculture" value="Country/Western">Country/Western</label>
                    <label class="radio"><input type="radio" name="impact_subculture" value="LGBT">LGBT</label>
                    <label class="radio"><input type="radio" name="impact_subculture" value="High Society">High Society</label>
                    <label class="radio"><input type="radio" name="impact_subculture" value="Celebrity">Celebrity</label>
                    <label class="radio"><input type="text" name="impact_subculture" placeholder="Other subculture"/></label>
					<label class="radio"><input type="radio" name="impact_subculture" value="undecided">Undecided</label>
				</ul>
			</div>
			
             <!---CLIP #1--->
			<div class="form-actions"><input class="btn btn-primary" type="submit" name="submit" value="Next Step" /></div>
            <input type="hidden" value="<cfoutput>#Encrypt('22,impact_religious-5-6,impact_subculture,impact_subculture','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
		</form>
<br class="clear"/>