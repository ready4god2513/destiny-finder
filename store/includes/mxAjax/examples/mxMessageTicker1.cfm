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
					paramArgs: "",
					executeOnLoad: true,
					messageDisplayIntervel: 5000,
					source: "messageContainer"
				});
			}
			addOnLoadEvent(function() {init();});
		</script>
		<style type="text/css">
			h2,h3,p{margin: 0 10px}
			h2{font-size: 200%;color: #f0f0f0}
			h3{font-size: 150%;color: #f0f0f0}
			h2{padding-top: 0.3em}
			#nifty{ margin: 0 0%;background: #c8c878}
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
		
		
		<h1>Using Message Ticker Component</h1>
		<div id="nifty" style="width:500px">
			<b class="rtop"><b class="r1"></b><b class="r2"></b><b class="r3"></b><b class="r4"></b></b>
			<h3>Scrolling Message Ticker</h3>
			<hr size="1" width="100%">
			<div style="width:482px; height:100px; overflow-y:hidden;position:relative; border:0px; left:8px; right:8px; bottom:0px" id="messageContainer">
				<div id="message1" style="height:100px">
					MEXICO CITY (Reuters) - Mexico's leftist opposition leader angrily vowed to push ahead with street protests that have paralyzed the capital after a top court on Saturday rejected his demand for a full recount in a presidential vote he says was stolen from him
				</div>
				<div id="message2" style="height:100px">
					UNITED NATIONS (Reuters) - The United States and France completed on Saturday a U.N. Security Council draft resolution calling for a halt in fighting between <font color=red>Israel and Hizbollah militia</font> as a first step toward a permanent peace
				</div>
				<div id="message3" style="height:100px">
					NEW YORK (Reuters) - There is no evidence that senior Pentagon commanders intentionally provided false testimony to about the military's actions on the morning of the September 11 attacks, according to a report by the Defense Department's watchdog agency cited in the New York Times.	
				</div>
			</div>
			<hr size="1" width="100%">
			<b class="rbottom"><b class="r4"></b><b class="r3"></b><b class="r2"></b><b class="r1"></b></b>
		</div>
		
		
	</body>
</html>