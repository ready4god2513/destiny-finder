<cfcomponent displayname="assessment" output="no" hint="I handle the assessment functions">
	
	<cfset objUsers = CreateObject("component","cfcs.users")>
	<cfset foxyCart = CreateObject("component", "cfcs.foxycart") />


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

	<cffunction name="getAssessment" output="false" returntype="query">
		<cfargument name="id" required="yes" type="string" />
	
		<cfquery name="qAssessments" datasource="#APPLICATION.DSN#">
	        SELECT *
			FROM Assessments
			WHERE assessment_id = <cfqueryparam cfsqltype="cf_sql_char" value="#ARGUMENTS.id#">
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
		<cfargument name="assessment_id" required="no" type="numeric">
			
		<cfquery name="qResult" datasource="#APPLICATION.DSN#">
			SELECT *
			FROM Results
			WHERE 1 = 1
			<cfif isDefined("result_id")>
				AND result_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#result_id#">
			<cfelse>
				<cfif isDefined("user_id")>
					AND user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
				</cfif>
				<cfif isDefined('assessment_id')>
					AND assessment_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#assessment_id#">
				</cfif>
				<cfif isDefined("invite")>
					AND invite_uid = <cfqueryparam cfsqltype="cf_sql_char" value="#invite#">
				<cfelse>
					AND invite_uid IS NULL
				</cfif>
			</cfif>
		</cfquery>
		
		<cfreturn qResult>
	</cffunction>
    
    <cffunction name="retrieve_invite_userid" output="false" returntype="query">
		<cfargument name="invite" required="no" type="string">
	
		<cfquery name="qInviteuid" datasource="#APPLICATION.DSN#">
			SELECT *
			FROM Results
			WHERE invite_uid = <cfqueryparam cfsqltype="cf_sql_char" value="#invite#">
		</cfquery>

		<cfreturn qInviteuid>
        
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
			WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.user_id#">
			AND assessment_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.assessment_id#">
			<cfif isDefined('ARGUMENTS.invite') AND LEN(invite) GT 0>
				AND invite_uid = <cfqueryparam cfsqltype="cf_sql_char" value="#ARGUMENTS.invite#">
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
			<cfset VARIABLES.items = DeSerializeJSON(qResult.result_set, false)>
				
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
					WHERE result_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qResult.result_id#">			
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
					WHERE result_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qResult.result_id#">
				</cfquery>
			
			</cfif>
		</cfif>
	
	</cffunction>
	
	
	<cffunction name="get_gift_name" hint="I get the gift name from the id" output="false" returnType="string">
		<cfargument name="gift_type_id" type="numeric" required="yes">
			
		<cfset var local = {} />
		<cfquery name="local.gift" datasource="#APPLICATION.DSN#">
			SELECT TOP 1 *
			FROM gifts
			WHERE gift_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.gift_type_id#">
		</cfquery>
		
		<cfreturn local.gift.gift_name>
	</cffunction>
	
	
	<cffunction name="parse_responses" hint="I loop through all of the responses and calculate which gift is chosen the most" output="false" returnType="array">
		<cfargument name="results" type="query" required="yes">
		<cfargument name="gift_type_id" type="numeric" required="yes">
		
		<cfset var local = {} />
		<cfset local.gifts = this.retrieve_gifts(gift_type_id = "#gift_type_id#")>
		<cfset local.result_set = DeSerializeJSON(arguments.results.result_set, false)>
		<cfset local.gift_count = ArrayNew(1)>
		
	
		<!--- PREPARE CONTAINER FOR KEEPING SCORE OF EACH GIFT --->
		<cfloop from="1" to="#local.gifts.recordcount#" index="i"> 
			<cfset local.gift_count[i] = {id = local.gifts.gift_id[i],counter = 0, name = local.gifts.gift_name[i]}>
		</cfloop>
	
		<cfloop from="1" to="#ArrayLen(local.result_set)#" index="i">
				<cfswitch expression="#local.result_set[i].type_id#">
					<cfcase value="1">
						<cfloop from="1" to="#ArrayLen(local.gift_count)#" index="j">
							<!--- This section needs to be simplified with a CFLOOP to condense this section of code. TJ --->
	                        <cfif arguments.gift_type_id EQ 3>
                        
								<cfif local.gift_count[j].id EQ ListGetAt(Replace(local.result_set[i].result,'"','','ALL'),1)>
	                                <cfset local.gift_count[j].counter = local.gift_count[j].counter + 9 >
	                            </cfif>
                        
								<cfif local.gift_count[j].id EQ ListGetAt(Replace(local.result_set[i].result,'"','','ALL'),2)>
	                                <cfset local.gift_count[j].counter = local.gift_count[j].counter + 8 >
	                            </cfif>
                        
								<cfif local.gift_count[j].id EQ ListGetAt(Replace(local.result_set[i].result,'"','','ALL'),3)>
	                                <cfset local.gift_count[j].counter = local.gift_count[j].counter + 7 >
	                            </cfif>
                            
	                            <cfif local.gift_count[j].id EQ ListGetAt(Replace(local.result_set[i].result,'"','','ALL'),4)>
	                                <cfset local.gift_count[j].counter = local.gift_count[j].counter + 6 >
	                            </cfif>
                            
	                            <cfif local.gift_count[j].id EQ ListGetAt(Replace(local.result_set[i].result,'"','','ALL'),5)>
	                                <cfset local.gift_count[j].counter = local.gift_count[j].counter + 5 >
	                            </cfif>
                            
	                            <cfif local.gift_count[j].id EQ ListGetAt(Replace(local.result_set[i].result,'"','','ALL'),6)>
	                                <cfset local.gift_count[j].counter = local.gift_count[j].counter + 4 >
	                            </cfif>
                            
	                            <cfif local.gift_count[j].id EQ ListGetAt(Replace(local.result_set[i].result,'"','','ALL'),7)>
	                                <cfset local.gift_count[j].counter = local.gift_count[j].counter + 3 >
	                            </cfif>
                            
	                            <cfif local.gift_count[j].id EQ ListGetAt(Replace(local.result_set[i].result,'"','','ALL'),8)>
	                                <cfset local.gift_count[j].counter = local.gift_count[j].counter + 2 >
	                            </cfif>
                            
	                            <cfif local.gift_count[j].id EQ ListGetAt(Replace(local.result_set[i].result,'"','','ALL'),9)>
	                                <cfset local.gift_count[j].counter = local.gift_count[j].counter + 1 >
	                            </cfif>
                            
	                        <cfelseif arguments.gift_type_id EQ 2>
                        
								<cfif local.gift_count[j].id EQ ListGetAt(Replace(local.result_set[i].result,'"','','ALL'),1)>
	                                <cfset local.gift_count[j].counter = local.gift_count[j].counter + 7 >
	                            </cfif>
                            
	                            <cfif local.gift_count[j].id EQ ListGetAt(Replace(local.result_set[i].result,'"','','ALL'),2)>
	                                <cfset local.gift_count[j].counter = local.gift_count[j].counter + 6 >
	                            </cfif>
                            
	                            <cfif local.gift_count[j].id EQ ListGetAt(Replace(local.result_set[i].result,'"','','ALL'),3)>
	                                <cfset local.gift_count[j].counter = local.gift_count[j].counter + 5 >
	                            </cfif>
                            
	                            <cfif local.gift_count[j].id EQ ListGetAt(Replace(local.result_set[i].result,'"','','ALL'),4)>
	                                <cfset local.gift_count[j].counter = local.gift_count[j].counter + 4 >
	                            </cfif>
                            
	                            <cfif local.gift_count[j].id EQ ListGetAt(Replace(local.result_set[i].result,'"','','ALL'),5)>
	                                <cfset local.gift_count[j].counter = local.gift_count[j].counter + 3 >
	                            </cfif>
                            
	                            <cfif local.gift_count[j].id EQ ListGetAt(Replace(local.result_set[i].result,'"','','ALL'),4)>
	                                <cfset local.gift_count[j].counter = local.gift_count[j].counter + 2 >
	                            </cfif>
                            
	                            <cfif local.gift_count[j].id EQ ListGetAt(Replace(local.result_set[i].result,'"','','ALL'),5)>
	                                <cfset local.gift_count[j].counter = local.gift_count[j].counter + 1 >
	                            </cfif>
                            
	                        <cfelseif arguments.gift_type_id EQ 1>
                        
	                        	<cfif local.gift_count[j].id EQ ListGetAt(Replace(local.result_set[i].result,'"','','ALL'),1)>
	                                <cfset local.gift_count[j].counter = local.gift_count[j].counter + 5 >
	                            </cfif>
                            
	                            <cfif local.gift_count[j].id EQ ListGetAt(Replace(local.result_set[i].result,'"','','ALL'),2)>
	                                <cfset local.gift_count[j].counter = local.gift_count[j].counter + 4 >
	                            </cfif>
                            
	                            <cfif local.gift_count[j].id EQ ListGetAt(Replace(local.result_set[i].result,'"','','ALL'),3)>
	                                <cfset local.gift_count[j].counter = local.gift_count[j].counter + 3 >
	                            </cfif>
                            
	                            <cfif local.gift_count[j].id EQ ListGetAt(Replace(local.result_set[i].result,'"','','ALL'),4)>
	                                <cfset local.gift_count[j].counter = local.gift_count[j].counter + 2 >
	                            </cfif>
                            
	                            <cfif local.gift_count[j].id EQ ListGetAt(Replace(local.result_set[i].result,'"','','ALL'),5)>
	                                <cfset local.gift_count[j].counter = local.gift_count[j].counter + 1 >
	                            </cfif>
                            
							</cfif>
                        
						</cfloop>
					</cfcase>
					<cfcase value="2">
						<cfset local.rating = DeSerializeJSON(local.result_set[i].result, false)>
						<cfloop from="1" to="#ArrayLen(local.gift_count)#" index="j">
							<cfif local.gift_count[j].id EQ local.rating.gift>
								<cfset local.gift_count[j].counter = local.gift_count[j].counter + local.rating.rate >
							</cfif>
						</cfloop>
					</cfcase>
				</cfswitch>
		</cfloop>
		
		<cfreturn local.gift_count />
	</cffunction>
	
	
	<cffunction name="get_top_gifts" hint="I get the top gifts" output="false" returnType="array">
		<cfargument name="results" type="array" required="yes">
			
		<cfset var local = {} />
		<cfset local.dominant_gifts = ArrayNew(1) />
		<cfset local.dominant_gifts[1] = { id = 0, count = 0} />
		<cfset local.dominant_gifts[2] = { id = 0, count = 0} />
		
		<cfloop from="1" to="#ArrayLen(arguments.results)#" index="i">
			<cfif arguments.results[i].counter GT local.dominant_gifts[1].count>
				<cfset local.dominant_gifts[1].id = arguments.results[i].id>
				<cfset local.dominant_gifts[1].count = arguments.results[i].counter>
			</cfif>
		</cfloop>
		
		<cfloop from="1" to="#ArrayLen(arguments.results)#" index="i">
			<cfif arguments.results[i].counter GT local.dominant_gifts[2].count AND arguments.results[i].id NEQ local.dominant_gifts[1].id>
				<cfset local.dominant_gifts[2].id = arguments.results[i].id>
				<cfset local.dominant_gifts[2].count = arguments.results[i].counter>
			</cfif>
		</cfloop>
		
		<cfreturn local.dominant_gifts />
	</cffunction>
	

	<cffunction name="process_results" hint="I process an assessment result set" output="true">
		<cfargument name="result_id" required="yes" type="numeric">
	    <cfargument name="assessment_id" required="no" type="numeric">
	    <cfargument name="gift_type_id" required="no" type="numeric">
        <cfargument name="nodisplay" required="no" type="numeric">
		<!--- SIMPLE SCORING ENGINE. THE RESULT SET IS LOOPED OVER AND THE ITEM TYPE DETERMINES HOW THE SET WILL BE SCORED--->
		<cfset var local = {}>
		
		<cfset local.qGifts = this.retrieve_gifts(gift_type_id="#gift_type_id#")>
		<cfset local.qResult = this.retrieve_result(result_id="#result_id#")>
			
		<cfset local.results = this.parse_responses(results = qResult, gift_type_id = arguments.gift_type_id) />
		<cfset local.top_gifts = this.get_top_gifts(results = local.results) />
		
		<cfquery name="local.uResult" datasource="#APPLICATION.DSN#">
			UPDATE Results
			SET
			result_gift_count = <cfqueryparam cfsqltype="char" value="#SerializeJSON(local.results)#">,
			last_modified = <cfqueryparam cfsqltype="cf_sql_date" value="#now()#">
			WHERE result_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#result_id#">
		</cfquery>
    
    
	    <cfquery name="local.qThisResult" datasource="#APPLICATION.DSN#">
	    	SELECT *
			FROM gifts
			<cfif arguments.assessment_id EQ 2>
				WHERE gift_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#local.top_gifts[1].id#">, <cfqueryparam cfsqltype="cf_sql_integer" value="#local.top_gifts[2].id#">)
				ORDER BY (Case When gift_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#local.top_gifts[1].id#"> then 0
					When gift_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#local.top_gifts[2].id#"> then 1
					Else gift_id End
				)
			<cfelse>
				WHERE gift_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#local.top_gifts[1].id#">
			</cfif>
	    </cfquery>
	
	    <cfquery name="local.qUser" datasource="#APPLICATION.DSN#">
			SELECT *
			FROM Users
			WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#REQUEST.user_id#">
		</cfquery>
		
		<cfparam name="URL.gift_type_id" default="0" />
		
        <cfif isDefined("nodisplay") AND nodisplay EQ 1>
        	<cfreturn />
        </cfif>

		<cfquery name="local.giftTypes" datasource="#APPLICATION.DSN#">
			SELECT *
			FROM Gifts
		</cfquery>
		
		<div class="row">
			<div class="span7">
				<h1>#this.getAssessment(URL.assessment_id).assessment_name# Results - #HTMLEditFormat(local.qUser.user_first_name)# #HTMLEditFormat(local.qUser.user_last_name)# #dateformat(local.qResult.last_modified,'mmm dd, yyyy')#</h1>
			</div>
			<div class="pull-right">
				<cfif not isDefined("URL.pdf")>
					<a href="#REQUEST.site_url#profile/?page=viewresult&amp;assessment_id=#val(arguments.assessment_id)#&amp;gift_type_id=#val(arguments.gift_type_id)#&amp;pdf=true" target="_blank" class="btn btn-info">Print Results (PDF)</a>
				</cfif>
			</div>
		</div>
		
		<cfset chart_format = "flash" />
		<cfif isDefined("URL.pdf")>
			<cfset chart_format = "png" />
		</cfif>
		
		<cfif #assessment_id# NEQ 1>
			<cfchart
				chartWidth="600"
				format="#chart_format#">
				<cfchartseries
					type="bar"
					serieslabel="Survey Results Breakdown"
					paintStyle="shade">

					<cfloop array="#local.results#" index="gift">
						<cfchartdata item="#gift.name#" value="#gift.counter#">
					</cfloop>
				</cfchartseries>
			</cfchart>
		</cfif>
		
		<cfif local.qThisResult.recordcount GT 0>
			<cfloop query="local.qThisResult">
			    <div class="short_desc">
					<cfif #currentrow# eq 1>
						#gift_primary#
					<cfelse>
						#gift_secondary#
					</cfif>
				</div>
				<hr />
			</cfloop>
			
			<cfif isDefined("assessment_id")>
			    <cfquery name="local.qGetClosing" datasource="#APPLICATION.DSN#">
					SELECT assessment_closing_text
					FROM Assessments
					WHERE assessment_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.assessment_id#">
				</cfquery>
		    	<div class="short_desc">#local.qGetClosing.assessment_closing_text#</div>

				<cfif not isDefined("URL.pdf")>
					<a href="#REQUEST.site_url#profile/?page=viewresult&amp;assessment_id=#val(arguments.assessment_id)#&amp;gift_type_id=#val(arguments.gift_type_id)#&amp;pdf=true" target="_blank" class="btn btn-info">Print Results (PDF)</a>
				</cfif>
		    </cfif>
		</cfif>
	
		
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
		
			<!-- 
				We need to query foxycart to check what surveys have been purchased by the user.
				Optimally we will create a habtm table that stores the permissions of the users.
			-->
			<cfreturn "">
		</cffunction>
		
		
		<cffunction name="compile_results" output="true" hint="I compile all results and tally score">
			<cfargument name="user_id" required="yes" type="numeric">
			<cfargument name="invite" required="no" type="string">

			<cfparam name="invite" default="">

			<cfset qResults = retrieve_result(user_id="#user_id#",invite="#invite#")>
			<cfset qGifts = retrieve_gifts(gift_type_id=1)>
			<cfset VARIABLES.compiled_gift_count = ArrayNew(1)>
		    <cfset VARIABLES.dominant_gift = {id = 0, count =0}>

			<!--- PREPARE CONTAINER FOR KEEPING SCORE OF EACH GIFT --->
			<cfloop from="1" to="#qGifts.recordcount#" index="i"> 
				<cfset VARIABLES.compiled_gift_count[i] = {id = qGifts.gift_id[i],counter = 0}>
			</cfloop>

			<cfoutput query="qResults">
				<cfif IsJSON(qResults.result_gift_count)>
					<cfset VARIABLES.result_gift_count = DeSerializeJSON(qResults.result_gift_count, false)>

					<cfloop from="1" to="#ArrayLen(VARIABLES.result_gift_count)#" index="i">
						<cfif VARIABLES.result_gift_count[i].counter GT VARIABLES.dominant_gift.count>
							<cfset VARIABLES.dominant_gift.id = VARIABLES.result_gift_count[i].id>
	                        <cfset VARIABLES.dominant_gift.count = VARIABLES.result_gift_count[i].counter>
						</cfif>
					</cfloop>
				</cfif>	
			</cfoutput>
			<cfquery name="qThisResult" datasource="#APPLICATION.DSN#">
                Select gift_name from gifts
                Where gift_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#VARIABLES.dominant_gift.id#">
            </cfquery>
			<cfoutput><cfif Len(qThisResult.gift_name) GT 0>#qThisResult.gift_name#<cfelse>none</cfif></cfoutput>
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
			
            <!---<cfset qUser = objQueries.user_detail(user_id="#REQUEST.user_id#")>--->
            
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
			
			<cfquery name="u" datasource="#APPLICATION.DSN#">
				SELECT *
				FROM Users
				WHERE user_id = <cfqueryparam cfsqltype="cf_sql_char" value="#ARGUMENTS.user_id#">
			</cfquery>
		
			<cfmail 
				from="noreply@destinyfinder.com" 
				to="#FORM.user_email#" 
				subject="You've been invited - DestinyFinder"
				type="html">
				<p>
					Hello #FORM.user_first_name# #FORM.user_last_name#,
				</p>
				<p>
					I've just taken the Free Trial Destiny Survey from DestinyFinder.com. This survey is part
					of a system of online tools that helps people discover and fulfill their destiny. I'd like you
					to do the survey about me so I can get a more objective picture of myself. Please be as
					honest as possible.
				</p>
				<p>
					It's fun, free and easy! (only 10 questions)
				</p>
                <p>
					All you need to do is follow this link take the survey:
					<a href="#REQUEST.site_url#invite/?invite=#VARIABLES.invite_uid#" target="_blank">START THE SURVEY</a>
				</p>
				<p>Thanks,<br /> #u.user_first_name# #u.user_last_name#</p>
				<p>
					<a href="http://destinyfinder.com" target="_blank">Destiny Finder</a><br />
					By taking this survey, you are not obligated in any way. 
					It is a free survey about your friend. The sponsoring organization is Destiny Finder, 
					headquartered in Redding California, working with many churches and ministries. 
					If you're concerned, please contact your friend at <a href="mailto:#u.user_email#">#u.user_email#</a>
				</p>
			</cfmail>
		
		</cffunction>
		

</cfcomponent>