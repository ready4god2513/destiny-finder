
<h2><cfoutput>#(VARIABLES.vCount - 1)#</cfoutput>. Choose the stage you want to be at in 3-5 years:</h2>
        <br />
        <h3>Instructions</h3>
		<p>Select one that is truest for you.</p>
		<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
			<div class="input">
				<ul class="inputs-list">
					<li><label><input type="radio" name="development" value="Child">Child (You're mostly in receiving mode, may have a few "household" tasks.)</label></li>
					<li><label><input type="radio" name="development" value="Adolescent">Adolescent (You have more household tasks, some responsibility, developing rapidly.)</label></li>
					<li><label><input type="radio" name="development" value="Young Adult">Young Adult (You require less supervision, take more responsibility, separating from parents/leaders.)</label></li>
					<li><label><input type="radio" name="development" value="Adult">Adult (You're reproducing spiritual children and helping them grow, may be married with actual kids, focused on next generation.)</label></li>
					<li><label><input type="radio" name="development" value="Senior">Senior (Your kids (spiritual or biological) are on their own, you're providing counsel, help, overseeing, focused on grandchildren)</label></li>
				</ul>
			</div>
			<div class="form-actions"><input class="btn primary" type="submit" name="submit" value="Next Step" /></div>
            <input type="hidden" value="<cfoutput>#Encrypt('25,development-6-3,development2,development_2','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
		</form>
<br class="clear"/>
        
        <cfset progbar= (308 / 27) * (VARIABLES.vCount - 1)>
        <div class="percent_complete_label">% of survey completed</div><div class="percent_completed"><img src="/assets/images/progbar_pix.png" width="<cfoutput>#progbar#</cfoutput>" height="21"></div>

			