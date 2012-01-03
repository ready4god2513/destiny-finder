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

<div id="banner_wrapper">
	<img src="site_images/bnr_discover_your_destiny_c.jpg" id="discover-your-destiny" />
	<a href="/auth/index.cfm?page=user&amp;create=1">
		<img id="banner_content" src="site_images/banner_promo_box.png" />
	</a>
	<div class="clear"></div>
</div>

<div id="home-page" class="body_content">
	<div class="row">
		
		<div class="span-one-third">
			<h1>Destiny Guide 1.0</h1>
			<div class="section_content">
				<img src="/site_images/pic_destiny_guide_1.0.jpg" width="90" height="92" id="destiny-guide-img" />
				<div id="what-is-destiny">
					<strong>
						The Destiny Survey is just the first step of the Destiny Guide 1.0 System. 
						The Destiny Guide System is based on 30 years of helping people 
						discover their destiny. It contains:
					</strong>
					<ul>
						<li>The <strong>Destiny Profiler</strong>, a comprehensive assessment of 10 dimensions of gifting, core traits, personality, personal passion and more.</li>
						<li>The <strong>Destiny Planner</strong>, a coach-directed, individualized action plan based on your profile.</li>
						<li>The <strong>Destiny Activator</strong>, in which a coach helps you find a mentor and an opportunity to use your gifts in your target area.</li>
					</ul>
				</div>
				<div class="clear"></div>
			</div>
			
			<a href="/blog/">
				<img src="/site_images/blog_304x90.png" alt="Destiny Finder Blog" width="304" height="90" />
			</a>
		</div>
		
		<div class="span-one-third">
			<h2>Testimonials</h2>
			<div class="section_content">
				<iframe width="280" height="190" src="http://www.youtube.com/embed/NKKUJn01nyY" frameborder="0" allowfullscreen></iframe>
			</div>
			
			<h4>Ask Michael</h4>
			<div class="section_content">
				<img src="/site_images/pic_michael_sm.jpg" width="90" height="82" />
				<div class="section_content_text">
					<strong>Ask Michael Brodeur,</strong>
					<p>
						DestinyFinder CEO, what is your most burning question about finding your destiny?
					</p>
					<p>
						<a href="#">Coming Soon!</a>
					</p>
				</div>
			</div>
		</div>
		
		<div class="span-one-third">
			<h2>Free Survey</h2>
			<div class="section_content">
				<ul>
					<li>5 minute survey reveals your inner design</li>
					<li>Learn how your design shapes your destiny</li>
					<li>Receive your free customized results instantly</li>
				</ul>
			</div>
			
			<div class="section_content">
				<form method="post" target="_blank" action="http://visitor.r20.constantcontact.com/d.jsp" name="ccoptin">
					<h4>Join our Mailing List</h4>
					<input type="hidden" value="gahj9deab" name="llr" />
					<input type="hidden" value="1103934823430" name="m" />
					<input type="hidden" value="oi" name="p" />
					<input type="text" value="" name="ea" placeholder="you@your-email.com" />
					<input type="submit" class="btn primary" value="Join" name="go" />
				</form>
			</div>
			
			<a href="#">
				<img src="/site_images/DF-Book-icon1.jpg" width="252" height="74" />
			</a>
			<a href="#">
				<img src="/site_images/ProfilerModule.jpg" width="252" height="74" />
			</a>
		</div>
	</div>
<cfinclude template="templates/footer.cfm" />