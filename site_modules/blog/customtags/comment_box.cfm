<!--- Get requested URL from request object. --->
<cfset currentURL = "http://#CGI.HTTP_HOST#/blog/index.cfm?page=blog&amp;blog_id=#URL.blog_id#"/>
<div class="fb-comments" data-href="<cfoutput>#currentURL#</cfoutput>" data-num-posts="5" data-width="600"></div>