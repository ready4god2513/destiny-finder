
<h2><cfoutput>#(VARIABLES.vCount - 1)#</cfoutput>. Choose the stage you want to be at in 5-10 years:</h2>
<br />
<h3>Instructions</h3>
<p>Select one that is truest for you.</p>
<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
	<div class="controls">
		<div class="inputs-list">
			<label class="radio"><input type="radio" name="development" value="Child">Child (You're mostly in receiving mode, may have a few "household" tasks.)</label>
			<label class="radio"><input type="radio" name="development" value="Adolescent">Adolescent (You have more household tasks, some responsibility, developing rapidly.)</label>
			<label class="radio"><input type="radio" name="development" value="Young Adult">Young Adult (You require less supervision, take more responsibility, separating from parents/leaders.)</label>
			<label class="radio"><input type="radio" name="development" value="Adult">Adult (You're reproducing spiritual children and helping them grow, may be married with actual kids, focused on next generation.)</label>
			<label class="radio"><input type="radio" name="development" value="Senior">Senior (Your kids (spiritual or biological) are on their own, you're providing counsel, help, overseeing, focused on grandchildren)</label>
		</div>
	</div>



	<!--- <div style="float:left;margin:10px 40px 0px 40px;">
	Instructions:<br />
	Pick the one sphere (A-E) you're drawn to impact. Then pick the two sub-spheres you are drawn to impact. Only use undecided if you're really not sure.
	Fill in the "Other" blank if you don't find an answer close enough to your interest.
	</div>--->
	<div class="form-actions"><input class="btn btn-primary" type="submit" name="submit" value="Next Step" /></div>
	<input type="hidden" value="<cfoutput>#Encrypt('26,surveydone,development3,development_3','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
	<input type="hidden" value="1" name="surveydone" />

</form>

	
		


