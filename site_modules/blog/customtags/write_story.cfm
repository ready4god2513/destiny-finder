
<cfparam name="URL.edit_story" default="new">
<cfset obj_story = CreateObject("component","site_modules.blog.cfcs.story")>
<cfset obj_queries = CreateObject("component","site_modules.blog.cfcs.queries")>

<cfset qAuthor = obj_queries.author_detail(author_id="#REQUEST.user_id#")>

<cfif isDefined('FORM.submit')>
	<cfset obj_story.process_form(process="#FORM.submit#")> 
</cfif>

<cfif URL.edit_story NEQ "new">
	<cfset qStory = obj_queries.retrieve_story_temp(story_id="#URL.edit_story#",author_id="#REQUEST.user_id#")>	
</cfif>


<cfparam name="qStory.recordcount" default="0">
<cfparam name="qStory.story_id" default="0">
<cfparam name="qStory.story_temp_id" default="0">
<cfparam name="qStory.story_title" default="">
<cfparam name="qStory.story_date" default="#DateFormat(NOW(),'yyyy-mm-dd')#">
<cfparam name="qStory.story_content" default="">
<cfparam name="qStory.story_shorttext" default="">
<cfparam name="qStory.story_categories" default="">
<cfparam name="qStory.story_media" default="">
<cfparam name="qStory.story_thumb" default="">
<cfparam name="qStory.story_youtube" default="">
<cfparam name="qStory.story_active" default="0">
<cfparam name="qStory.story_publish_date" default="#NOW()#">
<cfparam name="qStory.story_publish_time" default="">
<cfparam name="qStory.story_facebook" default="">
<cfparam name="qStory.story_twitter" default="">





<cfif qStory.recordcount EQ 0 AND URL.edit_story NEQ "new">

	<div class="admin_note">
	- Story could not be retrieved-
	</div><!--  class="admin_note" -->

<cfelse>

	<cfoutput>
		<cfif qStory.story_active EQ 1>
			<div class="site_notification">
				This post has an update pending approval.
			</div>
		</cfif>
		<form action="index.cfm?page=blog&admin=1&write=1" method="post" enctype="multipart/form-data">
		<table width="600" border="0" cellspacing="4" cellpadding="0" class="table_reset">
		  <tr>
			<td width="163" class="form_label">Title:</td>
			<td width="425">
				<input type="text" name="story_title" size="20" value="#qStory.story_title#">
				<input type="hidden" name="story_date" value="#qStory.story_date#">
				<input type="hidden" name="story_user_id" value="#REQUEST.user_id#">
			</td>
		  </tr>
		<!--- <cfif URL.edit_story NEQ "new">
		  <tr>
			<td width="163" class="form_label">Date Created:</td>
			<td width="425">
				#DateFormat(qStory.story_date,"mmm dd, yyyy")#
			</td>
		  </tr>
		</cfif> --->
		 <tr>
		   <td class="form_label">Publish Date:</td>
		   <td>
		   <script type="text/javascript">DateInput('story_publish_date', true, 'MM-DD-YYYY','#DateFormat(qStory.story_publish_date,"m/d/yyyy")#');</script>
		  </td>
		  </tr>
		     <tr>
		   <td class="form_label">Publish Time:</td> 
		   <td>
			<cfset VARIABLES.time_index = 0>
			<select name="story_publish_time">
				<cfloop from="1" to="24" index="i">
					<cfset VARIABLES.current_time = "#VARIABLES.time_index#:00:00">
					<option value="#VARIABLES.current_time#" <cfif VARIABLES.current_time EQ TimeFormat(qStory.story_publish_date,'H:00:00')>selected="selected"</cfif>>#TimeFormat('#VARIABLES.time_index#:00:00','h:mm tt')#</option>				
					<cfset VARIABLES.time_index = VARIABLES.time_index + 1>
				</cfloop>
			</select>
		   
		   </td>
	      </tr>
		 <tr>
			<td class="form_label" style="text-align:left;">Story Intro Text:</td>
			<td>&nbsp;</td>
		  </tr>
		  <tr>
			<td colspan="2">
				<cfscript>
					// Calculate basepath for FCKeditor. It's in the folder right above _samples
				
					basePath = '/editor/';
					fckEditor = createObject("component", "#basePath#fckeditor");
					fckEditor.instanceName	= "story_shorttext";
					fckEditor.value			= '#qStory.story_shorttext#';
					fckEditor.basePath		= basePath;
					fckEditor.width			= 500;
					fckEditor.height		= 250;
					fckeditor.ToolbarSet = "Basic";
					fckEditor.create(); // create the editor.
				</cfscript>
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
					fckEditor.instanceName	= "story_facebook";
					fckEditor.value			= '#qStory.story_facebook#';
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
					fckEditor.instanceName	= "story_twitter";
					fckEditor.value			= '#qStory.story_twitter#';
					fckEditor.basePath		= basePath;
					fckEditor.width			= 500;
					fckEditor.height		= 70;
					fckeditor.ToolbarSet = "Blank";
					fckEditor.create(); // create the editor.
				</cfscript>
			</td>
		  </tr>
		  <cfelse>
		  <input type="hidden" name="story_facebook" value="#qStory.story_facebook#">
		  <input type="hidden" name="story_twitter" value="#qStory.story_twitter#">
		  </cfif>
		  <tr>
			<td class="form_label" style="text-align:left;">Story:</td>
			<td>&nbsp;</td>
		  </tr>
		  <tr>
			<td colspan="2">
				<cfscript>
					// Calculate basepath for FCKeditor. It's in the folder right above _samples
				
					basePath = '/editor/';
					fckEditor = createObject("component", "#basePath#fckeditor");
					fckEditor.instanceName	= "story_content";
					fckEditor.value			= '#qStory.story_content#';
					fckEditor.basePath		= basePath;
					fckEditor.width			= 500;
					fckEditor.height		= 500;
					fckeditor.ToolbarSet = "Basic";
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
		<cfmodule template="/admin/customtags/category_checkboxes.cfm" story_id="#qStory.story_id#">
		<br/>
		<br/>
	</td>
  </tr>
   <tr>
			<td valign="top" class="form_label">Story Thumbnail Image:</td>
			<td valign="top">
			<cfif LEN(qStory.story_thumb) GT 0>
				Uploaded Image:<br/>
						<img src="#qStory.story_thumb#">
				<br/>
					Replace:
			</cfif>
				<input type="file" name="add_story_thumb">
				<input type="hidden" name="story_thumb" value="#qStory.story_thumb#">
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
			<cfif LEN(qStory.story_media) GT 0>
				Uploaded File:<br/>
					<cfif LEN(qStory.story_media) GT 0 OR LEN(qStory.story_youtube) GT 0>
						
						<cfif LEN(qStory.story_media) GT 0>
							<cfif findnocase(RIGHT(qStory.story_media,3),"gif,jpg,png")>
								<img src="#qStory.story_media#">
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
										[ '/assets/images/default_media_splash.jpg', {url: '..#qStory.story_media#', autoPlay: false} ]
									
									});
								
								</script>
								">
								<a style="display:block;width:241px;height:181px;background-color:##000000;border:1px solid ##000000;" id="player"></a>
							</cfif>
						<cfelseif LEN(qStory.story_youtube) GT 0>
							<cfset VARIABLES.movie = Replace(qStory.story_youtube,"/watch?v=","/v/")>
							<object width="425" height="344"><param name="movie" value="#VARIABLES.movie#&hl=en_US&fs=1&rel=0"></param><param name="allowFullScreen" value="true"></param><param name="allowscriptaccess" value="always"></param><embed src="#VARIABLES.movie#&hl=en_US&fs=1&rel=0" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="425" height="344"></embed></object>
						</cfif>
					</cfif>
					<br/>
					Replace:
			</cfif>
				<input type="file" name="add_media_file">
				<input type="hidden" name="story_media" value="#qStory.story_media#">
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
				<input type="text" name="story_youtube" size="30" value="#qStory.story_youtube#">
			</td>
		  </tr>
		<cfif URL.edit_story EQ "new">
		  <tr>
			<td colspan="2">
				<div align="center">
					<input type="submit" name="submit" value="Post Story">
				</div>
			</td>
		  </tr>
		 <cfelse>
		  <tr>
			<td colspan="2">
				<div align="center">
					<input type="submit" name="submit" value="Update Story">
					<input type="hidden" name="story_id" value="#URL.edit_story#">
				</div>
			</td>
		  </tr>
		 </cfif>
		</table>
		</form>
	</cfoutput>

</cfif>