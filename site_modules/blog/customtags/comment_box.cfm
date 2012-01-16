<!--- Get requested URL from request object. --->
<cfset currentURL = "http://#CGI.HTTP_HOST#/blog/index.cfm?page=blog&amp;blog_id=#URL.blog_id#"/>

<div id="disqus_thread"></div>
<script type="text/javascript">
    /* * * CONFIGURATION VARIABLES: EDIT BEFORE PASTING INTO YOUR WEBPAGE * * */
    var disqus_shortname = "destinyfinder"; // required: replace example with your forum shortname
	var disqus_url = "<cfoutput>#currentURL#</cfoutput>";
	var disqus_identifier = "<cfoutput>#Hash(currentURL)#</cfoutput>";
	
	<cfif FindNoCase("dev.", #currentURL#) gt 0>
		var disqus_developer = 1;
	</cfif>
    /* * * DON"T EDIT BELOW THIS LINE * * */
    (function() {
        var dsq = document.createElement("script"); dsq.type = "text/javascript"; dsq.async = true;
        dsq.src = "http://" + disqus_shortname + ".disqus.com/embed.js";
        (document.getElementsByTagName("head")[0] || document.getElementsByTagName("body")[0]).appendChild(dsq);
    })();
</script>
<noscript>Please enable JavaScript to view the <a href="http://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>
<a href="http://disqus.com" class="dsq-brlink">blog comments powered by <span class="logo-disqus">Disqus</span></a>