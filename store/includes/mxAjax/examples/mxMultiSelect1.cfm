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
			}
			addOnLoadEvent(function() {init();});
		</script>
		<link rel="stylesheet" type="text/css" href="style.css"/>
		<style type="text/css">
			div.multiSelect {
				width: 250px;
				height:100px;
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
			}		

			div.multiSelect label.disabled {
				color:#D7B899;
			}		

			div.multiSelect label.selected {
				background-color:#316AC5;				
				color:#ffffff;
			}		

		</style>
	</head>
	<body>
		
		
		<h1>Using MultiSelect Component</h1>
		<br/>

		<div id="mySelectControl" class="multiSelectControl"></div>
 		<select name="mySelect" id="mySelect" size="6" multiple="multiple">
    		<option value="VA">Virginia</option>
    		<option value="CO">Colorado</option>
		    <option value="AT" disabled>Atlanta</option>
		    <option value="MD" selected>Maryland</option>
		    <option value="NY" selected>New York</option>
		    <option value="DC">Washington DC</option>
		    <option value="FL">Florida</option>
   		</select>
		<script language="javascript">
			mySelectObj = new mxAjax.MultiSelect({
				executeOnLoad: true,
				target: "mySelect",
				cssClass: "multiSelect"
			});
		</script>

		
		
	</body>
</html>