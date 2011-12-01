<cfparam name="ATTRIBUTES.post_title" default="">
<cfparam name="ATTRIBUTES.post_id" default="">
<cfparam name="ATTRIBUTES.post_author_id" default="">
<cfparam name="ATTRIBUTES.post_author_name" default="">
<cfparam name="ATTRIBUTES.post_date" default="">
<cfparam name="ATTRIBUTES.post_short_description" default="">
<cfparam name="ATTRIBUTES.post_media" default="">
<cfparam name="ATTRIBUTES.post_thumb" default="">

<cfoutput>
	<div class="blog_preview_wrapper">
		<cfif LEN(ATTRIBUTES.post_thumb) GT 0>
			<img src="#ATTRIBUTES.post_thumb#" class="blog_thumb_image" align="left">
		</cfif>
		<a href="index.cfm?page=blog&blog_id=#ATTRIBUTES.post_id#" class="blog_preview_title">#ATTRIBUTES.post_title#</a> 
		<!--- 
		<cfif LEN(ATTRIBUTES.post_media) GT 0>
			<img src="../site_images/<cfif ATTRIBUTES.post_media EQ "video">video<cfelseif ATTRIBUTES.post_media EQ "audio">audio</cfif>_icon.gif">
		</cfif>
		--->
		<br/>
		<span class="blog_preview_date">#UCASE(DateFormat(ATTRIBUTES.post_date, 'dddd, mmm dd, yyyy'))#</span>
		<div class="blog_preview_shorttext">
			#ATTRIBUTES.post_short_description#
			<br/><br/>
			<a href="index.cfm?page=blog&blog_id=#ATTRIBUTES.post_id#" class="blog_button">READ MORE</a><cfmodule template="comment_count.cfm" blog_id="#ATTRIBUTES.post_id#" fancy_display="1">&nbsp;&nbsp;|&nbsp;&nbsp;<span class="blog_preview_author">POSTED BY <a href="index.cfm?page=blog&author=#ATTRIBUTES.post_author_id#">#ATTRIBUTES.post_author_name#</a></span>
		</div>
	</div>
</cfoutput>