<cffunction name="listing_memo" returntype="any" output="yes">
	<cfargument name="title" type="string" required="yes">
	<cfargument name="action" type="string" required="yes">
	
		<div style="width:350px;border:1px dotted ##ff0000; color:##ff0000;font-size:13px;padding-bottom:5px;padding-top:5px;font-weight:bold;text-align:center;margin-left:auto;margin-right:auto;margin-bottom:5px;margin-top:5px;">
		<cfif action EQ "new">
			<cfset memo_message = "#title# Has Been Added">
		<cfelseif action EQ "updated">
			<cfset memo_message = "#title# Has Been Updated">
		<cfelseif action EQ "deleted">
			<cfset memo_message = "#title# Has Been Deleted">
		</cfif>
		<cfoutput>#memo_message#</cfoutput>
		</div>
	
	<cfreturn>
</cffunction>

<cffunction name="delete_step1" returntype="any" output="yes">
	<cfargument name="page_return" type="string" required="yes">
	<cfargument name="table_primkey_name" type="string" required="yes">
	<!--- <cfargument name="table_primkey_value" type="string" required="yes"> --->
	<cfargument name="table_title_column" type="string" required="yes">
		<!--- additional_form_fields should be in comma delimeted listing --->
	<cfargument name="additional_form_fields" type="string" required="no">
	<!--- <cfargument name="table_title_column_value" type="string" required="yes"> --->
	
	<cfset table_primkey_value = "#form[table_primkey_name]#">
	<cfset table_title_column_value = "#form[table_title_column]#">
	
	

	<cfoutput><div id="delete_warning">Are you sure you want to delete: #table_title_column_value# ?<Br /><br />
		<cfform action="#page_return#" method="post" enctype="multipart/form-data">
		<input name="submit" type="submit" value="Yes, Confirm Deletion" />&nbsp;
		<input name="submit" type="submit" value="Cancel" />
		<input type="hidden" name="#table_primkey_name#" value="#table_primkey_value#" />
		<input type="hidden" name="#table_title_column#" value='#table_title_column_value#' />
		<cfif isDefined('additional_form_fields') AND additional_form_fields NEQ "">
			<cfloop list="#additional_form_fields#" index="field_name">
				<input type="hidden" name="#field_name#" value="#form[field_name]#">
			</cfloop>
		</cfif>
		
		</cfform>
		</div>
	</cfoutput>
</cffunction>


<cffunction name="delete_step2" returntype="any" output="yes">
		<cfargument name="table_name" type="string" required="yes">
		<cfargument name="table_primkey_name" type="string" required="yes">
		<!---<cfargument name="table_primkey_value" type="string" required="yes">--->
		<cfargument name="table_title_column" type="string" required="yes">
		<!--- <cfargument name="table_title_column_value" type="string" required="yes">--->
		<cfargument name="page_return" type="string" required="yes">
		<cfargument name="additional_url_vars" type="string" required="no">
		<cfargument name="dsn" type="string" required="yes">
	
		<cfset table_primkey_value = "#form[table_primkey_name]#">
		<cfset table_title_column_value = '#form[table_title_column]#'>
		<cfparam name="additional_url_vars" default="">
		<cfquery name="deleterecord" datasource="#DSN#" dbtype="odbc">
		DELETE FROM #table_name#
		WHERE #table_primkey_name# = #table_primkey_value#
		</cfquery>
		
		
</cffunction>


<cffunction name="image_field" returntype="any" output="true">
		<cfargument name="query_scope" type="string" required="yes">
		<cfargument name="img_field_name" type="string" required="yes">
		<cfargument name="img_field_desc" type="string" required="yes">
		<cfargument name="img_field_desc2" type="string" required="no">
		<cfargument name="img_directory" type="string" required="no">
		<cfargument name="new_entry" type="string" required="yes">

<cfif isDefined('img_directory') AND img_directory NEQ "">
	<cfset VARIABLES.image_directory = "#img_directory#" & "_directory">
<cfelse>
	<cfset VARIABLES.image_directory = "#img_field_name#" & "_directory">
</cfif>

<cfset VARIABLES.image_directory = '#APPLICATION[image_directory]#'>

<cfset VARIABLES.full_variable_name = "#query_scope#.#img_field_name#">

<cfif new_entry NEQ "yes">
<cfset VARIABLES.image_filename = "#VARIABLES[query_scope][img_field_name][1]#">
<cfelse>
<cfset VARIABLES.image_filename = "">
</cfif>


<cfif VARIABLES.image_filename EQ "">
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
  <td valign="top"><strong>#img_field_desc#</strong>
  <cfif isDefined('img_field_desc2') AND img_field_desc2 NEQ "">
  <br>
  #img_field_desc2#
  </cfif>
  </td>
  <td>Upload Image: <input type="file" class="form" size="30" name="add_#img_field_name#">
	 </td>
</tr>
<cfelse>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
  <td valign="top"><strong>#img_field_desc# Uploaded:</strong></td>
  <td><img src="..#replace(image_directory, '\', '/', 'All')##VARIABLES.image_filename#" >
	    <br>
	  <br>
	  Replace Image: <input type="file" class="form" size="30" name="add_#img_field_name#"><br>
	  <input type="checkbox" value="1" name="delete_#img_field_name#"> Delete Image
	  <input type="hidden" name="#img_field_name#" value="#VARIABLES.image_filename#" />
	  <br />
	  &nbsp;</td>
</tr>
</cfif>

</cffunction>


<cffunction name="lookup_table_add" returntype="any" output="true">
	<cfargument name="table_primkey_name" type="string" required="yes">
	<cfargument name="secondary_primkey_name" type="string" required="yes">
	<cfargument name="db_table_name" type="string" required="yes">
	<cfargument name="checkbox_name" type="string" required="yes">
	<cfargument name="lookup_table" type="string" required="yes">

<cfset checkbox_value = "#form[checkbox_name]#">
<cfset latest_record_query = "getlatestrecord">

<cfquery name="#latest_record_query#" datasource="#DSN#" maxrows="1">
SELECT #table_primkey_name# FROM #db_table_name#
ORDER BY #table_primkey_name# DESC
</cfquery>

<!--- CONVERT CHECKBOX SELECTIONS FROM LIST TO AN ARRAY --->
<cfset VARIABLES.checkbox_array = ListToArray(#checkbox_value#)>

<!--- FIND THE LENGTH OF THE ARRAY SO WE CAN LOOP OVER IT --->
<cfset VARIABLES.checkbox_array_len = ArrayLen(#VARIABLES.checkbox_array#)>


<!--- LOOP THROUGH ARRAY AND LOAD CHECKBOX SELECTIONS INTO THE LOOKUP TABLE --->
<cfloop from="1" to="#VARIABLES.checkbox_array_len#" index="i">
			<cfquery name="insertlookup" datasource="#DSN#">
				INSERT INTO #lookup_table#
				(#table_primkey_name#,#secondary_primkey_name#) VALUES ('#VARIABLES[latest_record_query][table_primkey_name][1]#','#VARIABLES.checkbox_array[i]#')
			</cfquery>
</cfloop>

</cffunction>


<cffunction name="lookup_table_update" returntype="any" output="true">
	<cfargument name="table_primkey_name" type="string" required="yes">
	<cfargument name="secondary_primkey_name" type="string" required="yes">
	<cfargument name="db_table_name" type="string" required="yes">
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

<cfquery name="checkmatch" datasource="#DSN#">
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
		
		
			DELETE FROM #lookup_table#<br>
			WHERE #table_primkey_name# = #form[table_primkey_name]#<br>
			AND #secondary_primkey_name# = #VARIABLES['checkmatch'][secondary_primkey_name][query_curreny_row]#
			<Br>
			
		
			<cfquery name="deletematch" datasource="#DSN#">
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
		
		
		<cfquery name="getmatch" datasource="#DSN#">
		SELECT #table_primkey_name# FROM #lookup_table#
		WHERE #table_primkey_name# = #form[table_primkey_name]# AND #secondary_primkey_name# = #VARIABLES.checkbox_array[i]#
		</cfquery>
		
		<cfif getmatch.recordcount EQ 0>
			<cfquery name="insertlookup" datasource="#DSN#">
				INSERT INTO #lookup_table#
				(#table_primkey_name#,#secondary_primkey_name#) VALUES ('#form[table_primkey_name]# ','#VARIABLES.checkbox_array[i]#')
			</cfquery>
		</cfif>
	</cfloop>

<!--- IF ITEM DOES NOT EXIST --->
<cfelse>

	<cfloop from="1" to="#VARIABLES.checkbox_array_len#" index="i">
			<cfquery name="insertmatch" datasource="#DSN#">
				INSERT INTO #lookup_table#
				(#table_primkey_name#,#secondary_primkey_name#) VALUES ('#form[table_primkey_name]# ','#VARIABLES.checkbox_array[i]#')
			</cfquery>
	</cfloop>

</cfif>
</cffunction>


<cffunction name="image_upload_and_delete" returntype="any" output="true">
	<cfargument name="image_field_name" type="string" required="yes">
	<cfargument name="image_path_name" type="string" required="yes">
	<cfargument name="db_table_name" type="string" required="yes">
	<cfargument name="table_primkey_name" type="string" required="yes">

	<cfset VARIABLES.add_field_name = "add_#image_field_name#">
	
	<cfparam name="FORM.#VARIABLES.add_field_name#" default="">
	<cfset VARIABLES.add_field_name_value = FORM[VARIABLES.add_field_name]>


<!--- UPLOAD IMAGE --->
<cfif isdefined('VARIABLES.add_field_name_value') AND Len(VARIABLES.add_field_name_value) GT 0>
	<CFFILE ACTION="Upload" 
		FILEFIELD="form.#VARIABLES.add_field_name#"
		DESTINATION="#APPLICATION[image_path_name]#"
		NAMECONFLICT="overwrite">
	<cfset "form.#image_field_name#" = "#file.ServerFile#">
</cfif>



<!--- DELETE IMAGE --->
<cfif isDefined("form.delete_image") and form.delete_image EQ 1>
	<cfquery name="getimage" datasource="#DSN#">
		SELECT #image_field_name# FROM #db_table_name#
		WHERE #table_primkey_name# = #form[VARIABLES.table_primkey_name]#
	</cfquery>
	
	<cfset VARIABLES.getimage_value = getimage[image_field_name]>
	
	<cfif isDefined('VARIABLES.getimage_value') AND Len(VARIABLES.getimage_value) GT 0>
		<cfif FileExists("#APPLICATION[image_path_name]##VARIABLES.getimage_value#")>
		 <CFFILE ACTION="Delete"
			FILE="#APPLICATION[image_path_name]##VARIABLES.getimage_value#">
		</cfif>
	</cfif>
	<cfset "form.#image_field_name#" = "">
</cfif>

</cffunction>