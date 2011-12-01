
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page is used to parse parameters passed into the layout page. Each parameter is copied into attributes scope and available on the layout page. --->

<cfparam name="QuerytoUse" default="#Request.GetColors#">

<cfset ParamString = QuerytoUse['passparam'][1]>
<!--- set any variables listed in the template's 'passparam' field --->
<cfif len(ParamString)>
	<cfloop list="#ParamString#" index="counter">
		<!--- Make sure parameter is passed correctly --->
		<cfif ListLen(counter,'=') GT 1>
			<cfset temp = setvariable("attributes.#trim(listgetat(counter,1,'='))#", "#trim(listgetat(counter,2,'='))#")>
		<cfelse>
			 <cfset temp = setvariable("attributes.#trim(listgetat(counter,1,'='))#", "")>
		</cfif>
	</cfloop>
</cfif>

