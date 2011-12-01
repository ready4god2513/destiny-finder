<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page is run to check that any required custom fields have been filled out. Called by shopping.checkout (step=shipping) --->

<cfparam name="customneeded" default="0">

<cfif len(attributes.CustomText_Req)>
	
	<cfloop index="customfield" list="#attributes.CustomText_Req#">
		<cfif NOT isDefined("attributes.#customfield#") OR NOT Len(attributes[customfield])>
			<cfset customneeded = 1>
		</cfif>
	</cfloop>
	
<cfelseif len(attributes.CustomSelect_Req)>
	
	<cfloop index="customfield" list="#attributes.CustomSelect_Req#">
		<cfif NOT isDefined("attributes.#customfield#") OR NOT Len(attributes[customfield])>
			<cfset customneeded = 1>
		</cfif>
	</cfloop>

	
<cfelse>
	<!--- No custom fields required --->
	<cfset customneeded = 0>
	
</cfif>
