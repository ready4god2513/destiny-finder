<cfquery name="qBlogs" datasource="#APPLICATION.DSN#" maxrows="12">
	SELECT Blogs.blog_id,Blogs.blog_title,Blogs.blog_publish_date,Blogs.blog_shorttext,Blogs.blog_twitter
	FROM Blogs INNER JOIN
                      Users ON Blogs.blog_user_id = Users.user_id
	WHERE Blogs.blog_publish_date <= <cfqueryparam cfsqltype="cf_sql_timestamp" value="#DateAdd('h',REQUEST.time_offset,NOW())#">
	AND Blogs.blog_active = 1 AND Users.user_type = 1
	ORDER BY Blogs.blog_publish_date DESC
</cfquery>	


<cfxml variable="RSS_Blogs">
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
<cfoutput>
	<channel>
		<title>Insight Creative Group</title>
		<link>#REQUEST.site_url#</link>
		<description>Insight Creative Group - Blog</description>
		<lastBuildDate>#DateFormat(NOW(),'ddd, dd mmm yyyy')# #TimeFormat(NOW(),'hh:mm:ss')# CST</lastBuildDate>
		<language>en-us</language>

		<cfloop query="qBlogs">
			<cfif LEN(qBlogs.blog_twitter) GT 0>
			<cfset VARIABLES.description_text = qBlogs.blog_twitter>
				<item>
					<title>#XMLFormat(qBlogs.blog_title)#</title>
					<link>#XMLFormat("#REQUEST.site_url#blog/index.cfm?page=blog&blog_id=#qBlogs.blog_id#")#</link>
					<guid>#XMLFormat("#REQUEST.site_url#blog/index.cfm?page=blog&blog_id=#qBlogs.blog_id#")#</guid>
					<pubDate>#DateFormat(qBlogs.blog_publish_date,'ddd, dd mmm yyyy')# #TimeFormat(qBlogs.blog_publish_date,'hh:mm:ss')# CST</pubDate>
					<description>#XMLFormat(VARIABLES.description_text)#</description>
				</item>
			</cfif>
		</cfloop>
		
		<atom:link href="#REQUEST.site_url#feed.xml" rel="self" type="application/rss+xml" />
	
	</channel>
</rss>
</cfoutput>
</cfxml>

<cffile action="write"
    file="#REQUEST.site_path#twitter_feed.xml"
    output="#ToString(RSS_Blogs)#"
    nameconflict="overwrite">
	
