<cfset delightSurvey = CreateObject("component","cfcs.delight") />
<cfset delightResults = delightSurvey.getResults(user_id = REQUEST.user_id) />
<cfset comparedResults = delightSurvey.compareResults(aptitudes = delightResults.aptitudes, delights = delightResults.delights) />


<div class="row">
	<div class="span8">
		<h2>Delight Results</h2>
	</div>
	<div class="pull-right">
		<a href="/profile/?page=viewresult&assessment_id=6&gift_type_id=0&pdf=true" class="btn btn-info">Print Results (PDF)</a>
	</div>
</div>

<cfif ArrayLen(comparedResults) GT 0>
	<ol>
		<cfloop array="#comparedResults#" index="i">
			<li><cfoutput>#i#</cfoutput></li>
		</cfloop>
	</ol>
	
	<p>
		These delights are key for you. They are the things that you're both really good at and you
		love doing. Your destiny will probably include one or more of these things. You should try
		to aim for these things because if you are able to combine what you're really gifted at, with
		what you're most passionate about, you'll be the most productive and the most fulfilled you
		can be.
	</p>
	<p>
		Start thinking about how to do more of what you love and are good at.
	</p>
	
<cfelse>
	<p>
		Unfortunately We didn't find any matches for your aptitudes and delights.
	</p>
</cfif>

<h3>Next Step</h3>
<p>
	If you've done the surveys in sequence, you've now finished all the surveys in the Profiler. Way
	to go! That's a lot of work. The results from all five surveys of the Destiny Profiler make up
	a "destiny profile." You should now have a good grasp of how you've been designed by God.
	This will help you begin to map the journey into your destiny.
</p>
<p>
	The next step is to get the Profiler Summary Report. It has a summary of all the surveys
	you've done that you can print out.
</p>
<a href="/profiler/summary.cfm" class="btn">Profiler Summary Report</a>
<p>
	We encourage you to engage a coach at any time to help you interpret your destiny profile. 
	<a href="/products/index.cfm?page=coaching&gateway=3&parent_gateway=3">See Coaching</a>
</p>

<div class="row">
	<div class="pull-right">
		<a href="/profile/?page=viewresult&assessment_id=6&gift_type_id=0&pdf=true" class="btn btn-info">Print Results (PDF)</a>
	</div>
</div>