
<h2>Choose the stage you want to be at in 3-5 years:</h2>
        <br />
        <h3>Instructions</h3>
		<p>Select one that is truest for you.</p>
		<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
			<div class="controls">
				<div class="inputs-list">
					<label class="radio"><input type="radio" name="development_2" value="Child">Child (You're mostly in receiving mode, may have a few "household" tasks.)</label>
					<label class="radio"><input type="radio" name="development_2" value="Adolescent">Adolescent (You have more household tasks, some responsibility, developing rapidly.)</label>
					<label class="radio"><input type="radio" name="development_2" value="Young Adult">Young Adult (You require less supervision, take more responsibility, separating from parents/leaders.)</label>
					<label class="radio"><input type="radio" name="development_2" value="Adult">Adult (You're reproducing spiritual children and helping them grow, may be married with actual kids, focused on next generation.)</label>
					<label class="radio"><input type="radio" name="development_2" value="Senior">Senior (Your kids (spiritual or biological) are on their own, you're providing counsel, help, overseeing, focused on grandchildren)</label>
				</ul>
			</div>
			<div class="form-actions"><input class="btn btn-primary" type="submit" name="submit" value="Next Step" /></div>
            <input type="hidden" value="<cfoutput>#Encrypt('25,development-6-3,development_2,development_2','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
		</form>
<br class="clear"/>
        
        
        

			