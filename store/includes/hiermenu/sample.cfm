<cfprocessingdirective pageencoding="iso-8859-1">
<cfimport taglib="CustomTags/tmt_hiermenu/" prefix="tmt">
<cfparam name="url.skin" default="blue_gray.css" type="string">
<cfsetting showdebugoutput="no">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>hiermenu</title>
<style type="text/css">
	body, html {

		font-family: Verdana, Geneva, Arial, Helvetica, sans-serif;
	}
	img{
		border: 0;
	}
	#doc{
		clear: left;
		float: left;
		margin-left: 0.5em;
		margin-top: 1.0em;
		width: 42em;
	}
</style>
</head>
<body>

<tmt:hierbar css="#url.skin#">
	<tmt:hieritem id="xx" class="ppp" label="Home" href="http://www.olimpo.ch/tmt/" title="Back to CF goodies" />
	<tmt:hiermenu label="Dreamweaver">
		<tmt:hieritem href="http://www.massimocorner.com/" label="Massimocorner" />
		<tmt:hieritem href="http://www.dwfaq.com/" label="DWfaq" />
		<tmt:hieritem href="http://www.projectseven.com/" label="Project VII" />
		<tmt:hieritem href="http://www.yaromat.com/" label="Yaromat" />
	</tmt:hiermenu>
	<tmt:hieritem label="Macromedia" href="http://www.macromedia.com/" />
	<tmt:hiermenu label="ColdFusion">
		<tmt:hieritem href="http://www.macromedia.com/software/coldfusion/" label="Macromedia" />
		<tmt:hieritem href="http://www.cflib.org/" label="cflib" />
		<tmt:hieritem href="http://www.cfmentor.com/" label="cfmentor" />
		<tmt:hiermenu label="Ben Forta">
			<tmt:hieritem href="http://www.forta.com/" label="Website" />
			<tmt:hieritem href="http://www.forta.com/blog/" label="Blog" />
			<tmt:hieritem href="http://www.forta.com/books/" label="Books" />
		</tmt:hiermenu>
		<tmt:hiermenu label="Mailing lists">
			<tmt:hieritem href="http://www.houseoffusion.com/cf_lists/" label="CF-Talk" />
			<tmt:hieritem href="http://www.cfczone.org/listserv.cfm" label="CFCDev" />
		</tmt:hiermenu>
	</tmt:hiermenu>
	<tmt:hiermenu label="Change skin" title="Select a different skin">
		<tmt:hieritem href="#GetFileFromPath(GetTemplatePath())#?skin=flat_blue.css" label="Flat Blue" />
		<tmt:hieritem href="#GetFileFromPath(GetTemplatePath())#?skin=blue_gray.css" label="Blue Gray" />
		<tmt:hieritem href="#GetFileFromPath(GetTemplatePath())#?skin=blue_vertical.css" label="Blue Vertical" />
		<tmt:hiermenu id="office" label="Office 2003">
			<tmt:hieritem href="#GetFileFromPath(GetTemplatePath())#?skin=office2003_green.css" label="Green" />
			<tmt:hieritem href="#GetFileFromPath(GetTemplatePath())#?skin=office2003_blue.css" label="Blue" />
			<tmt:hieritem href="#GetFileFromPath(GetTemplatePath())#?skin=office2003_silver.css" label="Silver" />			
		</tmt:hiermenu>
	</tmt:hiermenu>
</tmt:hierbar>

<div id="doc">
	<p>This specific demo works fine in IE 5.x only with the &quot;Flat Blue&quot; skin. That's due to the fact I used borders and margins that let the box model in this browser go crazy. Fixing it is easy, just change a few values inside the CSS file and make IE 5.x happy as well.</p>
	<p>The whole look and feel is completely driven by the CSS file, so we will be able to create different menus (including horizontal ones), by just pointing to a different CSS file. Basically, every CSS can be a skin on its own. By the way, if you would like to share a custom skin, please contact me, I would be more than happy to include it inside the distribution.</p>
	<p>Very special thanks to <a href="http://bellavite.com/">Giampaolo Bellavite</a> for the Office 2003 skins</p>
</div>

</body>
</html>
