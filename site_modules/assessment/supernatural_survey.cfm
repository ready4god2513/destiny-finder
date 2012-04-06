<cfif NOT isDefined("URL.complete") AND NOT isDefined("URL.question")>
	<cfinclude template="../supernatural_survey/intro.cfm" />
<cfelse>
	<cfset delightSurvey = CreateObject("component","cfcs.supernatural").init(user_id = REQUEST.user_id) />
	<cfparam name="URL.question" default="1" min="1" max="4" type="range" />
	<cfset percentage="#(((URL.question - 1) / 4) * 100)#">

	<cfif isDefined("URL.complete")>
		<cfset delightSurvey.insertRecord(items = FORM) />
		<cflocation url="/profile/?page=viewresult&assessment_id=4&gift_type_id=3" addtoken="no" />
	</cfif>

	<cfif URL.question EQ 4>
		<cfset action = "/profile/?page=assessment&assessment_id=4&gift_type_id=3&complete=true">
	<cfelse>
		<cfset action = "/profile/?page=assessment&assessment_id=4&gift_type_id=3&question=#(URL.question + 1)#">
	</cfif>

	<form action="<cfoutput>#action#</cfoutput>" class="survey-form" method="post">
		<cfinclude template="../supernatural_survey/questions/#URL.question#.cfm" />
		
		<cfset CreateObject("java", "java.util.Collections").Shuffle(types) />
	
		<cfloop array="#types#" index="name">
			<cfparam name="FORM['#name[1]#']" default="0">
			<cfoutput>
				<div class="control-group">
					<label class="control-label">#name[2]#</label>
					<div class="controls">
						<label class="radio inline">
							<input type="radio" name="#name[1]#" value="#(FORM[name[1]] + 4)#" checked="checked" />
							Very Often
						</label>
						<label class="radio inline">
							<input type="radio" name="#name[1]#" value="#(FORM[name[1]] + 3)#" />
							Often
						</label>
						<label class="radio inline">
							<input type="radio" name="#name[1]#" value="#(FORM[name[1]] + 2)#" />
							Sometimes
						</label>
						<label class="radio inline">
							<input type="radio" name="#name[1]#" value="#(FORM[name[1]] + 1)#" />
							Rarely
						</label>
						<label class="radio inline">
							<input type="radio" name="#name[1]#" value="#(FORM[name[1]])#" />
							Never
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
			<div class="bar" style="width: <cfoutput>#percentage#</cfoutput>%;"></div>
		</div>

		<script>
			$(function(){
				$(".progress .bar").css("width", "<cfoutput>#percentage#</cfoutput>%");
			});
		</script>
	</form>
</cfif>