<cfcomponent displayname="files" output="no" hint="I handle file functions">

<cffunction name="upload_file" returntype="string" output="false" hint="I process a file upload.">
	<cfargument name="form_file_field" required="yes" type="string">
	<cfargument name="file_type" required="no" type="string">
	<cfargument name="file_purpose" required="yes" type="string">

		
	

	<cftry>
	  <cfset request.badext ="cfml,cfm,asp,shtml,php,cgi,htm,php,exe">
	  <!---  WHEN UPLOADING a FLV the file type was application/octet-stream --->
	  <cfset request.accept ="image/gif,image/jpg,image/jpeg,image/png,video/x-flv,video/mp4,audio/mp3,application/octet-stream">

	 <cflock name="file_upload" type="exclusive" timeout="3">
	  <CFFile action="UPLOAD" 
	  	filefield="form.#form_file_field#" 
		destination="#REQUEST.temp_upload_dir#" 
		nameconflict="MAKEUNIQUE">
	</cflock>
	
		
	  <cfset request.tmpfilename = File.ServerFile>
	  <cfset request.filetype = File.ContentType & "/" & File.ContentSubType>
		
	
	  <cfif ListFindNoCase(request.accept, request.filetype) AND NOT ListFindNoCase(request.badext, File.ClientFileExt)>
		<cfset request.clientfile = File.ClientFile>
	  <cfelse>

	  
	  <cflock name="file_delete" type="exclusive" timeout="3">
		 <cffile action="DELETE" 
      		file="#REQUEST.temp_upload_dir##File.ServerFile#">
		</cflock>
		<!--- THROW ERROR GOES HERE --->
				<!--- ---><cfoutput>#request.filetype#</cfoutput>
			<cflocation url="/blog/index.cfm?page=blog&admin=1&fileerror=1" addtoken="no">
	  </cfif>

		<cfif Findnocase(File.ClientFileExt,"gif,jpg,png")>
			<cfset file_type = "image">		
			
				<cfimage
				action = "info"
				source = "#REQUEST.temp_upload_dir##File.ServerFile#"
				structname = "uploaded_image">
			
			<!--- CF WAS THROWING WEIRD ERRORS ON A RESIZE AND OVERWRITE SO WE SAVE THE RESIZED IMAGE AND DELETE THE ORIGINAL --->
			<cfif file_purpose EQ "blog">
				
				<cfif form_file_field EQ "add_media_file">
					<cfif uploaded_image.width GT 500>
						<cfimage
							action = "resize"
							source = "#REQUEST.temp_upload_dir##File.ServerFile#"
							width = "500"
							height = ""
							name = "Image_resize"
							destination = "#REQUEST.temp_upload_dir#Resized_#File.ServerFile#"
							overwrite = "yes"
							>
	
							<cffile action="DELETE" 
								file="#REQUEST.temp_upload_dir##File.ServerFile#">
							
							<cfset File.ServerFile = "resized_#File.ServerFile#">
							
					</cfif>
					
				<cfelseif form_file_field EQ "add_blog_thumb">
				
						<cfimage
						action = "resize"
						source = "#REQUEST.temp_upload_dir##File.ServerFile#"
						width = "122"
						height = "93"
						name = "Image_resize"
						destination = "#REQUEST.temp_upload_dir#Resized_#File.ServerFile#"
						overwrite = "yes"
						>

   					 
						<cffile action="DELETE" 
      						file="#REQUEST.temp_upload_dir##File.ServerFile#">
							
						<cfset File.ServerFile = "resized_#File.ServerFile#">
					
				</cfif>
				
			<cfelseif file_purpose EQ "profile">
					 
					<cfimage
						action = "resize"
						source = "#REQUEST.temp_upload_dir##File.ServerFile#"
						width = "122"
						height = "93"
						name = "Image_resize"
						destination = "#REQUEST.temp_upload_dir#Resized_#File.ServerFile#"
						overwrite = "yes"
						>

   					 
						<cffile action="DELETE" 
      						file="#REQUEST.temp_upload_dir##File.ServerFile#">
							
						<cfset File.ServerFile = "resized_#File.ServerFile#">
						
			</cfif>

		<cfelseif Findnocase(File.ClientFileExt,"flv,mp4")>
			<cfset file_type = "video">		
		<cfelseif Findnocase(File.ClientFileExt,"mp3")>
			<cfset file_type = "audio">		
		</cfif>
		
			  <cfset sleep(3000)>
	<cflock name="file_move" type="exclusive" timeout="3">
  		<CFFile action="MOVE" 
			source="#REQUEST.temp_upload_dir##File.ServerFile#" 
			destination="#REQUEST.site_path#custom_files\user_files\#file_type#\" 
			nameConflict="makeunique">
		</cflock>

		
		<cfset VARIABLES.full_file_path = "#REQUEST.site_path#custom_files\user_files\#file_type#\#file.ServerFile#">
		<cfset VARIABLES.file_ext = Right(file.serverfile,3)>
		<cfset VARIABLES.random_seed = RandRange(1,100000)>
		<cfset VARIABLES.random_file = "#REQUEST.site_path#custom_files\user_files\#file_type#\#file_purpose#_#VARIABLES.random_seed#.#VARIABLES.file_ext#">
		<cfset VARIABLES.check_random_file = fileexists('#VARIABLES.random_file#')>

		<cfloop condition="VARIABLES.check_random_file EQ 'Yes' ">
			<cfset VARIABLES.random_seed = RandRange(1,100000)>
			<cfset VARIABLES.random_file = "#REQUEST.site_path#custom_files\user_files\#file_type#\#file_purpose#_#VARIABLES.random_seed#.#VARIABLES.file_ext#">
			<cfset VARIABLES.check_random_file = fileexists('#VARIABLES.random_file#')>
		</cfloop>
		
		  <cfset sleep(3000)>
		<cflock name="file_rename" type="exclusive" timeout="3">
		<CFFile 
			action="rename"
     		source="#REQUEST.site_path#custom_files\user_files\#file_type#\#file.serverfile#"
			destination="#VARIABLES.random_file#"
			>
		</cflock>
			
		<cfcatch type="ANY">
			<cfset VARIABLES.error_message = "
			<strong>Error Type:</strong> #cfcatch.Type#<br/>
			<strong>Error Message:</strong> #cfcatch.Message#<br/>
			<strong>Error Detail:</strong> #cfcatch.detail#<br/>
			">
			<cfsavecontent variable="VARIABLES.error_dump">
				<cfdump var="#cfcatch.TagContext#">
			</cfsavecontent>
			
			<cfquery name="Insert_Error" datasource="#APPLICATION.DSN#">
				INSERT INTO ErrorLog
				(error_message,error_dump)
					VALUES
				('#VARIABLES.error_message#','#VARIABLES.error_dump#')
			</cfquery>
			
			<cfmail from="#REQUEST.from_email#" to="#REQUEST.web_admin#" subject="#APPLICATION.sitename#: ERROR REPORT" type="html">
			#VARIABLES.error_message#
			<br/>
			<br/>
			#VARIABLES.error_dump#
			</cfmail>
			
			<cflocation url="/blog/index.cfm?page=blog&admin=1&fileerror=2" addtoken="no">
		</cfcatch>
		
		</cftry>


		<cfset VARIABLES.file_name = "/custom_files/user_files/#file_type#/#file_purpose#_#VARIABLES.random_seed#.#VARIABLES.file_ext#">
		
		
		
		
		<cfreturn VARIABLES.file_name>
		
		
	
</cffunction>


</cfcomponent>