<!----
 * http://www.indiankey.com/mxajax/
 *
 * @author Arjun Kalura (arjun.kalura@gmail.com)
 * @version 0.1, July 8th 2006
---->
<cfsetting enablecfoutputonly="yes">
<cfscript>
	dataPass = "";
	functionName = "";
	functionParametersPassed = "";
	item = "";

	attributes.mxAjax.mxAjaxResponse = "";
	attributes.mxAjax.mxAjaxParam = StructNew();
	attributes.mxAjax.mxAjaxRequest = StructNew();
	attributes.mxAjax.mxAjaxFunctionName = "";
	attributes.mxAjax.mxAjaxHtmlResponse = "";
	attributes.mxAjax.mxAjax = CreateObject("component", "mxajax.core.cf.mxAjax");
	

	if (isDefined("json")) {
		if (CGI.REQUEST_METHOD eq "POST") {
			dataPass = FORM.mxAjaxParam;
		} else if (CGI.REQUEST_METHOD eq "GET") {
			dataPass = URL.mxAjaxParam;
		}
		attributes.mxAjax.mxAjaxRequest = attributes.mxAjax.mxAjax.jsondecode(dataPass);
	} else {
		attributes.mxAjax.mxAjaxRequest = attributes.mxAjax.mxAjax.convertToJsonRequest();
	}
</cfscript>

<cfif StructKeyExists(attributes.mxAjax.mxAjaxRequest, "calls") EQ true>
	<!---  multiple function call --->
<cfelse>
	<!--- single function call --->
	<cfloop collection="#attributes.mxAjax.mxAjaxRequest#" item="item">
		<cfif isStruct( attributes.mxAjax.mxAjaxRequest[item] )>
			<cfset functionName = item>
		</cfif>
		<cfif lcase(item) EQ "htmlresponse">
			<cfset attributes.mxAjax.mxAjaxHtmlResponse = attributes.mxAjax.mxAjaxRequest[item]>
		</cfif>
	</cfloop>
	<cfif isStruct(attributes.mxAjax.mxAjaxRequest[functionName])>
		<cfset functionParametersPassed = StructKeyList( attributes.mxAjax.mxAjaxRequest[functionName])>
	<cfelse>
		<cfset functionParametersPassed = "">
	</cfif>
	<cfloop list="#functionParametersPassed#" index="item">
		<cfset StructInsert(attributes.mxAjax.mxAjaxParam, item, attributes.mxAjax.mxAjaxRequest[functionName][item])>
	</cfloop>
</cfif>
<cfoutput>out of first one</cfoutput>
<cfcontent reset="yes">