
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page is used to perform the verity search. Called from act_search.cfm --->

<cfif NOT isDefined("StartRow")>
        <cfset StartRow = 1>
<cfelse>
        <cfset StartRow = (StartRow + 20)>
</cfif>

<!--- remove any characters, other than alphanumeric, space or dashes --->
<cfset search_string = Trim(ReReplace(attributes.string, "[^\w+^\s+^\-]", " ", "All"))>

<cflock timeout="120" name="verity" type="READONLY">
<cfsearch collection="#request.appSettings.CollectionName#"
          name="Results"
          type="SIMPLE"
          criteria="#LCase(String)#">
</cflock>
		  




