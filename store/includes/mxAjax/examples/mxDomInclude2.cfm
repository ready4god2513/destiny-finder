<html>
	<head>
		<title>Dom Include to load Dynamic Data</title>
		<script type='text/javascript' src='../core/js/prototype.js'></script>
		<script type='text/javascript' src='../core/js/mxAjax.js'></script>
		<script type='text/javascript' src='../core/js/mxDomInclude.js'></script>
		<script language="javascript">
				var url = "<cfoutput>#ajaxUrl#</cfoutput>";

				function init() {
					new mxAjax.DomInclude({
						source:"dynamicdata",
						paramArgs: new mxAjax.Param(url,{param:"", cffunction:"getCopyrightContent"})
					}); 
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
			
			
			<h1>Dom Include to load Dynamic Data</h1>
			
			<p>DOMinclude is a script that creates this effect: If JavaScript is available the linked file gets shown in a new layer - if it is an image just as the image, if not inside an IFRAME. DOMinclude automatically 
			positions the popup where the original link is and adds a text prefix to the original link telling the user how to hide the layer again.</p>
			
			
			<a id="dynamicdata" href="\null\">Load Dynamic Data</a>
			<br/><br/><br/>
			
			
		</body>
	</html>
