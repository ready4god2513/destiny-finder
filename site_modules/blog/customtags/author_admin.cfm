<cfset obj_queries = CreateObject("component","site_modules.blog.cfcs.queries")>
<cfset qAuthor = obj_queries.author_detail(author_id="#REQUEST.user_id#")>
<cfset qPostList = obj_queries.author_post_list(author_id="#REQUEST.user_id#",publish_date="0")>

<cfoutput>


	<div class="admin_welcome">
		   <cfif isDefined('URL.new')>
				<div class="site_notification">
					Thank you for creating an account.<br/>
				</div><!-- class="admin_notification" -->
			</cfif>

		<div class="author_detail_name">
		Welcome #qAuthor.user_first_name# #qAuthor.user_last_name#
		</div><!--  class="author_detail_name" -->
		<div class="author_detail_description">
			<cfif LEN(qAuthor.user_image) GT 0>
				<img src="#qAuthor.user_image#" align="left">
			</cfif>
			#qAuthor.user_description#<br/>
			<a href="index.cfm?page=blog&admin=1&profile=1" class="admin_link">[Edit Your Profile]</a>
		</div><!-- class="author_detail_description" -->
			
	</div><!-- class="admin_welcom" -->
	
		
	<div class="clear"></div>
	<div class="author_post_list">
	<h2>Your Posts:&nbsp;&nbsp;<a href="index.cfm?page=blog&admin=1&write=1" class="admin_link">[Write New Post]</a></h2>
	
		<ul class="admin_post_list">
	<cfif qPostList.recordcount GT 0>
		<cfloop query="qPostList">
			<li>
				<div class="admin_column" style="width:200px;">
					<a href="index.cfm?page=blog&admin=1&edit_blog=#qPostList.blog_id#">
						<cfif LEN(qPostList.blog_title) GT 30>
							#Left(qPostList.blog_title,27)#...	
						<cfelse>
							#qPostList.blog_title#
						</cfif></a>
				</div>
				<div class="admin_column" style="width:100px;">
					#DateFormat(qPostList.blog_publish_date,"mmm dd, yyyy")#
				</div>
				<div class="admin_column" style="width:25px;">
					<img src="/assets/images/#qPostList.blog_active#.gif">
				</div>
				<div class="admin_column" style="width:100px;">
					<a href="index.cfm?page=blog&admin=1&blog_id=#qPostList.blog_id#">[ VIEW ]</a> 
					<a href="index.cfm?page=blog&admin=1&edit_blog=#qPostList.blog_id#">[ EDIT ]</a>
				</div>
				<div class="clear"></div>
			</li>			
		</cfloop>
	<cfelse>
		- No posts available to display -
	</cfif>
		</ul>
			
	</div><!-- class="author_post_list" -->
</cfoutput>