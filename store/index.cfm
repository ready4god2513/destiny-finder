
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to call the appropriate Fusebox core file --->

<!---- for search engine urls ------>
<cfset SESdummyExtension = ".cfm">
<cfset SESrBaseName = "baseHREF"> 
<cfinclude template="customtags/sesConverter.cfm"> 

<!--- include the core FuseBox  --->
<cflock type="READONLY" scope="server" timeout="10">
	<cfset variables.fuseboxVersion=Replace(Replace(ListDeleteAt(server.coldfusion.productVersion,4),",","","all")," ","","all")>
	<cfset variables.fuseboxOSName=server.os.name>
</cflock>

<cfinclude template="fbx_fusebox30_CF50_lite.cfm">


