
<h2><cfoutput>#(VARIABLES.vCount - 1)#</cfoutput>. Culture and Lifestyle</h2>
<br />

<h3>Instructions</h3>
<p>Pick the two sub-spheres you are drawn to impact. Only use undecided if You're really not sure.</p>
<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
	<div class="controls">
		<div class="inputs-list">
			<label class="checkbox"><input type="checkbox" class="checkbox" name="culture_lifestyle" value="Cultural Expression">Cultural Expression (Cultures, sub-cultures, styles, trends, symbols, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="culture_lifestyle" value="Entertainment, Sports and Games">Entertainment, Sports and Games (Music, movies, TV, sports, comics, video games, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="culture_lifestyle" value="Performing and Visual Arts">Performing and Visual Arts (Theater, dance, fashion, photography, graphic arts, fine arts, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="culture_lifestyle" value="Traditional Media">Traditional Media (TV news, magazines, newspapers, etc.)</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="culture_lifestyle" value="Digital Media">Digital Media (Internet, social networking, etc.)</label>
		</div>
	</div>

	<!---CLIP #1--->
	<div class="form-actions"><input class="btn btn-primary" type="submit" name="submit" value="Next Step" /></div>
	<input type="hidden" value="<cfoutput>#Encrypt('4,causes_societal-2-1,culture_lifestyle,sphere_sub1','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
</form>
<br class="clear"/>

	

<!---
<div style="float:left;margin:10px 40px 0px 40px;">
Instructions:<br />
Pick the one sphere (A-E) you're drawn to impact. Then pick the two sub-spheres you are drawn to impact. Only use undecided if you're really not sure.
Fill in the "Other" blank if you don't find an answer close enough to your interest.
</div>

--->