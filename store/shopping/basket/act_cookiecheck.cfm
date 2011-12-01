<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page is used to make sure the user has cookies turned on in order to shop. --->

<cfif NOT StructKeyExists(cookie, "CFID") AND NOT  StructKeyExists(cookie, "JSESSIONID")>
	<cflocation url="#self#?fuseaction=page.nocookies">
</cfif>
