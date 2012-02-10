<h4>Top Aptitudes</h4>
<p>
	<strong>Instructions:</strong> List the top 10 things (skills, professions, strengths, abilities, hobbies, sports, etc.) you are best at doing.
</p>
<p>
	Use as few words as possible.
</p>

<p>
	Example: accounting, basketball, organizing, singing, fishing, writing poetry, video games, finding bargains, statistical analysis, programming
</p>

<cfoutput>
	<form action="/profile/?page=assessment&assessment_id=6&gift_type_id=0" method="POST" id="listing-aptitudes">
		<cfloop from="1" to="20" index="i">
			<div class="clearfix">
				<label for="aptitudes#i#">#i#.</label>
				<div class="input">
					<input type="text" id="aptitudes#i#" name="aptitudes" class="required" />
				</div>
			</div>
		</cfloop>
		
		
		<h4>Top Delights</h4>
		<p>
			Now list the top things you love to do or are most passionate about (skills, professions,
			strengths, abilities, hobbies, sports, etc ).
		</p>
		<p>
			Example: singing, basketball, organizing, sewing, fishing, coaching, writing poetry,
			video games, finding bargains, statistical analysis, programming, running, decorating,
			comforting people, helping.
		</p>
		<p>
			Don't limit yourself; even if it sounds a bit crazy, if you love to do it, put it down.
		</p>
		<cfloop from="1" to="20" index="i">
			<div class="clearfix">
				<label for="delights#i#">#i#.</label>
				<div class="input">
					<input type="text" id="delights#i#" name="delights" class="required" />
				</div>
			</div>
		</cfloop>

		<div class="actions">
			<input type="submit" name="submit" value="Submit Answers" class="btn info" />
		</div>
	</form>
</cfoutput>

<script>
	$(function(){
		// Form Validations
		$("#listing-aptitudes").validate();
	});
</script>