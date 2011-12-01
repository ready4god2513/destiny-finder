<cfif isDefined('URL.item_type')>

	<cfswitch expression="#URL.item_type#">
		<cfcase value="1">
			<cflocation url="word_sort.cfm?sort_id=new&assessment_id=#URL.assessment_id#&gift_type_id=#URL.gift_type_id#">
		</cfcase>
		<cfcase value="2">
			<cflocation url="agree.cfm?agree_id=new&assessment_id=#URL.assessment_id#&gift_type_id=#URL.gift_type_id#">
		</cfcase>
		<cfdefaultcase></cfdefaultcase>
	</cfswitch>

</cfif>