<cfset delightSurvey = CreateObject("component","cfcs.supernatural") />
<cfparam name="URL.question" default="1" min="1" max="4" type="range" />

<form action="/profile/?page=assessment&assessment_id=4&gift_type_id=3&question=<cfoutput>#(URL.question + 1)#</cfoutput>" class="survey-form" method="post">
	<cfinclude template="../supernatural_survey/questions/#URL.question#.cfm" />
	
	<cfloop array="#types#" index="name">
		<cfparam name="FORM['#name[1]#']" default="0">
		<cfoutput>
			<div class="control-group">
				<label class="control-label">#name[2]#</label>
				<div class="controls">
					<label class="radio">
						<input type="radio" name="#name[1]#" value="#(FORM[name[1]] + 5)#" checked="checked" />
						5 (Most Often)
					</label>
					<label class="radio">
						<input type="radio" name="#name[1]#" value="#(FORM[name[1]] + 4)#" />
						4 (Often)
					</label>
					<label class="radio">
						<input type="radio" name="#name[1]#" value="#(FORM[name[1]] + 3)#" />
						3 (Sometimes)
					</label>
					<label class="radio">
						<input type="radio" name="#name[1]#" value="#(FORM[name[1]] + 2)#" />
						2 (Occasionally)
					</label>
					<label class="radio">
						<input type="radio" name="#name[1]#" value="#(FORM[name[1]] + 1)#" />
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

	<div class="percent_complete_label">% of survey completed</div>
	<div class="progress progress-info progress-striped active">
		<div class="bar" style="width: 50%;"></div>
	</div>

	<script>
		$(function(){
			$(".progress .bar").css("width", "50%");
		});
	</script>
</form>