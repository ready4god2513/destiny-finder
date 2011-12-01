<cfset obj_queries = CreateObject("component","site_modules.blog.cfcs.queries")>
<cfset qCategories = obj_queries.category_list()>
<ul>
	<cfoutput query="qCategories">
		<cfset qPosts = obj_queries.category_posts(category_id="#qCategories.category_id#")>
		<li><a href="index.cfm?page=blog&category=#qCategories.category_id#">#qCategories.category_title# <cfif qPosts.recordcount GT 0>(#qPosts.recordcount#)</cfif></a></li>
	</cfoutput>
</ul>