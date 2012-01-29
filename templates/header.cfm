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
	<script src="/assets/scripts/libraries/modernizr.js"></script>
	<script src="/assets/scripts/libraries/bootstrap.dropdown.js"></script>
	<script src="/assets/scripts/libraries/jquery.metadata.js"></script>
	<script src="/assets/scripts/libraries/jquery.cycle.js"></script>
	<script src="/assets/scripts/libraries/jquery.form.js"></script>
	<script src="/assets/scripts/libraries/jquery.sortable.js"></script>
	<script src="/assets/scripts/libraries/jquery.hoverIntent.minified.js"></script>
	<script src="/assets/scripts/libraries/jquery.validate.min.js"></script>
	<script src="/assets/scripts/libraries/jquery_easing.js"></script>
	<script src="/assets/scripts/main.js"></script>


	<cfif isDefined("ATTRIBUTES.additionalStyles")>
		<cfloop array="#ATTRIBUTES.additionalStyles#" index="style">
			<cfoutput><link rel="stylesheet" href="#style#" type="text/css" media="screen" charset="utf-8" /></cfoutput>
		</cfloop>
	</cfif>

	<link rel="stylesheet" type="text/css" href="/assets/styles/main.css" />
</head>
<body>
	<div class="container">
	      <div class="content">
			<header id="top">
				<div class="row">
					<div class="span6">
						<a href="/"><img src="/assets/images/logo.png" id="header-logo" /></a>
					</div>

					<nav class="pull-right span10">
						<ul>
							<li><a href="https://destinyfinder.foxycart.com/cart">Cart</a></li>
							<li><a href="/pages/?page=support">Support</a></li>
							<cfif isDefined("SESSION.user_id") AND Len(SESSION.user_id) GT 0>
								<li><a href="/auth/account">My Account</a></li>
								<li><a href="/profile/?logout=yes">Log Out</a></li>
							<cfelse>
								<li><a href="/auth/">Login / Sign Up</a></li>
							</cfif>
						</ul>
					</nav>
				</div>
			</header>

			<div class="topbar-wrapper">
				<div class="topbar" data-dropdown="dropdown" >
					<div class="topbar-inner">
						<div class="container">
							<ul class="nav">
								<li><a href="/index.cfm"><span>Home</span></a></li>
								<cfoutput query="qGateways">
									<li class="dropdown">
										<a href="##" class="dropdown-toggle">#qGateways.gateway_name#</a>
										<cfmodule template="/customtags/sub_menu_multi.cfm"
											gateway="#qGateways.gateway_id#"	
											gateway_page_name="#qGateways.gateway_name#"
											gateway_path="#qGateways.gateway_path#"		
											parent_gateway="#qGateways.gateway_id#">
									</li>
								</cfoutput>
								<li><a href="/store">Store</a></li>
								<cfif isDefined("SESSION.user_id") AND Len(SESSION.user_id) GT 0>
									<li><a href="/auth/account">My Account</a></li>
								</cfif>
							</ul>
						</div>
					</div>
				</div>
			</div>