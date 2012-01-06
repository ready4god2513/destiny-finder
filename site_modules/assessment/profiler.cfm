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
	<!---<cfset VARIABLES.memberships = objAssessments.retrieve_membership(user_id="#REQUEST.user_id#")>--->
	<cfset VARIABLES.accesskey_id_list = objAssessments.member_accesskeys(user_id="#REQUEST.user_id#")>
	<cfoutput>
	<div class="user_greeting">
		<h2>Profiler - #HTMLEditFormat(qUser.user_first_name)# #HTMLEditFormat(qUser.user_last_name)#</h2> 
	</div>
	
	<div class="assessment_wrapper box">
	<h2>Your Available Surveys</h2>
	<span style="font-size: 11px;line-height:12px;"><br /></span>
    
    
	<cfset VARIABLES.Result_List = ValueList(qResults.assessment_id,',')>
    
    <cfquery datasource="#APPLICATION.DSN#" name="qPassionResult">
    	SELECT * FROM Passion_Survey
        WHERE user_id = "#REQUEST.user_id#"
        AND development_3 IS NOT NULL
    </cfquery>
    <cfset VARIABLES.PassionComplete = 0>
    <cfif qPassionResult.recordcount GT 0>
    	<cfset VARIABLES.PassionComplete = 1>
    </cfif>
    <cfloop query="qAssessments">
    <ul style="margin-bottom:20px;">
		<li class="assessment_list_title">#HTMLEditFormat(qAssessments.assessment_name)#
		<cfif (ListContains(VARIABLES.accesskey_id_list,qAssessments.assessment_access_key) OR qAssessments.assessment_id EQ 1)>
			<cfif (isDefined("VARIABLES.Result_List") AND ListContains(VARIABLES.Result_List,qAssessments.assessment_id) GT 0) OR (qAssessments.assessment_id EQ 5 AND VARIABLES.PassionComplete EQ 1)>
            	<a class="results_button" href="index.cfm?page=assessment&assessment_id=#val(qAssessments.assessment_id)#&gift_type_id=#val(qAssessments.gift_type_id)#" style="color:white;">RETAKE</a>	
				<a class="results_button" href="index.cfm?page=viewresult&assessment_id=#val(qAssessments.assessment_id)#&gift_type_id=#val(qAssessments.gift_type_id)#" style="color:white;">RESULT</a>
			<cfelse>
            	<a class="take_survey" href="index.cfm?page=assessment&assessment_id=#val(qAssessments.assessment_id)#&gift_type_id=#val(qAssessments.gift_type_id)#" style="color:white;">TAKE SURVEY</a>	
			</cfif> 
		<cfelse>
        	 <a class="take_survey" href="##" style="color:white;">COMING SOON</a> 
		</cfif></li>
    </ul>
    <!---<cfif qAssessments.currentrow GT 1>---><hr /><!---</cfif>--->
    </cfloop>
    <!--- #VARIABLES.accesskey_id_list#<br />
    #VARIABLES.Result_List#--->
   
	<!---<cfif ArrayLEN(VARIABLES.memberships) GT 0>
		<cfset VARIABLES.membership_list = "">
		<cfloop from="1" to="#ArrayLen(VARIABLES.memberships)#" index="i">
			<cfset VARIABLES.membership_list = ListAppend(VARIABLES.membership_list,"#VARIABLES.memberships[i].id#")>
		</cfloop>
		<cfset qPaidAssessments = objAssessments.retrieve_assessments(memberships="#VARIABLES.membership_list#",user_id="#REQUEST.user_id#")>
		<cfloop query="qPaidAssessments">
        <ul style="margin-bottom:20px;">
			<li class="assessment_list_title">#qPaidAssessments.assessment_name#<a class="results_button" href="index.cfm?page=assessment&assessment_id=#qPaidAssessments.assessment_id#&gift_type_id=#qPaidAssessments.gift_type_id#" style="color:white;"><cfif isDefined("qPaidAssessments.result_id") AND Len(qPaidAssessments.result_id) GT 0>RETAKE<cfelse>TAKE SURVEY</cfif></a> <a class="results_button" href="index.cfm?page=viewresult&assessment_id=#qPaidAssessments.assessment_id#&gift_type_id=#qPaidAssessments.gift_type_id#" style="color:white;">RESULT</a></li>
		</ul>
        <hr>
        </cfloop>
	</cfif>--->	
    
    <!---<cfset qBuyAssessments = objAssessments.purchase_assessments(memberships="#VARIABLES.membership_list#")>
	<cfloop query="qBuyAssessments">
        <ul style="margin-bottom:20px;">
			<li class="assessment_list_title">#qBuyAssessments.assessment_name#<a class="take_survey" href="##" style="color:white;">BUY SURVEY</a></li>
        </ul>
        <hr />
	</cfloop>--->

	</div><!---<div class="assessment_wrapper box">--->
	
	<!---<div class="result">
		<h2>Invites:</h2>
		<ul>
			<cfif qInvites.recordcount GT 0>
				<cfloop query="qInvites">
					<li>#qInvites.invite_first_name# #qInvites.invite_last_name#
					</li>
				</cfloop>
			<cfelse>
				<li>- No Invites Have Been Sent -</li>
			</cfif>
		</ul>
		<a href="index.cfm?invite=1">Add Invite</a>
	</div>--->
</cfoutput>
</cfif>