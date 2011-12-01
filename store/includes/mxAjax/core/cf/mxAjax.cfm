<!----
 * http://www.indiankey.com/mxajax/
 *
 * @author Arjun Kalura (arjun.kalura@gmail.com)
 * @version 0.1, July 8th 2006
---->
<cfsetting enablecfoutputonly="yes">
<cfdump var="#cgi#">
<cfif findnocase("localhost", cgi.HTTP_HOST) GT 0>
	<cfset mxAjax = CreateObject("component", "mxAjax")>
<cfelse>
	<cfset mxAjax = CreateObject("component", "com.indiankey.mxajax.core.cf.mxAjax")>
</cfif>
<cftry>
	<cfscript>
		debug = false;
		dataPass = "";
		htmlResponse = false;
		if (isDefined("json")) {
			if (CGI.REQUEST_METHOD eq "POST") {
				dataPass = FORM.mxAjaxParam;
			} else if (CGI.REQUEST_METHOD eq "GET") {
				dataPass = URL.mxAjaxParam;
			}
		}
	</cfscript>

	
	<cfif (isDefined("json"))>
		<cfset mxAjaxRequest = mxAjax.jsondecode(dataPass)>
	<cfelse>
		<!--- non json request --->
		<cfset mxAjaxRequest = mxAjax.convertToJsonRequest()>
	</cfif>
	<cfif StructKeyExists(mxAjaxRequest, "calls") EQ true>
		<!---  multiple function call --->
		<cfset mxAjaxResponse = StructNew()>
		<cfset mxAjaxResponse.calls = ArrayNew(1)>
		<cfloop from="1" to="#ArrayLen(mxAjaxRequest.calls)#" index="rctr">
			<cfset functionName = StructKeyList(mxAjaxRequest.calls[rctr])>
			<cfif isStruct(mxAjaxRequest.calls[rctr][functionName])>
				<cfset functionParametersPassed = StructKeyList( mxAjaxRequest.calls[rctr][functionName])>
			<cfelse>
				<cfset functionParametersPassed = "">
			</cfif>
			
			<cfset _functionParameters = getMetaData(variables[functionName]).parameters>
			<cfset _functionArguments = StructNew()>
			<cfloop from="1" to="#ArrayLen(_functionParameters)#" index="fctr">
				<cfif ListFindNoCase(functionParametersPassed, _functionParameters[fctr].NAME ) GT 0>
					<cfset StructInsert(_functionArguments, _functionParameters[fctr].NAME, mxAjaxRequest.calls[rctr][functionName][_functionParameters[fctr].NAME])>
				</cfif>
			</cfloop>
			<cfinvoke method="#functionName#" returnvariable="result" argumentcollection="#_functionArguments#" />	
			<cfset callResponse = StructNew()>
			<cfset callResponse.functionName = functionName>
			<cfset callResponse.data = result>
			<cfset ArrayAppend(mxAjaxResponse.calls, callResponse)>
		</cfloop>
	<cfelse>
		<!--- single function call --->
		<cfloop collection="#mxAjaxRequest#" item="item">
			<cfif isStruct( mxAjaxRequest[item] )>
				<cfset functionName = item>
			</cfif>
			<cfif lcase(item) EQ "htmlresponse">
				<cfset htmlresponse = mxAjaxRequest[item]>
			</cfif>
		</cfloop>
		<cfif isStruct(mxAjaxRequest[functionName])>
			<cfset functionParametersPassed = StructKeyList( mxAjaxRequest[functionName])>
		<cfelse>
			<cfset functionParametersPassed = "">
		</cfif>
		
		<cfset _functionParameters = getMetaData(variables[functionName]).parameters>
		<cfset _functionArguments = StructNew()>
		<cfloop from="1" to="#ArrayLen(_functionParameters)#" index="fctr">
			<cfif ListFindNoCase(functionParametersPassed, _functionParameters[fctr].NAME ) GT 0>
				<cfset StructInsert(_functionArguments, _functionParameters[fctr].NAME, mxAjaxRequest[functionName][_functionParameters[fctr].NAME])>
			</cfif>
		</cfloop>
		<cfinvoke method="#functionName#" returnvariable="result" argumentcollection="#_functionArguments#" />	
		<cfset mxAjaxResponse = result>
	</cfif>
	
	<cfoutput><br/><br/>htmlResponse = #htmlResponse#<br/><br/><br/></cfoutput>
	<cfif htmlResponse EQ false>
		<cfset output = mxAjax.jsonencode(mxAjaxResponse)>
	<cfelse>
		<cfset output = mxAjaxResponse>
	</cfif>
	
	<cfdump var="#output#">
	<cfdump var="#mxAjaxResponse#">


	<cfif debug eq false><cfcontent reset="Yes"></cfif><cfoutput>#output#</cfoutput><cfabort>
	<cfcatch type="any">
		<cfrethrow>
	</cfcatch>
</cftry>
