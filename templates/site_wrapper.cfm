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
<script type="text/javascript" src="/site_scripts/jquery_easing.js"></script>
<script type="text/javascript" src="/site_scripts/jquery.fancybox-1.2.1.js"></script>
<script type='text/javascript' src='https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.16/jquery-ui.min.js'></script>
<script type="text/javascript" src="/site_scripts/pngfix.js"></script>
<script type="text/javascript" src="/site_scripts/jquery.hoverIntent.minified.js"></script>
<script type="text/javascript" src="/site_scripts/superfish.js"></script>
<script type="text/javascript" src="/site_scripts/jquery.form.js"></script>
<script type="text/javascript" src="/site_scripts/pngfix.js"></script>
<script type="text/javascript" src="/site_scripts/dropdowns.js"></script>

<link rel="stylesheet" type="text/css" href="/site_styles/fancybox.css">
  <script>
	$(document).ready(function() {
		jQuery(function(){
				jQuery('ul.sf-menu').superfish();
			});
	});
  </script>
  <cfif LEN(ATTRIBUTES.meta_desc) GT 0>
    <meta name="description" content="#ATTRIBUTES.meta_desc#" />
  </cfif>
</cfoutput>
<link rel="stylesheet" type="text/css" href="/site_styles/main.css">

<!--[if IE 7]>
<link rel="stylesheet" type="text/css" href="/site_styles/ie7.css">
<![endif]-->
<!--[if IE 8]>
<link rel="stylesheet" type="text/css" href="/site_styles/ie8.css">
<![endif]-->

<link rel="stylesheet" type="text/css" href="/site_styles/word_sort.css">
</head>
<body>
<div class="site_wrapper">
  <div class="head">
    <div class="head_logo"><img src="../site_images/transparent.png" width="345" height="110" usemap="#head_logo"></div>
    	<map name="head_logo"><area shape="rect" coords="0,0,345,110" href="http://www.destinyfinder.com/"></map>
  		<form action="#" method="post" enctype="application/x-www-form-urlencoded">
   	<div class="head_search">
      	<div id="head_search_input">
         <input type="text" id="head_search_input_field" onFocus="this.value='';" value="Search">
     	</div><!---<div class="head_search_input">--->
		<div class="head_search_button">
			<input type="image" value="submit_search" src="../site_images/head_search_btn.gif" alt="" name="submit_search"> 
		</div><!---<div class="head_search_button">--->
		<div id="head_menu_links">
			<a href="index.cfm">Help</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="/about/?page=contact">Contact</a>&nbsp;&nbsp;|<a href="#"><img src="../site_images/head_btn_social_fb.gif" class="head_social_button" width="16" height="16"></a><a href="#"><img src="../site_images/head_btn_social_t.gif" class="head_social_button" height="16"></a>
		</div><!---<div class="head_menu_links">--->
    </div><!---<div class="head_search">--->
		</form>
        <!---<div style="width:45px;float:left;margin:15px 0px 0px 527px;">&nbsp;<cfif isDefined("SESSION.user_id") AND val(SESSION.user_id) GT 0><a href="index.cfm?logout=yes">Logout</a></cfif></div>--->
  </div><!---<div class="head">--->
  <div class="head_gnav">
    <ul class="sf-menu">
      <li><a href="/index.cfm"><span>Home</span></a></li>
          <cfoutput query="qGateways">
            <li class="head_gnav_menu <cfif qGateways.recordcount EQ qGateways.currentrow>sf-menu-last</cfif>"><a href="#qGateways.gateway_path##qGateways.gateway_landing_page#" <cfif ATTRIBUTES.gateway_id EQ qGateways.gateway_id>class="gateway_active"</cfif> ><span>#qGateways.gateway_name#</span></a>
              <cfmodule template="/customtags/sub_menu_multi.cfm"
                            gateway="#qGateways.gateway_id#"	
                            gateway_page_name="#qGateways.gateway_name#"
                            gateway_path="#qGateways.gateway_path#"		
                            parent_gateway="#qGateways.gateway_id#">
            </li>
		  </cfoutput>
     </ul>      
   </div><!---<div class="head_gnav">--->  
   <div class="head_gnav_signin"><cfif isDefined("SESSION.user_id") AND Len(SESSION.user_id) GT 0><a href="https://www.destinyfinder.com/profile/index.cfm?logout=yes">Log Out</a><cfelse><a href="/profile/">Log In</a></cfif></div><!-- <div class="head_gnav_signin"> -->
	
    
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
                <!---<li><a href="/profile/"<cfif isDefined("URL.page") AND Lcase(URL.page) EQ 'user'> style="background-color:#f7f1e4;margin-top:-2px;"</cfif>><span<cfif isDefined("URL.page") AND Lcase(URL.page) EQ 'user'> style="background-color:#f7f1e4;"</cfif>>Settings</span></a></li> --->
                <li><a href="/profile/?page=profiler"<cfif isDefined("URL.page") AND Lcase(URL.page) NEQ 'user'> style="background-color:#f7f1e4;margin-top:-2px;"</cfif>><span<cfif isDefined("URL.page") AND Lcase(URL.page) NEQ 'user'> style="background-color:#f7f1e4;"</cfif>>Profiler<!---Active Surveys---></span></a></li>
                <li><a href="#"><span>Planner</span></a></li>
                <li><a href="#"><span>Activator</span></a></li>
                <!---<li><a href="/profile/?page=viewresults"><span>Survey ResultActive Surveys</span></a></li>--->
                <!---<li><a href="#"><span>Completed Surveys</span></a></li>---> 
                </ul>
              </div><!--<div id="subpage_nav">-->
		  </cfif>   
        </div><!--<div class="subpage_banner">-->	
     
        
			<div class="body_content">
<cfelse>
			</div> 
            <div style="background-color:#F7F1E4;"><br class="clear" /></div>
<!--    FOOTER BEGINS HERE      -->
   <div class="footer_wrapper">
   		<div class="footer_menu_cols">
            <a href="/index.cfm">Home</a><br />
            <a href="/about/">About Us</a>   
        </div>
        <div class="footer_menu_cols">
            <a href="/products/">Products &amp; Services</a><br />     
            <a href="/profile/">Destiny Guide 1.0</a>     
        </div>
        <div class="footer_menu_cols">
            <a href="/coaching/">Coaching</a><br />
            <!---<a href="/store/">Store</a>--->
        </div> 
        <div class="footer_menu_cols">
            <a href="/free/">Resources</a><br />
            <a href="/about/index.cfm?page=contact">Contact</a>
        </div> 
        <div class="footer_menu_cols">
            <!---<a href="/blog/">Blog</a><br />--->
            <a href="/privacy/">Privacy</a>
        </div> 
   </div><!-- <div class="footer_wrapper"> -->
    <br class="clear" />
   
   </div><!-- class="site_wrapper" -->
</body>
</html>
</cfif>