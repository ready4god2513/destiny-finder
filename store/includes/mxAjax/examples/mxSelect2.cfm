<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>Making multiple coldfusion function call</title>
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
					postFunction: afterMakePopulated,
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
			
			function afterMakePopulated(response,json) {
				$("info").innerHTML = json.calls[1].data;
			}

			addOnLoadEvent(function() {init();});
		</script>
		<link rel="stylesheet" type="text/css" href="style.css"/>
	</head>
	<body>
		
		
		<h1>Making multiple coldfusion function call</h1>
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
		</table>
		
		
	</body>
</html>