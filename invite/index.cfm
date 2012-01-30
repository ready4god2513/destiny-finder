
<cfif isDefined("url.invite")>
	<cfset VARIABLES.invite_uid = Left(HTMLEditFormat(url.invite),6)>

    <cflocation url="/profile/?page=assessment&assessment_id=1&gift_type_id=1&invite=#VARIABLES.invite_uid#">
    <cfabort>
    
<cfelse>

	<cflocation url="/index.cfm">
    <cfabort>
    
</cfif>
