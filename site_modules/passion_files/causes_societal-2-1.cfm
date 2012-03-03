<h2>I feel most passionate about the following societal causes:</h2>
<h3>Instructions</h3>
<p>Select two that are truest for you.</p>

<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
	
	<div class="controls">
		<div class="inputs-list">
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_societal" value="Human Reproduction" />Human Reproduction (Right to life, abortion, birth control, adoption, crisis pregnancy, euthanasia, stem cell research, genetics, bioethics, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_societal" value="Broken Families" />Broken Families (Divorce, child neglect, teen problems and issues, abuse physical or emotional, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_societal" value="Economic issues" />Economic issues (Poverty, homelessness, hunger, unsafe water, disease, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_societal" value="Ignorance" />Ignorance (Illiteracy, education and empowerment, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_societal" value="Justice Issues" />Justice Issues (Human trafficking, racism, oppression, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_societal" value="Political" />Political (War, corruption, legislative process, political ideology, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_societal" value="Environmental" />Environmental (Recycling, natural resources, endangered species, animal cruelty, climate change, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_societal" value="None/Other">None/Other</label>
			<label class="checkbox"><input type="text" name="causes_societal" placeholder="Other causes"/></label>
		</div>
	</div>

	<!---CLIP #1--->
	<div class="form-actions"><input class="btn btn-primary" type="submit" name="submit" value="Next Step" /></div>
	<input type="hidden" value="<cfoutput>#Encrypt('8,causes_human-2-2,causes_societal,causes_societal','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
</form>