<h2>Sphere</h2>
<h3>Instructions</h3>
<p>Pick the one sphere you're drawn to impact.  Only use undecided if you're really not sure.</p>
<form name="form" action="act_passion_survey.cfm" class="survey-form" method="post">
	<div class="input">
		<ul class="inputs-list">
			<li><label><input type="radio" name="sphere" value="Family and Individual">Family and Individual</label></li>
			<li><label><input type="radio" name="sphere" value="Culture and Lifestyle">Culture and Lifestyle</label></li>
			<li><label><input type="radio" name="sphere" value="Business and Economics">Business and Economics</label></li>
			<li><label><input type="radio" name="sphere" value="Government Legal and NonProfit">Government, Legal and Non-Profit</label></li>
			<li><label><input type="radio" name="sphere" value="Religion and Spirituality">Religion and Spirituality</label></li>
		</ul>
	</div>
	

	<div class="actions"><input class="btn primary" type="submit" name="submit" value="Next Step" /></div>
	<input type="hidden" value="<cfoutput>#Encrypt('2,sphere-1,sphere,sphere','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
</form>

<cfset progbar= 0>
<div class="percent_complete_label">% of survey completed</div><div class="percent_completed"><img src="/assets/images/progbar_pix.png" width="<cfoutput>#progbar#</cfoutput>" height="21"></div>