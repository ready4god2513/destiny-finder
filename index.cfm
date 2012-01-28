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
	<div id="rotating-banner">
		
	</div>
	<div id="free-trial-home">
		
	</div>
</div>

<div class="row">
	<div class="span11">
		<section id="main">
			<article>
				<h2>About Us</h2>
				<p>
					Etiam enim leo, consequat ac ullamcorper a, fringilla a ipsum. Integer odio diam, accumsan ac mollis id, ultrices sed lectus. Vestibulum mattis elit nec enim fringilla rutrum. In sit amet risus ac eros commodo mattis. Proin viverra ultricies erat, at hendrerit metus fermentum et. Vivamus sit amet euismod mi. Nunc ullamcorper, ipsum at interdum egestas, nisi velit consequat magna, ornare fermentum sapien elit eget tellus. Aenean euismod, erat a adipiscing commodo, lorem mi mollis dolor, at porta nisi risus tincidunt sapien. Mauris vel tellus tortor, in luctus turpis. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Sed id nunc turpis, sed dignissim purus. Mauris vestibulum, quam sed eleifend aliquet, erat sapien aliquam turpis, eu pretium nunc urna id felis.
				</p>
			</article>

			<article>
				<h2>News</h2>
				<h3>Profiler now available!</h3>
				<p>
					Etiam enim leo, consequat ac ullamcorper a, fringilla a ipsum. Integer odio diam, accumsan ac mollis id, ultrices sed lectus. Vestibulum mattis elit nec enim fringilla rutrum. In sit amet risus ac eros commodo mattis. Proin viverra ultricies erat, at hendrerit metus fermentum et. Vivamus sit amet euismod mi. Nunc ullamcorper, ipsum at interdum egestas, nisi velit consequat magna, ornare fermentum sapien elit eget tellus. Aenean euismod, erat a adipiscing commodo, lorem mi mollis dolor, at porta nisi risus tincidunt sapien. Mauris vel tellus tortor, in luctus turpis. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Sed id nunc turpis, sed dignissim purus. Mauris vestibulum, quam sed eleifend aliquet, erat sapien aliquam turpis, eu pretium nunc urna id felis.
				</p>
			</article>

			<article>
				<h2>Products &amp; Services</h2>
				<p>
					Etiam enim leo, consequat ac ullamcorper a, fringilla a ipsum. Integer odio diam, accumsan ac mollis id, ultrices sed lectus. Vestibulum mattis elit nec enim fringilla rutrum. In sit amet risus ac eros commodo mattis. Proin viverra ultricies erat, at hendrerit metus fermentum et. Vivamus sit amet euismod mi. Nunc ullamcorper, ipsum at interdum egestas, nisi velit consequat magna, ornare fermentum sapien elit eget tellus. Aenean euismod, erat a adipiscing commodo, lorem mi mollis dolor, at porta nisi risus tincidunt sapien. Mauris vel tellus tortor, in luctus turpis. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Sed id nunc turpis, sed dignissim purus. Mauris vestibulum, quam sed eleifend aliquet, erat sapien aliquam turpis, eu pretium nunc urna id felis.
				</p>
			</article>
		</section>
	</div>

	<cfinclude template="templates/sidebar.cfm">
</div>

<cfinclude template="templates/footer.cfm" />