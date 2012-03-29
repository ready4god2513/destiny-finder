<cfset delightSurvey = CreateObject("component","cfcs.supernatural") />
<cfparam name="URL.question" default="1" min="1" max="4" type="range" />

<cfinclude template="../supernatural_survey/questions/#URL.question#.cfm" />