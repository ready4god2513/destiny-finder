<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>Populating Drop down list with Coldfusion Array</title>
		<script type='text/javascript' src='../core/js/prototype.js'></script>
		<script type='text/javascript' src='../core/js/mxAjax.js'></script>
		<script type='text/javascript' src='../core/js/mxMessageTicker.js'></script>
		<script language="javascript">
			var url = "<cfoutput>#ajaxUrl#</cfoutput>";
	
			function init() {
				new mxAjax.MessageTicker({
					parser: new mxAjax.CFArrayToJSArray(),
					executeOnLoad: true,
					source: "messageContainer", 
					messageDisplayIntervel: 5000,
					paramArgs: new mxAjax.Param(url,{cffunction:"getMessageTickerData"})
				});
			}
			addOnLoadEvent(function() {init();});
		</script>
		<style type="text/css">
			h2,h3,p{margin: 0 10px}
			h2{font-size: 200%;color: #f0f0f0}
			h3{font-size: 150%;color: #f0f0f0}
			p{padding-bottom:1em}
			h2{padding-top: 0.3em}
			div#nifty{ margin: 0 0%;background: #9BD1FA}
			b.rtop, b.rbottom{display:block;background: #FFF}
			b.rtop b, b.rbottom b{display:block;height: 1px;  overflow: hidden; background: #9BD1FA}
			b.r1{margin: 0 5px}
			b.r2{margin: 0 3px}
			b.r3{margin: 0 2px}
			b.rtop b.r4, b.rbottom b.r4{margin: 0 1px;height: 2px}
		</style>
		<link rel="stylesheet" type="text/css" href="style.css"/>
	</head>
	<body>
		
		
		<h1>Dynamic Message Ticker</h1>
		<div id="nifty" style="width:400px">
			<b class="rtop"><b class="r1"></b><b class="r2"></b><b class="r3"></b><b class="r4"></b></b>
			
			<h3>Scrolling Dynamic Message Ticker</h3>
			<hr size="1" width="100%">
			<div style="width:384px; height:100px; overflow-y:hidden;position:relative; border:0px; left:8px; right:8px;" id="messageContainer"></div>
			
			<b class="rbottom"><b class="r4"></b><b class="r3"></b><b class="r2"></b><b class="r1"></b></b>
		</div>
		
		
	</body>
</html>