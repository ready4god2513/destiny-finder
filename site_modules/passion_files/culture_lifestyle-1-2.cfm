<h5>2. Culture and Lifestyle</h5>
<cfinclude template="instructions-multiple.cfm">
<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
	<div class="controls">
		<div class="inputs-list">
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1" value="Cultural Expression">Cultural Expression (styles, trends, symbols, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1" value="Entertainment, Sports and Games">Entertainment, Sports and Games (music, movies, TV, sports, comics, video games, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1" value="Performing and Visual Arts">Performing and Visual Arts (theater, dance, fashion, photography, graphic arts, fine arts, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1" value="Traditional Media">Traditional Media (TV news, magazines, newspapers, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1" value="Digital Media">Digital Media (Internet, social networking, blogs, etc.)</label>
			<label class="checkbox"><input type="text" name="sphere_sub1" placeholder="other"/></label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1" value="undecided">Undecided</label>
		</div>
	</div>

	<!---CLIP #1--->
	<div class="form-actions"><input class="btn btn-primary" type="submit" name="submit" value="Next Step" /></div>
	<input type="hidden" value="<cfoutput>#Encrypt('4,causes_societal-2-1,sphere_sub1,sphere_sub1','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
</form>
<br class="clear"/>