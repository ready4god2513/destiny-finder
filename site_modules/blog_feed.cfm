<cfquery name="qFeeds" datasource="#APPLICATION.DSN#">
	SELECT * FROM Feeds
	WHERE feed_active = 1
</cfquery>

<cfloop query="qFeeds">
<div class="feed_wrapper">
	<div class="feed_author">
		<cfoutput>#qFeeds.feed_author#</cfoutput>
	</div>
	<cfmodule template="feed_module.cfm"
		feed_url="#qFeeds.feed_url#"
		feed_type="#qFeeds.feed_type#"
		debug="0"
	>
</div>
</cfloop>