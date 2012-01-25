<cfset obj_admin = CreateObject("component","cfcs.admin")>

<cfinclude template="templates/admin_subpage_header.cfm">

<!--- SET REDUNDANT VARIABLES --->
<cfset VARIABLES.listing_page = "post_listing.cfm">
<cfset VARIABLES.form_return_page = "blog.cfm">
<cfset VARIABLES.db_table_name = "Blogs">

<!--- SET VARIABLES FOR DELETE FUNCTION --->
<cfset VARIABLES.table_primkey_name = "blog_id">
<cfset VARIABLES.table_title_column = "blog_title">
<cfset VARIABLES.fieldslist = "blog_title,blog_content,blog_shorttext,blog_active,blog_categories,blog_publish_date,blog_facebook,blog_twitter,blog_meta_desc">

<!--- Queries to update database if form has been submitted --->



<cfif isdefined("form.submit") AND form.submit IS "Update this post">
<cfset VARIABLES.fieldslist = "blog_id," & VARIABLES.fieldslist>		

<cfset FORM.blog_publish_date = CreateODBCDateTime("#FORM.blog_publish_date# #FORM.blog_publish_time#")>

<cfif isDefined('FORM.remove_media')>	
			<cfset VARIABLES.old_file = Replace(REQUEST.site_path,"www\","www") & Replace(FORM.blog_media,"/","\","ALL")>
			<cfif fileexists(VARIABLES.old_file)>
				<CFFile action="DELETE" file="#VARIABLES.old_file#">
     		</cfif>
	<cfset FORM.blog_media = "">
	<cfset VARIABLES.fieldslist = VARIABLES.fieldslist & ",blog_media">
</cfif>

<cfif isDefined('FORM.remove_thumb')>	
			<cfset VARIABLES.old_file = Replace(REQUEST.site_path,"www\","www") & Replace(FORM.blog_thumb,"/","\","ALL")>
			<cfif fileexists(VARIABLES.old_file)>
				<CFFile action="DELETE" file="#VARIABLES.old_file#">
     		</cfif>
	<cfset FORM.blog_thumb = "">
	<cfset VARIABLES.fieldslist = VARIABLES.fieldslist & ",blog_thumb">
</cfif>

<cfif isDefined('FORM.blog_youtube')>
	<cfset VARIABLES.fieldslist = VARIABLES.fieldslist & ",blog_youtube">
</cfif>

<cfupdate datasource="#APPLICATION.DSN#" tablename="#VARIABLES.db_table_name#" dbtype="ODBC" formfields="#VARIABLES.fieldslist#">

<!--- UPDATE TEMP TABLE Post VERSION --->
<cfquery name="qTempPost" datasource="#APPLICATION.DSN#">
	SELECT blog_temp_id
	FROM Blogs_temp
	WHERE blog_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#FORM.blog_id#">
</cfquery>

<cfset FORM.blog_temp_id = qTempPost.blog_temp_id>
<cfset FORM.blog_active = 0>
<cfset VARIABLES.fieldslist = VARIABLES.fieldslist & ",blog_temp_id">

<cfupdate datasource="#APPLICATION.DSN#" tablename="Blogs_temp" dbtype="ODBC" formfields="#VARIABLES.fieldslist#">

<cfset table_title_column_value = "#form[table_title_column]#">

<cfset obj_admin.lookup_table_update(
				lookup_table="Category_blog_Match",
				table_primkey_name="#VARIABLES.table_primkey_name#",
				checkbox_name="blog_categories",
				secondary_primkey_name="category_id"
				)>
	
<cflocation url="#VARIABLES.listing_page#?memo=updated&title=#VARIABLES.table_title_column_value#"> 
<cfabort>

<cfelseif isdefined("form.submit") AND form.submit IS "Delete this Post">
<cfparam name="FORM.blog_media" default="">

	<cfoutput>
#delete_step1(page_return="#VARIABLES.form_return_page#",table_primkey_name="#VARIABLES.table_primkey_name#",table_title_column="#VARIABLES.table_title_column#",additional_form_fields="blog_media")#</cfoutput>
<!--- 
<cfoutput>#Replace(REQUEST.site_path,"www\","www") & Replace(FORM.blog_media,"/","\","ALL")#<br/>
#fileexists(Replace(REQUEST.site_path,"www\","www") & Replace(FORM.blog_media,"/","\","ALL"))#</cfoutput> 
--->
<cfabort>

<cfelseif isdefined("form.submit") AND form.submit IS "Yes, Confirm Deletion">
		<cfset VARIABLES.old_file = Replace(REQUEST.site_path,"www\","www") & Replace(FORM.blog_media,"/","\","ALL")>
		<cfif fileexists(VARIABLES.old_file)>
			<CFFile action="DELETE" file="#VARIABLES.old_file#">
		</cfif>	
		<cfquery name="qTempPost" datasource="#APPLICATION.DSN#">
		SELECT blog_temp_id,blog_media
		FROM Blogs_temp
		WHERE blog_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#FORM.blog_id#">
	</cfquery>
	
		<cfset VARIABLES.old_file = Replace(REQUEST.site_path,"www\","www") & Replace(qTempPost.blog_media,"/","\","ALL")>
		<cfif fileexists(VARIABLES.old_file)>
			<CFFile action="DELETE" file="#VARIABLES.old_file#">
		</cfif>	

	
	<cfquery name="DeleteTemp" datasource="#APPLICATION.DSN#">
		DELETE
		FROM Blogs_temp
		WHERE blog_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#FORM.blog_id#">
	</cfquery>

	
	<cfquery name="RemoveCatPostMatch" datasource="#APPLICATION.DSN#">
		DELETE
		FROM Category_blog_Match
		WHERE blog_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#FORM.blog_id#">
	</cfquery>
	
	<cfoutput>#delete_step2(DSN="#APPLICATION.DSN#",page_return="#VARIABLES.listing_page#",table_name="#VARIABLES.db_table_name#",table_primkey_name="#VARIABLES.table_primkey_name#",table_title_column="#VARIABLES.table_title_column#")#</cfoutput>

		

	
<cfabort>

<cfelseif isdefined("form.submit") AND form.submit IS "Cancel">
<cfset table_primkey_value = "#form[table_primkey_name]#">
<cflocation url="#VARIABLES.form_return_page#?#VARIABLES.table_primkey_name#=#VARIABLES.table_primkey_value#">
<cfabort>
</cfif>

<!--- query to get existing values --->
<cfif isdefined("url.blog_id")>
<cfquery name="qPost" datasource="#APPLICATION.DSN#" dbtype="odbc">
SELECT * FROM Blogs
WHERE blog_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.blog_id#">
</cfquery>
</cfif>


<cfoutput>

<cfform action="#VARIABLES.form_return_page#" method="post" enctype="multipart/form-data">
<table border="0" cellpadding="0" cellspacing="2" id="admincontent" width="98%" align="center">
	<cfset bg1 = "##eeeeee">
	<cfset bg2 = "##ffffff">
	<cfset bg = "bg1">

<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
  <td colspan="2"><a href="#VARIABLES.listing_page#"><strong>&laquo;Post Listing</strong></a> </td>
  </tr>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td width="20%"><strong>Post Title:</strong></td>
<td width="80%"><input type="text" size="20" name="blog_title" value="#qPost.blog_title#" class="form_element"></td></tr>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td width="20%"><strong>Date:</strong></td>
<td width="80%"><em>#DateFormat(qPost.blog_date,'mm-dd-yyyy')#</em></td></tr>
 <tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td><strong>Active:</strong></td><td>Yes: <input type="radio" name="blog_active" value="1" <cfif qPost.blog_active IS 1>checked</cfif>>&nbsp;No:<input type="radio" name="blog_active" value="0" <cfif qPost.blog_active IS 0>checked</cfif>> 
  (If yes, this post will be for public viewing.)</td>
</tr>
 <tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
		   <td ><strong>Publish Date:</strong></td>
		   <td><script type="text/javascript">DateInput('blog_publish_date', true, 'MM-DD-YYYY','#DateFormat(qPost.blog_publish_date,"m/d/yyyy")#');</script></td>
      </tr>
		      <tr>
		   <td class="form_label"><strong>Publish Time:</strong></td> 
		   <td>
			<cfset VARIABLES.time_index = 0>
			<select name="blog_publish_time">
				<cfloop from="1" to="24" index="i">
					<cfset VARIABLES.current_time = "#VARIABLES.time_index#:00:00">
					<option value="#VARIABLES.current_time#" <cfif VARIABLES.current_time EQ TimeFormat(qPost.blog_publish_date,'H:00:00')>selected="selected"</cfif>>#TimeFormat('#VARIABLES.time_index#:00:00','h:mm tt')#</option>				
					<cfset VARIABLES.time_index = VARIABLES.time_index + 1>
				</cfloop>
			</select>
		   
		   </td>
	      </tr>
<!---  <tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
   <td><span style="font-weight: bold">Add To Prayer Wall Flash: </span></td>
   <td>
   Yes: <input type="radio" name="blog_wall" value="1" <cfif qPost.blog_wall IS 1>checked</cfif>>&nbsp;No:<input type="radio" name="blog_wall" value="0" <cfif qPost.blog_wall IS 0>checked</cfif>> 
  
   </td>
 </tr>--->
 <tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
   <td><span style="font-weight: bold">Categories:</span></td>
   <td>&nbsp;</td>
 </tr>
<tr valign="top" <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
  <td colspan="2">
	<cfmodule template="customtags/category_checkboxes.cfm" 
			item_table="Blogs"
			item_primary_key="Blog_id"
			item_primary_key_value="#qpost.blog_id#"
			item_cat_col="blog_categories"
			cat_id_col="category_id"
			cat_name_col="category_title"
			category_table="Categories"
			>
	</td>
	<cfif LEN(qPost.blog_thumb) GT 0>
	 <tr>
	  <td colspan="2" style="text-align:center;">
	  <div align="left"><strong>Post Thumbnail:</strong></div>

	 
		
			<img src="#qPost.blog_thumb#">
		
		<br/>
		<input type="hidden" name="blog_thumb" value="#qPost.blog_thumb#" />
		<input type="checkbox" name="remove_thumb" value="1" /> Remove Thumb
		
	</td>
	</tr>
	</cfif>	

  	<cfif LEN(qPost.blog_media) GT 0 OR LEN(qPost.blog_youtube) GT 0>
  <tr>
	  <td colspan="2" style="text-align:center;">
	  <div align="left"><strong>Post Media:</strong></div>
  
	<cfhtmlhead text="
	<script type='text/javascript' src='/assets/scripts/jquery.min.js'></script>
	<script type='text/javascript' src='/assets/scripts/flowplayer-3.0.6.min.js'></script>
	<script type='text/javascript' src='/assets/scripts/flowplayer.playlist-3.0.5.min.js'></script>
	<script>
	
	$f('player',{src: '/assets/scripts/flowplayer.commercial-3.0.7.swf', wmode: 'transparent'}, 
		{
		 key: '#REQUEST.flowplayer_license#',
		 playlist: 
			[ '/assets/images/default_media_splash.jpg', {url: '..#qPost.blog_media#', autoPlay: false} ]
		
		});
	
	</script>
	">
	
	<cfif LEN(qPost.blog_media) GT 0>
		<cfif findnocase(RIGHT(qPost.blog_media,3),"gif,jpg,png")>
			<img src="#qPost.blog_media#">
		<cfelse>
			<a style="display:block;width:241px;height:181px;margin-left:auto;margin-right:auto;background-color:##000000;border:1px solid ##000000;" id="player"></a>
		</cfif>
		<br/>
		<input type="hidden" name="blog_media" value="#qPost.blog_media#" />
		<input type="checkbox" name="remove_media" value="1" /> Remove Media
	<cfelseif LEN(qPost.blog_youtube) GT 0>
		<cfset VARIABLES.movie = Replace(qPost.blog_youtube,"/watch?v=","/v/")>
		<object width="425" height="344"><param name="movie" value="#VARIABLES.movie#&hl=en_US&fs=1&rel=0"></param><param name="allowFullScreen" value="true"></param><param name="allowscriptaccess" value="always"></param><embed src="#VARIABLES.movie#&hl=en_US&fs=1&rel=0" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="425" height="344"></embed></object>
		<br/>
		<input type="text" size="20" name="blog_youtube" value="#qPost.blog_youtube#"/>
	</cfif>
	</td>
	</tr>
	</cfif>
   <tr>
	  <td><strong>Post Intro Text:</strong></td>
	  <td>&nbsp;</td>
	 </tr>
	<tr>
	  <td colspan="2">
	
	  <cfscript>
			// Calculate basepath for FCKeditor. It's in the folder right above _samples
		
			basePath = 'editor/';
			fckEditor = createObject("component", "#basePath#fckeditor");
			fckEditor.instanceName	= "blog_shorttext";
			fckEditor.value			= '#qPost.blog_shorttext#';
			fckEditor.basePath		= basePath;
			fckEditor.width			= "100%";
			fckEditor.height		= 200;
			fckeditor.ToolbarSet = "Default";
			fckEditor.create(); // create the editor.
		</cfscript>
	  	
	  </td>
	  </tr>
	    <tr>
			<td class="form_label" style="text-align:left;; font-weight: bold">Facebook Feed Text:</td>
			<td>&nbsp;</td>
	  </tr>
		  <tr>
			<td colspan="2">
				<cfscript>
					// Calculate basepath for FCKeditor. It's in the folder right above _samples
				
					basePath = 'editor/';
					fckEditor = createObject("component", "#basePath#fckeditor");
					fckEditor.instanceName	= "blog_facebook";
					fckEditor.value			= '#qPost.blog_facebook#';
					fckEditor.basePath		= basePath;
					fckEditor.width			= 500;
					fckEditor.height		= 70;
					fckeditor.ToolbarSet = "Basic";
					fckEditor.create(); // create the editor.
				</cfscript>
			</td>
		  </tr>
		    <tr>
			<td class="form_label" style="text-align:left;; font-weight: bold">Twitter Feed Text:</td>
			<td>&nbsp;</td>
		  </tr>
		  <tr>
			<td colspan="2">
				<cfscript>
					// Calculate basepath for FCKeditor. It's in the folder right above _samples
				
					basePath = 'editor/';
					fckEditor = createObject("component", "#basePath#fckeditor");
					fckEditor.instanceName	= "blog_twitter";
					fckEditor.value			= '#qPost.blog_twitter#';
					fckEditor.basePath		= basePath;
					fckEditor.width			= 500;
					fckEditor.height		= 70;
					fckeditor.ToolbarSet = "Basic";
					fckEditor.create(); // create the editor.
				</cfscript>
			</td>
		  </tr>
		    <tr>
			<td class="form_label" style="text-align:left;; font-weight: bold">Meta Description:</td>
			<td>&nbsp;</td>
		  </tr>
		   <tr>
			<td colspan="2">
				<input type="text" size="50" name="blog_meta_desc" value="#qPost.blog_meta_desc#" class="form_element">
			</td>
		  </tr>
 <tr>
	  <td><strong>Post:</strong></td>
	  <td>&nbsp;</td>
	 </tr>
	<tr>
	  <td colspan="2">
	
	  <cfscript>
			// Calculate basepath for FCKeditor. It's in the folder right above _samples
		
			basePath = 'editor/';
			fckEditor = createObject("component", "#basePath#fckeditor");
			fckEditor.instanceName	= "blog_content";
			fckEditor.value			= '#qPost.blog_content#';
			fckEditor.basePath		= basePath;
			fckEditor.width			= "100%";
			fckEditor.height		= 300;
			fckeditor.ToolbarSet = "Default";
			fckEditor.create(); // create the editor.
		</cfscript>
	  	
	  </td>
	  </tr>

<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td colspan="2"><input type="submit" name="submit" value="Update this post" class="form_element"><input type="submit" name="submit" value="Delete this Post" class="form_element"><input type="hidden" name="blog_id" value="#qPost.blog_id#" /></td></tr>

</table>
</cfform>
</cfoutput>

<cfinclude template="templates/admin_subpage_footer.cfm">