<h2>2. When I am praying I feel impressed with</h2>

<cfset types = ArrayNew(2) />
<cfset types[1] = ["Discerning of Spirits", "awareness of the strategies of the enemy against others."] />
<cfset types[2] = ["Gifts of Healings", "a sense of authority over sickness and disease."] />
<cfset types[3] = ["Faith", "a confidence in God for impossible things."] />
<cfset types[4] = ["Prophecy", "a word of encouragement for a friend or family member."] />
<cfset types[5] = ["Interpretation of Tongues", "the understanding of a message spoken in an unknown language."] />
<cfset types[6] = ["Kinds of Tongues", "an urge to speak a message to/from God in an unknown language."] />
<cfset types[7] = ["Word of Knowledge", "solutions to problems or challenging situations."] />
<cfset types[8] = ["Word of Wisdom", "information about a person or situation."] />
<cfset types[9] = ["Working of Miracles", "a sense of boldness to partner with God for the miraculous."] />

<form action="/profile/?page=assessment&assessment_id=4&gift_type_id=3&question=3" class="survey-form" method="post">
	
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
	<div class="bar" style="width: 25%;"></div>
</div>

<script>
	$(function(){
		$(".progress .bar").css("width", "25%");
	});
</script>