<cfcomponent displayname="admin" output="no" hint="I handle the admin functions">

<cffunction name="lookup_table_update" returntype="any" output="false">
	<cfargument name="table_primkey_name" type="string" required="yes">
	<cfargument name="secondary_primkey_name" type="string" required="yes">
	<!--- <cfargument name="db_table_name" type="string" required="yes"> --->
	<cfargument name="checkbox_name" type="string" required="yes">
	<cfargument name="lookup_table" type="string" required="yes">

<cfparam name="form.#checkbox_name#" default="">
<cfset checkbox_value = "#form[checkbox_name]#">


<!--- CONVERT CHECKBOX SELECTIONS FROM LIST TO AN ARRAY --->
<cfset VARIABLES.checkbox_array = ListToArray(#checkbox_value#)>


<!--- *********************** FOR TESTING PURPOSES
<cfdump var="#VARIABLES.category_array#"><Br /> --->

<!--- FIND THE LENGTH OF THE ARRAY SO WE CAN LOOP OVER IT --->
<cfset VARIABLES.checkbox_array_len = ArrayLen(#VARIABLES.checkbox_array#)>

<!--- DETERMINE IF THIS IS A ITEM OR AN EXISTING ONE --->

<cfquery name="checkmatch" datasource="#APPLICATION.DSN#">
SELECT #table_primkey_name#,#secondary_primkey_name# FROM #lookup_table#
WHERE  #table_primkey_name# = '#FORM[table_primkey_name]#'
</cfquery>

<!--- IF THE ITEM EXISTS THEN PROCEED --->
<cfif checkmatch.recordcount GT 0>

	<!--- SET A FLAG TO DETERMINE IF THE MATCH HAS BEEN SET.  THIS WILL BE USED TO DETERMINE WHETHER A MATCH NEEDS TO BE REMOVED FROM THE TABLE --->
	<cfset VARIABLES.match_exists = 0>
	
	<!--- LOOP OVER ALL THE MATCHES --->
	
	<cfloop query="checkmatch">
	<cfset VARIABLES.query_curreny_row = checkmatch.currentrow>
		<!--- ************************** FOR TESTING PURPOSES 
		<cfoutput>LOOP THROUGH Category ID: #checkmatch.category_id#<br /></cfoutput>--->
		
		<!--- CHECK TO SEE IF THIS IS STILL A VALID MATCH --->
		<cfloop from="1" to="#VARIABLES.checkbox_array_len#" index="i">
			
			<!--- ************************** FOR TESTING PURPOSES  
			 <cfoutput>FROM SUBMISSION: #VARIABLES.checkbox_array[i]#<Br />
				Current Query Value: #VARIABLES['checkmatch'][secondary_primkey_name][query_curreny_row]#</cfoutput>--->
				
			<!--- IF THE SECONDARY_ID IS FOUND IN THE ARRAY, CHANGE THE VARIABLE FROM 0 TO 1 --->
			<cfif VARIABLES['checkmatch'][secondary_primkey_name][query_curreny_row] EQ #VARIABLES.checkbox_array[i]#>
				<cfset VARIABLES.match_exists = 1>
			</cfif>

			<!--- *****************************  FOR TESTING PURPOSES 
			<cfoutput>#VARIABLES.match_exists#<Br /><br /></cfoutput>---> 
		</cfloop>
		
		<!--- IF THE SECONDARY_ID IS NOT FOUND IN THE ARRAY, REMOVE IT FROM THE TABLE.  THE ITEM IS NO LONGER ASSOCIATED WITH THE MATCH --->
		<cfif VARIABLES.match_exists EQ 0>
		
		<!--- *****************************  FOR TESTING PURPOSES 
			DELETE FROM #lookup_table#<br>
			WHERE #table_primkey_name# = #form[table_primkey_name]#<br>
			AND #secondary_primkey_name# = #VARIABLES['checkmatch'][secondary_primkey_name][query_curreny_row]#
			<Br>
			--->
		
			<cfquery name="deletematch" datasource="#APPLICATION.DSN#">
			DELETE FROM #lookup_table#
			WHERE #table_primkey_name# = #form[table_primkey_name]# AND #secondary_primkey_name# = #VARIABLES['checkmatch'][secondary_primkey_name][query_curreny_row]#
			</cfquery>
			
			<!--- ************************** FOR TESTING PURPOSES
			<cfoutput>Category DELETED<Br /></cfoutput> --->
		
		</cfif>
		
		<cfset VARIABLES.match_exists = 0>
	</cfloop>

	<!--- BEGIN LOOP TO CHECK IF MATCH EXISTS AND IF NOT, INSERT IT --->
	<cfloop from="1" to="#VARIABLES.checkbox_array_len#" index="i">
		
		
		<cfquery name="getmatch" datasource="#APPLICATION.DSN#">
		SELECT #table_primkey_name# FROM #lookup_table#
		WHERE #table_primkey_name# = #form[table_primkey_name]# AND #secondary_primkey_name# = #VARIABLES.checkbox_array[i]#
		</cfquery>
		
		<cfif getmatch.recordcount EQ 0>
			<cfquery name="insertlookup" datasource="#APPLICATION.DSN#">
				INSERT INTO #lookup_table#
				(#table_primkey_name#,#secondary_primkey_name#) VALUES ('#form[table_primkey_name]# ','#VARIABLES.checkbox_array[i]#')
			</cfquery>
		</cfif>
	</cfloop>

<!--- IF ITEM DOES NOT EXIST --->
<cfelse>

	<cfloop from="1" to="#VARIABLES.checkbox_array_len#" index="i">


			<cfquery name="insertmatch" datasource="#APPLICATION.DSN#">
				INSERT INTO #lookup_table#
				(#table_primkey_name#,#secondary_primkey_name#) VALUES ('#form[table_primkey_name]# ','#VARIABLES.checkbox_array[i]#')
			</cfquery>
	</cfloop>

</cfif>

</cffunction>

<cffunction name="sort_order" output="false" hint="I handle the sortorder function">
	<cfargument name="divOrder" required="yes" type="string">
	<cfargument name="sort_id_list" required="yes" type="string">
	<cfargument name="table_name" required="yes" type="string">
	<cfargument name="sort_column" required="yes" type="string">
	<cfargument name="primary_key" required="yes" type="string">
	

	<!--- SORTABLE CODE --->
	<!--- <cfset VARIABLES.page_id_array = ListToArray('#form.page_id_list#')> --->
	<cfset VARIABLES.divorder = Replace('#divOrder#','sortContainer[]=','','ALL')>
	<cfset VARIABLES.divorder = Replace('#VARIABLES.divorder#','&',',','All')>
	<cfset VARIABLES.div_order_array = ListToArray('#VARIABLES.divOrder#')>
	
	<cfset VARIABLES.sort_id_array = ArrayNew(1)>
	<cfset VARIABLES.div_marker = 0>
	
		<cfloop from="1" to="#ListLen(sort_id_list)#" index="i">
			<cfset VARIABLES.sort_id_array[i] = StructNew()>
			<cfset VARIABLES.sort_id_array[i].sort_id = ListGetAt(sort_id_list,i)>
			<cfset VARIABLES.sort_id_array[i].div_id =  VARIABLES.div_marker>
			<cfset VARIABLES.div_marker = VARIABLES.div_marker + 1>
		</cfloop>
	
<!---
	Sort ID ARRAY:<br />
	<cfdump var="#VARIABLES.sort_id_array#">
	Div Order ARRAY:<br />
	<cfdump var="#VARIABLES.div_order_array#">
--->
	
		<cfloop from="1" to="#ArrayLen(VARIABLES.sort_id_array)#" index="x">
		
		<!---<cfoutput>
		<br/>
		UPDATE #table_name# set #sort_column# = #x# WHERE #primary_key# = <br/>
			<cfloop from="1" to="#ArrayLen(VARIABLES.sort_id_array)#" index="y">
				<cfif VARIABLES.div_order_array[x] EQ VARIABLES.sort_id_array[y].div_id>
					#VARIABLES.sort_id_array[y].sort_id#<br/>
				</cfif> 
			</cfloop>
		</cfoutput>
		--->
			<cfquery name="update_sortorder" datasource="#APPLICATION.DSN#">
			UPDATE #table_name# set #sort_column# = #x# WHERE #primary_key# = 
			<cfloop from="1" to="#ArrayLen(VARIABLES.sort_id_array)#" index="y">
				<cfif VARIABLES.div_order_array[x] EQ VARIABLES.sort_id_array[y].div_id>
					#VARIABLES.sort_id_array[y].sort_id#
				</cfif> 
			</cfloop>
		</cfquery>
		
		
		</cfloop>
	
</cffunction>


</cfcomponent>