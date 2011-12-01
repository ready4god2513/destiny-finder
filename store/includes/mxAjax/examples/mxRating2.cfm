<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>Populating Drop down list with Coldfusion Array</title>
		<script type='text/javascript' src='../core/js/prototype.js'></script>
		<script type='text/javascript' src='../core/js/mxAjax.js'></script>
		<script type='text/javascript' src='../core/js/mxRating.js'></script>
		<style type="text/css">
			div.star-rating {
				width: 160px;
			  	float: left;
			  	clear: both;
			}
			
			div.star-rating a {
			  	cursor: pointer;
			  	margin: 0px;
			  	float: left;
			  	display: block;
			  	width: 30px;
			  	height: 30px;
			  	padding: 0 1px;
			  	background-image: url(../core/images/star/img_2_unselected.gif);
			  	background-repeat: no-repeat;
			  	background-position: 1px 0;
			}
			
			div.star-rating a.over {
			  	background-image: url(../core/images/star/img_2_hover.gif);
			}
			
			div.star-rating a.selected {
			  	background-image: url(../core/images/star/img_2_selected.gif);
			}
			
			div.star-rating a.selectedover {
			}
			
			div.star-rating a.selectedless {
			}
			
			div.star-rating a.defaultSelected {
				background-image: url(../core/images/star/img_2_defaultselected.gif);
			}

			div.star-rating-message {
			  	display: block;
			  	height: 12px;
			  	font: 10px Verdana;
			}
		</style>
		<script language="javascript">
				var url = "<cfoutput>#ajaxUrl#</cfoutput>";
		
				function init() {
					var aj_rater1 = new mxAjax.Rating({
						paramArgs: new mxAjax.Param(url,{param:"rating={" + AJAX_RATING_PARAMETER + "}", cffunction:"setRating"}),
						ratings: "1,2,3,4,5",
						onOff: "false",
						savedMessage: "<font color='red'><b>Your opinion is saved</b></font>",
						messageClass: "star-rating-message",
						selectedClass: "selected",
						selectedLessClass: "selectedless",
						defaultSelectedClass: "defaultSelected",
						selectedOverClass: "selectedover",
						defaultRating: "2",
						overClass: "over",
						state: "raterField",
						containerClass: "star-rating",
						source: "rater1"
					});
				}
				addOnLoadEvent(function() {init();});
			</script>
			<LINK REL="stylesheet" type="text/css" href="style.css">
			<link rel="stylesheet" type="text/css" href="style.css"/>
		</head>
		<body>
			
			
			<h1>Using mxRating Component</h1>
			<input type="hidden" id="raterField" />
	  		<div id="rater1" class="star-rating"><a href="javascript:void(0)" title="I hate it"></a><a href="javascript:void(0)" title="I don't like it"></a><a href="javascript:void(0)" title="It's Ok"></a><a href="javascript:void(0)" title="I like it"></a><a href="javascript:void(0)" title="I love it!"></a></div>
	  		<br/><br/><br/><br/>
			
			
		</body>
	</html>