<!----
 * http://www.indiankey.com/mxajax/
 *
 * @author Arjun Kalura (arjun.kalura@gmail.com)
 * @version 0.1, July 8th 2006
---->
<cfcomponent extends="mxAjax">
	<cffunction name="makeAndDescription">
		<cfargument name="make" required="yes" type="string">
		<cfset retData = StructNew()>
		<cfset retData.lookup = makeLookup(arguments.make)>
		<cfset retData.description = makeDescription(arguments.make)>
		<cfreturn retData>
	</cffunction>
	
	<cffunction name="makeLookup">
		<cfargument name="make" required="yes" type="string">
		<cfset modelArray = ArrayNew(1)>
		<cfquery datasource="#request.mxAjaxDS#" name="qryData">
			SELECT * FROM phoneModel WHERE make = '#arguments.make#'
		</cfquery>
		<cfloop query="qryData">
			<cfset ArrayAppend(modelArray, "#qryData.model#,#qryData.name#")>
		</cfloop>
		<cfreturn modelArray>
	</cffunction>
	
	<cffunction name="makeDescription">
		<cfargument name="make" required="yes" type="string">
		<cfquery datasource="#request.mxAjaxDS#" name="qryData">
			SELECT * FROM phoneMake WHERE make = '#arguments.make#'
		</cfquery>
		<cfreturn qryData.description>
	</cffunction>

	<cffunction name="modelImage">
		<cfargument name="model" required="yes" type="string">
		<cfquery datasource="#request.mxAjaxDS#" name="qryData">
			SELECT * FROM phoneModel WHERE model = '#arguments.model#'
		</cfquery>
		<cfreturn "<img src='http://www.indiankey.com/cfajax/examples/" & qryData.image & "' border='0'/>">
	</cffunction>
	
	<cffunction name="getRandomQuote">
		<cfquery datasource="#request.mxAjaxDS#" name="qryData">
			SELECT * FROM quote WHERE id = #RandRange(1, 21, "SHA1PRNG")#
		</cfquery>
		<cfsavecontent variable="out">
			<cfoutput>
			<br>#qryData.quote#<br><br>
			<i>#qryData.author# - #qryData.moreinfo#</i>
			<br><br>
			#now()#
			</cfoutput>
		</cfsavecontent>
		<cfreturn out>
	</cffunction>
	
	<cffunction name="getRandomFact">
		<cfquery datasource="#request.mxAjaxDS#" name="qryData">
			SELECT * FROM facts WHERE id = #RandRange(1, 12, "SHA1PRNG")#
		</cfquery>
		<cfsavecontent variable="out">
			<cfoutput>
			<h3><a href="#qryData.link#" target="_new">#qryData.title#</a></h3>
			<p>#qryData.detail#</p><br><br>
			#now()#
			</cfoutput>
		</cfsavecontent>
		<cfreturn out>
	</cffunction>
	
	<cffunction name="getContent">
		<cfargument name="id" type="numeric">
		
		<cfquery datasource="#request.mxAjaxDS#" name="qryData">
			SELECT * FROM content WHERE id = #arguments.id#
		</cfquery>
		<cfsavecontent variable="out">
			<cfoutput>
			<h3>#qryData.title#</h3>
			<p>#qryData.content#</p><br><br>
			#now()#
			</cfoutput>
		</cfsavecontent>
		<cfreturn out>
	</cffunction>
	
	<cffunction name="getStateList" access="remote">
		<cfargument name="searchCharacter" required="yes" type="string" default="W"> 
		<cfquery datasource="#request.mxAjaxDS#" name="qryData">
			SELECT Code AS [KEY], Name as [VALUE] from state WHERE [search] like '#lcase(urlDecode(searchCharacter))#%'
		</cfquery>
		<cfreturn qryData>
	</cffunction>
	
	<cffunction name="getCopyrightContent">
		<cfsavecontent variable="out"><cfoutput>
			<html>
			<head>
				<title>Example Terms and Conditions</title>
				<style type="text/css">
					@import 'data/DOMinclude.css';
				</style>
			</head>
			<body>
				<h1>Dynamic Content</h1>
				<b>All of this content is comming from Server side CF Page</b>
				<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Suspendisse
				  vulputate felis ut est. Vivamus congue. Nullam consequat. Etiam elit
				  ipsum, pulvinar in, commodo sed, malesuada et, wisi. Maecenas nunc odio,
				  interdum et, mollis eget, egestas quis, enim. Vestibulum augue leo,
				</p>
			</body>
			</html>
			<br><br><br>
			#now()#</cfoutput>
		</cfsavecontent>
		<cfreturn out>
	</cffunction>
	
	<cffunction name="setRating">
		<cfargument name="rating" required="yes">
		<cfset retData = true>
		<!--- save the information in database --->
		<cfreturn retData>
	</cffunction>

	<cffunction name="getMessageTickerData">
		<cfset retData = ArrayNew(1)>
	
		<cfquery datasource="#request.mxAjaxDS#" name="qryData">
			SELECT * FROM quote
		</cfquery>
		<cfloop query="qryData">
			<cfset ArrayAppend(retData, qryData.quote)>
		</cfloop>
	
		<cfreturn retData>
	</cffunction>
	
</cfcomponent>