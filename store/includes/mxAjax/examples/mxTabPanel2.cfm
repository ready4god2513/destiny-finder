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
				paramArgs: new mxAjax.Param(url,{param:params, cffunction:"getContent"}),
				target: "tabContent",
				panelId: "tabPanel",
				source: elem,
				currentStyleClass: "ajaxCurrentTab"
				});
			}
			
			function init() {
				executeAjaxTab(null, 'id=1');
			}

			addOnLoadEvent(function() {init();});
		</script>
		<LINK REL="stylesheet" type="text/css" href="style.css">
		<link rel="stylesheet" type="text/css" href="style.css"/>
	</head>
	<body>
		
		
		<h3>Tab Panel - getting CF data return</h3>
		<div id="tabPanelWrapper">
			<div id="tabPanel" class="tabPanel">
				<ul>
		  			<li><a href="javascript://" onclick="executeAjaxTab(this, 'id=1'); return false;" class="ajaxCurrentTab">Requirements?</a></li>
		  			<li><a href="javascript://" onclick="executeAjaxTab(this, 'id=2'); return false;">Functional Req?</a></li>
		  			<li><a href="javascript://" onclick="executeAjaxTab(this, 'id=3'); return false;">Writing Requirements</a></li>
				</ul>
			</div>
			<div id="tabContent" class="tabContent"></div>
			<p>Page loaded at: <cfoutput>#now()#</cfoutput></p>
		</div>
		
		
	</body>
</html>