<h2><cfoutput>#(VARIABLES.vCount - 1)#</cfoutput>. I feel most passionate about the following societal causes:</h2>
<h3>Instructions</h3>
<p>Select two that are truest for you.</p>

<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
	
	<div class="controls">
		<div class="inputs-list">
			<label class="checkbox"><input type="checkbox" class="checkbox" name="passion" value="Human Reproduction" />Human Reproduction (Right to life, abortion, birth control, adoption, crisis pregnancy, euthanasia, stem cell research, genetics, bioethics, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="passion" value="Broken Families" />Broken Families (Divorce, child neglect, teen problems and issues, abuse physical or emotional, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="passion" value="Economic issues" />Economic issues (Poverty, homelessness, hunger, unsafe water, disease, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="passion" value="Ignorance" />Ignorance (Illiteracy, education and empowerment, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="passion" value="Justice Issues" />Justice Issues (Human trafficking, racism, oppression, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="passion" value="Political" />Political (War, corruption, legislative process, political ideology, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="passion" value="Environmental" />Environmental (Recycling, natural resources, endangered species, animal cruelty, climate change, etc.)</label>
		</div>
	</div>

	<!---CLIP #1--->
	<div class="form-actions"><input class="btn btn-primary" type="submit" name="submit" value="Next Step" /></div>
	<input type="hidden" value="<cfoutput>#Encrypt('8,causes_human-2-2,passion,causes_societal','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
</form>