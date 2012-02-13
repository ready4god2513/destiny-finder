<h2><cfoutput>#(VARIABLES.vCount - 1)#</cfoutput>. I feel most passionate about the following societal causes:</h2>
<h3>Instructions</h3>
<p>Select two that are truest for you.</p>

<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
	
	<div class="input">
		<ul class="inputs-list">
			<li><label><input type="checkbox" name="passion" value="Human Reproduction" />Human Reproduction (Right to life, abortion, birth control, adoption, crisis pregnancy, euthanasia, stem cell research, genetics, bioethics, etc.)</label></li>
			<li><label><input type="checkbox" name="passion" value="Broken Families" />Broken Families (Divorce, child neglect, teen problems and issues, abuse physical or emotional, etc.)</label></li>
			<li><label><input type="checkbox" name="passion" value="Economic issues" />Economic issues (Poverty, homelessness, hunger, unsafe water, disease, etc.)</label></li>
			<li><label><input type="checkbox" name="passion" value="Ignorance" />Ignorance (Illiteracy, education and empowerment, etc.)</label></li>
			<li><label><input type="checkbox" name="passion" value="Justice Issues" />Justice Issues (Human trafficking, racism, oppression, etc.)</label></li>
			<li><label><input type="checkbox" name="passion" value="Political" />Political (War, corruption, legislative process, political ideology, etc.)</label></li>
			<li><label><input type="checkbox" name="passion" value="Environmental" />Environmental (Recycling, natural resources, endangered species, animal cruelty, climate change, etc.)</label></li>
		</ul>
	</div>

	<!---CLIP #1--->
	<div class="actions"><input class="btn primary" type="submit" name="submit" value="Next Step" /></div>
	<input type="hidden" value="<cfoutput>#Encrypt('8,causes_human-2-2,passion,causes_societal','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
</form>
<br class="clear"/>
<cfset progbar= (308 / 27) * (VARIABLES.vCount - 1)>
<div class="percent_complete_label">% of survey completed</div>
<div class="percent_completed"><img src="/assets/images/progbar_pix.png" width="<cfoutput>#progbar#</cfoutput>" height="21"></div>

<!---
<div style="float:left;margin:10px 40px 0px 40px;">
Instructions:<br />
Pick the one sphere (A-E) you're drawn to impact. Then pick the two sub-spheres you are drawn to impact. Only use undecided if you're really not sure.
Fill in the "Other" blank if you don't find an answer close enough to your interest.
</div>

--->