<!--- CFWebstore®, version 6.20 --->

<!--- CFWebstore® is ©Copyright 1998-2008 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page retrieves the current cfwebstore version and news from cfwebstore.com and saves to application memory --->
<!--- <cfparam name="RefreshInfo" default="No">

<cfif NOT isDefined("Application.Info.DayofYear") OR IsDefined("URL.Refresh") 
	OR Application.Info.DayofYear IS NOT DayofYear(Now()) OR Application.Info.TryAgain IS 'Yes'>
	<cfset RefreshInfo = "Yes">
</cfif>

<cfif RefreshInfo>

	<cfset Info = StructNew()>
	<cfset Info.TryAgain = "No">
	
	<!--- Attempt to get the current release version and news from cfwebstore.com --->
	<cftry>	
		<!--- <cfobject webservice="http://localhost:8500/new_cfwebstore/webservice/webstoreinfo.cfc?wsdl" name="WebstoreInfo"> --->
		<cfset WebstoreInfo ='http://www.cfwebstore.com/webservice/webstoreinfo.cfc?wsdl'>
		
		<cfinvoke webservice="#WebstoreInfo#" method="GetVersion" returnVariable="versioninfo" timeout="3">
		<cfinvoke webservice="#WebstoreInfo#" method="GetNews" returnVariable="news"  timeout="3">
	
	<cfcatch>
		<cfset versioninfo = "N/A">
		<cfset news = "Web service not available.">
		<cfset Info.TryAgain = "Yes">
	</cfcatch>
	
	</cftry> 
		
	<cftry>	
		<!--- Read in the current cfwebstore version --->
		<cfset TopDirectory = GetDirectoryFromPath(ExpandPath("*.*"))>
		<cfset versionFile = TopDirectory & 'version.txt'>
		<cffile action="READ" file="#versionFile#" variable="currVersion">
		
	<cfcatch>
		<cfset currVersion = "N/A">
		<cfset Info.TryAgain = "Yes">
	</cfcatch>
	
	</cftry> 
	
	<!--- Create the output --->
	<cfsavecontent variable="news">
		<cfoutput>
		<strong>CFWebstore&reg; Release Version:</strong> #versioninfo#<br/><br/>
		<strong>Your Current Version:</strong> #currVersion#<br/><br/>
		<strong>Latest News:</strong> #news#
		</cfoutput>
	</cfsavecontent>
	
	<cfset Info.News = news>
	<cfset Info.DayofYear =  DayofYear(Now())>
	<cfset Application.Info = Info>

 </cfif>
 
 <cfoutput>#Application.Info.News#</cfoutput>
 --->
