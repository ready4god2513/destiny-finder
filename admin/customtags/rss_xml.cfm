<cfquery name="qBlogs" datasource="#APPLICATION.DSN#" maxrows="12">
	SELECT blog_id,blog_title,blog_publish_date,blog_shorttext
	FROM Blogs
	WHERE blog_publish_date <= <cfqueryparam cfsqltype="cf_sql_timestamp" value="#DateAdd('h',REQUEST.time_offset,NOW())#">
	AND blog_active = 1
	ORDER BY blog_publish_date DESC
</cfquery>	

<cfxml variable="RSS_Blogs">
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
<cfoutput>
	<channel>
		<title>InsightOkc.com</title>
		<link>#REQUEST.site_url#</link>
		<description>Insight Creative Group</description>
		<lastBuildDate>#DateFormat(NOW(),'ddd, dd mmm yyyy')# #TimeFormat(NOW(),'hh:mm:ss')# CST</lastBuildDate>
		<language>en-us</language>

		<cfloop query="qBlogs">
			<item>
				<title>#XMLFormat(qBlogs.blog_title)#</title>
				<link>#XMLFormat("#REQUEST.site_url#blog/index.cfm?page=blog&blog_id=#qBlogs.blog_id#")#</link>
				<guid>#XMLFormat("#REQUEST.site_url#blog/index.cfm?page=blog&blog_id=#qBlogs.blog_id#")#</guid>
				<pubDate>#DateFormat(qBlogs.blog_publish_date,'ddd, dd mmm yyyy')# #TimeFormat(qBlogs.blog_publish_date,'hh:mm:ss')# CST</pubDate>
				<description>#XMLFormat(qBlogs.blog_shorttext)#</description>
			</item>
		</cfloop>
		
		<atom:link href="#REQUEST.site_url#feed.xml" rel="self" type="application/rss+xml" />
	
	</channel>
</rss>
</cfoutput>
</cfxml>

<cffile action="write"
    file="#REQUEST.site_path#feed.xml"
    output="#ToString(RSS_Blogs)#"
    nameconflict="overwrite">
	
