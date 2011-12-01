<cfset objAssessments = CreateObject("component","cfcs.assessment")>

<cfif isDefined('URL.invite')>
	<cfset qInvite = objAssessments.retrieve_invites(invite_uid="#URL.invite#")>
	<cfset VARIABLES.user_id = qInvite.user_id>
	<cfset VARIABLES.invite = URL.invite>
	<cfset VARIABLES.assessment_id = 1>
<cfelse>
	<cfparam name="URL.assessment_id" default="1">
	<cfset VARIABLES.user_id = REQUEST.user_id>
	<cfset VARIABLES.assessment_id = URL.assessment_id>
    <cfset VARIABLES.page = URL.page>
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
	<!--- <cfdump var="#VARIABLES.result_set#"> --->
	
<!---	<cfloop query="qItems" startrow="#URL.q#" endrow="#URL.q#">--->
	<div class="assessment_item">
		<cfset VARIABLES.item_result = "">
		
		<!---<cfif qResults.recordcount>
			
			<cfloop from="1" to="#ArrayLen(VARIABLES.result_set)#" index="i">
				<cfif VARIABLES.result_set[i].id EQ qItems.item_type_id>
					<cfset VARIABLES.item_result = DeSerializeJSON(VARIABLES.result_set[i].result)>
				</cfif>
			</cfloop>
		</cfif>--->
		
		<cfswitch expression="#qItems.item_type#">
			<cfcase value="1">
					<cfmodule template="word_sort.cfm"
						item_result="#VARIABLES.item_result#"
						user_id="#VARIABLES.user_id#"
						invite="#VARIABLES.invite#"
                        page="#VARIABLES.page#"
						assessment_id="#VARIABLES.assessment_id#"
						>
				
			</cfcase>
			
			<cfcase value="2">
					<cfmodule template="agree.cfm"
						agree_id="#qItems.item_type_id#"
						type_id="#qItems.item_type#"
						item_result="#VARIABLES.item_result#"
						user_id="#VARIABLES.user_id#"
						invite="#VARIABLES.invite#"
						assessment_id="#VARIABLES.assessment_id#"
						>
			</cfcase>
		</cfswitch>
	</div>
	<!---</cfloop>--->

</cfif>
