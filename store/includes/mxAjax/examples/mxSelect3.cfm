<html>
	<head>
		<title>Multiple coldfusion function call and Ajax.Update call</title>
		<script type='text/javascript' src='../core/js/prototype.js'></script>
		<script type='text/javascript' src='../core/js/mxAjax.js'></script>
		<script type='text/javascript' src='../core/js/mxSelect.js'></script>
		<script language="javascript">
			var url = "<cfoutput>#ajaxUrl#</cfoutput>";
			
			function init() {
				new mxAjax.Select({
					parser: new mxAjax.CFArrayToJSKeyValueParser(),
					executeOnLoad: true,
					target: "model", 
					paramFunction: makeParam,
					postFunction: afterModelPopulated,
					source: "make"
				});
			}

			function makeParam() {
				oParam = new mxAjax.Param(url,{});
				oParam.addCall( {"makelookup": {
									"make": $("make").value
								}});
				oParam.addCall( {"makeDescription": {
									"make": $("make").value
								}});
				return oParam;
			}
			
			function afterModelPopulated(response, json) {
				$("info").innerHTML = json.calls[1].data;
				updateImage();
			}
			
			function updateImage() {
				$("selectedID").innerHTML = $("model").value;
				new Ajax.Updater('image', url + '?method=init&function=modelImage&model=' + $("model").value + '&htmlResponse=true'); return false;
			}
			
			addOnLoadEvent(function() {init();});
		</script>
		<link rel="stylesheet" type="text/css" href="style.css"/>
	</head>
	<body>
		
		
		<h1>Multiple coldfusion function call and Ajax.Update call</h1>
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
					<select name="model" id="model" style="vertical-align:top;" onChange="updateImage()"></select>
				</td>
			</tr>
			<tr>
				<td width="200" align="right">
					<b>Model ID :</b>
				</td>
				<td>
					<b><span name="selectedID" id="selectedID"></span></b>
				</td>
			</tr>
			<tr>
				<td width="200" align="right">
					<b>Image :</b>
				</td>
				<td>
					<br/>
					<span name="image" id="image"></span>
				</td>
			</tr>
		</table>
		
		
	</body>
</html>
