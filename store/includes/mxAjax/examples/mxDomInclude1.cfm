<html>
	<head>
		<title>Dom Include Component An alternative for Popup windows</title>
		<script type='text/javascript' src='../core/js/prototype.js'></script>
		<script type='text/javascript' src='../core/js/mxAjax.js'></script>
		<script type='text/javascript' src='../core/js/mxDomInclude.js'></script>
		<script language="javascript">
				var url = "<cfoutput>#ajaxUrl#</cfoutput>";
				
				function init() {
					new mxAjax.DomInclude( {source:"amazon"} ); 
					new mxAjax.DomInclude( {source:"photo"} ); 
					new mxAjax.DomInclude( {source:"content"} ); 
				}
				addOnLoadEvent(function() {init();});
		</script>
	   	<style>
			#accordionExample { width : 450px; }
	   	</style>
	   	<LINK REL="stylesheet" type="text/css" href="style.css">
		<link rel="stylesheet" type="text/css" href="style.css"/>
	</head>
	<body>
		
		
		<h1>Using mxDomInclude - alternative for Popup windows</h1>
		
		<p>DOMinclude is a script that creates this effect: If JavaScript is available the linked file gets shown in a new layer - if it is an image just as the image, if not inside an IFRAME. DOMinclude automatically 
		positions the popup where the original link is and adds a text prefix to the original link telling the user how to hide the layer again. - <a href="http://www.onlinetools.org/tools/dominclude/">Orignal Version</a></p>
		
		Example 1 : <a id="amazon" href="data/amberspyglass.html">Phillip Pullman: The Amber Spyglass</a> 
		<br/><br/>
		Example 2 : <a id="photo" href="data/saywhat.jpg">Image</a>
		<br/><br/>
		Example 3 : <a id="content" href="data/exampleTandC.html">Html Content</a>
		<br/><br/><br/>
		
		
	</body>
</html>
