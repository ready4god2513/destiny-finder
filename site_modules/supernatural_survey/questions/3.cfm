<h2>3. When interacting with others I find myself</h2>

<cfset types = ArrayNew(2) />
<cfset types[1] = ["Discerning of Spirits", "perceiving the enemy's work and taking authority over it."] />
<cfset types[2] = ["Gifts of Healings", "feeling a deep empathy toward anyone ill or injured."] />
<cfset types[3] = ["Faith", "certain of answered prayer for their impossible situations."] />
<cfset types[4] = ["Prophecy", "sensing words of strength and comfort from God for them. "] />
<cfset types[5] = ["Interpretation of Tongues", "sensing the meaning of a message in tongues given by me or another."] />
<cfset types[6] = ["Kinds of Tongues", "praying in a language I don’t understand."] />
<cfset types[7] = ["Word of Knowledge", "suddenly knowing things I couldn’t have known naturally."] />
<cfset types[8] = ["Word of Wisdom", "sensing answers to their problems that exceed my natural ability."] />
<cfset types[9] = ["Working of Miracles", "praying and seeing God answer spectacularly in public ways."] />

<form action="/profile/?page=assessment&assessment_id=4&gift_type_id=3&question=4" class="survey-form" method="post">
	
	<cfloop array="#types#" index="name">
		<cfoutput>
			<div class="control-group">
				<label class="control-label">#name[2]#</label>
				<div class="controls">
					<label class="radio">
						<input type="radio" name="#name[1]#" value="5" checked="" />
						5 (Most Often)
					</label>
					<label class="radio">
						<input type="radio" name="#name[1]#" value="4" checked="" />
						4 (Often)
					</label>
					<label class="radio">
						<input type="radio" name="#name[1]#" value="3" checked="" />
						3 (Sometimes)
					</label>
					<label class="radio">
						<input type="radio" name="#name[1]#" value="2" checked="" />
						2 (Occasionally)
					</label>
					<label class="radio">
						<input type="radio" name="#name[1]#" value="1" checked="" />
						1 (Never)
					</label>
				</div>
			</div>
		</cfoutput>
	</cfloop>
	

	<!---CLIP #1--->
	<div class="form-actions">
		<input class="btn btn-primary" type="submit" name="submit" value="Next Step" />
	</div>
</form>

<div class="percent_complete_label">% of survey completed</div>
<div class="progress progress-info progress-striped active">
	<div class="bar" style="width: 50%;"></div>
</div>

<script>
	$(function(){
		$(".progress .bar").css("width", "50%");
	});
</script>