<h2>4. When I'm meeting with a group of believers I will</h2>

<cfset types = ArrayNew(2) />
<cfset types[1] = ["Discerning of Spirits", "sense the presence of demonic activity in a person or situation."] />
<cfset types[2] = ["Gifts of Healings", "minister healing to someone who is sick or injured in the group."] />
<cfset types[3] = ["Faith", "experience a rush of confidence concerning a promise of God."] />
<cfset types[4] = ["Prophecy", "speak encouraging words specifically from God for the group."] />
<cfset types[5] = ["Interpretation of Tongues", "interpret a message in tongues shared for the group."] />
<cfset types[6] = ["Kinds of Tongues", "speak in an unlearned language in response to the Holy Spirit."] />
<cfset types[7] = ["Word of Knowledge", "get an impression of an emotional or physical need."] />
<cfset types[8] = ["Word of Wisdom", "have a clear sense of direction for the group or the meeting."] />
<cfset types[9] = ["Working of Miracles", "be used by God to bring about an extraordinary miracle."] />

<form action="/profile/?page=assessment&assessment_id=4&gift_type_id=3&complete=true" class="survey-form" method="post">

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
		<input class="btn btn-primary" type="submit" name="submit" value="Complete Survey" />
	</div>
</form>

<div class="percent_complete_label">% of survey completed</div>
<div class="progress progress-info progress-striped active">
	<div class="bar" style="width: 75%;"></div>
</div>

<script>
	$(function(){
		$(".progress .bar").css("width", "75%");
	});
</script>