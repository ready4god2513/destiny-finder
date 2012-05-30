<cfcomponent displayname="assessment" output="no" hint="I handle the admin functions">

<cffunction name="retrieve_types" returntype="query" output="false">
	<cfquery name="qTypes" datasource="#APPLICATION.DSN#">
		SELECT * 
		FROM Assessment_Item_Types
	</cfquery>

	<cfreturn qTypes>
</cffunction>

<cffunction name="retrieve_gifts" returntype="query" output="false">
<cfargument name="gift_type_id" type="numeric" required="yes">
	<cfquery name="qGifts" datasource="#APPLICATION.DSN#">
		SELECT * 
		FROM Gifts
        WHERE gift_type_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#gift_type_id#">
	</cfquery>

	<cfreturn qGifts>
</cffunction>

<cffunction name="insert_assessment_item" output="false">
	<cfargument name="item_type" type="numeric" required="yes">
	<cfargument name="item_type_id" type="numeric" required="yes">
	<cfargument name="assessment_id" type="numeric" required="yes">
	
	<cfquery name="iItem" datasource="#APPLICATION.DSN#">
		INSERT INTO Assessment_Items (item_type,item_type_id,assessment_id)
		VALUES (
			<cfqueryparam cfsqltype="cf_sql_integer" value="#item_type#">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="#item_type_id#">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="#assessment_id#">
		)
	</cfquery>

</cffunction>

<cffunction name="prepare_words_for_insert" output="false" returntype="string">
	<cfargument name="gift_recordcount" required="yes" type="numeric">
	
	<cfset VARIABLES.word_set = ArrayNew(2)>

	<cfloop from="1" to="#gift_recordcount#" index="i">
		<cfset VARIABLES.word_set[i][1] = FORM['sort_word#i#_gift_id']>
		<cfset VARIABLES.word_set[i][2] = FORM['sort_word#i#']>
	</cfloop>
	
	<cfset FORM.sort_words = SerializeJSON(VARIABLES.word_set)>
	
	<cfreturn FORM.sort_words>
	
</cffunction>

<cffunction name="delete_assessment_item" output="false">
	<cfargument name="item_type_id" required="yes" type="numeric">
	<cfargument name="item_type" required="yes" type="numeric">
	
	<cfquery name="dAssessment_Item" datasource="#APPLICATION.DSN#">
		DELETE 
		FROM Assessment_Items
		WHERE item_type_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#item_type_id#">
		AND item_type = <cfqueryparam cfsqltype="cf_sql_integer" value="#item_type#">
	</cfquery>
		
</cffunction>

</cfcomponent>