<cfinclude template="../require_login.cfm" />
<cfset foxyCart = CreateObject("component","cfcs.foxycart")>
	
<cfset passionSurveyObj = CreateObject("component","cfcs.passion").init(user_id = REQUEST.user_id) />
<cfset passionSurvey = passionSurveyObj.findSurvey()>
	
<cfif REQUEST.user_id EQ 0 AND NOT isDefined('URL.create')>

	<cfmodule template="/site_modules/user/login_box.cfm" >

<cfelseif isDefined('URL.create') OR isDefined('URL.edit')>

	<cfmodule template="/site_modules/user/user_profile.cfm">

<cfelseif isDefined('URL.invite')>
	
	<cfmodule template="/site_modules/user/invite.cfm">

<cfelseif REQUEST.user_id GT 0>
	
	<cfset objQueries = CreateObject("component","cfcs.queries")>
	<cfset objAssessments = CreateObject("component","cfcs.assessment")>
	<cfset delightSurvey = CreateObject("component","cfcs.delight") /> 
	<cfset qUser = objQueries.user_detail(user_id="#REQUEST.user_id#")>
	<cfset qAssessments = objAssessments.retrieve_assessments()>    
	<cfset qResults = objAssessments.get_results(user_id="#REQUEST.user_id#")>
	<cfset qInvites = objAssessments.retrieve_invites(user_id="#REQUEST.user_id#")>
	<cfset VARIABLES.accesskey_id_list = objAssessments.member_accesskeys(user_id="#REQUEST.user_id#")>
	<cfoutput>
	
		<div class="assessment_wrapper box">
			<h3>Tools</h3>
    
			<cfset VARIABLES.Result_List = ValueList(qResults.assessment_id,',')>

		    <cfset VARIABLES.PassionComplete = 0>
		    <cfif passionSurvey.recordcount GT 0>
		    	<cfset VARIABLES.PassionComplete = 1>
		    </cfif>
		
			<cfset VARIABLES.delightComplete = 0>
			<cfif delightSurvey.getResults(user_id = REQUEST.user_id).recordcount GT 0>
				<cfset VARIABLES.delightComplete = 1>
			</cfif>
			
		
			<table id="users-surveys" class="table table-striped table-bordered table-condensed">
			    <cfloop query="qAssessments">
					<cfif qAssessments.assessment_id EQ 1>
						<tr>
							<th colspan="3">Free Surveys</th>
						</tr>
					<cfelseif qAssessments.assessment_id EQ 2>
						<tr>
							<th colspan="3">Destiny Profiler (5 surveys) BETA Free!</th>
						</tr>
					</cfif>
					
					<tr class="#qAssessments.assessment_name#">
						<td>#HTMLEditFormat(qAssessments.assessment_name)#</td>
						<cfif qAssessments.assessment_id EQ 1 OR (qAssessments.assessment_id NEQ 1 AND foxyCart.customerPurchasedCode(email = REQUEST.user.user_email, code = #Hash("profiler")#))>
							<cfif (isDefined("VARIABLES.Result_List") AND ListContains(VARIABLES.Result_List,qAssessments.assessment_id) GT 0) OR (qAssessments.assessment_id EQ 5 AND VARIABLES.PassionComplete EQ 1)  OR (qAssessments.assessment_id EQ 6 AND VARIABLES.delightComplete EQ 1)>
				            	<td><a class="btn btn-success" href="/profile/?page=assessment&amp;assessment_id=#val(qAssessments.assessment_id)#&amp;gift_type_id=#val(qAssessments.gift_type_id)#">Retake</a></td>	
								<td><a class="btn btn-primary" href="/profile/?page=viewresult&amp;assessment_id=#val(qAssessments.assessment_id)#&amp;gift_type_id=#val(qAssessments.gift_type_id)#">Result</a></td>
							<cfelse>
				            	<td colspan="2"><a class="btn btn-success" href="/profile/?page=assessment&amp;assessment_id=#val(qAssessments.assessment_id)#&amp;gift_type_id=#val(qAssessments.gift_type_id)#">Take Survey</a></td>	
							</cfif>
						<cfelse>
							<td colspan="2"><a href="/store/" class="btn btn-success">Purchase the Profiler</a></td>
						</cfif>
					</tr>
					<cfif qAssessments.assessment_id EQ 1>
						<tr>
							<td>Friends 360 Survey (Free)</td>
							<td><a href="/profile/?page=invmod" class="btn btn-success">Invite Friends</a></td>
							<td><a class="btn btn-primary" href="/profile/?page=viewresult&amp;assessment_id=#val(qAssessments.assessment_id)#&amp;gift_type_id=#val(qAssessments.gift_type_id)#">Result</a></td>
						</tr>
					</cfif>
			    </cfloop>
			</table>
		</div>
	</cfoutput>
</cfif>