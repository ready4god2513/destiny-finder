<h5>2. Business and Economics</h5>
<cfinclude template="instructions-multiple.cfm">

<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
	
	<div class="control-group">
		<div class="inputs-list">
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1" value="Basic Foods &amp; Raw Materials">Basic Foods & Raw Materials (including agriculture, fishing, forestry, mining, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1" value="Manufacturing &amp; Construction">Manufacturing & Construction (including processing, chemical, engineering, energy, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1" value="Retail, Wholesale & Service">Retail, Wholesale & Service (including restaurants, clerical, trades, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1" value="Transportation & Distribution">Transportation & Distribution (including tourism, travel, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1" value="Financial Services & Real Estate">Financial Services & Real Estate (including banking, insurance, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1" value="Science & Technology">Science & Technology (including R&D, information technology, communications, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1"><input type="text" name="sphere_sub1" placeholder="other"/></label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1" value="undecided">Undecided</label>
		</div>
	</div>
	

	<div class="form-actions"><input class="btn btn-primary" type="submit" name="submit" value="Next Step" /></div>
	<input type="hidden" value="<cfoutput>#Encrypt('5,causes_societal-2-1,sphere_sub1,sphere_sub1','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
</form>

