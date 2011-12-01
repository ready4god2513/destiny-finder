<cfquery name="qBlogs" datasource="#APPLICATION.DSN#">
	SELECT * 
	FROM Blogs
</cfquery>

<cfoutput query="qBlogs">
	<a href="index.cfm?page=blog&blog_id=#qBlogs.blog_id#">#qBlogs.blog_title#</a><br/>
</cfoutput>
