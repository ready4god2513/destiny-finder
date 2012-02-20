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
			<div id="rotating-images">
				<img src="assets/images/slidepictures/DadandSon.jpg" width="590" height="280" alt="DadandSon">
				<img src="assets/images/slidepictures/ExploreYourPotential.jpg" width="590" height="280" alt="ExploreYourPotential">
				<img src="assets/images/slidepictures/LockSlide.jpg" width="590" height="280" alt="LockSlide">
				<img src="assets/images/slidepictures/StepSToneSlide.jpg" width="590" height="280" alt="StepSToneSlide">
				<img src="assets/images/slidepictures/TransformYourWorld.jpg" width="590" height="280" alt="TransformYourWorld">
			</div>
		</div>
		<div id="cycle-nav"></div>
	</div>
	<div class="pull-right">
		<div id="try-it-free-home">
			<a href="/profile/?page=assessment&amp;assessment_id=1&amp;gift_type_id=1">
				<img src="/assets/images/free-trial-home-banner.png" />
			</a>
		</div>
	</div>
</div>

<div class="row">
	<div class="span11">
		<section id="main">
			<article>
				<h2>About Us</h2>
				<p>
					We believe you've been uniquely designed by God with a personal destiny -- to do something significant for His kingdom. With unique online tools and personal coaching, we help you discover your destiny, maximize your impact and experience real fulfillment.
					<a href="/about/index.cfm?page=about&amp;gateway=2&amp;parent_gateway=2">More...</a>
				</p>
			</article>

			<article>
				<h2>News</h2>
				<h3>BETA Site launches, Profiler FREE for the next 7 days!</h3>
				<p>
					The Profiler is FREE for the next 7 days while we BETA-test the new site. 
					We need your feedback to make our website, products and services be the 
					best they can be. Please take the Free Survey, invite friends to take the 
					Friends Survey, and take the Destiny Profiler surveys for free 
					(you'll still be sent to the store - the cost will be zero.) All we ask is that 
					you use the Feedback button available on each page and give us as much 
					feedback as possible about errors, things that don't make sense, or suggestions. 
					Thank you for partnering with us to make a difference!
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
							<a href="/profile/?page=assessment&amp;assessment_id=1&amp;gift_type_id=1">More...</a>
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
							<a href="/profile/?page=profiler">More...</a>
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
						<h5>DestinyFinder Book - Feb 2012 Release</h5>
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