<cfif REQUEST.user_id EQ 0 AND NOT isDefined('URL.create')>

	<cfmodule template="/site_modules/user/login_box.cfm" >

<cfelseif isDefined('URL.create') OR isDefined('URL.edit')>

	<cfmodule template="/site_modules/user/user_profile.cfm">

<cfelseif isDefined('URL.invite')>
	
	<cfmodule template="/site_modules/user/invite.cfm">

<cfelseif REQUEST.user_id GT 0>
	
	<cfset objQueries = CreateObject("component","cfcs.queries")>
	<cfset objAssessments = CreateObject("component","cfcs.assessment")>
	<cfset qUser = objQueries.user_detail(user_id="#REQUEST.user_id#")>
	<cfset qAssessments = objAssessments.retrieve_assessments()>    
	<cfset qResults = objAssessments.get_results(user_id="#REQUEST.user_id#")>
	<cfset qInvites = objAssessments.retrieve_invites(user_id="#REQUEST.user_id#")>
	<cfset VARIABLES.accesskey_id_list = objAssessments.member_accesskeys(user_id="#REQUEST.user_id#")>
	<cfoutput>
	<div class="user_greeting">
		<h2>Profiler - #HTMLEditFormat(qUser.user_first_name)# #HTMLEditFormat(qUser.user_last_name)#</h2> 
	</div>
	
	<div class="assessment_wrapper box">
	<h2>Your Available Surveys</h2>
    
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

	<table>
	    <cfloop query="qAssessments">
			<tr>
				<td>#HTMLEditFormat(qAssessments.assessment_name)#</td>
				<td>
					<cfif (ListContains(VARIABLES.accesskey_id_list,qAssessments.assessment_access_key) OR qAssessments.assessment_id EQ 1)>
						<cfif (isDefined("VARIABLES.Result_List") AND ListContains(VARIABLES.Result_List,qAssessments.assessment_id) GT 0) OR (qAssessments.assessment_id EQ 5 AND VARIABLES.PassionComplete EQ 1)>
			            	<a class="btn primary" href="index.cfm?page=assessment&amp;assessment_id=#val(qAssessments.assessment_id)#&amp;gift_type_id=#val(qAssessments.gift_type_id)#">RETAKE</a>	
							<a class="btn success" href="index.cfm?page=viewresult&amp;assessment_id=#val(qAssessments.assessment_id)#&amp;gift_type_id=#val(qAssessments.gift_type_id)#">RESULT</a>
						<cfelse>
			            	<a class="btn primary" href="index.cfm?page=assessment&amp;assessment_id=#val(qAssessments.assessment_id)#&amp;gift_type_id=#val(qAssessments.gift_type_id)#">TAKE SURVEY</a>	
						</cfif> 
					<cfelse>
			        	 <a class="btn disabled" href="##">COMING SOON</a> 
					</cfif>
				</td>
			</tr>
	    </cfloop>
	</table>
   
	
	</div>
</cfoutput>
</cfif>