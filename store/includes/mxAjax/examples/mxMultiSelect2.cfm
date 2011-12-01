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
					target: "mySelect",
					control: "mySelectControl",
					cssClass: "multiSelect"
				});
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
		<form method="post" action="mxMultiSelect1.cfm">
			<div id="mySelectControl" class="multiSelectControl"></div>
	 		<select name="mySelect" id="mySelect" size="6" multiple="multiple">
	    		<option value="1">test 1 of this thing</option>
	    		<option value="2">&nbsp;test 2 of this &lt;thing&gt;</option>
			    <option value="3" disabled>test 3 of this thing</option>
			    <option value="4" selected>test 4 of this thing</option>
			    <option value="5" selected>test 5 of this thing</option>
			    <option value="6">test 6 of this thing</option>
			    <option value="7">test 7 of this thing</option>
			    <option value="8">test 8 of this thing</option>
	    		<option value="9">test 9 of this thing</option>
	   		</select>
		</form>
		
		
	</body>
</html>