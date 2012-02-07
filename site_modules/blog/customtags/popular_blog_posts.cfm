<cfquery name="popularBlogPosts" datasource="#APPLICATION.dsn#">
	SELECT *
	FROM Blogs
</cfquery>

<section id="popular-posts">
	<h4>Popular Articles</h4>
	<ul>
		<cfoutput query="popularBlogPosts">
			<cfset postURL = "http://#CGI.HTTP_HOST#/blog/index.cfm?page=blog&amp;blog_id=#popularBlogPosts.blog_id#" />
			<li>
				<a href="#postURL#">#popularBlogPosts.blog_title#</a>
				<a href="#postURL###disqus_thread" data-disqus-identifier="#Hash(postURL)#" class="comment-count">#popularBlogPosts.blog_title#</a>
			</li>
		</cfoutput>
	</ul>
</section>

<script type="text/javascript">
    /* * * CONFIGURATION VARIABLES: EDIT BEFORE PASTING INTO YOUR WEBPAGE * * */
    var disqus_shortname = 'destinyfinder'; // required: replace example with your forum shortname

    /* * * DON'T EDIT BELOW THIS LINE * * */
    (function () {
        var s = document.createElement('script'); s.async = true;
        s.type = 'text/javascript';
        s.src = 'https://' + disqus_shortname + '.disqus.com/count.js';
        (document.getElementsByTagName('HEAD')[0] || document.getElementsByTagName('BODY')[0]).appendChild(s);
    }());
</script>

<script>
	$("#popular-posts ul li").sortElements(function(a, b){
	    return $(a).children(".comment-count").text() > $(b).text() ? 1 : -1;
	});
</script>