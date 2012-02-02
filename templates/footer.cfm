		<footer id="bottom">
	
			<div id="social-media-footer">
				<div class="fb-like" data-href="https://www.facebook.com/pages/Destiny-Finder/101856686575972" data-send="true" data-width="450" data-show-faces="true"></div>
			</div>
			
			<div class="row">
				
				<div class="span4">
					<a href="/"><img src="/assets/images/logo.png" id="footer-logo" width="220" height="65" /></a>
				</div>
				
				<nav class="span11 offset1">
					<div class="row">
						<ul class="span5">
							<li><a href="/">Home</a></li>
							<li><a href="/about/">About Us</a></li>
							<li><a href="/store/">Products &amp; Services</a></li>
							<li><a href="/free/">Resources</a></li>
							<li><a href="/about/index.cfm?page=privacypolicy">Privacy Policy</a></li>
							<li><a href="/about/index.cfm?page=termsofuse">Terms of Use</a></li>
						</ul>

						<ul class="span5">
							<li><a href="https://destinyfinder.foxycart.com/cart?cart=view">Cart</a></li>
							<cfif isDefined("SESSION.user_id") AND Len(SESSION.user_id) GT 0>
								<li><a href="/auth/account">My Account</a></li>
								<li><a href="/profile/?logout=yes">Log Out</a></li>
							<cfelse>
								<li><a href="/auth/">Login / Sign Up</a></li>
							</cfif>
							<li><a href="/about/?page=contact">Contact</a></li>
						</ul>
					</div>
				</nav>
			</div>
		</footer>
	</div>
</div>

<script>
	!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");
</script>

<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(["_setAccount", "UA-28069489-1"]);
  _gaq.push(["_trackPageview"]);

  (function() {
    var ga = document.createElement("script"); ga.type = "text/javascript"; ga.async = true;
    ga.src = ("https:" == document.location.protocol ? "https://ssl" : "http://www") + ".google-analytics.com/ga.js";
    var s = document.getElementsByTagName("script")[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>


<div id="fb-root"></div>
<script>
	(function(d, s, id) {
	  var js, fjs = d.getElementsByTagName(s)[0];
	  if (d.getElementById(id)) return;
	  js = d.createElement(s); js.id = id;
	  js.src = "//connect.facebook.net/en_US/all.js#xfbml=1&appId=358884870793317";
	  fjs.parentNode.insertBefore(js, fjs);
	}(document, 'script', 'facebook-jssdk'));
</script>

<script type="text/javascript">
  var uvOptions = {};
  (function() {
    var uv = document.createElement('script'); uv.type = 'text/javascript'; uv.async = true;
    uv.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'widget.uservoice.com/zJalL7A4qQVEls5JJxLkDg.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(uv, s);
  })();
</script>

</body>
</html>