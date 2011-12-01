<cfif FindNoCase("EXEC(", CGI.Query_String) OR FindNoCase("EXEC(", CGI.Script_Name) OR FindNoCase("EXEC(", CGI.Path_Info)>
	<cfabort>
<cfelseif FindNoCase("CAST(", CGI.Query_String) OR FindNoCase("CAST(", CGI.Script_Name) OR FindNoCase("CAST(", CGI.Path_Info)>
	<cfabort>
</cfif>

<cfloop collection="#form#" item="item">
 <cfif form[item] contains "exec(">
    <cfabort>
 </cfif>
</cfloop>

<cfloop collection="#URL#" item="item">
 <cfif url[item] contains "exec(">
     <cfabort>
 </cfif>
</cfloop>
<cfset REQUEST.DSN="destinyfinder_dev">
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to make sure that the user goes through the main index.cfm page --->

<cfsetting showdebugoutput="no">

<cfset request.self="index.cfm">

<cfinclude template="config.cfm">

<!--- add any files that can be directly accessed to this list --->
<!--- <cfset directAccessFiles="#request.self#,go.cfm,image.cfm,colortool.cfm">
<cfif not listFindNoCase(directaccessfiles,getfilefrompath(cgi.script_name))>
	<cflocation url="#request.self#" addtoken="No">
</cfif>	 --->

<cfif "#GetDirectoryFromPath(GetCurrentTemplatePath())#index.cfm" NEQ GetBaseTemplatePath()
 AND "#GetDirectoryFromPath(GetCurrentTemplatePath())#go.cfm" NEQ GetBaseTemplatePath()
 AND "#GetDirectoryFromPath(GetCurrentTemplatePath())#image.cfm" NEQ GetBaseTemplatePath()
 AND "#GetDirectoryFromPath(GetCurrentTemplatePath())#colortool.cfm" NEQ GetBaseTemplatePath()
 AND "#GetDirectoryFromPath(GetCurrentTemplatePath())#admin\index.cfm" NEQ GetBaseTemplatePath()>
	<cflocation url="#Request.StorePath#index.cfm">
 </cfif>

