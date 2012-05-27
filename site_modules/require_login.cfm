<cfif REQUEST.user_id EQ 0>
	<cfset SESSION.after = "#PATH_INFO#?#CGI.QUERY_STRING#" />
	<cflocation url="/auth/" addtoken="no" />
	<cfabort />
</cfif>