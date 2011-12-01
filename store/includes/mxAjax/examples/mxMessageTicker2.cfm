
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>Populating Drop down list with Coldfusion Array</title>
		<script type='text/javascript' src='../core/js/prototype.js'></script>
		<script type='text/javascript' src='../core/js/mxAjax.js'></script>
		<script type='text/javascript' src='../core/js/mxMessageTicker.js'></script>
		<script language="javascript">
			function init() {
				new mxAjax.MessageTicker({
					executeOnLoad: true,
					messageDisplayIntervel: 8000,
					messageScrollCtr: 2,
					source: "messageContainer"
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
			.back{ margin: 0 0%;background: #c8c878}
			b.rtop, b.rbottom{display:block;background: #FFF}
			b.rtop b, b.rbottom b{display:block;height: 1px;  overflow: hidden; background: #c8c878}
			b.r1{margin: 0 5px}
			b.r2{margin: 0 3px}
			b.r3{margin: 0 2px}
			b.rtop b.r4, b.rbottom b.r4{margin: 0 1px;height: 2px}
		</style>
		<link rel="stylesheet" type="text/css" href="style.css"/>
	</head>
	<body>
		
		
		<h1>Another Message Ticker example</h1>
		<div id="imgTicker" class="back"  style="width:300px">
			<b class="rtop"><b class="r1"></b><b class="r2"></b><b class="r3"></b><b class="r4"></b></b>
			<hr size="1" width="100%">
			<div style="width:280px;height:280px; overflow-y:hidden;position:relative; border:0px; left:8px; right:8px; bottom:0px" id="messageContainer">
				<div id="message1" style="height:280px">
					<img src="http://ec3.images-amazon.com/images/P/B0007QKN22.01._AA280_SCLZZZZZZZ_V57223176_.jpg" height="280" width="280">
				</div>
				<div id="message2" style="height:280px">
					<img src="http://ec3.images-amazon.com/images/P/B0007QKN22.01.PT02._AA280_SCLZZZZZZZ_V57223176_.jpg" height="280" width="280">
				</div>
				<div id="message3" style="height:280px">
					<img src="http://ec3.images-amazon.com/images/P/B0007QKN22.01.PT03._AA280_SCLZZZZZZZ_V57223176_.jpg" height="280" width="280">
				</div>
				<div id="message4" style="height:280px">
					<img src="http://ec3.images-amazon.com/images/P/B0007QKN22.01.PT01._AA280_SCLZZZZZZZ_V57223176_.jpg" height="280" width="280">
				</div>
			</div>
			<hr size="1" width="100%">
			<b class="rbottom"><b class="r4"></b><b class="r3"></b><b class="r2"></b><b class="r1"></b></b>
		</div>
		
		
	</body>
</html>