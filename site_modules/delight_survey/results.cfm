<cfset delightSurvey = CreateObject("component","cfcs.delight") />
<cfset delightResults = delightSurvey.getResults(user_id = REQUEST.user_id) />
<cfset comparedResults = delightSurvey.compareResults(aptitudes = delightResults.aptitudes, delights = delightResults.delights) />

<h1>Delight Results</h1>

<cfif ArrayLen(comparedResults) GT 0>
	<ol>
		<cfloop array="#comparedResults#" index="i">
			<li><cfoutput>#i#</cfoutput></li>
		</cfloop>
	</ol>
	
	<p>
		These things are key for you. They are the things that you're both really good at
		and you love doing. Your destiny will probably include one or more of these things.
		You should try to aim for these things because if you are able to combine what
		you're really gifted at, with what you're most passionate about, you'll be the most
		productive and the most fulfilled you can be.
	</p>
	<p>
		Start thinking about how to do more of what you love and are good at.
	</p>
	
<cfelse>
	<p>
		We didn't find any matches... Needs verbiage from Michael, Tony, and Glen.
	</p>
</cfif>