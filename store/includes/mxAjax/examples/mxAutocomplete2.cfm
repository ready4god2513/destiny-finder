<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>Autocomplete with flexible drop down window</title>
		<script type='text/javascript' src='../core/js/prototype.js'></script>
		<script type='text/javascript' src='../core/js/scriptaculous.js'></script>
		<script type='text/javascript' src='../core/js/mxAjax.js'></script>
		<script type='text/javascript' src='../core/js/mxAutocomplete.js'></script>
		<script language="javascript">
			var url = "<cfoutput>#ajaxUrl#</cfoutput>";
			
			function init() {
				new mxAjax.Autocomplete({
					indicator: "indicator",
					minimumCharacters: "1",
					target: "statecode",
					className: "autocomplete",
					paramArgs: new mxAjax.Param(url,{cffunction:"getStateList"}),
					parser: new mxAjax.CFQueryToJSKeyValueParser(),
					source: "searchCharacter",
					flexWidth: true
				});
			}
			
			addOnLoadEvent(function() {init();});
		</script>
		<link rel="stylesheet" type="text/css" href="style.css"/>
	</head>
	<body>
		<h3>Autocomplete with flexible drop down window</h3>
		<table>
			<tr>
				<td width="18" align="right">
					<span id="indicator" style="display:none;"><img src="../core/images/indicator.gif" /></span>
				</td>
				<td width="1"></td>
				<td>
					State : <input id="searchCharacter" name="searchCharacter" type="text" size="20" />
					&nbsp;&nbsp;
					<input id="statecode" name="statecode" type="text" size="2" />
				</td>
			</tr>
		</table>
	</body>
</html>