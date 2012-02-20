<cfset objAssessment = CreateObject("component","cfcs.assessment")> 

<cfif FindNoCase("destinyfinder",CGI.HTTP_REFERER)>

    <cfif isDefined("FORM.nxpz3")>
    	<cfset vHiddenList = DEcrypt(FORM.nxpz3,'keyei3v2','CFMX_COMPAT','Hex')>
    	<cfset VARIABLES.vCount = ListGetAt(vHiddenList,1) + 1>
        <cfset VARIABLES.vNextQuestion = ListGetAt(vHiddenList,2)>
        <cfset VARIABLES.vFormField = ListGetAt(vHiddenList,3)>
        <cfset VARIABLES.vDBColumn = ListGetAt(vHiddenList,4)>
        <cfset FORM.user_id = #REQUEST.user_id#>
        <cfset FORM.last_modified = #now()#>
        
        <cfquery name="ResultExists" datasource="#APPLICATION.DSN#">
        	SELECT * 
			FROM Passion_Survey
            WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#REQUEST.user_id#">
        </cfquery>

		
        <cfif ResultExists.recordcount EQ 0 AND VARIABLES.vFormField EQ 'sphere'>
        	<cfquery datasource="#APPLICATION.DSN#">
            	INSERT INTO Passion_Survey (
                user_id,
                sphere,
                last_modified  )
                VALUES (
                <cfqueryparam cfsqltype="cf_sql_integer" value="#REQUEST.user_id#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.sphere#">,
                <cfqueryparam cfsqltype="cf_sql_date" value="#now()#"> )
            </cfquery> 
        <cfelse>
        	<cfquery datasource="#APPLICATION.DSN#">
            	UPDATE Passion_Survey
				SET last_modified = <cfqueryparam cfsqltype="cf_sql_date" value="#now()#">
				<cfif StructKeyExists(ResultExists, "#VARIABLES.vFormField#")>
					, "#VARIABLES.vFormField#" = "#FORM[VARIABLES.vFormField]#"
				</cfif>
                WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#FORM.user_id#">
            </cfquery>
        </cfif>
					<!--- 	1 = Family and Individual
							2 = Culture and Lifestyle
							3 = Business and Economics
							4 = Government, Legal and Non-Profit
					        5 = Religion and Spirituality   --->
        <cfif VARIABLES.vNextQuestion EQ 'sphere-1'>
       		<cfswitch expression="#FORM.sphere#">
                <cfcase value="Family and Individual">
                    <cfset VARIABLES.vNextQuestion = 'family-1-1'>
                </cfcase>
                <cfcase value="Culture and Lifestyle">
                    <cfset VARIABLES.vNextQuestion = 'culture_lifestyle-1-2'>
                </cfcase>
                <cfcase value="Business and Economics">
                    <cfset VARIABLES.vNextQuestion = 'business_economics-1-3'>
                </cfcase>
                <cfcase value="Government Legal and NonProfit">
                    <cfset VARIABLES.vNextQuestion = 'government_legal-1-4'>
                </cfcase>
                <cfcase value="Religion and Spirituality">
                    <cfset VARIABLES.vNextQuestion = 'religion_spirituality-1-5'>
                </cfcase>
        	</cfswitch>
        </cfif>

    </cfif>
    <cfif isDefined("FORM.surveydone")>
	    <script type="text/javascript">
			<!-- //
			top.location.href = '/profile/?page=viewresult&assessment_id=5';
			// -->
		</script>
	<cfelse>
    	<cflocation addtoken="yes" url="/site_modules/assessment/passion_survey.cfm?assessment_id=5&nxpb3=#Encrypt('#VARIABLES.vCount#,#VARIABLES.vNextQuestion#','keyei3v2','CFMX_COMPAT','Hex')#">
	</cfif>
</cfif>