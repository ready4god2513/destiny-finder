<cfif REQUEST.user_id EQ 0>
	<cflocation url="/auth/" addtoken="no" />
	<cfabort />
</cfif>