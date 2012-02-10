<cfset delightSurvey = CreateObject("component","cfcs.delight") />
<cfset delightResults = delightSurvey.getResults(user_id = REQUEST.user_id) />

<h1>Delight Results</h1>
<cfdump var="#delightSurvey.compareResults(aptitudes = delightResults.aptitudes, delights = delightResults.delights)#">