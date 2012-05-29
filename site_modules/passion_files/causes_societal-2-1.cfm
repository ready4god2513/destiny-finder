<h5>3. I feel most passionate about the following causes:</h5>
<cfinclude template="instructions-multiple.cfm">

<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
	
	<div class="controls">
		<div class="inputs-list">
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_societal" value="Human Life Issues" />Human Life Issues (abortion, birth control, adoption, euthanasia, stem cell research, bioethics, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_societal" value="Family Health Issues" />Family Health Issues (divorce, child neglect, teen issues, abuse, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_societal" value="Economic issues" />Economic Issues (poverty, homelessness, hunger, unsafe water, disease, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_societal" value="Education Issues" />Education Issues (illiteracy, education and empowerment, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_societal" value="Justice Issues" />Justice Issues (human trafficking, racism, oppression, prison system, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_societal" value="Political Issues" />Political Issues (war, corruption, legislative process, political ideology, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_societal" value="Environmental Issues" />Environmental Issues (recycling, natural resources, endangered species, animal cruelty, climate change, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_societal"><input type="text" name="causes_societal" placeholder="other"/></label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_societal" value="undecided">Undecided</label>
		</div>
	</div>

	<!---CLIP #1--->
	<div class="form-actions"><input class="btn btn-primary" type="submit" name="submit" value="Next Step" /></div>
	<input type="hidden" value="<cfoutput>#Encrypt('8,causes_human-2-2,causes_societal,causes_societal','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
</form>