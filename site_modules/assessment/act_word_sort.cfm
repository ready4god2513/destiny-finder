<cfset objAssessment = CreateObject("component","cfcs.assessment")> 

<cfif NOT isDefined("FORM.surveydone")>
	<cfif FindNoCase('destinyfinder',CGI.HTTP_REFERER)>

		<cfset VARIABLES.result = Replace(FORM.sort_serialized,'item[]=','','ALL')>
		<cfset VARIABLES.result = Replace(VARIABLES.result,'&',',','ALL')>

		<cfset VARIABLES.item = {
			id = '#FORM.sort_id#',
			type_id = '#FORM.type_id#',
			result = '#SerializeJSON(VARIABLES.result)#'
		}>
		
		<cfoutput>
			#objAssessment.insert_assessment(
				assessment_id="#FORM.assessment_id#",
				item_detail="#VARIABLES.item#",
				user_id="#FORM.user_id#",
				invite="#FORM.invite#"
				)#
		</cfoutput>
	    <cfif isDefined("FORM.qcount")>
	    	<cfset FORM.qcount = FORM.qcount + 1>
	    </cfif>
		<cflocation addtoken="yes" url="/site_modules/assessment/word_sort.cfm?page=#FORM.page#&assessment_id=#FORM.assessment_id#&invite=#FORM.invite#&user_id=#FORM.user_id#&item_result=#FORM.item_result#&type_id=#FORM.type_id#&qcount=#FORM.qcount#&gift_type_id=#FORM.gift_type_id#">
	</cfif>
<cfelse>
	<cfif isDefined("FORM.invite")>
		<script type="text/javascript">
			<!-- //
			top.location.href = '/profile/?page=viewresult&assessment_id=<cfoutput>#HTMLEditFormat(val(FORM.assessment_id))#&gift_type_id=#HTMLEditFormat(val(FORM.gift_type_id))#&invite=#FORM.invite#</cfoutput>';
			// -->
		</script>
	<cfelse>
		<script type="text/javascript">
			<!-- //
			top.location.href = '/profile/?page=viewresult&assessment_id=<cfoutput>#HTMLEditFormat(val(FORM.assessment_id))#&gift_type_id=#HTMLEditFormat(val(FORM.gift_type_id))#</cfoutput>';
			// -->
		</script>
	</cfif>
</cfif>