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
<cfparam name="ATTRIBUTES.gateway_id" default="">
<cfparam name="ATTRIBUTES.header_image" default="">
<cfparam name="URL.page" default="">
<cfparam name="URL.gateway" default="">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
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
  <script type="text/javascript" src="/site_scripts/jquery.min.js"></script>
  <script type="text/javascript" src="/site_scripts/jquery_easing.js"></script>
  <script type="text/javascript" src="/site_scripts/jquery.fancybox-1.2.1.js"></script>
  <script type="text/javascript" src="/site_scripts/pngfix.js"></script>
  <script type="text/javascript" src="/site_scripts/jquery.hoverIntent.minified.js"></script>
  <script type="text/javascript" src="/site_scripts/superfish.js"></script>
  <script type="text/javascript" src="/site_scripts/dropdowns.js"></script>
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
<link rel="stylesheet" type="text/css" href="site_styles/home.css">
<link rel="stylesheet" type="text/css" href="site_scripts/fancy.css">
</head>
<body>
<div class="site_wrapper">
  <div class="head">
    <div class="head_logo"><img src="site_images/transparent.png" width="345" height="110" usemap="#head_logo"></div>
    	<map name="head_logo"><area shape="rect" coords="0,0,345,110" href="/"></map>
  		<form action="#" method="post" enctype="application/x-www-form-urlencoded">
   	<div class="head_search">
      	<div id="head_search_input">
         <input type="text" class="head_search_input_field" onFocus="this.value='';" value="Search">
     	</div><!---<div class="head_search_input">--->
		<div class="head_search_button">
			<input type="image" value="submit_search" src="site_images/head_search_btn.gif" alt="" name="submit_search"> 
		</div><!---<div class="head_search_button">--->
		<div id="head_menu_links">
			<a href="index2.cfm">Help</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="#">Contact</a>&nbsp;&nbsp;|<a href="#"><img src="site_images/head_btn_social_fb.gif" class="head_social_button" width="16" height="16"></a><a href="#"><img src="site_images/head_btn_social_t.gif" class="head_social_button" height="16"></a>
		</div><!---<div class="head_menu_links">--->
    </div><!---<div class="head_search">--->
		</form>
        <div style="width:45px;float:left;margin:15px 0px 0px 527px;">&nbsp;<cfif isDefined("SESSION.user_id") AND val(SESSION.user_id) GT 0><a href="/profile/index.cfm?logout=yes">Logout</a></cfif></div>
  </div><!---<div class="head">--->
  <div class="head_gnav">
    <ul class="sf-menu">
      <li><a href="/index2.cfm"><span>Home</span></a></li>
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
   <div class="head_gnav_signin"><cfif isDefined("SESSION.user_id") AND Len(SESSION.user_id) GT 0><a href="/profile/index.cfm?page=user" id="link_myaccount">My Account</a><cfelse><a href="/profile/">SIGN IN</a></cfif></div><!-- <div class="head_gnav_signin"> -->
   <div class="banner_wrapper">
   		<img src="site_images/bnr_discover_your_destiny_c.jpg" width="588px" height="291px" style="float:left;">
		<a href="/auth/index.cfm?page=user&create=1"><img class="banner_content" src="site_images/banner_promo_box.png" border="0" width="392px" height="373"></a>
   </div><!-- <div class="banner_wrapper"> -->
   
   <div class="body_content">
   		<div class="section_wrapper" style="height: 360px;">
			<div><h1>Destiny Guide 1.0</h1></div>
            <div class="section_content"><div style="width:90px; height:236px; float:left; margin-right:8px;"><img src="site_images/pic_destiny_guide_1.0.jpg" width="90" height="92"></div>
           <div class="section_content_text">
                    The Destiny Survey is just the first step of the Destiny Guide 1.0 System. The Destiny Guide System is based on 30 years of helping people discover their destiny. It contains:
                    <ul>
                        <li>The <strong>Destiny Profiler</strong>, a comprehensive assessment of 10 dimensions of gifting, core traits, personality, personal passion and more.</li>
                        <li>The <strong>Destiny Planner</strong>, a coach-directed, individualized action plan based on your profile.</li>
                        <li>The <strong>Destiny Activator</strong>, in which a coach helps you find a mentor and an opportunity to use your gifts in your target area.</li>
                    </ul>
                </div><!-- <div class="section_content_text"> -->
            </div><!-- <div class="section_content"> -->
		</div><!-- <div class="section_wrapper"> -->
        
        <div class="section_wrapper" style="height: 360px;">
            <div><h2>Testimonials</h2></div>
            <div class="section_content">
            	<iframe width="304" height="206" src="http://www.youtube.com/embed/MfMwV6rMjiQ" frameborder="0" allowfullscreen></iframe>
            <!---<a id="destinyvid" title="Fullfill Your Destiny" href="http://www.youtube.com/watch?v=MfMwV6rMjiQ&feature=player_embedded#at=41"><img style="margin-left:16px" src="site_images/btn_videoplayer.png" width="270" height="147"></a>---></div><!-- <div class="section_content"> -->
        </div> <!--<div class="section_wrapper">-->

        <div class="section_wrapper">
            <div><h3>News</h3></div>
            <div class="section_content">
            	<div class="section_content_text" style="width:290px;">Destiny Guide 1.0 launches at Jesus Culture
                <p>DestinyFinder's flagship product, Destiny Guide 1.0, will make its official launch at the Jesus Culture Awakening conference Aug. 3-5, 2011 at Allstate Arena, Chicago.<br /><!---<a href="#">More...</a>---></p>
                </div><!--<div class="section_content_text">-->
            </div><!-- <div class="section_content"> -->
		</div> <!--<div class="section_wrapper">-->
        
        <div class="section_wrapper">
            <div><h4>Ask Michael</h4></div>
            <div class="section_content">
              <div style="width:90px; height:200px; float:left; margin-right:8px;"><img src="site_images/pic_michael_sm.jpg" width="90" height="82"></div>
                <div class="section_content_text">Ask Michael Brodeur,
                    <p>DestinyFinder CEO, what is your most burning question about finding your destiny.<br /><a href="#">Ask Now...</a></p>
                </div><!-- <div class="section_content_text"> -->
            </div><!--<div class="section_content">--> 
   		</div><!--<div class="section_wrapper">-->
   </div>
   
   <div class="body_right_col">
   <div class="rt_col_section_wrapper">
			<h2>Destiny Guide 1.0</h2>
            <div style="width:90px; height:236px; float:left; margin-right:4px;"><img src="site_images/pic_destiny_guide_1.0.jpg" width="90" height="92"></div>
           <div class="section_content_text">
                    The Destiny Survey is just the first step of the Destiny Guide 1.0 System. The Destiny Guide System is based on 30 years of helping people discover their destiny. It contains:
                    <ul>
                        <li>The <strong>Destiny Profiler</strong>, a comprehensive assessment of 10 dimensions of gifting, core traits, personality, personal passion and more.</li>
                        <li>The <strong>Destiny Planner</strong>, a coach-directed, individualized action plan based on your profile.</li>
                        <li>The <strong>Destiny Activator</strong>, in which a coach helps you find a mentor and an opportunity to use your gifts in your target area.</li>
                    </ul>
                </div><!-- <div class="section_content_text"> -->
         <br class="clear" />   
        <a href="/blog/"><img style="margin:10px 0 0 3px;" src="site_images/btn_blog_read_latest.jpg" width="263" height="80" /></a>
		</div><!-- <div class="section_wrapper"> -->
   </div><!---<div class="body_right_col">--->

<!--    FOOTER BEGINS HERE      -->
   <div class="footer_wrapper">
   		<div class="footer_menu_cols">
            <a href="/index2.cfm">Home</a><br />
            <a href="/about/index.cfm">About Us</a>   
        </div>
        <div class="footer_menu_cols">
        	<a href="/surveys/index.cfm">Our Approach</a><br />
            <a href="/products/index.cfm">Products &amp; Services</a>            
        </div>
        <div class="footer_menu_cols">
            <a href="/coaching/index.cfm">Coaching</a><br />
            <a href="#">Online Store</a>
        </div> 
        <div class="footer_menu_cols">
            <a href="/free/index.cfm">Resources</a><br />
            <a href="#">Help</a>
        </div> 
        <div class="footer_menu_cols">
            <a href="/blog/">Blog</a><br />
            <a href="#">Legal</a>
        </div> 
        
   		<!---<div class="footer_nav_wrapper">
			<ul class="footer_nav_wrapper">
				<li style="margin-right: 50px;"><a href="#">Home</a></li>
				<li style="margin-right: 28px;"><a href="#">Products &amp; Services</a></li>
				<li style="margin-right: 48px;"><a href="#">Coaching</a></li>
				<li style="margin-right: 32px;"><a href="#">Free Resources</a></li>
				<li style="margin-right: 32px;"><a href="#">Site Map</a></li>
			</ul><!-- <ul class="footer_links_1"> -->
            <br />
			<ul class="footer_nav_wrapper">
				<li style="margin-right: 32px;"><a href="#">About Us</a></li>
				<li style="margin-right: 65px;"><a href="#">Assessments</a></li>
				<li style="margin-right: 32px;"><a href="#">Online Store</a></li>
				<li style="margin-right: 93px;"><a href="#">Help</a></li>
				<li style="margin-right: 32px;"><a href="#">Legal</a></li>
			</ul><!-- <ul class="footer_links_2"> -->
		</div><!-- <div class="footer_nav_wrapper"> -->--->
   </div><!-- <div class="footer_wrapper"> -->
   
   
</div><!-- class="site_wrapper" -->
<script>
		$(document).ready(function() 
			{
				 $("a.enlarge_link").fancybox(); 
			}); 
</script>
</body>
</html>
