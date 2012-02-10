<cfinclude template="../require_login.cfm" />
<cfset foxyCart = CreateObject("component","cfcs.foxycart")>
	
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
			<h4>Your Available Surveys</h4>
    
			<cfset VARIABLES.Result_List = ValueList(qResults.assessment_id,',')>
    
		    <cfquery datasource="#APPLICATION.DSN#" name="qPassionResult">
		    	SELECT * 
				FROM Passion_Survey
		        WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#REQUEST.user_id#">
		        AND development_3 IS NOT NULL
		    </cfquery>

		    <cfset VARIABLES.PassionComplete = 0>
		    <cfif qPassionResult.recordcount GT 0>
		    	<cfset VARIABLES.PassionComplete = 1>
		    </cfif>
		
			<cfset VARIABLES.delightComplete = 0>
			<cfif delightSurvey.getResults(user_id = REQUEST.user_id).recordcount GT 0>
				<cfset VARIABLES.delightComplete = 1>
			</cfif>
			
		
			<table>
			    <cfloop query="qAssessments">
					<tr class="#qAssessments.assessment_name#">
						<th>#HTMLEditFormat(qAssessments.assessment_name)#</th>
						<cfif qAssessments.assessment_id EQ 1 OR (qAssessments.assessment_id NEQ 1 AND foxyCart.customerPurchasedCode(email = REQUEST.user.user_email, code = #Hash("profiler")#))>
							<cfif (isDefined("VARIABLES.Result_List") AND ListContains(VARIABLES.Result_List,qAssessments.assessment_id) GT 0) OR (qAssessments.assessment_id EQ 5 AND VARIABLES.PassionComplete EQ 1)  OR (qAssessments.assessment_id EQ 6 AND VARIABLES.delightComplete EQ 1)>
				            	<td><a class="btn success" href="/profile/?page=assessment&amp;assessment_id=#val(qAssessments.assessment_id)#&amp;gift_type_id=#val(qAssessments.gift_type_id)#">Retake</a></td>	
								<td><a class="btn primary" href="/profile/?page=viewresult&amp;assessment_id=#val(qAssessments.assessment_id)#&amp;gift_type_id=#val(qAssessments.gift_type_id)#">Result</a></td>
							<cfelse>
				            	<td colspan="2"><a class="btn success" href="/profile/?page=assessment&amp;assessment_id=#val(qAssessments.assessment_id)#&amp;gift_type_id=#val(qAssessments.gift_type_id)#">Take Survey</a></td>	
							</cfif>
						<cfelse>
							<td colspan="2"><a href="/store/" class="btn success">Purchase the Profiler</a></td>
						</cfif>
					</tr>
					<cfif qAssessments.assessment_id EQ 1>
						<tr>
							<th>Friends 360 Survey (Free)</th>
							<td><a href="/profile/?page=invmod" class="btn success">Invite Friends</a></td>
							<td><a class="btn primary" href="/profile/?page=viewresult&amp;assessment_id=#val(qAssessments.assessment_id)#&amp;gift_type_id=#val(qAssessments.gift_type_id)#">Result</a></td>
						</tr>
					</cfif>
			    </cfloop>
			</table>
		</div>
	</cfoutput>
</cfif>