<cfset objAssessments = CreateObject("component","cfcs.assessment") />
<cfset foxyCart = CreateObject("component","cfcs.foxycart") />
<cfset objUsers = CreateObject("component", "cfcs.users") />

<cfif isDefined('URL.invite')>
	<cfset qInvite = objAssessments.retrieve_invites(invite_uid="#URL.invite#")>
	<cfset VARIABLES.user_id = qInvite.user_id>
	<cfset VARIABLES.invite = URL.invite>
	<cfset VARIABLES.assessment_id = 1>
<cfelse>
	<cfparam name="URL.assessment_id" default="">
	<cfset VARIABLES.user_id = REQUEST.user_id>
	<cfset VARIABLES.assessment_id = URL.assessment_id>
</cfif>

<cfif VARIABLES.assessment_id NEQ 1 AND foxyCart.customerPurchasedCode(email = REQUEST.user.user_email, code = Hash("profiler")) NEQ true>
	<cflocation url="/auth/account/" addtoken="false" />
</cfif>

<cfparam name="VARIABLES.invite" default="">

<cfif isDefined('VARIABLES.assessment_id') AND isNumeric(VARIABLES.assessment_id)>
	
	<cfif isDefined("URL.invite") AND Len(URL.invite) GT 2>
		<cfset referrer = objUsers.findByInviteId(URL.invite) />
		<h2>Friends 360 Survey for <cfoutput>#referrer.user_first_name# #referrer.user_last_name#</cfoutput></h2>
	<cfelse>
		<h2><cfoutput>#objAssessments.getAssessment(URL.assessment_id).assessment_name#</cfoutput></h2>
	</cfif>

	    <cfset qItems = objAssessments.retrieve_assessment_items(assessment_id="#VARIABLES.assessment_id#")>
        <cfset qResults = objAssessments.retrieve_result(user_id="#VARIABLES.user_id#",assessment_id="#VARIABLES.assessment_id#",invite_uid="#VARIABLES.invite#")>
        <cfif qResults.recordcount>
            <cfset VARIABLES.result_set = DeserializeJSON(qResults.result_set, false)>
        <cfelse>
            <cfset VARIABLES.result_set = ArrayNew(1)>
        </cfif>

        <div class="assessment_item">
	
		<cfset VARIABLES.item_result = "">
		<cfset item_type = 1>
        <cfif VARIABLES.assessment_id EQ 4>
			<cfset item_type = 4>
		<cfelseif VARIABLES.assessment_id EQ 5>
			<cfset item_type = 5>
		<cfelseif VARIABLES.assessment_id EQ 6>
			<cfset item_type = 6>
		</cfif>
		
            <cfswitch expression="#item_type#">
                <cfcase value="1">
					<cfif isDefined("URL.intro")>
						<cfinclude template="friend-intro.cfm" />
					<cfelse>
						<cfmodule template="word_sort.cfm"
                            sort_id="#qItems.item_type_id#"
                            type_id="#qItems.item_type#"
                            item_result="#VARIABLES.item_result#"
                            user_id="#VARIABLES.user_id#"
                            invite="#VARIABLES.invite#"
                            assessment_id="#VARIABLES.assessment_id#"
                            >
					</cfif>
                </cfcase>
				
				<cfcase value="6">
					<cfmodule template="delight_survey.cfm"
						type_id="#qItems.item_type#"
						item_result="#VARIABLES.item_result#"
						user_id="#VARIABLES.user_id#"
						invite="#VARIABLES.invite#"
						assessment_id="#VARIABLES.assessment_id#"
						>
				</cfcase>
				
				<cfcase value="4">
					<cfmodule template="supernatural_survey.cfm"
						type_id="#qItems.item_type#"
						item_result="#VARIABLES.item_result#"
						user_id="#VARIABLES.user_id#"
						assessment_id="#VARIABLES.assessment_id#"
						>
				</cfcase>
                
                <cfdefaultcase>
                        <cfmodule template="passion_survey.cfm"
                            type_id="#qItems.item_type#"
                            item_result="#VARIABLES.item_result#"
                            user_id="#VARIABLES.user_id#"
                            invite="#VARIABLES.invite#"
                            assessment_id="#VARIABLES.assessment_id#"
                            >
                </cfdefaultcase>
            </cfswitch>
        </div>
    <!---</cfloop>--->
</cfif>
