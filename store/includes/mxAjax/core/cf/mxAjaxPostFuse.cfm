<!----
 * http://www.indiankey.com/mxajax/
 *
 * @author Arjun Kalura (arjun.kalura@gmail.com)
 * @version 0.1, July 8th 2006
---->
<cfset return_mxAjaxResponse = "">
<cfif isDefined("attributes.mxAjax.mxAjaxResponse") AND attributes.mxAjax.mxAjaxHtmlResponse EQ false>
	<cfset return_mxAjaxResponse = attributes.mxAjax.mxAjax.jsonencode(attributes.mxAjax.mxAjaxResponse)>
</cfif>
<!----
<cfdump var="#getPageContext().getCFOutput()#">
<cfdump var="#getPageContext()#">
---->
<cfif attributes.mxAjax.mxAjaxHtmlResponse EQ false><cfset getPageContext().getCFOutput().clearAll()>mxajax****/<cfoutput>#return_mxAjaxResponse#</cfoutput>/****mxajax</cfif>