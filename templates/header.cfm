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
<link rel="stylesheet" type="text/css" href="/site_styles/home.css">
</head>
<body>
<div class="site_wrapper">
  <div class="head">
    <div class="head_logo"><img src="/site_images/transparent.png" width="345" height="110" usemap="#head_logo"></div>
    	<map name="head_logo"><area shape="rect" coords="0,0,345,110" href="/index2.cfm"></map>
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