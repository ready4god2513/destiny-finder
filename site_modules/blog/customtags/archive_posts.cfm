<cfquery name="recentBlogPosts" datasource="#APPLICATION.dsn#">
	SELECT *
	FROM Blogs
	ORDER BY blog_date DESC
</cfquery>

<section id="recent-posts">
	<h4>Recent Articles</h4>
	<ul>
		<cfoutput query="recentBlogPosts">
			<cfset postURL = "http://#CGI.HTTP_HOST#/blog/index.cfm?page=blog&amp;blog_id=#recentBlogPosts.blog_id#" />
			<li>
				<a href="#postURL#">#recentBlogPosts.blog_title#</a>
				<a href="#postURL###disqus_thread" data-disqus-identifier="#Hash(postURL)#" class="comment-count">#recentBlogPosts.blog_title#</a>
			</li>
		</cfoutput>
	</ul>
</section>