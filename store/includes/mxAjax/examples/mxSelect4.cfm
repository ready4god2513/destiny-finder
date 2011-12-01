<html>
	<head>
		<title>CF Function returning multiple set of data</title>
		<script type='text/javascript' src='../core/js/prototype.js'></script>
		<script type='text/javascript' src='../core/js/mxAjax.js'></script>
		<script type='text/javascript' src='../core/js/mxSelect.js'></script>
		<script language="javascript">
			var url = "<cfoutput>#ajaxUrl#</cfoutput>";
			
			function init() {
				new mxAjax.Select({
					parser: new mxAjax.CFArrayToJSKeyValueParser({path:".lookup"}),
					executeOnLoad: true,
					target: "model", 
					postFunction: afterModelPopulated,
					paramArgs: new mxAjax.Param(url,{param:"make={make}", cffunction:"makeAndDescription"}),
					source: "make"
				});
			}
			
			function afterModelPopulated(response,json) {
				$("info").innerHTML = json.description;
			}
			
			addOnLoadEvent(function() {init();});
		</script>
		<link rel="stylesheet" type="text/css" href="style.css"/>
	</head>
	<body>
		
		
		<h1>CF Function returning multiple set of data</h1>
		<table>
			<tr>
				<td width="200" align="right">
					<b>Select a phone make :</b>
				</td>
				<td>
					<select id="make" name="make">
						<option value="Nokia">Nokia</option>
						<option value="Motorolla">Motorolla</option>
						<option value="Samsung">Samsung</option>
					</select>
				</td>
			</tr>
			<tr>
				<td width="200" align="right">
					<b>Make Info :</b>
				</td>
				<td>
					<span id="info"/>
				</td>
			</tr>
			<tr>
				<td width="200" align="right">
					<b>Select a phone model :</b>
				</td>
				<td>
					<select name="model" id="model" style="vertical-align:top;"></select>
				</td>
			</tr>
		</table>
		
		
	</body>
</html>