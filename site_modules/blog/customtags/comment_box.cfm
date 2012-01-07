<!--- Get request from ColdFusion page context. --->
<cfset objRequest = GetPageContext().GetRequest() />
 
<!--- Get requested URL from request object. --->
<cfset currentURL = objRequest.GetRequestUrl().Append(
"?" & objRequest.GetQueryString()
).ToString()
/>

<div class="fb-comments" data-href="<cfoutput>#currentURL#</cfoutput>" data-num-posts="5" data-width="450"></div>