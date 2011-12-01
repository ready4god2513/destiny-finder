<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>Simple Portlet</title>
		<script type='text/javascript' src='../core/js/prototype.js'></script>
		<script type='text/javascript' src='../core/js/scriptaculous.js'></script>
		<script type='text/javascript' src='../core/js/mxAjax.js'></script>
		<script type='text/javascript' src='../core/js/mxPortlet.js'></script>
	</head>
	<LINK REL="stylesheet" type="text/css" href="style.css">
	<link rel="stylesheet" type="text/css" href="style.css"/>
	<body>
		
		
		<h3>Simple Portlet</h3>
		<div id="portletArea">
			<div id="portlet_1" class="portletBox"><div id="portlet_1Tools" class="portletTools"><img id="portlet_1Refresh" class="portletRefresh" src="../core/images/refresh.png"/><img id="portlet_1Size" class="portletSize" src="../core/images/minimize.png"/><img id="portlet_1Close" class="portletClose" src="../core/images/close.png"/></div><div id="portlet_1Title" class="portletTitle">Demo Portlet</div><div id="portlet_1Content" class="portletContent"></div></div>
		</div>
		<script type="text/javascript">
			var url = "<cfoutput>#ajaxUrl#</cfoutput>";
			
			var aj_portlet_1 = new mxAjax.Portlet({
				executeOnLoad: true,
				paramArgs: new mxAjax.Param(url + '?htmlResponse=true',{cffunction:"getRandomFact"}),
				imageClose: "../core/images/close.png",
				imageRefresh: "../core/images/refresh.png",
				title: "Demo Portlet",
				classNamePrefix: "portlet",
				imageMaximize: "../core/images/maximize.png",
				imageMinimize: "../core/images/minimize.png",
				source: "portlet_1",
				refreshPeriod: "5"
			});
		</script>
		
		
	</body>
</html>