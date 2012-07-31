<cfquery name="qBlocks" datasource="#APPLICATION.DSN#">
SELECT * FROM MiscContent
</cfquery>
<cfquery name="qGateways" datasource="#APPLICATION.DSN#">
SELECT *
FROM Gateway_Pages
WHERE gateway_parent_id = 0 AND gateway_id > 1
AND gateway_active = 1
ORDER BY gateway_sortorder ASC
</cfquery>
<cfparam name="ATTRIBUTES.html_title" default="" />
<cfparam name="ATTRIBUTES.meta_desc" default="" />
<cfparam name="ATTRIBUTES.page_name" default="" />
<cfparam name="ATTRIBUTES.gateway_id" default="" />
<cfparam name="ATTRIBUTES.header_image" default="" />
<cfparam name="URL.page" default="" />
<cfparam name="URL.gateway" default="" />

<cfinclude template="templates/header.cfm" />

<div class="row">
	<div class="span10">
		<iframe id="ytplayer" type="text/html" width="640" height="360" src="http://www.youtube.com/embed/k_fs9Uaye7o?autoplay=0&controls=0&enablejsapi=1&modestbranding=1&rel=0&showinfo=0&theme=light&wmode=transparent" frameborder="0" allowfullscreen></iframe>
	</div>
	<div id="free-banner-home" class="span6 pull-right">
		<a href="/profile/?page=assessment&amp;assessment_id=1&amp;gift_type_id=1">
			<img src="/assets/images/free-trial-home-banner.png" />
		</a>
	</div>
</div>

<div class="row">
	<div class="span11">
		<section id="main">
			<article>
				<h2>About Us</h2>
				<p>
					We believe you've been uniquely designed by God with a personal destiny - 
					to do things that no one else can do in quite the same way. With exciting online tools and 
					in-depth personal coaching, we help you identify your abilities, discover your destiny, 
					maximize your impact, and experience real fulfillment in life.
					<a href="/about/index.cfm?page=about&amp;gateway=2&amp;parent_gateway=2">More...</a>
				</p>
			</article>

			<article>
				<h2>News</h2>
				<h3>Destiny Profiler launching at Jesus Culture New York!</h3>
				<p>
					It's powerful, it's easy, it's here!  Five surveys based on spiritual gifts, motivational gifts, passion and more reveal your basic destiny direction
					<a href="/products/index.cfm?page=profiler305&gateway=3&parent_gateway=3">More...</a>
				</p>
			</article>
			
			<article>
				<h3>Friends 360 Survey launches</h3>
				<p>
					You can now invite your friends to take the free trial destiny survey about you -- get valuable feedback to help you understand your gifting and calling. It's free, it's fun, it's easy.
					<a href="/profile/?page=profiler">More...</a>
				</p>
			</article>

			<article>
				<h2>Products &amp; Services</h2>
				<div class="row">
					<div class="span2">
						<img src="/assets/images/compass.png" />
					</div>
					<div class="span8">
						<h5>Free Trial Destiny Survey</h5>
						<p>
							Reveals your inner design. Only 10 questions, instant results.
							<a href="/products/index.cfm?page=destinyguide10&gateway=3&parent_gateway=3">More...</a>
						</p>
					</div>
				</div>
				<div class="row">
					<div class="span2">
						<img src="/assets/images/profiler.jpg" />
					</div>
					<div class="span8">
						<h5>Destiny Profiler</h5>
						<p>
							Five surveys based on spiritual gifts, passion and more reveal your basic destiny direction.
							<a href="/products/index.cfm?page=profiler305&gateway=3&parent_gateway=3">More...</a>
						</p>
					</div>
				</div>
				<div class="row">	
					<div class="span2">
						<img src="/assets/images/coaching.jpg" />
					</div>
					<div class="span8">
						<h5>Destiny Coaching</h5>
						<p>
							Experienced coaches work with you by phone to accelerate your progress. 
							<a href="/products/index.cfm?page=coaching&amp;gateway=3&amp;parent_gateway=3">More</a>
						</p>
					</div>
				</div>
				<div class="row">	
					<div class="span2">
						<img src="/assets/images/df-book.jpg" />
					</div>
					<div class="span8">
						<h5>Destiny Finder Book</h5>
						<p>
							Michael Brodeur's work sets the foundation for understanding and pursuing kingdom-focused personal destiny.
							<a href="/products/index.cfm?page=destinyfinderbook&amp;gateway=3&amp;parent_gateway=3">More...</a>
						</p>
					</div>
				</div>
			</article>
		</section>
	</div>

	<cfinclude template="templates/sidebar.cfm">
</div>

<cfinclude template="templates/footer.cfm" />