<cfset obj_queries = CreateObject("component","site_modules.blog.cfcs.queries")>
<cfset qArchive = obj_queries.archive_listing()>

<h4>Recent Posts</h4>
<ul>
	<cfoutput query="qArchive">
		<li><a href="index.cfm?page=blog&month=#qArchive.Month#&year=#qArchive.Year#">#MonthAsString(qArchive.Month)# #qArchive.Year#</a></li>
	</cfoutput>
</ul>