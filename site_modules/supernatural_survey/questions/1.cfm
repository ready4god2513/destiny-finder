<h2>1. I am used by God in the following gifts</h2>

<cfset types = ["Discerning of Spirits", "Gifts of Healings", "Faith", "Prophecy", "Interpretation of Tongues", "Kinds of Tongues", "Word of Knowledge", "Word of Wisdom", "Working of Miracles"]>

<form action="/profile/?page=assessment&assessment_id=4&gift_type_id=3&question=2" class="survey-form" method="post">
	
	<cfloop array="#types#" index="name">
		<cfoutput>
			<div class="control-group">
				<label class="control-label">#name#</label>
				<div class="controls">
					<label class="radio">
						<input type="radio" name="#name#" value="5" checked="" />
						5 (Most Often)
					</label>
					<label class="radio">
						<input type="radio" name="#name#" value="4" checked="" />
						4 (Often)
					</label>
					<label class="radio">
						<input type="radio" name="#name#" value="3" checked="" />
						3 (Sometimes)
					</label>
					<label class="radio">
						<input type="radio" name="#name#" value="2" checked="" />
						2 (Occasionally)
					</label>
					<label class="radio">
						<input type="radio" name="#name#" value="1" checked="" />
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
	<div class="bar" style="width: 0%;"></div>
</div>