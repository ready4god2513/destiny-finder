<cfparam name="ATTRIBUTES.admin" default="0">
<cfparam name="ATTRIBUTES.author_id" default="0">
<cfset obj_queries = CreateObject("component","site_modules.blog.cfcs.queries")>

<cfset qPost = obj_queries.retrieve_blog(blog_id="#URL.blog_id#",admin="#ATTRIBUTES.admin#",author_id="#ATTRIBUTES.author_id#")>

<cfif qPost.recordcount GT 0>
	<cfset qAuthor = obj_queries.author_detail(author_id="#qPost.blog_user_id#")>
	
	<cfoutput query="qPost">
		<article class="single-blog-post">
			<header>
				<h2>#qPost.blog_title#</h2>
				<span class="blog_author">by <a href="index.cfm?page=blog&author=#qPost.blog_user_id#">#qAuthor.user_first_name# #qAuthor.user_last_name#</a></span> 
				<span class="blog_date">on #DateFormat(qPost.blog_date, 'mmm dd, yyyy')#</span>
			</header>
			#qPost.blog_content#
			<footer>
				POSTED BY <a href="index.cfm?page=blog&author=#qPost.blog_user_id#">#Ucase("#qAuthor.user_first_name# #qAuthor.user_last_name#")#</a> ON <span class="blog_date">#DateFormat(qPost.blog_date,'mmm dd, yyyy')#</span>
			</footer>
		</article>
	</cfoutput>
	
	<h5>COMMENTS:</h5>
	<cfmodule template="comment_box.cfm">

<cfelse>
	<div class="site_notification">- Post could not be retrieved -</div>
</cfif>
