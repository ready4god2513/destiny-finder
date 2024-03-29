
<cfparam name="URL.edit_blog" default="new">
<cfset obj_blog = CreateObject("component","site_modules.blog.cfcs.blog")>
<cfset obj_queries = CreateObject("component","site_modules.blog.cfcs.queries")>

<cfset qAuthor = obj_queries.author_detail(author_id="#REQUEST.user_id#")>

<cfif isDefined('FORM.submit')>
	<cfset obj_blog.process_form(process="#FORM.submit#")> 
</cfif>

<cfif URL.edit_blog NEQ "new">
	<!--- IF USER REQUIRES MODERATION PULL BLOG FROM TEMP TABLE --->
	<cfif qAuthor.user_moderate EQ 1>
		<cfset qBlog = obj_queries.retrieve_blog_temp(blog_id="#URL.edit_blog#",author_id="#REQUEST.user_id#")>	
	<cfelse>
		<cfset qBlog = obj_queries.retrieve_blog_temp(blog_id="#URL.edit_blog#",author_id="#REQUEST.user_id#")>	
	</cfif>
</cfif>


<cfparam name="qBlog.recordcount" default="0">
<cfparam name="qBlog.blog_id" default="0">
<cfparam name="qBlog.blog_temp_id" default="0">
<cfparam name="qBlog.blog_title" default="">
<cfparam name="qBlog.blog_date" default="#DateFormat(NOW(),'yyyy-mm-dd')#">
<cfparam name="qBlog.blog_content" default="">
<cfparam name="qBlog.blog_shorttext" default="">
<cfparam name="qBlog.blog_categories" default="">
<cfparam name="qBlog.blog_media" default="">
<cfparam name="qBlog.blog_thumb" default="">
<cfparam name="qBlog.blog_youtube" default="">
<cfparam name="qBlog.blog_active" default="0">
<cfparam name="qBlog.blog_publish_date" default="#NOW()#">
<cfparam name="qBlog.blog_publish_time" default="">
<cfparam name="qBlog.blog_facebook" default="">
<cfparam name="qBlog.blog_twitter" default="">
<cfparam name="qBlog.blog_meta_desc" default="">





<cfif qBlog.recordcount EQ 0 AND URL.edit_blog NEQ "new">

	<div class="admin_note">
	- Post could not be retrieved-
	</div><!--  class="admin_note" -->

<cfelse>

	<cfoutput>
		<cfif qAuthor.user_moderate EQ 1>
			<cfif qBlog.blog_active EQ 1>
				<div class="site_notification">
					This post has an update pending approval.
				</div>
			</cfif>
		</cfif>
		<form action="index.cfm?page=blog&admin=1&write=1" method="post" enctype="multipart/form-data">
		<table width="600" border="0" cellspacing="4" cellpadding="0" class="table_reset">
		  <tr>
			<td width="163" class="form_label">Title:</td>
			<td width="425">
				<input type="text" name="blog_title" size="20" value="#qBlog.blog_title#">
				<input type="hidden" name="blog_date" value="#qBlog.blog_date#">
				<input type="hidden" name="blog_user_id" value="#REQUEST.user_id#">
			</td>
		  </tr>
		<!--- <cfif URL.edit_blog NEQ "new">
		  <tr>
			<td width="163" class="form_label">Date Created:</td>
			<td width="425">
				#DateFormat(qBlog.blog_date,"mmm dd, yyyy")#
			</td>
		  </tr>
		</cfif> --->
		 <tr>
		   <td class="form_label">Publish Date:</td>
		   <td>
		   <script type="text/javascript">DateInput('blog_publish_date', true, 'MM-DD-YYYY','#DateFormat(qBlog.blog_publish_date,"m/d/yyyy")#');</script>
		  </td>
		  </tr>
		     <tr>
		   <td class="form_label">Publish Time:</td> 
		   <td>
			<cfset VARIABLES.time_index = 0>
			<select name="blog_publish_time">
				<cfloop from="1" to="24" index="i">
					<cfset VARIABLES.current_time = "#VARIABLES.time_index#:00:00">
					<option value="#VARIABLES.current_time#" <cfif VARIABLES.current_time EQ TimeFormat(qBlog.blog_publish_date,'H:00:00')>selected="selected"</cfif>>#TimeFormat('#VARIABLES.time_index#:00:00','h:mm tt')#</option>				
					<cfset VARIABLES.time_index = VARIABLES.time_index + 1>
				</cfloop>
			</select>
		   
		   </td>
	      </tr>
		 <tr>
			<td class="form_label" style="text-align:left;">Post Intro Text:</td>
			<td>&nbsp;</td>
		  </tr>
		  <tr>
			<td colspan="2">
				<cfscript>
					// Calculate basepath for FCKeditor. It's in the folder right above _samples
				
					basePath = '/editor/';
					fckEditor = createObject("component", "#basePath#fckeditor");
					fckEditor.instanceName	= "blog_shorttext";
					fckEditor.value			= '#qBlog.blog_shorttext#';
					fckEditor.basePath		= basePath;
					fckEditor.width			= 500;
					fckEditor.height		= 250;
					fckeditor.ToolbarSet = "Blog";
					fckEditor.create(); // create the editor.
				</cfscript>
			</td>
		  </tr>
		  <tr>
			<td class="form_label" style="text-align:left;">Post Meta Description:</td>
			<td>&nbsp;</td>
		  </tr>
		  <tr>
			<td colspan="2">
								<input type="text" size="50" name="blog_meta_desc" value="#qBlog.blog_meta_desc#" class="form_element">
			</td>
		  </tr>
		<cfif qAuthor.user_type EQ 1>
		  <tr>
			<td class="form_label" style="text-align:left;">Facebook Feed Text:</td>
			<td>&nbsp;</td>
		  </tr>
		  <tr>
			<td colspan="2">
				<cfscript>
					// Calculate basepath for FCKeditor. It's in the folder right above _samples
				
					basePath = '/editor/';
					fckEditor = createObject("component", "#basePath#fckeditor");
					fckEditor.instanceName	= "blog_facebook";
					fckEditor.value			= '#qBlog.blog_facebook#';
					fckEditor.basePath		= basePath;
					fckEditor.width			= 500;
					fckEditor.height		= 70;
					fckeditor.ToolbarSet = "Blank";
					fckEditor.create(); // create the editor.
				</cfscript>
			</td>
		  </tr>
		    <tr>
			<td class="form_label" style="text-align:left;">Twitter Feed Text:</td>
			<td>&nbsp;</td>
		  </tr>
		  <tr>
			<td colspan="2">
				<cfscript>
					// Calculate basepath for FCKeditor. It's in the folder right above _samples
				
					basePath = '/editor/';
					fckEditor = createObject("component", "#basePath#fckeditor");
					fckEditor.instanceName	= "blog_twitter";
					fckEditor.value			= '#qBlog.blog_twitter#';
					fckEditor.basePath		= basePath;
					fckEditor.width			= 500;
					fckEditor.height		= 70;
					fckeditor.ToolbarSet = "Blank";
					fckEditor.create(); // create the editor.
				</cfscript>
			</td>
		  </tr>
		  <cfelse>
		  <input type="hidden" name="blog_facebook" value="#qBlog.blog_facebook#">
		  <input type="hidden" name="blog_twitter" value="#qBlog.blog_twitter#">
		  </cfif>
		  <tr>
			<td class="form_label" style="text-align:left;">Post:</td>
			<td>&nbsp;</td>
		  </tr>
		  <tr>
			<td colspan="2">
				<cfscript>
					// Calculate basepath for FCKeditor. It's in the folder right above _samples
				
					basePath = '/editor/';
					fckEditor = createObject("component", "#basePath#fckeditor");
					fckEditor.instanceName	= "blog_content";
					fckEditor.value			= '#qBlog.blog_content#';
					fckEditor.basePath		= basePath;
					fckEditor.width			= 500;
					fckEditor.height		= 500;
					fckeditor.ToolbarSet = "Blog";
					fckEditor.create(); // create the editor.
				</cfscript>
			</td>
		  </tr>
		   <tr>
			<td><br/><br/><strong>Categories</strong></td>
			<td>&nbsp;</td>
		  </tr>
		<tr valign="top">
  <td colspan="2">
		<!--- <cfmodule template="/admin/customtags/category_checkboxes.cfm" blog_id="#qBlog.blog_id#"> --->
		<cfmodule template="/admin/customtags/category_checkboxes.cfm" 
			item_table="Blogs"
			item_primary_key="Blog_id"
			item_primary_key_value="#qBlog.blog_id#"
			item_cat_col="blog_categories"
			cat_id_col="category_id"
			cat_name_col="category_title"
			category_table="Categories"
			>
		<br/>
		<br/>
	</td>
  </tr>
   <tr>
			<td valign="top" class="form_label">Post Thumbnail Image:</td>
			<td valign="top">
			<cfif LEN(qBlog.blog_thumb) GT 0>
				Uploaded Image:<br/>
						<img src="#qBlog.blog_thumb#">
				<br/>
					Replace:
			</cfif>
				<input type="file" name="add_blog_thumb">
				<input type="hidden" name="blog_thumb" value="#qBlog.blog_thumb#">
			</td>
		  </tr>
   <tr>
     <td colspan="2" valign="top" class="form_label">
	 <div style="width:300px;margin-left:auto;margin-right:auto;border:1px dotted ##ff0000;padding:5px;">
	 	 <span style="color:##ff0000;font-weight:bold;">IMPORTANT THUMBNAIL RESTRICTIONS</span><br/>
		 <strong>Supported Files:</strong> <em>Jpg,Gif</em><br>
         <strong>Image Dimensions:</strong> <em>122px x 93px</em><br>
	</div>
	 </td>
     </tr>
   <tr>
			<td valign="top" class="form_label">Media File:</td>
			<td valign="top">
			<cfif LEN(qBlog.blog_media) GT 0>
				Uploaded File:<br/>
					<cfif LEN(qBlog.blog_media) GT 0 OR LEN(qBlog.blog_youtube) GT 0>
						
						<cfif LEN(qBlog.blog_media) GT 0>
							<cfif findnocase(RIGHT(qBlog.blog_media,3),"gif,jpg,png")>
								<img src="#qBlog.blog_media#">
							<cfelse>
							<cfhtmlhead text="
								<script type='text/javascript' src='../assets/scripts/jquery.min.js'></script>
								<script type='text/javascript' src='../assets/scripts/flowplayer-3.0.6.min.js'></script>
								<script type='text/javascript' src='../assets/scripts/flowplayer.playlist-3.0.5.min.js'></script>
								<script>
								
								$f('player',{src: '../assets/scripts/flowplayer.commercial-3.0.7.swf', wmode: 'transparent'}, 
									{
									 key: '#REQUEST.flowplayer_license#',
									 playlist: 
										[ '/assets/images/default_media_splash.jpg', {url: '..#qBlog.blog_media#', autoPlay: false} ]
									
									});
								
								</script>
								">
								<a style="display:block;width:241px;height:181px;background-color:##000000;border:1px solid ##000000;" id="player"></a>
							</cfif>
						<cfelseif LEN(qBlog.blog_youtube) GT 0>
							<cfset VARIABLES.movie = Replace(qBlog.blog_youtube,"/watch?v=","/v/")>
							<object width="425" height="344"><param name="movie" value="#VARIABLES.movie#&hl=en_US&fs=1&rel=0"></param><param name="allowFullScreen" value="true"></param><param name="allowscriptaccess" value="always"></param><embed src="#VARIABLES.movie#&hl=en_US&fs=1&rel=0" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="425" height="344"></embed></object>
						</cfif>
					</cfif>
					<br/>
					Replace:
			</cfif>
				<input type="file" name="add_media_file">
				<input type="hidden" name="blog_media" value="#qBlog.blog_media#">
			</td>
		  </tr>
   <tr>
     <td colspan="2" valign="top"><div style="width:300px;margin-left:auto;margin-right:auto;border:1px dotted ##ff0000;padding:5px;">
	 	 <span style="color:##ff0000;font-weight:bold;">IMPORTANT MEDIA FILE RESTRICTIONS</span><br/>
		 <strong>Supported Media Files:</strong> <em>Flv,Mp4,Mp3,Jpg,Gif</em><br>
         <strong>Video Dimensions:</strong><br>
         <strong>Image Dimensions:</strong> <em>Max width 500px</em><br>
         <strong>File Size Limit:</strong> <em>10mb </em></div></td>
     </tr>
	   <tr>
			<td width="163" class="form_label">Embed A YouTube Video</td>
			<td width="425">
				YouTube video URL:
				<input type="text" name="blog_youtube" size="30" value="#qBlog.blog_youtube#">
			</td>
		  </tr>
		<cfif URL.edit_blog EQ "new">
		  <tr>
			<td colspan="2">
				<div align="center">
					<input type="submit" name="submit" value="Post">
				</div>
			</td>
		  </tr>
		 <cfelse>
		  <tr>
			<td colspan="2">
				<div align="center">
					<input type="submit" name="submit" value="Update Post">
					<input type="hidden" name="blog_id" value="#URL.edit_blog#">
				</div>
			</td>
		  </tr>
		 </cfif>
		</table>
		</form>
	</cfoutput>

</cfif>