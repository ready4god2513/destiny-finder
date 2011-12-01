<html>
	<head>
		<title>Tab Panel - getting CF data return</title>
		<script type='text/javascript' src='../core/js/prototype.js'></script>
		<script type='text/javascript' src='../core/js/scriptaculous.js'></script>
		<script type='text/javascript' src='../core/js/mxAjax.js'></script>
		<script type='text/javascript' src='../core/js/mxTabPanel.js'></script>
		<script language="javascript">
			var url = "<cfoutput>#ajaxUrl#</cfoutput>";

			function executeAjaxTab(elem, params) {
				var aj_tabPanel = new mxAjax.TabPanel({
				paramArgs: new mxAjax.Param(url,{param:params, cffunction:"makeAndDescription"}),
				target: "tabContent",
				panelId: "tabPanel",
				parser: new mxAjax.ParseJson({path:".description"}),
				source: elem,
				currentStyleClass: "ajaxCurrentTab"
				});
			}
			
			function init() {
				executeAjaxTab(null, 'make=Nokia');
			}

			addOnLoadEvent(function() {init();});
		</script>
		<LINK REL="stylesheet" type="text/css" href="style.css">
		<link rel="stylesheet" type="text/css" href="style.css"/>
	</head>
	<body>
		
		
		<h3>Tab Panel - getting multiple return data</h3>
		<div id="tabPanelWrapper">
			<div id="tabPanel" class="tabPanel">
				<ul>
		  			<li><a class="ajaxCurrentTab" href="javascript://" onclick="executeAjaxTab(this, 'make=Nokia'); return false;">Nokia</a></li>
		  			<li><a href="javascript://" onclick="executeAjaxTab(this, 'make=Motorolla'); return false;">Motorolla</a></li>
		  			<li><a href="javascript://" onclick="executeAjaxTab(this, 'make=Samsung'); return false;">Samsung</a></li>
				</ul>
			</div>
			<div id="tabContent" class="tabContent"></div>
			<p>Page loaded at: <cfoutput>#now()#</cfoutput></p>
		</div>
		
		
	</body>
</html>