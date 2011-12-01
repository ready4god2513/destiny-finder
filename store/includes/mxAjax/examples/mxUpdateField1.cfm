<html>
	<head>
		<title>Updating field with CF Array data</title>
		<script type='text/javascript' src='../core/js/prototype.js'></script>
		<script type='text/javascript' src='../core/js/mxAjax.js'></script>
		<script type='text/javascript' src='../core/js/mxUpdateField.js'></script>
		<script language="javascript">
			var url = "<cfoutput>#ajaxUrl#</cfoutput>";
			
			function init() {
				new mxAjax.UpdateField({
					parser: new mxAjax.CFArrayToJSArray(),
					paramArgs: new mxAjax.Param(url,{param:"make={make}", cffunction:"makelookup"}),
					target: "field1,field2",
					source: "make"
				});
			}

			addOnLoadEvent(function() {init();});
		</script>
		<link rel="stylesheet" type="text/css" href="style.css"/>
	</head>
	<body>
		
		
		<h1>Updating field with CF Array data</h1>
		<table>
			<tr>
				<td>
					Select a phone brand :
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
				<td>
					Field 1	
				</td>
				<td>
					<input id="field1" name="field1" type="text" size="30" />
				</td>
			</tr>
			<tr>
				<td>
					Field 2	
				</td>
				<td>
					<input id="field2" name="field2" type="text" size="30" />
				</td>
			</tr>
		</table>
		
		
	</body>
</html>