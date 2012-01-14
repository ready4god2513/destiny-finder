<!doctype html>
<!--[if lt IE 7]> <html lang="en-us" class="no-js ie6"> <![endif]-->
<!--[if IE 7]>    <html lang="en-us" class="no-js ie7"> <![endif]-->
<!--[if IE 8]>    <html lang="en-us" class="no-js ie8"> <![endif]-->
<!--[if gt IE 8]><!--> <html lang="en-us" class="no-js"> <!--<![endif]-->
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=Edge;chrome=1" >

	<title dir="ltr">
		<cfif LEN(ATTRIBUTES.html_title) GT 0>
			<cfoutput>#ATTRIBUTES.html_title#</cfoutput> |
		</cfif>
		Destiny Finder
	</title>
	<cfif LEN(ATTRIBUTES.meta_desc) GT 0>
		<meta name="description" content="<cfoutput>#ATTRIBUTES.meta_desc#</cfoutput>" />
	</cfif>

	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.16/jquery-ui.min.js"></script>
	
	<!-- Include all of the required libraries -->
	<script src="/site_scripts/libraries/modernizr.js"></script>
	<script src="/site_scripts/libraries/jquery.form.js"></script>
	<script src="/site_scripts/libraries/jquery.hoverIntent.minified.js"></script>
	<script src="/site_scripts/libraries/jquery.validate.min.js"></script>
	<script src="/site_scripts/libraries/jquery_easing.js"></script>
	<script src="/site_scripts/libraries/pngfix.js"></script>
	<script src="/site_scripts/libraries/superfish.js"></script>
	<script src="/site_scripts/libraries/swfobject.js"></script>
	<script src="/site_scripts/main.js"></script>
	

	<cfif isDefined("ATTRIBUTES.additionalStyles")>
		<cfloop array="#ATTRIBUTES.additionalStyles#" index="style">
			<cfoutput><link rel="stylesheet" href="#style#" type="text/css" media="screen" charset="utf-8" /></cfoutput>
		</cfloop>
	</cfif>
	
	<link rel="stylesheet" type="text/css" href="/site_styles/main.css" />

	<!--[if IE 7]>
		<link rel="stylesheet" type="text/css" href="/site_styles/ie7.css" />
	<![endif]-->
	<!--[if IE 8]>
		<link rel="stylesheet" type="text/css" href="/site_styles/ie8.css" />
	<![endif]-->
</head>
<body>
	<div class="container">
		<header>
			<div class="row">
				<div class="span11">
					<img src="/site_images/transparent.png" width="345" height="110" usemap="#head_logo" />
					<map name="head_logo"><area shape="rect" coords="0,0,345,110" href="/"></map>
				</div>

				<nav class="span5">
					<ul>
						<li><a href="https://destinyfinder.foxycart.com/cart">Cart</a></li>
						<cfif isDefined("SESSION.user_id") AND Len(SESSION.user_id) GT 0>
							<li><a href="/profile/index.cfm?logout=yes">Log Out</a></li>
						<cfelse>
							<li><a href="/auth/">Login</a></li>
							<li><a href="/auth/?page=user&amp;create=1">Create Account</a></li>
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