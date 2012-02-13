<h2><cfoutput>#(VARIABLES.vCount - 1)#</cfoutput>. Business and Economics</h2>
<h3>Instructions</h3>
<p>Pick the two sub-spheres you are drawn to impact. Only use undecided if you're really not sure.</p>

<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
	
	<div class="input">
		<ul class="inputs-list">
			<li><label><input type="checkbox" name="business_economics" value="Finance, Investment, Insurance and Realestate">Finance, Investment, Insurance and Real estate</label></li>
			<li><label><input type="checkbox" name="business_economics" value="Science, Technology, Energy and R&amp;D">Science, Technology, Energy and R&amp;D</label></li>
			<li><label><input type="checkbox" name="business_economics" value="Manufacturing, Distribuation and Service">Manufacturing, Distribution and Service</label></li>
			<li><label><input type="checkbox" name="business_economics" value="Trades, Transportation, and Technical Services">Trades, Transportation, and Technical Services</label></li>
			<li><label><input type="checkbox" name="business_economics" value="Tourism, Travel, Hospitatily and Culinary">Tourism, Travel, Hospitality and Culinary</label></li>
			<li><label><input type="checkbox" name="business_economics" value="Sales, Marketing and Advertising">Sales, Marketing and Advertising</label></li>
			<li><label><input type="checkbox" name="business_economics" value="Undecided">Undecided</label></li>
		</ul>
	</div>
	

	<div class="actions"><input class="btn primary" type="submit" name="submit" value="Next Step" /></div>
	<input type="hidden" value="<cfoutput>#Encrypt('5,causes_societal-2-1,business_economics,sphere_sub1','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
</form>

<cfset progbar= (308 / 27) * (VARIABLES.vCount - 1)>
<div class="percent_complete_label">% of survey completed</div><div class="percent_completed"><img src="/assets/images/progbar_pix.png" width="<cfoutput>#progbar#</cfoutput>" height="21"></div>