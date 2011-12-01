
<!--- CFWebstore�, version 6.43 --->

<!--- CFWebstore� is �Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This is the layout page for the entire store. Edit it as much as you desire using the components below. Your store can use more than one layout page.  Lay_default.cfm will be the site's default layout. Additional layouts can be created and named. You can attach a custom layout page to a Palette that you create in the Palette Admin. The Palette can then be assigned to an individual Category, Product, Feature, or Page. --->

<!--- This file must be included at the top of all CFWebstore layout pages! Creates the header section and additional code needed by the software --->	
<cfinclude template="put_layouthead.cfm">

<!--- Style sheet(s) for the layout --->	
<cfquery name="qBlocks" datasource="#REQUEST.DSN#">
	SELECT * FROM MiscContent
</cfquery>
<cfquery name="qGateways" datasource="#REQUEST.DSN#">
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
<cfoutput>
  <cfif LEN(ATTRIBUTES.meta_desc) GT 0>
    <meta name="description" content="#ATTRIBUTES.meta_desc#" />
  </cfif>
</cfoutput>
<link rel="stylesheet" type="text/css" href="/site_styles/home.css">

<div class="site_wrapper">
  <div class="head">
    <div class="head_logo"><img src="../site_images/transparent.png" width="345" height="110" usemap="#head_logo"></div>
    	<map name="head_logo"><area shape="rect" coords="0,0,345,110" href="http://www.destinyfinder.com/index2.cfm"></map>
  		<form action="#" method="post" enctype="application/x-www-form-urlencoded">
   	<div class="head_search">
      	<div id="head_search_input">
         <input type="text" class="head_search_input_field" onFocus="this.value='';" value="Search">
     	</div><!---<div class="head_search_input">--->
		<div class="head_search_button">
			<input type="image" value="submit_search" src="../site_images/head_search_btn.gif" alt="" name="submit_search"> 
		</div><!---<div class="head_search_button">--->
		<div id="head_menu_links">
			<a href="index.cfm">Help</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="#">Contact</a>&nbsp;&nbsp;|<a href="#"><img src="../site_images/head_btn_social_fb.gif" class="head_social_button" width="16" height="16"></a><a href="#"><img src="../site_images/head_btn_social_t.gif" class="head_social_button" height="16"></a>
		</div><!---<div class="head_menu_links">--->
    </div><!---<div class="head_search">--->
		</form>
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
   <div class="head_gnav_signin"><a href="#">SIGN IN</a></div><!-- <div class="head_gnav_signin"> -->

<!--- Creates the body tag with background image and colors set by the palette. --->
<cfinclude template="put_body.cfm">

<table border="0" cellspacing="0" cellpadding="0" width="620" style="margin-left: 20px;">

<!--- The page has three columns: left menu, spacer, and body 
The column widths are set in this first row. Change the spacer.gif width to adjust columns.----->
<tr>  
	<td><img src="images/spacer.gif" height="1" alt="" width="160" border="0" /></td>
	<td><img src="images/spacer.gif" height="1" alt="" width="30" border="0" /></td>
	<td><img src="images/spacer.gif" height="1" alt="" width="675" border="0" /></td>
</tr>

<!--- Logo/Store title row ------------------------------->
<tr>
 <td colspan="3">
 
 <table width="100%" border="0">
  <tr>
 
  <td align="left" width="50%">
  <span style="font-size: large;">
  <cfinclude template="put_sitelogo.cfm">
  </span>
  </td>
  <td align="right" width="50%">

  <!--- Output the storewide discounts and shopping cart totals --->
	<cfinclude template="put_topinfo.cfm">  

  </td> 
 </tr>
 </table>
 
 </td> 
</tr> 

<!--- Breadcrumb Trail Menu Row--------------->
<tr>
	<td></td>
	<td colspan="2"  class="menu_trail">
	<cfinclude template="put_breadcrumb.cfm">
	</td>
</tr>

<!---- SPACER ROW below trail menu. ------->
<tr> 
    <td colspan="3"><img src="images/spacer.gif" alt="" height="20" width="1" border="0" /></td>
</tr>

<!---- Main Body Row -------->
<tr>
	<!---- MENU COLUMN------->
	<td valign="top" align="right">
				
		<!--- Menu of Top Level Categories and Pages ---->
		<cfinclude template="put_sidemenus.cfm">
			
		<!--- Links for admins --->		
		<cfinclude template="put_adminlinks.cfm">	
		
		<!--- An optional persistent search box --->		
		<cfinclude template="put_searchbox.cfm">	
		
		<!--- An optional persistent log-in box -- the site works perfectly well without --->
		<cfinclude template="put_loginbox.cfm">			
			
	</td>
	
	<!---- SPACER COLUMN between menu and content ------->
	<td>&nbsp;</td>
	
	<!---- PAGE CONTENT ------->
	<td valign="top" class="mainpage">
	
		<!--- THIS IS WHERE ALL GENERATED PAGE CONTENT GOES ---->
		<!-- Compress to remove whitespace -->
		<cfoutput>#HTMLCompressFormat(fusebox.layout)#</cfoutput>
	
	</td>
</tr>

<!---- Footer Menus ------->
<tr>
	<td valign="top" align="right"></td>
	<td colspan="2" align="center">
		
		<p>&nbsp;</p>
		
		<!--- horizontal category and page menus --->
		<cfinclude template="put_bottommenus.cfm">
		
		<!--- copyright/merchant line --->	
		<cfinclude template="put_copyright.cfm">

		
	</td>	
</tr>
</table>
	<!--    FOOTER BEGINS HERE      -->
   <div class="footer_wrapper">
   		<div class="footer_menu_cols">
            <a href="/index.cfm">Home</a><br />
            <a href="/about/">About Us</a>   
        </div>
        <div class="footer_menu_cols">
            <a href="/products/">Products &amp; Services</a><br />
            <a href="/profile/?page=profiler">Destiny Guide 1.0</a>          
        </div>
        <div class="footer_menu_cols">
            <a href="/coaching/">Coaching</a><br />
            <a href="/store/">Store</a>
        </div> 
        <div class="footer_menu_cols">
            <a href="/free/">Resources</a><br />
            <a href="#">Help</a>
        </div> 
        <div class="footer_menu_cols">
            <a href="/blog/">Blog</a><br />
            <a href="/privacy/">Privacy</a>
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
<!--- Allow debug variables list to display only for Administrators when &debug=1 is included in URL. --->
   </div><!-- class="site_wrapper" -->
<cfinclude template="put_debug.cfm">

</body>
</html>

	