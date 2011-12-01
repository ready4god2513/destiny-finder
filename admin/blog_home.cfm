<cfinclude template="templates/admin_subpage_header.cfm">

<!--- SET REDUNDANT VARIABLES --->
<cfset VARIABLES.listing_page = "blog_home.cfm">
<cfset VARIABLES.form_return_page = "blog_home.cfm">
<cfset VARIABLES.db_table_name = "blog_Home">

<!--- SET VARIABLES FOR DELETE FUNCTION --->
<cfset VARIABLES.table_primkey_name = "blog_id">
<cfset VARIABLES.table_title_column = "">

  	<cfquery name="qBlogs" datasource="#APPLICATION.DSN#">
		SELECT     
			Blogs.blog_id, Blogs.blog_title,Blogs.blog_user_id, Users.user_first_name, Users.user_last_name
		FROM Blogs INNER JOIN
            Users ON Blogs.blog_user_id = Users.user_id
		WHERE Blogs.blog_active = 1 AND users.user_active = 1
		ORDER BY users.user_id
	</cfquery>

<cfif isdefined("form.submit") AND form.submit IS "Update Blog">

<cfset VARIABLES.fieldlist = "blog_id,blog_intro,blog_feature_one,blog_feature_two,blog_feature_three,blog_misc_block">
<!---
<cfif LEN(FORM.add_media_image1) GT 0>
	<cfset FORM.media_image1 = FORM.add_media_image1>
	<cfset VARIABLES.fieldlist = VARIABLES.fieldlist & ",media_image1">
</cfif>
<cfif LEN(FORM.add_media_image2) GT 0>
	<cfset FORM.media_image2 = FORM.add_media_image2>
	<cfset VARIABLES.fieldlist = VARIABLES.fieldlist & ",media_image2">
</cfif>
 <cfif LEN(FORM.add_media_image3) GT 0>
	<cfset FORM.media_image3 = FORM.add_media_image3>
	<cfset VARIABLES.form_fields = VARIABLES.form_fields & ",media_image3">
</cfif> --->
<cfdump var="#FORM#">
<cfupdate datasource="#APPLICATION.DSN#" tablename="#VARIABLES.db_table_name#" dbtype="ODBC" formfields="#fieldlist#">

<cflocation url="#VARIABLES.listing_page#?memo=updated&title=Blog"> 
<cfabort>
</cfif>

	<!--- query to get existing values --->
	<cfquery name="qBlog" datasource="#APPLICATION.DSN#" dbtype="odbc">
	SELECT * 
	FROM blog_Home
	</cfquery>
	

<cfoutput>

<cfform action="#VARIABLES.form_return_page#" method="post" enctype="multipart/form-data">
<table border="0" cellpadding="0" cellspacing="2" id="admincontent" width="98%" align="center">
	<cfset bg1 = "##eeeeee">
	<cfset bg2 = "##ffffff">
	<cfset bg = "bg1">

<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
  <td colspan="2">
	  <cfif isDefined("url.memo")>
		<cfoutput>#listing_memo(action=url.memo, title=url.title)#</cfoutput>
	  </cfif>
  </td>
  </tr>

<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
  <td width="19%" valign="top"><strong>Blog Intro:</strong></td>
  <td width="81%">&nbsp;</td>
</tr>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
  <td colspan="2" valign="top">
  	 <cfscript>
			// Calculate basepath for FCKeditor. It's in the folder right above _samples
		
			basePath = 'editor/';
			fckEditor = createObject("component", "#basePath#fckeditor");
			fckEditor.instanceName	= "blog_intro";
			fckEditor.value			= '#qBlog.blog_intro#';
			fckEditor.basePath		= basePath;
			fckEditor.width			= "100%";
			fckEditor.height		= 255;
			fckeditor.ToolbarSet = "Default";
			fckEditor.create(); // create the editor.
		</cfscript>
  </td>
  </tr>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
  <td valign="top"><strong>Feature 1:</strong></td>
  <td>
  <cfset VARIABLES.author = qBlogs.blog_user_id[1]>
		<select name="blog_feature_one">
					<option value="0">-NONE-</option>
					<optgroup label="#qBlogs.user_first_name# #qBlogs.user_last_name#">
			<cfloop query="qBlogs">
				<cfif qBlogs.blog_user_id NEQ VARIABLES.author>
					<optgroup label="#qBlogs.user_first_name# #qBlogs.user_last_name#">
				</cfif>
				<option value="#qBlogs.blog_id#" <cfif qBlog.blog_feature_one EQ qBlogs.blog_id>selected</cfif>>#qBlogs.blog_title#</option>
				<cfset VARIABLES.author = qBlogs.blog_user_id>
			</cfloop>
		</select>
  </td>
</tr>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
  <td valign="top"><strong>Feature 2:</strong></td>
  <td>
  <cfset VARIABLES.author = qBlogs.blog_user_id[1]>
		<select name="blog_feature_two">
		<option value="0">-NONE-</option>
					<optgroup label="#qBlogs.user_first_name# #qBlogs.user_last_name#">
			<cfloop query="qBlogs">
				<cfif qBlogs.blog_user_id NEQ VARIABLES.author>
					<optgroup label="#qBlogs.user_first_name# #qBlogs.user_last_name#">
				</cfif>
				<option value="#qBlogs.blog_id#" <cfif qBlog.blog_feature_two EQ qBlogs.blog_id>selected</cfif>>#qBlogs.blog_title#</option>
				<cfset VARIABLES.author = qBlogs.blog_user_id>
			</cfloop>
		</select>
  </td>
</tr>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
  <td valign="top"><strong>Feature 3:</strong></td>
  <td>
  <cfset VARIABLES.author = qBlogs.blog_user_id[1]>
		<select name="blog_feature_three">
		<option value="0">-NONE-</option>
					<optgroup label="#qBlogs.user_first_name# #qBlogs.user_last_name#">
			<cfloop query="qBlogs">
				<cfif qBlogs.blog_user_id NEQ VARIABLES.author>
					<optgroup label="#qBlogs.user_first_name# #qBlogs.user_last_name#">
				</cfif>
				<option value="#qBlogs.blog_id#" <cfif qBlog.blog_feature_three EQ qBlogs.blog_id>selected</cfif>>#qBlogs.blog_title#</option>
				<cfset VARIABLES.author = qBlogs.blog_user_id>
			</cfloop>
		</select>
  </td>
</tr>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
  <td width="19%" valign="top"><strong>Misc Block:</strong></td>
  <td width="81%">&nbsp;</td>
</tr>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
  <td colspan="2" valign="top">
  	 <cfscript>
			// Calculate basepath for FCKeditor. It's in the folder right above _samples
		
			basePath = 'editor/';
			fckEditor = createObject("component", "#basePath#fckeditor");
			fckEditor.instanceName	= "blog_misc_block";
			fckEditor.value			= '#qBlog.blog_misc_block#';
			fckEditor.basePath		= basePath;
			fckEditor.width			= "100%";
			fckEditor.height		= 255;
			fckeditor.ToolbarSet = "Default";
			fckEditor.create(); // create the editor.
		</cfscript>
  </td>
  </tr>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
<td colspan="2">
<input type="submit" name="submit" value="Update Blog" class="form_element"><input type="hidden" name="blog_id" value="1" />
</td></tr>



</table>
</cfform>
</cfoutput>

<cfinclude template="templates/admin_subpage_footer.cfm">