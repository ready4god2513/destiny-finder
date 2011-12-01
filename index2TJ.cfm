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
<link rel="stylesheet" type="text/css" href="site_styles/home2.css">
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
   <div class="head_gnav_signin"><a href="#">SIGN IN</a></div><!-- <div class="head_gnav_signin"> -->
   <div class="banner_wrapper">
   		<img src="site_images/bnr_discover_your_destiny.jpg" width="588px" height="291px" style="float:left;">
		<img class="banner_content" src="site_images/banner_promo_box.png" width="392px" height="373">
   </div><!-- <div class="banner_wrapper"> -->
   
   <div class="body_content">
   		<div class="section_wrapper">
			<div><h1>DestinyFinder</h1></div>
            <div class="section_content"><div style="width:90px; height:236px; float:left; margin-right:8px;"><img src="site_images/pic_destiny_finder_1.0.jpg" width="90" height="92"></div>
                <div class="section_content_text">
                    The Destiny Survey is just the first step of the Destiny Guide 1.0 System, which contains:
                    <ul>
                        <li>The Destiny Profile, a comprehensive assessment of 10 dimensions of gifting, core traits, personality, personal passion and more.</li>
                        <li>The Destiny Planner, a coach-directed, individualized action plan based on your profile.</li>
                        <li>The Destiny Activator, in which a coach helps you find a mentor and an opportunity to use your 
              gifts in your target area.</li>
                    </ul>
                </div><!-- <div class="section_content_text"> -->
            </div><!-- <div class="section_content"> -->
		</div><!-- <div class="section_wrapper"> -->
        
        <div class="section_wrapper">
            <div><h2>Video Testimonials</h2></div>
            <div class="section_content"><img style="margin-left:16px" src="site_images/btn_videoplayer.png" width="270" height="147"></div><!-- <div class="section_content"> -->
        </div> <!--<div class="section_wrapper">-->
            
        <div class="section_wrapper">
            <div><h3>News</h3></div>
            <div class="section_content">
            	<div class="section_content_text">News headline here
                <p>News abstract here. Lorem ipsum dolor sit amet, conse cteuer adipiscing elit, sed diam nonummy nibh eusimod tincidunt ut.<br /><span>More...</span></p>
                </div><!--<div class="section_content_text">-->
            </div><!-- <div class="section_content"> -->
		</div> <!--<div class="section_wrapper">-->
        
        <div class="section_wrapper">
            <div><h4>Ask Michael</h4></div>
            <div class="section_content">
                <div style="width:90px; height:200px; float:left; margin-right:8px;"><img src="site_images/pic_askmichael.jpg" width="90" height="92"></div>
                <div class="section_content_text">Ask Michael Broduer,
                    <p>DestinyFinder CEO, what is your most burning question about finding your destiny.<br /><span>Ask Now...</span></p>
                </div><!-- <div class="section_content_text"> -->
            </div><!--<div class="section_content">-->
   		</div><!--<div class="section_wrapper">-->
   
   <div class="body_right_col">
   <img src="site_images/btn_blog_read_latest.jpg" width="263" height="80" />
   </div><!---<div class="body_right_col">--->

<!--    FOOTER BEGINS HERE      -->
   <div class="footer_wrapper">
   		<div class="footer_menu_cols">
            <a href="#">Home</a><br />
            <a href="#">About Us</a>   
        </div>
        <div class="footer_menu_cols">
            <a href="#">Products &amp; Services</a><br />
            <a href="#">Assessments</a>
        </div>
        <div class="footer_menu_cols">
            <a href="#">Coaching</a><br />
            <a href="#">Online Store</a>
        </div> 
        <div class="footer_menu_cols">
            <a href="#">Free Resources</a><br />
            <a href="#">Help</a>
        </div> 
        <div class="footer_menu_cols">
            <a href="#">Site Map</a><br />
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
</body>
</html>
