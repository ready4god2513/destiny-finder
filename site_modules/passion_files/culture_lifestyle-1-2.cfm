
<h5>Culture and Lifestyle</h5>
<br />

<h6>Instructions</h6>
<p>Pick the two sub-spheres you are drawn to impact. Only use undecided if You're really not sure.</p>
<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
	<div class="controls">
		<div class="inputs-list">
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1" value="Cultural Expression">Cultural Expression (Cultures, sub-cultures, styles, trends, symbols, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1" value="Entertainment, Sports and Games">Entertainment, Sports and Games (Music, movies, TV, sports, comics, video games, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1" value="Performing and Visual Arts">Performing and Visual Arts (Theater, dance, fashion, photography, graphic arts, fine arts, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1" value="Traditional Media">Traditional Media (TV news, magazines, newspapers, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="sphere_sub1" value="Digital Media">Digital Media (Internet, social networking, etc.)</label>
			<label class="checkbox"><input type="text" name="sphere_sub1" placeholder="Other impact sphere"/></label>
		</div>
	</div>

	<!---CLIP #1--->
	<div class="form-actions"><input class="btn btn-primary" type="submit" name="submit" value="Next Step" /></div>
	<input type="hidden" value="<cfoutput>#Encrypt('4,causes_societal-2-1,sphere_sub1,sphere_sub1','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
</form>
<br class="clear"/>