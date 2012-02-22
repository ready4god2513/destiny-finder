<cfset objQueries = CreateObject("component","cfcs.queries")>
<cfset objAssessments = CreateObject("component","cfcs.assessment")>
<cfset qUser = objQueries.user_detail(user_id="#REQUEST.user_id#")>
<cfset qAssessments = objAssessments.retrieve_assessments()>
<cfset qResults = objAssessments.retrieve_result(user_id="#REQUEST.user_id#")>
<cfset qInvites = objAssessments.retrieve_invites(user_id="#REQUEST.user_id#")>
<cfset VARIABLES.memberships = objAssessments.retrieve_membership(user_id="#REQUEST.user_id#")>
<cfset delightSurvey = CreateObject("component","cfcs.delight") />
<cfset passionSurveyObj = CreateObject("component","cfcs.passion").init(user_id = REQUEST.user_id) />

<cfoutput>
	<cfif isDefined("URL.pdf")>
		<cfdocument
			format="pdf">
			
			<cfdocumentitem type="header">
				<img src="/assets/images/logo.png" />
			</cfdocumentitem>
			<cfif URL.assessment_id LTE 4>
				#objAssessments.process_results(result_id="#val(qResults.result_id)#", assessment_id="#val(URL.assessment_id)#",gift_type_id="#val(URL.gift_type_id)#")#

			<cfelseif URL.assessment_id EQ 5>
				#passionSurveyObj.calculateResults()#
			</cfif>
			
			<cfdocumentitem type="footer">
				#cfdocument.currentpagenumber# of #cfdocument.totalpagecount#
			</cfdocumentitem>
		</cfdocument>
	<cfelse>
		<cfif URL.assessment_id LTE 4>
			#objAssessments.process_results(result_id="#val(qResults.result_id)#", assessment_id="#val(URL.assessment_id)#",gift_type_id="#val(URL.gift_type_id)#")#
		<cfelseif URL.assessment_id EQ 5>
			#passionSurveyObj.calculateResults()#
		<cfelseif URL.assessment_id EQ 6>
			<cfinclude template="../delight_survey/results.cfm" />
		</cfif>
	</cfif>

</cfoutput>