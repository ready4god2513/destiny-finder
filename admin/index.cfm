<cfinclude template="checksession.cfm"> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

<title>Webvision Control Panel: <cfoutput>#Application.sitename#</cfoutput></title>
<link rel="stylesheet" href="css/content.css" type="text/css" />
<link rel="stylesheet" href="css/ui.css" type="text/css" />
	
<!--[if IE]>
	<script type="text/javascript" src="scripts/excanvas-compressed.js"></script>		
<![endif]-->
	
<script type="text/javascript" src="scripts/mootools-1.2-core.js"></script>
<script type="text/javascript" src="scripts/mootools-1.2-more.js"></script>	

<!--
	mocha.js.php is for development. It is not recommended for production.
	For production it is recommended that you used a compressed version of either
	the output from mocha.js.php or mocha.js. You could also list the
	necessary source files individually here in the header though that will
	create a lot more http requests than a single concatenated file.-->
		
<script type="text/javascript" src="scripts/mocha.js"></script>


<!-- <script type="text/javascript" src="scripts/source/Utilities/mocha.js.php"></script> -->

<script type="text/javascript" src="scripts/mocha-init.js"></script>

</head>
<body>

<div id="desktop">

<div id="desktopHeader">
<div id="desktopTitlebarWrapper">
	<div id="desktopTitlebar">
		<div id="topNav">
			<ul class="menu-right">
				<li>Welcome <cfoutput>#session.name#</cfoutput></li>
				<li><a href="logout.cfm">Logout</a></li>
			</ul>
		</div>
	</div>
</div>
	
<div id="desktopNavbar">
	<ul>
	<li><a href="#" onclick="Reload();">Refresh Site</a></li>
	<li><a class="returnFalse" href="">Manage Content</a>	
		<ul id="dropdown">
			<li><a id="manageHomeCheck" href="" >Misc Content Blocks</a></li> 
			<li><a id="gatewayLinkCheck" href="">Pages</a></li>
		</ul>
	</li>
	<li><a class="returnFalse" href="">Manage Assessment</a>	
		<ul id="dropdown">
			<li><a id="gift" href="" >Gifts</a></li> 
			<li><a id="assessment" href="" >Assessments</a></li> 
		</ul>
	</li>
	<li><a class="returnFalse" href="">Manage Blog</a>	
		<ul id="dropdown">
			<li><a id="blog_home">Blog Home/Misc</a></li>
			<li><a id="author">Blog Authors</a></li>
			<li><a id="post_categories" href="">Categories</a></li>
			<li><a id="posts" href="">Posts</a></li>
			<li><a id="posttemp" href="">Pending Post Updates <!--- <cfif qTempStories.recordcount GT 0><span style="color:#ff0000;">[<cfoutput>#qTempStories.recordcount#</cfoutput>]</span></cfif>---></a></li>
			<li><a id="comment" href="">Comments</a></li>
		</ul>		
	</li>
	<li><a id="userCheck" href="">Users</a></li>
</ul>



	
</div><!-- desktopNavbar end -->
</div><!-- desktopHeader end -->

<div id="dockWrapper">
	<div id="dock">
		<div id="dockPlacement"></div>
		<div id="dockAutoHide"></div>
		<div id="dockSort"><div id="dockClear" class="clear"></div></div>
	</div>
</div>

<div id="pageWrapper"></div> 

<div id="desktopFooterWrapper">
	<div id="desktopFooter">
&nbsp;
	</div>
</div>

</div><!-- desktop end -->

</body>
</html>