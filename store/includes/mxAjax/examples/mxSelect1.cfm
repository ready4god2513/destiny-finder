<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>Populating Drop down list with Coldfusion Array</title>
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
					paramArgs: new mxAjax.Param(url,{param:"make={make}", httpMethod:"post", cffunction:"makelookup"}),
					source: "make"
				});
			}
			addOnLoadEvent(function() {init();});
		</script>
		<link rel="stylesheet" type="text/css" href="style.css"/>
	</head>
	<body>
		
		
		<h1>Populating Drop down list with Coldfusion Array</h1>
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
					<b>Select a phone model :</b>
				</td>
				<td>
					<select name="model" id="model" style="vertical-align:top;"></select>
				</td>
			</tr>
		</table>
		
		
	</body>
</html>