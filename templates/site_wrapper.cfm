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
<cfparam name="ATTRIBUTES.html_title" default="">
<cfparam name="ATTRIBUTES.meta_desc" default="">
<cfparam name="ATTRIBUTES.page_name" default="">
<cfparam name="ATTRIBUTES.url_page" default="">
<cfparam name="ATTRIBUTES.gateway_id" default="">
<cfparam name="ATTRIBUTES.header_image" default="">
<cfparam name="URL.page" default="#ATTRIBUTES.url_page#">
<cfparam name="URL.gateway" default="">
<cfif thistag.executionmode EQ 'start'>
	<!DOCTYPE html>
	<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<cfoutput>
	<title>
	<cfif LEN(ATTRIBUTES.html_title) GT 0>
		#ATTRIBUTES.html_title#
		<cfelse>
			#APPLICATION.sitename#
		</cfif>
	</title>
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
	<script type="text/javascript" src='https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.16/jquery-ui.min.js'></script>
	<!-- Built and combined from /site_scripts/libraries/* -->
	<script type="text/javascript" src="/site_scripts/libs.min.js"></script>
	<script type="text/javascript" src="/site_scripts/main.js"></script>

	<cfif isDefined("ATTRIBUTES.additionalStyles")>
		<cfloop array="#ATTRIBUTES.additionalStyles#" index="style">
			<link rel="stylesheet" href="<cfoutput>#style#</cfoutput>" type="text/css" media="screen" charset="utf-8" />
		</cfloop>
	</cfif>

	<link rel="stylesheet" type="text/css" href="/site_styles/fancybox.css" />
	<cfif LEN(ATTRIBUTES.meta_desc) GT 0>
		<meta name="description" content="#ATTRIBUTES.meta_desc#" />
	</cfif>
	</cfoutput>
	<link rel="stylesheet" type="text/css" href="/site_styles/main.css" />

	<!--[if IE 7]>
	<link rel="stylesheet" type="text/css" href="/site_styles/ie7.css" />
	<![endif]-->
	<!--[if IE 8]>
	<link rel="stylesheet" type="text/css" href="/site_styles/ie8.css" />
	<![endif]-->

	<link rel="stylesheet" type="text/css" href="/site_styles/word_sort.css" />
	</head>
	<body>
		<div class="container">
			<header>
				<div class="row">
					<div class="span11">
						<img src="/site_images/transparent.png" width="345" height="110" />
					</div>

					<nav class="span5">
						<ul>
							<li><a href="https://destinyfinder.foxycart.com/cart">Cart</a></li>
							<cfif isDefined("SESSION.user_id") AND Len(SESSION.user_id) GT 0>
								<li><a href="/profile/index.cfm?logout=yes">Log Out</a></li>
							<cfelse>
								<li><a href="/auth/?page=user&amp;create=1">Create Account</a></li>
								<li><a href="/auth/">Login</a></li>
							</cfif>
						</ul>
					</nav>
				</div>
			</header>
			
			<div class="head_gnav">
				<ul class="sf-menu">
					<li><a href="/index.cfm"><span>Home</span></a></li>
					<cfoutput query="qGateways">
						<li class="head_gnav_menu <cfif qGateways.recordcount EQ qGateways.currentrow>sf-menu-last</cfif>">
							<a href="#qGateways.gateway_path##qGateways.gateway_landing_page#" <cfif ATTRIBUTES.gateway_id EQ qGateways.gateway_id>class="gateway_active"</cfif> ><span>#qGateways.gateway_name#</span></a>
							<cfmodule template="/customtags/sub_menu_multi.cfm"
								gateway="#qGateways.gateway_id#"	
								gateway_page_name="#qGateways.gateway_name#"
								gateway_path="#qGateways.gateway_path#"		
								parent_gateway="#qGateways.gateway_id#">
						</li>
					</cfoutput>
				</ul>      
			</div>
			
			<div class="subpage_banner">
				<div id="subpage_title">
					<cfif isDefined("ATTRIBUTES.page_name")>
						<cfoutput>#ATTRIBUTES.page_name#</cfoutput>
					<cfelse>
						Account
					</cfif>
				</div>
				<cfif (isDefined("SESSION.user_id") AND Len(SESSION.user_id) GT 0) AND (FindNoCase('profile',GetBaseTemplatePath()))>              
					<div id="subpage_nav">  
						<ul> 
							<li><a href="/profile/?page=profiler"<cfif isDefined("URL.page") AND Lcase(URL.page) NEQ 'user'> style="background-color:#f7f1e4;margin-top:-2px;"</cfif>><span<cfif isDefined("URL.page") AND Lcase(URL.page) NEQ 'user'> style="background-color:#f7f1e4;"</cfif>>Profiler<!---Active Surveys---></span></a></li>
							<li><a href="#"><span>Planner</span></a></li>
							<li><a href="#"><span>Activator</span></a></li>
						</ul>
					</div>
				</cfif>   
			</div>

			<div class="body_content">
<cfelse>
	</div> 
	<div style="background-color:#F7F1E4;">
		<br class="clear" />
	</div>
	<div class="footer_wrapper">
		<div class="footer_menu_cols">
			<a href="/">Home</a><br />
			<a href="/about/">About Us</a>   
		</div>
		<div class="footer_menu_cols">
			<a href="/products/">Products &amp; Services</a><br />     
			<a href="/profile/">Destiny Guide 1.0</a>     
		</div>
		<div class="footer_menu_cols">
			<a href="/coaching/">Coaching</a><br />
		</div> 
		<div class="footer_menu_cols">
			<a href="/free/">Resources</a><br />
			<a href="/about/index.cfm?page=contact">Contact</a>
		</div> 
		<div class="footer_menu_cols">
			<a href="/privacy/">Privacy</a>
		</div> 
	</div>
	<br class="clear" />
	</div>
	</body>
	</html>
</cfif>