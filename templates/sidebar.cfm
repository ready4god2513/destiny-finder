<section id="sidebar" class="span5">
	
	<cfif CGI.PATH_INFO EQ "/index.cfm">
		<article>
			<h4>From the Founder</h4>
			<iframe width="260" height="176" src="//www.youtube.com/embed/GmBTuxvcAA8?wmode=transparent&amp;rel=0" frameborder="0" allowfullscreen></iframe>
		</article>

		<article>
			<h4>Testimonial</h4>
			<iframe width="260" height="176" src="//www.youtube.com/embed/NKKUJn01nyY?wmode=transparent&amp;rel=0" frameborder="0" allowfullscreen></iframe>
		</article>
	</cfif>

	<article>
		<cfinclude template="../site_modules/blog/customtags/popular_blog_posts.cfm" />
		<p><a href="/blog">Read More Articles</a></p>
	</article>

	<article>
		<h4>Join our Mailing List</h4>
		<form method="post" target="_blank" action="http://visitor.r20.constantcontact.com/d.jsp" name="ccoptin">
			<input type="hidden" value="gahj9deab" name="llr" />
			<input type="hidden" value="1103934823430" name="m" />
			<input type="hidden" value="oi" name="p" />
			<input type="email" value="" name="ea" placeholder="you@your-email.com" required="required" class="span3" />
			<input type="submit" class="btn btn-primary" value="Join" name="go" />
		</form>
	</article>
	
	<article>
		<a href="https://twitter.com/Destiny_Finder" class="twitter-follow-button" data-show-count="false">Follow @mydestinyfinder</a>
		<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>
		<div class="fb-like" data-href="https://www.facebook.com/mydestinyfinder" data-send="false" data-width="250" data-show-faces="false"></div>
	</article>
</section>