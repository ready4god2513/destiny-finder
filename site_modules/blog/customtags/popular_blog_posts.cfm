<cfquery name="popularBlogPosts" datasource="#APPLICATION.dsn#">
	SELECT *
	FROM Blogs
</cfquery>

<section id="popular-posts">
	<h4>Popular Articles</h4>
	<ul>
		<cfoutput query="popularBlogPosts">
			<cfset postURL = "http://#CGI.HTTP_HOST#/blog/index.cfm?page=blog&amp;blog_id=#popularBlogPosts.blog_id#" />
			<li>
				<a href="#postURL#">#popularBlogPosts.blog_title#</a>
			</li>
		</cfoutput>
	</ul>
</section>

