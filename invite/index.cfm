
<cfif isDefined("URL.invite") AND Len(URL.invite) GT 2>
	<cfset VARIABLES.invite_uid = Left(HTMLEditFormat(url.invite),6)>

    <cflocation url="/profile/?page=assessment&assessment_id=1&gift_type_id=1&invite=#VARIABLES.invite_uid#&intro=true">
    <cfabort>
    
<cfelse>

	<cflocation url="/index.cfm">
    <cfabort>
    
</cfif>
