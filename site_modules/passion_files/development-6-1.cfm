
<h2>Right now I am in the following stage of destiny development:</h2>
<br />
<h3>Instructions</h3>
<p>Select one that is truest for you.</p>
<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">

	<div class="input">
		<ul class="inputs-list">
			<li><label><input type="radio" name="development" value="Child">Child</label></li>
			<li><label><input type="radio" name="development" value="Adolescent">Adolescent</label></li>
			<li><label><input type="radio" name="development" value="Young Adult">Young Adult</label></li>
			<li><label><input type="radio" name="development" value="Adult">Adult</label></li>
			<li><label><input type="radio" name="development" value="Senior">Senior</label></li>
		</ul>
	</div>



	<p>Child (You're mostly in receiving mode, may have a few household tasks.)<br />
		Adolescent (You have more household tasks, some responsibility, developing rapidly.)<br />
		Young Adult (You require less supervision, take more responsibility, separating from parents/leaders.)<br />
		Adult (You're reproducing spiritual children and helping them grow, may be married with actual kids, focused on next generation.)<br />
		Senior (Your kids (spiritual or biological) are on their own, You're providing counsel, help, overseeing, focused on grandchildren)</p>

		<!--- <div style="float:left;margin:10px 40px 0px 40px;">
		Instructions:<br />
		Pick the one sphere (A-E) you're drawn to impact. Then pick the two sub-spheres you are drawn to impact. Only use undecided if you're really not sure.
		Fill in the "Other" blank if you don't find an answer close enough to your interest.
		</div>--->
		<div class="actions"><input class="btn primary" type="submit" name="submit" value="Next Step" /></div>
		<input type="hidden" value="<cfoutput>#Encrypt('24,development-6-2,development,development_1','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
	</form>
	<br class="clear"/>

	<cfset progbar= (308 / 27) * (VARIABLES.vCount - 1)>
		<div class="percent_complete_label">% of survey completed</div><div class="percent_completed"><img src="/assets/images/progbar_pix.png" width="<cfoutput>#progbar#</cfoutput>" height="21"></div>



