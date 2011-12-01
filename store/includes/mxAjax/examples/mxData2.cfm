<html>
	<head>
		<title>Returning Data from CF page</title>
		<script type='text/javascript' src='../core/js/prototype.js'></script>
		<script type='text/javascript' src='../core/js/mxAjax.js'></script>
		<script type='text/javascript' src='../core/js/mxData.js'></script>
		<script language="javascript">
			var url = "<cfoutput>#ajaxUrl#</cfoutput>";
			
			function init() {
				myAjaxFunction = new mxAjax.Data({
					executeOnLoad:true,
					paramFunction: param,
					postFunction: handleData
				});
			}

			function param(id) {
				oParam = new mxAjax.Param(url,{});
				oParam.addCall( {"makelookup": {
									"make": "Nokia"
								}});
				oParam.addCall( {"makeDescription": {
									"make": "Nokia"
								}});
				return oParam;
			}
			
			function handleData(response) {
				alert(response);
			}
			
			addOnLoadEvent(function() {init();});
		</script>
		<link rel="stylesheet" type="text/css" href="style.css"/>
	</head>
	<body>
		
		
		<h1>Returning Data from CF page - Multiple function Call</h1>
		
		
	</body>
</html>