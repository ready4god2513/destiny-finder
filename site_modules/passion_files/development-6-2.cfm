
<h2>Choose the stage you want to be at in 3-5 years:</h2>
        <br />
        <h3>Instructions</h3>
		<p>Select one that is truest for you.</p>
		<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
			
					<label><input type="radio" name="development2" value="Child">Child</label>
					<label><input type="radio" name="development2" value="Adolescent">Adolescent</label>
					<label><input type="radio" name="development2" value="Young Adult">Young Adult</label>
					<label><input type="radio" name="development2" value="Adult">Adult</label>
					<label><input type="radio" name="development2" value="Senior">Senior</label>
			<p>Child (You’re mostly in receiving mode, may have a few “household” tasks.)<br />
            Adolescent (You have more household tasks, some responsibility, developing rapidly.)<br />
			Young Adult (You require less supervision, take more responsibility, separating from parents/leaders.)<br />
			Adult (You’re reproducing spiritual children and helping them grow, may be married with actual kids, focused on next generation.)<br />
			Senior (Your kids (spiritual or biological) are on their own, you’re providing counsel, help, overseeing, focused on grandchildren)</p>
			
             <!--- <div style="float:left;margin:10px 40px 0px 40px;">
            Instructions:<br />
            Pick the one sphere (A-E) you're drawn to impact. Then pick the two sub-spheres you are drawn to impact. Only use undecided if you're really not sure.
Fill in the "Other" blank if you don't find an answer close enough to your interest.
 </div>--->
			<input class="btn primary" type="submit" name="submit" value="Next Step" />
            <input type="hidden" value="<cfoutput>#Encrypt('25,development-6-3,development2,development_2','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
		</form>
<br class="clear"/>
        
        <cfset progbar= (308 / 27) * (VARIABLES.vCount - 1)>
        <div class="percent_complete_label">% of survey completed</div><div class="percent_completed"><img src="/site_images/progbar_pix.png" width="<cfoutput>#progbar#</cfoutput>" height="21"></div>

			