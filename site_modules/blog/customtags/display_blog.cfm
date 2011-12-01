<cfparam name="ATTRIBUTES.admin" default="0">
<cfparam name="ATTRIBUTES.author_id" default="0">
<cfset obj_queries = CreateObject("component","site_modules.blog.cfcs.queries")>

<cfset qPost = obj_queries.retrieve_blog(blog_id="#URL.blog_id#",admin="#ATTRIBUTES.admin#",author_id="#ATTRIBUTES.author_id#")>

<cfif qPost.recordcount GT 0>
	<cfset qAuthor = obj_queries.author_detail(author_id="#qPost.blog_user_id#")>
	
	<cfif LEN(qPost.blog_media) GT 0 AND findnocase(RIGHT(qPost.blog_media,3),"gif,jpg,png") EQ 0>
	<cfhtmlhead text="
	<script type='text/javascript' src='../site_scripts/jquery.min.js'></script>
	<script type='text/javascript' src='../site_scripts/flowplayer-3.0.6.min.js'></script>
	<script type='text/javascript' src='../site_scripts/flowplayer.playlist-3.0.5.min.js'></script>
	<script>
	
	$f('player',{src: '../site_scripts/flowplayer.commercial-3.0.7.swf', wmode: 'transparent'}, 
		{
		 key: '#REQUEST.flowplayer_license#',
		 playlist: 
			[ '/site_images/default_media_splash.jpg', {url: '..#qPost.blog_media#', autoPlay: false} ]
		
		});
	
	</script>
	">
	</cfif>
	
	<cfoutput query="qPost">
		<cfif isDefined('URL.comment')>
			<div class="site_notification">
				Thank you for your comments.<br/>
				All comments require moderation before displayed publicly.
			</div>
		</cfif>
		<div class="blog_title">
			#qPost.blog_title#<br/>
			<span class="blog_author">by <a href="index.cfm?page=blog&author=#qPost.blog_user_id#">#qAuthor.user_first_name# #qAuthor.user_last_name#</a></span> 
			<span class="blog_date">on #DateFormat(qPost.blog_date, 'mmm dd, yyyy')#</span>
		</div><!-- class="blog_title" -->
		
		<cfif LEN(qPost.blog_media) GT 0 OR LEN(qPost.blog_youtube) GT 0>
		<div class="blog_media">
			<cfif LEN(qPost.blog_media) GT 0>
				<cfif findnocase(RIGHT(qPost.blog_media,3),"gif,jpg,png")>
					<img src="#qPost.blog_media#">
				<cfelse>
					<a style="display:block;width:241px;height:181px;margin-left:auto;margin-right:auto;background-color:##000000;border:1px solid ##000000;" id="player"></a>
				</cfif>
			<cfelseif LEN(qPost.blog_youtube) GT 0>
				<cfset VARIABLES.movie = Replace(qPost.blog_youtube,"/watch?v=","/v/")>
				<object width="425" height="344"><param name="movie" value="#VARIABLES.movie#&hl=en_US&fs=1&rel=0"></param><param name="allowFullScreen" value="true"></param><param name="allowscriptaccess" value="always"></param><embed src="#VARIABLES.movie#&hl=en_US&fs=1&rel=0" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="425" height="344"></embed></object>
			</cfif>
		</div><!-- class="blog_media" -->
		</cfif>
		<div class="blog_content">
			#qPost.blog_content#
		</div><!-- class="blog_content" -->
		<div class="blog_details">
			POSTED BY <a href="index.cfm?page=blog&author=#qPost.blog_user_id#">#Ucase("#qAuthor.user_first_name# #qAuthor.user_last_name#")#</a> ON <span class="blog_date">#DateFormat(qPost.blog_date,'mmm dd, yyyy')#</span>
		</div> <!-- class="blog_details" -->
	</cfoutput>
		<div class="blog_comments">
			COMMENTS:
		</div>
		<cfmodule template="display_comments.cfm">
		<cfmodule template="comment_box.cfm">

<cfelse>
	<div class="site_notification">- Post could not be retrieved -</div>
</cfif>
