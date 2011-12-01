<html>
	<head>
		<title>Rico Accordion Component</title>
		<script type='text/javascript' src='../core/js/prototype.js'></script>
		<script type='text/javascript' src='../core/js/mxAjax.js'></script>
		<script type='text/javascript' src='../core/js/mxRicoAccordion.js'></script>
		<script language="javascript">
			var url = "<cfoutput>#ajaxUrl#</cfoutput>";
			
			function init() {
				new mxAjax.RicoAccordion( 'accordionExample', {panelHeight:227, onShowTab:onShowTab, executeOnLoad:true } ); 
				function onShowTab(tab) {
					new Ajax.Updater(tab.content.id, url + '?method=init&function=getRandomQuote&htmlResponse=true');
				}
			}
			addOnLoadEvent(function() {init();});
		</script>
	   	<style>
			#accordionExample { width : 350px; }
	   	</style>
	   	<LINK REL="stylesheet" type="text/css" href="style.css">
		<link rel="stylesheet" type="text/css" href="style.css"/>
	</head>
	<body>
		
		
		<h1>Dynamically loading data when a Tab is clicked</h1>
		<div style="margin-top:6px; border-top-width:1px; border-top-style:solid;" id="accordionExample">
			<div id="panel1">
				<div id="panel1Header" class="accordionTabTitleBar">
					Quote 1
				</div>
				<div id="panel1Content"  class="accordionTabContentBox">
					
				</div>
			</div>
		
			<div id="panel2">
				<div id="panel2Header" class="accordionTabTitleBar">
					Quote 2
				</div>
				<div id="panel2Content" class="accordionTabContentBox">
					
				</div>
			</div>
		
			<div id="panel3">
				<div id="panel3Header"  class="accordionTabTitleBar">
					Quote 3
				</div>
				<div id="panel3Content" class="accordionTabContentBox">
					
				</div>
			</div>
		</div>
		
		
	</body>
</html>