<cfcomponent displayname="assessment" output="no" hint="I handle the assessment functions">
<cfset objUsers = CreateObject("component","cfcs.users")>


<cffunction name="retrieve_assessments" output="false" returntype="query">
	<cfargument name="assessment_id" required="no" type="numeric">
	<cfargument name="memberships" required="no" type="string">
	<cfargument name="user_id" required="no" type="numeric">
	<cfargument name="null" required="no" type="numeric">
    
	
	<cfquery name="qAssessments" datasource="#APPLICATION.DSN#">
      <cfif isDefined("user_id")>
        SELECT a.*,b.result_id
		FROM Assessments a
        LEFT OUTER JOIN Results b ON a.assessment_id = b.assessment_id
		WHERE a.assessment_active = 1
        AND b.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
		<cfif isDefined('assessment_id')>
			AND a.assessment_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#assessment_id#">
		</cfif>
		<cfif isDefined('memberships')>
			AND a.assessment_access_key IN (#memberships#)
		<cfelseif isDefined('null') AND null EQ	1>
			AND a.assessment_access_key IS NULL
		</cfif>
      <cfelse>
        SELECT *
		FROM Assessments
		WHERE assessment_active = 1
		<cfif isDefined('assessment_id')>
			AND assessment_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#assessment_id#">
		</cfif>
		<cfif isDefined('memberships')>
			AND assessment_access_key IN (#memberships#)
		<cfelseif isDefined('null') AND null EQ 1>
			AND assessment_access_key IS NULL
		</cfif>
      </cfif>
	</cfquery>

	<cfreturn qAssessments>
</cffunction>

<cffunction name="purchase_assessments" output="false" returntype="query">
	<cfargument name="memberships" required="no" type="string">
	
	<cfquery name="qAssessments" datasource="#APPLICATION.DSN#">
        SELECT *
		FROM Assessments
		WHERE assessment_active = 1
		AND assessment_access_key NOT IN (#memberships#)
	</cfquery>

	<cfreturn qAssessments>
</cffunction>

<cffunction name="get_results" returntype="query" output="false">
<cfargument name="user_id" type="numeric" required="yes">
	<cfquery name="qResults" datasource="#APPLICATION.DSN#">
		SELECT * 
		FROM Results
        WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
	</cfquery>

	<cfreturn qResults>
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

<cffunction name="retrieve_assessment_items" output="false" returntype="query">
	<cfargument name="assessment_id" required="yes" type="numeric">
	
	
	<cfquery name="qItems" datasource="#APPLICATION.DSN#">
		SELECT *
		FROM Assessment_Items
		WHERE Assessment_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#assessment_id#">
		ORDER BY Item_sortorder ASC
	</cfquery>
	
	<cfreturn qItems>	
	
</cffunction>

<cffunction name="retrieve_sort" output="false" returntype="query">
	<cfargument name="sort_id" required="yes" type="numeric">
	
	<cfquery name="qSort" datasource="#APPLICATION.DSN#">
		SELECT *
		FROM Sort
		WHERE Sort_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sort_id#">
	</cfquery>
	
	<cfreturn qSort>
	
</cffunction>

<cffunction name="retrieve_agree" output="false" returntype="query">
	<cfargument name="agree_id" required="yes" type="numeric">
	
	<cfquery name="qAgree" datasource="#APPLICATION.DSN#">
		SELECT *
		FROM Agree
		WHERE agree_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#agree_id#">
	</cfquery>
	
	<cfreturn qAgree>
	
</cffunction>

<cffunction name="retrieve_result" output="false" returntype="query">
	<cfargument name="result_id" required="no" type="numeric">
	<cfargument name="user_id" required="no" type="numeric">
	<cfargument name="invite" required="no" type="string">
	
	<cfquery name="qResult" datasource="#APPLICATION.DSN#">
		SELECT *
		FROM Results
		<cfif isDefined('result_id')>
			WHERE result_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#result_id#">
		<cfelse>
			WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
		</cfif>
		<cfif isDefined('assessment_id')>
			AND assessment_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#assessment_id#">
		</cfif>
		<!---<cfif isDefined('invite')>
			AND invite_uid = <cfqueryparam cfsqltype="cf_sql_char" value="#invite#">
		<cfelse>
			AND invite_uid IS NULL
		</cfif>--->

	</cfquery>

	<cfreturn qResult>

</cffunction>

<cffunction name="insert_assessment" output="true" hint="I handle the process of inserting/updating a result set for an assessment">
	<cfargument name="assessment_id" required="yes" type="numeric">
	<cfargument name="item_detail" required="yes" type="struct">
	<cfargument name="user_id" required="yes" type="numeric">
	<cfargument name="invite" required="no" type="string">
	
	<!--- IF THE USER IS NOT LOGGED IN, REDIRECT THEM TO LOG IN --->
	<cfif user_id EQ 0 >
		<cflocation url="/pages/index.cfm?page=user" addtoken="no">
		<cfabort>
	</cfif>
	
	<!--- SEE IF THERE IS ALREADY A RECORD OF THIS ASSESSMENT IN THE SYSTEM --->
	<cfquery name="qResult" datasource="#APPLICATION.DSN#">
		SELECT *
		FROM Results
		WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
		AND assessment_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#assessment_id#">
		<cfif isDefined('invite') AND LEN(invite) GT 0>
			AND invite_uid = <cfqueryparam cfsqltype="cf_sql_char" value="#invite#">
		</cfif>
	</cfquery>
	
	<cfif qResult.recordcount EQ 0>
		<!--- IF NO RECORD IS FOUND, PREPARE THE RESULT SET AND INSERT IT INTO THE DB --->
		
		<cfset VARIABLES.items = ArrayNew(1)>
		<cfset VARIABLES.items[1] = item_detail>
		
		<cfset VARIABLES.result_set = SerializeJSON(VARIABLES.items)>
				
		<cfquery name="iResult" datasource="#APPLICATION.DSN#"	>
			INSERT INTO Results
			(assessment_id,user_id,last_modified,result_set
			<cfif isDefined('invite') AND LEN(invite) GT 0>
				,invite_uid
			</cfif>)
			VALUES
			(<cfqueryparam cfsqltype="cf_sql_integer" value="#assessment_id#">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">,
            <cfqueryparam cfsqltype="cf_sql_date" value="#now()#">,
			<cfqueryparam cfsqltype="cf_sql_char" value="#VARIABLES.result_set#">
			<cfif isDefined('invite') AND LEN(invite) GT 0>
				,<cfqueryparam cfsqltype="cf_sql_char" value="#invite#">
			</cfif>)
		</cfquery>
		
	<cfelse>
		<!--- IF THERE IS A RECORD FOUND, WE NEED TO PULL THE EXISTING RESULT SET AND DETERMINE IF THIS IS AN UPDATE TO AN EXISTING ITEM OR A NEW ONE--->
		<cfset VARIABLES.items = DeSerializeJSON(qResult.result_set)>
				
		<cfset VARIABLES.item_found = 0>

		<cfloop from="1" to="#ArrayLen(VARIABLES.items)#" index="i">
			<cfif VARIABLES.items[i].id EQ item_detail.id>
				<cfset VARIABLES.item_found = i>
			</cfif>
		</cfloop>
		
		<cfif VARIABLES.item_found EQ 0>
			<!--- NEW ITEM --->
			<cfset VARIABLES.items[ArrayLen(VARIABLES.items)+1] = item_detail>
			<cfset VARIABLES.result_set = SerializeJSON(VARIABLES.items)>

			<cfquery name="uResult" datasource="#APPLICATION.DSN#">
				UPDATE Results
				SET
				result_set = <cfqueryparam cfsqltype="cf_sql_char" value="#VARIABLES.result_set#">,
                last_modified = <cfqueryparam cfsqltype="cf_sql_date" value="#now()#">
				WHERE result_id = #qResult.result_id#				
			</cfquery>
			
					
		<cfelse>
			<!--- UPDATE ITEM --->
			<cfset VARIABLES.items[VARIABLES.item_found] = item_detail>
			
			<cfset VARIABLES.result_set = SerializeJSON(VARIABLES.items)>

			<cfquery name="uResult" datasource="#APPLICATION.DSN#">
				UPDATE Results
				SET
				result_set = <cfqueryparam cfsqltype="cf_sql_char" value="#VARIABLES.result_set#">,
                last_modified = <cfqueryparam cfsqltype="cf_sql_date" value="#now()#">
				WHERE result_id = #qResult.result_id#				
			</cfquery>
			
		</cfif>
	</cfif>
	
</cffunction>

<cffunction name="process_results" hint="I process an assessment result set" output="true">
	<cfargument name="result_id" required="yes" type="numeric">
    <cfargument name="assessment_id" required="no" type="numeric">
    <cfargument name="gift_type_id" required="no" type="numeric">
	<!--- SIMPLE SCORING ENGINE. THE RESULT SET IS LOOPED OVER AND THE ITEM TYPE DETERMINES HOW THE SET WILL BE SCORED--->
	
	<cfset qGifts = retrieve_gifts(gift_type_id="#gift_type_id#")>
	<cfset qResult = retrieve_result(result_id="#result_id#")>
	<cfset VARIABLES.result_set = DeSerializeJSON(qResult.result_set)>
	<cfset VARIABLES.gift_count = ArrayNew(1)>
	<cfset VARIABLES.dominant_gift = {id = 0, count =0}>
    <!---<cfset VARIABLES.secondary_gift = {id = 0, count =0}>--->
	
	<!--- PREPARE CONTAINER FOR KEEPING SCORE OF EACH GIFT --->
	<cfloop from="1" to="#qGifts.recordcount#" index="i"> 
		<cfset VARIABLES.gift_count[i] = {id = qGifts.gift_id[i],counter = 0}>
	</cfloop>
	
	
	
	<cfloop from="1" to="#ArrayLen(VARIABLES.result_set)#" index="i">
			<cfswitch expression="#VARIABLES.result_set[i].type_id#">
				<cfcase value="1">
					<cfloop from="1" to="#ArrayLen(VARIABLES.gift_count)#" index="j">
						<!--- This section needs to be simplified with a CFLOOP to condense this section of code. TJ --->
                        <cfif gift_type_id EQ 3>
                        
							<cfif VARIABLES.gift_count[j].id EQ ListGetAt(Replace(VARIABLES.result_set[i].result,'"','','ALL'),1)>
                                <cfset VARIABLES.gift_count[j].counter = VARIABLES.gift_count[j].counter + 9 >
                            </cfif>
                        
							<cfif VARIABLES.gift_count[j].id EQ ListGetAt(Replace(VARIABLES.result_set[i].result,'"','','ALL'),2)>
                                <cfset VARIABLES.gift_count[j].counter = VARIABLES.gift_count[j].counter + 8 >
                            </cfif>
                        
							<cfif VARIABLES.gift_count[j].id EQ ListGetAt(Replace(VARIABLES.result_set[i].result,'"','','ALL'),3)>
                                <cfset VARIABLES.gift_count[j].counter = VARIABLES.gift_count[j].counter + 7 >
                            </cfif>
                            
                            <cfif VARIABLES.gift_count[j].id EQ ListGetAt(Replace(VARIABLES.result_set[i].result,'"','','ALL'),4)>
                                <cfset VARIABLES.gift_count[j].counter = VARIABLES.gift_count[j].counter + 6 >
                            </cfif>
                            
                            <cfif VARIABLES.gift_count[j].id EQ ListGetAt(Replace(VARIABLES.result_set[i].result,'"','','ALL'),5)>
                                <cfset VARIABLES.gift_count[j].counter = VARIABLES.gift_count[j].counter + 5 >
                            </cfif>
                            
                            <cfif VARIABLES.gift_count[j].id EQ ListGetAt(Replace(VARIABLES.result_set[i].result,'"','','ALL'),6)>
                                <cfset VARIABLES.gift_count[j].counter = VARIABLES.gift_count[j].counter + 4 >
                            </cfif>
                            
                            <cfif VARIABLES.gift_count[j].id EQ ListGetAt(Replace(VARIABLES.result_set[i].result,'"','','ALL'),7)>
                                <cfset VARIABLES.gift_count[j].counter = VARIABLES.gift_count[j].counter + 3 >
                            </cfif>
                            
                            <cfif VARIABLES.gift_count[j].id EQ ListGetAt(Replace(VARIABLES.result_set[i].result,'"','','ALL'),8)>
                                <cfset VARIABLES.gift_count[j].counter = VARIABLES.gift_count[j].counter + 2 >
                            </cfif>
                            
                            <cfif VARIABLES.gift_count[j].id EQ ListGetAt(Replace(VARIABLES.result_set[i].result,'"','','ALL'),9)>
                                <cfset VARIABLES.gift_count[j].counter = VARIABLES.gift_count[j].counter + 1 >
                            </cfif>
                            
                        <cfelseif gift_type_id EQ 2>
                        
							<cfif VARIABLES.gift_count[j].id EQ ListGetAt(Replace(VARIABLES.result_set[i].result,'"','','ALL'),1)>
                                <cfset VARIABLES.gift_count[j].counter = VARIABLES.gift_count[j].counter + 7 >
                            </cfif>
                            
                            <cfif VARIABLES.gift_count[j].id EQ ListGetAt(Replace(VARIABLES.result_set[i].result,'"','','ALL'),2)>
                                <cfset VARIABLES.gift_count[j].counter = VARIABLES.gift_count[j].counter + 6 >
                            </cfif>
                            
                            <cfif VARIABLES.gift_count[j].id EQ ListGetAt(Replace(VARIABLES.result_set[i].result,'"','','ALL'),3)>
                                <cfset VARIABLES.gift_count[j].counter = VARIABLES.gift_count[j].counter + 5 >
                            </cfif>
                            
                            <cfif VARIABLES.gift_count[j].id EQ ListGetAt(Replace(VARIABLES.result_set[i].result,'"','','ALL'),4)>
                                <cfset VARIABLES.gift_count[j].counter = VARIABLES.gift_count[j].counter + 4 >
                            </cfif>
                            
                            <cfif VARIABLES.gift_count[j].id EQ ListGetAt(Replace(VARIABLES.result_set[i].result,'"','','ALL'),5)>
                                <cfset VARIABLES.gift_count[j].counter = VARIABLES.gift_count[j].counter + 3 >
                            </cfif>
                            
                            <cfif VARIABLES.gift_count[j].id EQ ListGetAt(Replace(VARIABLES.result_set[i].result,'"','','ALL'),4)>
                                <cfset VARIABLES.gift_count[j].counter = VARIABLES.gift_count[j].counter + 2 >
                            </cfif>
                            
                            <cfif VARIABLES.gift_count[j].id EQ ListGetAt(Replace(VARIABLES.result_set[i].result,'"','','ALL'),5)>
                                <cfset VARIABLES.gift_count[j].counter = VARIABLES.gift_count[j].counter + 1 >
                            </cfif>
                            
                        <cfelseif gift_type_id EQ 1>
                        
                        	<cfif VARIABLES.gift_count[j].id EQ ListGetAt(Replace(VARIABLES.result_set[i].result,'"','','ALL'),1)>
                                <cfset VARIABLES.gift_count[j].counter = VARIABLES.gift_count[j].counter + 5 >
                            </cfif>
                            
                            <cfif VARIABLES.gift_count[j].id EQ ListGetAt(Replace(VARIABLES.result_set[i].result,'"','','ALL'),2)>
                                <cfset VARIABLES.gift_count[j].counter = VARIABLES.gift_count[j].counter + 4 >
                            </cfif>
                            
                            <cfif VARIABLES.gift_count[j].id EQ ListGetAt(Replace(VARIABLES.result_set[i].result,'"','','ALL'),3)>
                                <cfset VARIABLES.gift_count[j].counter = VARIABLES.gift_count[j].counter + 3 >
                            </cfif>
                            
                            <cfif VARIABLES.gift_count[j].id EQ ListGetAt(Replace(VARIABLES.result_set[i].result,'"','','ALL'),4)>
                                <cfset VARIABLES.gift_count[j].counter = VARIABLES.gift_count[j].counter + 2 >
                            </cfif>
                            
                            <cfif VARIABLES.gift_count[j].id EQ ListGetAt(Replace(VARIABLES.result_set[i].result,'"','','ALL'),5)>
                                <cfset VARIABLES.gift_count[j].counter = VARIABLES.gift_count[j].counter + 1 >
                            </cfif>
                            
						</cfif>
                        
					</cfloop>
				</cfcase>
				<cfcase value="2">
					<cfset VARIABLES.rating = DeSerializeJSON(VARIABLES.result_set[i].result)>
					<cfloop from="1" to="#ArrayLen(VARIABLES.gift_count)#" index="j">
						<cfif VARIABLES.gift_count[j].id EQ VARIABLES.rating.gift>
							<cfset VARIABLES.gift_count[j].counter = VARIABLES.gift_count[j].counter + VARIABLES.rating.rate >
						</cfif>
					</cfloop>
				</cfcase>
			</cfswitch>
	</cfloop>
	<!---<br/><br/>	
	<strong>GIFT COUNT: </strong>--->	
	<cfquery name="uResult" datasource="#APPLICATION.DSN#">
		UPDATE Results
		SET
		result_gift_count = <cfqueryparam cfsqltype="char" value="#SerializeJSON(VARIABLES.gift_count)#">
		WHERE result_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#result_id#">
	</cfquery> 
	
	<!---<cfdump var="#VARIABLES.gift_count#">
	<div align="center"><cfchart
       format="png"
       scalefrom="0"
       scaleto="40">
      <cfchartseries
          type="bar"
          serieslabel="Free Survey Core Gift Result"
          seriescolor="gray">
        <cfchartdata item="Apostle" value="#VARIABLES.gift_count[1].counter#">
        <cfchartdata item="Prophet" value="#VARIABLES.gift_count[2].counter#">
        <cfchartdata item="Evangelist" value="#VARIABLES.gift_count[3].counter#">
        <cfchartdata item="Pastor" value="#VARIABLES.gift_count[4].counter#">
        <cfchartdata item="Teacher" value="#VARIABLES.gift_count[5].counter#">
      </cfchartseries>
    </cfchart></div>--->
    
	<cfloop from="1" to="#ArrayLen(VARIABLES.gift_count)#" index="i">
		<cfif VARIABLES.gift_count[i].counter GT VARIABLES.dominant_gift.count>
			<cfset VARIABLES.dominant_gift.id = VARIABLES.gift_count[i].id>
			<cfset VARIABLES.dominant_gift.count = VARIABLES.gift_count[i].counter>
		</cfif>
	</cfloop>
    
    <!---<cfloop from="1" to="#ArrayLen(VARIABLES.gift_count)#" index="i">
		<cfif VARIABLES.gift_count[i].counter GT VARIABLES.secondary_gift.count AND VARIABLES.gift_count[i].id NEQ VARIABLES.dominant_gift.id>
			<cfset VARIABLES.secondary_gift.id = VARIABLES.gift_count[i].id>
			<cfset VARIABLES.secondary_gift.count = VARIABLES.gift_count[i].counter>
		</cfif>
	</cfloop>--->
    
    
    <cfquery name="qThisResult" datasource="#APPLICATION.DSN#">
    Select 
    <cfif assessment_id GTE 2>gift_primary<cfelse>gift_brief</cfif> AS ThisResult from gifts
    Where gift_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#VARIABLES.dominant_gift.id#">
    </cfquery>
    <!---<cfdump var="#qThisResult#">--->
    <cfquery name="qUser" datasource="#APPLICATION.DSN#">
		SELECT *
		FROM Users
		WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#REQUEST.user_id#">
	</cfquery>
	<!---<br/><br/>
	<strong>Primary GIFT: </strong>--->
    <cfif qThisResult.recordcount GT 0>
    <div style="margin: 70px 0px 0px 100px; color: ##a82b33; font-size: 18px; font-weight: bold">Survey Result - #HTMLEditFormat(qUser.user_first_name)# #HTMLEditFormat(qUser.user_last_name)# #dateformat(qResult.last_modified,'mmm dd, yyyy')#</div>
    <div class="short_desc">#qThisResult.ThisResult#
    </div>
    <cfif isDefined("assessment_id")>
    <cfquery name="qGetClosing" datasource="#APPLICATION.DSN#">
		SELECT assessment_closing_text
		FROM Assessments
		WHERE assessment_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#assessment_id#">
	</cfquery>
    <div class="short_desc">#qGetClosing.assessment_closing_text#
    </div>
    </cfif>
    </cfif><!---<cfdump var="#VARIABLES.gift_count#">
	<div align="center"><cfchart labelmask=""
       format="png"
       scalefrom="0"
       scaleto="40"
       showmarkers="no"
       showlegend="no">
      <cfchartseries
          type="bar"
          serieslabel="Free Survey Core Gift Result"
          seriescolor="gray">
        <cfchartdata item="Apostle" value="#VARIABLES.gift_count[1].counter#">
        <cfchartdata item="Prophet" value="#VARIABLES.gift_count[2].counter#">
        <cfchartdata item="Evangelist" value="#VARIABLES.gift_count[3].counter#">
        <cfchartdata item="Pastor" value="#VARIABLES.gift_count[4].counter#">
        <cfchartdata item="Teacher" value="#VARIABLES.gift_count[5].counter#">
      </cfchartseries>
    </cfchart></div>--->
	<!---<cfdump var="#VARIABLES.dominant_gift#">
    <strong>Secondary GIFT: </strong>
    <cfdump var="#VARIABLES.secondary_gift#">--->
	
</cffunction>


<cffunction name="retrieve_membership" output="false" returntype="array" hint="I verify if a user has a membership or not">
		<cfargument name="user_id" required="yes" type="numeric">
		<cfset VARIABLES.memberships = ArrayNew(1)>
		
		<cfquery name="qUsername" datasource="#APPLICATION.DSN#">
			SELECT user_email
			FROM users
			WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
		</cfquery>
		
		<cfquery name="qStoreUser" datasource="#APPLICATION.STORE_DSN#">
			SELECT user_id
			FROM users
			WHERE username = <cfqueryparam cfsqltype="cf_sql_char" value="#qUsername.user_email#">
		</cfquery>
	
		<cfif qStoreUser.recordcount GT 0>
			<cfquery name="qUserMemberships" datasource="#APPLICATION.STORE_DSN#">
				SELECT accesskey_id
				FROM Memberships
				WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qStoreUser.user_id#"> 
				AND valid = 'true'
			</cfquery>
			
			
			<cfset VARIABLES.membership_index = 1>
			
			<cfset VARIABLES.accesskey_id_list = "">
			
			<cfloop query="qUserMemberships">
				<cfset VARIABLES.accesskey_id_list = ListAppend(VARIABLES.accesskey_id_list,qUserMemberships.accesskey_id)>
			</cfloop>
			
			
			<cfloop list="#VARIABLES.accesskey_id_list#" index="access_key">
				
				<cfquery name="qMembership" datasource="#APPLICATION.STORE_DSN#">
					SELECT Name
					FROM AccessKeys
					WHERE accesskey_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#access_key#">
				</cfquery>
				<cfset VARIABLES.memberships[VARIABLES.membership_index] = StructNew()>
				<cfset VARIABLES.memberships[VARIABLES.membership_index].id = access_key>
				<cfset VARIABLES.memberships[VARIABLES.membership_index].name = qMembership.Name>
				
				<cfset VARIABLES.membership_index = VARIABLES.membership_index + 1>
			</cfloop>
			
			<!---<cfquery name="qMembership" datasource="#APPLICATION.STORE_DSN#">
				SELECT Name,AccessKey_ID
				FROM AccessKeys
				WHERE accesskey_id IN (SELECT accesskey_id
				FROM Memberships
				WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qStoreUser.user_id#"> AND valid = 'true')
			</cfquery>--->
			
		</cfif>
		
		<cfreturn VARIABLES.memberships>
	</cffunction>
    
    <cffunction name="member_accesskeys" output="false" returntype="string" hint="I only return a comma delimitted list of accesskeys">
		<cfargument name="user_id" required="yes" type="numeric">
		
		<cfquery name="qUsername" datasource="#APPLICATION.DSN#">
			SELECT user_email
			FROM users
			WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
		</cfquery>
		
		<cfquery name="qStoreUser" datasource="#APPLICATION.STORE_DSN#">
			SELECT user_id
			FROM users
			WHERE username = <cfqueryparam cfsqltype="cf_sql_char" value="#qUsername.user_email#">
		</cfquery>
	
		<cfif qStoreUser.recordcount GT 0>
			<cfquery name="qUserMemberships" datasource="#APPLICATION.STORE_DSN#">
				SELECT accesskey_id
				FROM Memberships
				WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qStoreUser.user_id#"> 
				AND valid = 'true'
			</cfquery>
			
			<cfset VARIABLES.accesskey_id_list = ValueList(qUserMemberships.AccessKey_ID,',')>

			<!---<cfquery name="qMembership" datasource="#APPLICATION.STORE_DSN#">
				SELECT Name,AccessKey_ID
				FROM AccessKeys
				WHERE accesskey_id IN (SELECT accesskey_id
				FROM Memberships
				WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qStoreUser.user_id#"> AND valid = 'true')
			</cfquery>--->
			
		</cfif>
		
		<cfreturn VARIABLES.accesskey_id_list>
	</cffunction>
    
	<cffunction name="process_passion_statement" output="true" hint="I produce the passion statement">
		<cfargument name="user_id" required="yes" type="numeric">
        <cfset objQueries = CreateObject("component","cfcs.queries")>
		<cfset qUser = objQueries.user_detail(user_id="#REQUEST.user_id#")>
        <cfset qPassionResults = objQueries.passion_results(user_id="#REQUEST.user_id#")>		
		<div style="margin: 70px 0px 0px 100px; color: ##a82b33; font-size: 18px; font-weight: bold">Destiny Survey Result - #HTMLEditFormat(qUser.user_first_name)# #HTMLEditFormat(qUser.user_last_name)# #dateformat(qPassionResults.last_modified,'mmm dd, yyyy')#</div>
    <div class="short_desc">
    <h2>Passion Statement</h2><br>
<p>I am most passionate about bringing my primary kingdom impact in the sphere of <strong>#HTMLEditFormat(qPassionResults.sphere)#</strong>, specifically working in the area of <strong>#HTMLEditFormat(ListGetAt(qPassionResults.sphere_sub1,1))#</strong> and/or <strong>#HTMLEditFormat(ListGetAt(qPassionResults.sphere_sub1,2))#</strong>.</p>
<p>The causes I am most passionate about are <strong>#HTMLEditFormat(ListGetAt(qPassionResults.causes_societal,1))#</strong> and <strong>#HTMLEditFormat(ListGetAt(qPassionResults.causes_societal,2))#</strong>. I知 drawn to help people who are afflicted with <strong>#HTMLEditFormat(ListGetAt(qPassionResults.causes_human,1))#</strong> and <strong>#HTMLEditFormat(ListGetAt(qPassionResults.causes_human,2))#</strong>.</p>
<p>I really enjoy being involved in <strong>#HTMLEditFormat(ListGetAt(qPassionResults.causes_ministries,1))#</strong> and <strong>#HTMLEditFormat(ListGetAt(qPassionResults.causes_ministries,2))#</strong> types of ministries. I am most passionate about bringing kingdom impact through <strong>#HTMLEditFormat(ListGetAt(qPassionResults.causes_ministry_activities,1))#</strong> and <strong>#HTMLEditFormat(ListGetAt(qPassionResults.causes_ministry_activities,2))#</strong>. </p>
<p>I feel the most fulfilled when communicating with others through <strong>#HTMLEditFormat(ListGetAt(qPassionResults.causes_communication,1))#</strong> and <strong>#HTMLEditFormat(ListGetAt(qPassionResults.causes_communication,2))#</strong>, and I feel most alive when expressing myself through artistic and creative expressions of <strong>#HTMLEditFormat(ListGetAt(qPassionResults.causes_expressing,1))#</strong> and <strong>#ListGetAt(qPassionResults.causes_expressing,2)#</strong>. My heart direction is mostly <strong>#HTMLEditFormat(qPassionResults.causes_heart)#</strong>.</p>
<p>I知 most comfortable in a <strong>#HTMLEditFormat(qPassionResults.scope_org)#</strong> type of organization, and the size of group I prefer to work with is <strong>#HTMLEditFormat(qPassionResults.scope_group)#</strong>. In my church or ministry commitment, I feel most comfortable serving as a <strong>#HTMLEditFormat(ListGetAt(qPassionResults.role_church,1))#</strong> and <strong><strong>#HTMLEditFormat(ListGetAt(qPassionResults.role_church,2))#</strong></strong>. 
In the workplace, I知 most comfortable in the role of <strong>#HTMLEditFormat(ListGetAt(qPassionResults.role_workplace,1))#</strong> or <strong>#HTMLEditFormat(ListGetAt(qPassionResults.role_workplace,2))#</strong>.</p>
<p>I want to impact the <strong>#HTMLEditFormat(qPassionResults.impact_age_group)#</strong> age group in <strong>#HTMLEditFormat(qPassionResults.impact_area)#</strong> areas of <cfif qPassionResults.impact_region EQ 'United States'>the </cfif><strong>#HTMLEditFormat(qPassionResults.impact_region)#</strong>, of <strong>#HTMLEditFormat(qPassionResults.impact_ethnicity)#</strong> ethnicity and the <strong>#HTMLEditFormat(qPassionResults.impact_subculture)#</strong> subculture with a <strong>#HTMLEditFormat(qPassionResults.impact_religious)#</strong> religious orientation. </p>
<p>At present I知 in the <strong>#HTMLEditFormat(qPassionResults.development_1)#</strong> stage of destiny development. In 3-5 years I want to be in the <strong>#HTMLEditFormat(qPassionResults.development_2)#</strong> stage, and in 5-10 years I want to be in the <strong>#HTMLEditFormat(qPassionResults.development_3)#</strong> destiny development stage.</p>
<p>I have a passion to bring kingdom impact and transformation to the people I feel called to, and by God痴 grace I will!</p>
</div>

	</cffunction>
    
	<cffunction name="compile_results" output="true" hint="I compile all results and tally score">
		<cfargument name="user_id" required="yes" type="numeric">
		<cfargument name="invite" required="no" type="string">
		
		<cfparam name="invite" default="">
		
		<cfset qResults = retrieve_result(user_id="#user_id#",invite="#invite#",gift_type_id=1)>
		<cfset qGifts = retrieve_gifts(gift_type_id=1)>
		<cfset VARIABLES.compiled_gift_count = ArrayNew(1)>
		
		<!--- PREPARE CONTAINER FOR KEEPING SCORE OF EACH GIFT --->
		<cfloop from="1" to="#qGifts.recordcount#" index="i"> 
			<cfset VARIABLES.compiled_gift_count[i] = {id = qGifts.gift_id[i],counter = 0}>
		</cfloop>

		<cfoutput query="qResults">
			<cfset VARIABLES.result_gift_count = DeSerializeJSON(qResults.result_gift_count)>
						
			<cfloop from="1" to="#ArrayLen(VARIABLES.result_gift_count)#" index="i">
				<cfset VARIABLES.compiled_gift_count[i].counter = VARIABLES.compiled_gift_count[i].counter + VARIABLES.result_gift_count[i].counter>
			</cfloop>
			
		</cfoutput>
		
		<cfdump var="#VARIABLES.compiled_gift_count#">
	</cffunction>

	<cffunction name="retrieve_invites" output="false" returntype="query" hint="I retrieve invites">
		<cfargument name="user_id" required="no" type="numeric">
		<cfargument name="invite_uid" required="no" type="string">
		
		<cfquery name="qInvites" datasource="#APPLICATION.DSN#">
			SELECT *
			FROM Invites
			WHERE 
			<cfif isDefined('user_id')>
				user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
			</cfif>
			<cfif isDefined('invite_uid')>
				invite_uid = <cfqueryparam cfsqltype="cf_sql_char" value="#invite_uid#">
			</cfif>
		</cfquery>
		
		<cfreturn qInvites>
		
	</cffunction>

	<cffunction name="invite_friend" output="false" returntype="string" hint="I invite">
		<cfargument name="user_id" required="yes" type="numeric">
		
		<!--- GENERATE RANDOM UID --->
		<cfloop index="i" from="1" to="6" step="1">
			<cfset a = randrange(48,122)>
			<cfif (a gt 57 and a lt 65) or (a gt 90 and a lt 97)>
				<cfset str_uid["#i#"]="E">
			<cfelse>
				<cfset str_uid["#i#"]=chr(a)>
			</cfif>
		</cfloop>

		<cfset VARIABLES.invite_uid =LCase("#str_uid[1]##str_uid[2]##str_uid[3]##str_uid[4]##str_uid[5]##str_uid[6]#")>	
		
		<cfquery name="iInvite" datasource="#APPLICATION.DSN#">
			INSERT INTO
				Invites
				(invite_uid,user_id,invite_email,invite_first_name,invite_last_name)
				VALUES
				(<cfqueryparam cfsqltype="cf_sql_char" value="#VARIABLES.invite_uid#">,#user_id#,<cfqueryparam cfsqltype="cf_sql_char" value="#FORM.user_email#">,<cfqueryparam cfsqltype="cf_sql_char" value="#FORM.user_first_name#">,<cfqueryparam cfsqltype="cf_sql_char" value="#FORM.user_last_name#">)
		</cfquery>
		
		<cfmail from="noreply@destinyfinder.com" to="#FORM.user_email#" subject="You've been invited.">
			You've been invited to take an assessment for a friend.
		</cfmail>
		
	</cffunction>
    
    
    
    


</cfcomponent>
