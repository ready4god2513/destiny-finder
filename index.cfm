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
		<div id="rotating-banner">
			<img src="/assets/images/336699.gif" />
			<img src="/assets/images/336699.gif" />
			<img src="/assets/images/336699.gif" />
			<img src="/assets/images/336699.gif" />
		</div>
		<div id="cycle-nav"></div>
	</div>
	<div class="span6">
		<div id="try-it-free-home">
			<img src="http://placehold.it/340x280/fff" />
		</div>
	</div>
</div>

<div class="row">
	<div class="span11">
		<section id="main">
			<article>
				<h2>About Us</h2>
				<p>
					We believe you've been uniquely designed by God with a personal destiny! 
					To do something significant for His kingdom. We help you discover your 
					destiny, maximize your impact and experience real fulfillment.
					<a href="/about/index.cfm?page=about&gateway=2&parent_gateway=2">More</a>
				</p>
			</article>

			<article>
				<h2>News</h2>
				<h3>Profiler now available!</h3>
				<p>
					It's here and there's nothing else like it on the planet! Five online surveys 
					based on spiritual gifts, motivation, passion and more produce a profile of 
					your basic gifting, calling and direction. Special introductory offer. 
					<a href="/profile/?page=profiler">More</a>
				</p>
			</article>

			<article>
				<h2>Products &amp; Services</h2>
				<div class="row">
					<div class="span2">
						<img src="/assets/images/pic_destiny_guide_1.0.jpg" />
					</div>
					<div class="span8">
						<h5>Free Trial Destiny Survey</h5>
						<p>Reveals your inner design. Takes 5 minutes, instant results</p>
						<p><a href="/profile/?page=assessment&assessment_id=1&gift_type_id=1">More</a></p>
					</div>
				</div>
				<div class="row">
					<div class="span2">
						<img src="/assets/images/pic_destiny_guide_1.0.jpg" />
					</div>
					<div class="span8">
						<h5>Profiler</h5>
						<p>Five surveys based on spiritual gifts, passion and more reveal 
						your basic destiny direction</p>
						<p><a href="/profile/?page=profiler">More</a></p>
					</div>
				</div>
				<div class="row">	
					<div class="span2">
						<img src="/assets/images/pic_destiny_guide_1.0.jpg" />
					</div>
					<div class="span8">
						<h5>Coaching</h5>
						<p>Experienced coaches work with you by phone to accelerate 
						your progress.</p>
						<p><a href="/products/index.cfm?page=coaching&gateway=3&parent_gateway=3">More</a></p>
					</div>
				</div>
				<div class="row">	
					<div class="span2">
						<img src="/assets/images/pic_destiny_guide_1.0.jpg" />
					</div>
					<div class="span8">
						<h5>DestinyFinder Book - Just Published!</h5>
						<p>Michael Brodeur's work sets the foundation for understanding 
						and pursuing kingdom-focused personal destiny.</p>
						<p><a href="/products/index.cfm?page=destinyfinderbook&gateway=3&parent_gateway=3">More</a></p>
					</div>
				</div>
			</article>
		</section>
	</div>

	<cfinclude template="templates/sidebar.cfm">
</div>

<cfinclude template="templates/footer.cfm" />