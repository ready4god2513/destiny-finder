<cfcomponent displayname="profiler" output="no" hint="I handle the profiler summary reports">
	
	
	<cfset variables.user_id = "" />
	
	
	<cffunction name="init" output="false">
		<cfargument name="user_id" type="numeric" required="true" />
		
		<cfset variables.user_id = ARGUMENTS.user_id />
		<cfreturn this />
	</cffunction>
	
	
	<cffunction name="summary" output="true" return="void">
		
		<cfset var local = {} />
		<cfset local.queries = CreateObject("component","cfcs.queries")>
		<cfset local.assessments = CreateObject("component","cfcs.assessment")>
		<cfset local.delightSurvey = CreateObject("component","cfcs.delight") />
		<cfset local.passionSurveyObj = CreateObject("component","cfcs.passion").init(user_id = REQUEST.user_id) />
		<cfset local.supernaturalSurveyObj = CreateObject("component","cfcs.supernatural").init(user_id = REQUEST.user_id) />
		<cfset local.delightSurvey = CreateObject("component","cfcs.delight") />
		<cfset local.delightResults = local.delightSurvey.getResults(user_id = variables.user_id) />
		<cfset local.comparedResults = local.delightSurvey.compareResults(aptitudes = local.delightResults.aptitudes, delights = local.delightResults.delights) />
		
		<cfoutput>
			<div class="row">
				<div class="span7">
					<h2>Destiny Profiler Summary</h2>
					<h6>#local.queries.username(variables.user_id)# - #DateFormat(now(), "mmmm d, yyyy")#</h6>
				</div>
				
				<cfif not isDefined("URL.pdf")>
					<div class="pull-right">
						<a href="/profiler/summary.cfm?pdf=true" target="_blank" class="btn btn-info">Print PDF</a>
					</div>
				</cfif>
			</div>
			
			
			<h3>Introduction</h3>
			<p>
				This summary shows your top two or three orientations for each orientation type. 
				Keep in mind that this is not set in stone. These are orientations, and that means it's a general direction or tendency. 
				Each person functions a little differently from everyone else. You are unique. 
				Let these results help guide you as you pray, organize your thoughts, get counsel and move forward. 
				Be intentional, trust the Lord, and He will guide you.
			</p>
			
			<h3>Destiny Orientations</h3>
			<cfset local.destiny_assessment = local.assessments.retrieve_assessments(2) />
			<cfset local.destiny_results = local.assessments.retrieve_result(user_id = variables.user_id, assessment_id = 2) />
			<cfset local.responses = local.assessments.parse_responses(results = local.destiny_results, gift_type_id = local.destiny_assessment.gift_type_id) />
			<cfset local.top_destiny = local.assessments.get_top_gifts(local.responses) />
			<ol>
				<li>Primary Destiny Orientation - #local.assessments.get_gift_name(local.top_destiny[1].id)#</li>
				<li>Secondary Destiny Orientation - #local.assessments.get_gift_name(local.top_destiny[2].id)#</li>
			</ol>
			
			<h3>Motivational Orientations</h3>
			<cfset local.motivational_assessment = local.assessments.retrieve_assessments(3) />
			<cfset local.motivational_results = local.assessments.retrieve_result(user_id = variables.user_id, assessment_id = 3) />
			<cfset local.responses = local.assessments.parse_responses(results = local.motivational_results, gift_type_id = local.motivational_assessment.gift_type_id) />
			<cfset local.top_motivational = local.assessments.get_top_gifts(local.responses) />
			<ol>
				<li>Primary Motivational Orientation - #local.assessments.get_gift_name(local.top_motivational[1].id)#</li>
				<li>Secondary Motivational Orientation - #local.assessments.get_gift_name(local.top_motivational[2].id)#</li>
			</ol>
			
			<h3>Supernatural Orientations</h3>
			<cfset local.survey_results = local.supernaturalSurveyObj.sortResults() />
			<ol>
				<cfloop query="local.survey_results" endRow="3">
					<li>#name#</li>
				</cfloop>
			</ol>
			
			#local.passionSurveyObj.calculateResults()#
			
			<h3>Aptitude-Delight Matches</h3>
			<h6>Top aptitude and delight matches</h6>
			<cfif ArrayLen(local.comparedResults) GT 0>
				<ol>
					<cfloop array="#local.comparedResults#" index="i">
						<li><cfoutput>#i#</cfoutput></li>
					</cfloop>
				</ol>
			<cfelse>
				<p>
					Unfortunately We didn't find any matches for your aptitudes and delights.
				</p>
			</cfif>
			
			<h3>Next Steps</h3>
			<p>Congratulations! You've taken a major step forward on your destiny journey. You can print the summary</p>

			<p>Pray over these results and start making some notes about what you see.</p>

			<p>
				You can find more extensive information on the surveys and about destiny 
				in our <a href="/free/index.cfm?page=resourcesoverview&gateway=6&parent_gateway=6">Resources section</a>
			</p>
			
			<p>
				We encourage you to take advantage of the destiny coaching that we offer. 
				Working with a coach will greatly speed up your progress and help bring clarity. 
				For more information, <a href="/products/index.cfm?page=coaching&gateway=3&parent_gateway=3">see coaching</a>
			</p>
			
			<p>
				We will be releasing the Destiny Planner later this year. It will help you take the destiny profile you've now 
				developed and work with a coach and some more surveys to plan out the next steps on your journey. Stay tuned!
			</p>
			

			<p>
				Remember to invite your friends to <a href="/profile/?page=invmod">take the Free Trial Destiny Survey about you</a> - that will give you helpful feedback.
			</p>
			
			<p>
				Check out our <a href="/blog/">blog</a><br />
				And like us on <a href="https://www.facebook.com/destinyfinder1">Facebook</a>.
			</p>

			<p>
				Keep moving forward!<br />
				--the Destiny Staff
			</p>
			
			<div class="row">
				
				<cfif not isDefined("URL.pdf")>
					<div class="pull-right">
						<a href="/profiler/summary.cfm?pdf=true" target="_blank" class="btn btn-info">Print PDF</a>
					</div>
				</cfif>
			</div>
		</cfoutput>
		
	</cffunction>
	
	
</cfcomponent>