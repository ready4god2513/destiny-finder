<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>mxAjax - Multi Select component</title>
		<script type='text/javascript' src='../core/js/prototype.js'></script>
		<script type='text/javascript' src='../core/js/mxAjax.js'></script>
		<script type='text/javascript' src='../core/js/mxMultiSelect.js'></script>
		<script language="javascript">
			var url = "<cfoutput>#ajaxUrl#</cfoutput>";
			var mySelectObj;
	
			function init() {
				mySelectObj = new mxAjax.MultiSelect({
					executeOnLoad: true,
					source: "make",
					control: "mySelectControl",
					cssClass: "multiSelect",
					parser: new mxAjax.CFArrayToJSKeyValueParser(),
					target: "mySelect", 
					paramArgs: new mxAjax.Param(url,{param:"make={make}", httpMethod:"post", cffunction:"makelookup"})
				});
			}
			addOnLoadEvent(function() {init();});
		</script>
		<link rel="stylesheet" type="text/css" href="style.css"/>
		<style type="text/css">
			div.multiSelect {
				width: 250px;
				height:80px;
			  	overflow:auto;
  				border:1px solid #000;
  				border-color:#7F9DB9;
				position:relative;
				font-size:14px;
			}

			div.multiSelect label {
				display:block;
			}

			div.multiSelect label span {
				font-size:13px;
			}		

			div.multiSelect label.disabled {
				color:green;
				font-size:20px;
				font-weight:bold;
			}		

			div.multiSelect label.selected {
				background-color:#316AC5;				
				color:#ffffff;
			}		
			
			div.multiSelectControl {
			}
			
			div.multiSelectControl a {
			  	cursor: pointer;
			  	text-decoration:none;
			  	font-size:14px;
			  	font-face:Verdana;
			  	color:red;
			}
			
			div.multiSelectControl a.over {
			}
			
			div.multiSelectControl a.selected {
			}
			
		</style>
	</head>
	<body>
		
		
		<h1>Using MultiSelect with controls</h1>
		<br/>
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
					<b>Select phone model :</b>
				</td>
				<td>
					<div id="mySelectControl" class="multiSelectControl"></div>
			 		<select name="mySelect" id="mySelect" size="4" multiple="multiple">
			   		</select>
				</td>
			</tr>
		</table>
		
		
	</body>
</html>