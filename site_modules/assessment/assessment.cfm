<cfset objAssessments = CreateObject("component","cfcs.assessment") />
<cfset foxyCart = CreateObject("component","cfcs.foxycart") />

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

	    <cfset qItems = objAssessments.retrieve_assessment_items(assessment_id="#VARIABLES.assessment_id#")>
        <cfset qResults = objAssessments.retrieve_result(user_id="#VARIABLES.user_id#",assessment_id="#VARIABLES.assessment_id#",invite_uid="#VARIABLES.invite#")>
        <cfif qResults.recordcount>
            <cfset VARIABLES.result_set = DeserializeJSON(qResults.result_set)>
        <cfelse>
            <cfset VARIABLES.result_set = ArrayNew(1)>
        </cfif>

        <div class="assessment_item">
	
		<cfset VARIABLES.item_result = "">
		<cfset item_type = 1>
        <cfif VARIABLES.assessment_id EQ 5>
			<cfset item_type = 5>
		<cfelseif VARIABLES.assessment_id EQ 6>
			<cfset item_type = 6>
		</cfif>
		
            <cfswitch expression="#item_type#">
                <cfcase value="1">
                        <cfmodule template="word_sort.cfm"
                            sort_id="#qItems.item_type_id#"
                            type_id="#qItems.item_type#"
                            item_result="#VARIABLES.item_result#"
                            user_id="#VARIABLES.user_id#"
                            invite="#VARIABLES.invite#"
                            assessment_id="#VARIABLES.assessment_id#"
                            >
                    
                </cfcase>
				
				<!--- Passion Survey --->
				<cfcase value="6">
					<cfmodule template="delight_survey.cfm"
						type_id="#qItems.item_type#"
						item_result="#VARIABLES.item_result#"
						user_id="#VARIABLES.user_id#"
						invite="#VARIABLES.invite#"
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
