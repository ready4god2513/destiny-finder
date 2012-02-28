<h2>Business and Economics</h2>
<h3>Instructions</h3>
<p>Pick the two sub-spheres you are drawn to impact. Fill in your own answer if no other matches.</p>

<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
	
	<div class="control-group">
		<div class="inputs-list">
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1" value="Finance, Investment, Insurance and Realestate">Finance, Investment, Insurance and Real estate</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1" value="Science, Technology, Energy and R&amp;D">Science, Technology, Energy and R&amp;D</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1" value="Manufacturing, Distribuation and Service">Manufacturing, Distribution and Service</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1" value="Trades, Transportation, and Technical Services">Trades, Transportation, and Technical Services</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1" value="Tourism, Travel, Hospitatily and Culinary">Tourism, Travel, Hospitality and Culinary</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1" value="Sales, Marketing and Advertising">Sales, Marketing and Advertising</label>
			<label class="checkbox"><input type="text" name="sphere_sub1" placeholder="Other impact sphere"/></label>
		</div>
	</div>
	

	<div class="form-actions"><input class="btn btn-primary" type="submit" name="submit" value="Next Step" /></div>
	<input type="hidden" value="<cfoutput>#Encrypt('5,causes_societal-2-1,sphere_sub1,sphere_sub1','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
</form>

