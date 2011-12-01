<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Untitled Document</title>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js" type="text/javascript"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.3/jquery-ui.min.js" type="text/javascript"></script>

<style type="text/css">
	#sortable { list-style-type: none; margin: 0; padding: 0; width: 60%; }
	#sortable li { margin: 0 3px 3px 3px; padding: 0.4em; padding-left: 1.5em; font-size: 1.4em; height: 18px; }
	#sortable li span { position: absolute; margin-left: -1.3em; }
	.ui-sortable-helper {background-color:#00FF00;}
	</style>
</head>
<body>

	<script type="text/javascript">
	$(function() {
		$("#sortable").sortable();
		$("#sortable").disableSelection();
		$('.sort').click(
			function(event){
				alert($("#sortable").sortable("serialize", {key: 'string'}));
			}
		);
	});
	</script>


<div class="demo">

<ul id="sortable">
	<li class="ui-state-default" id="item_1"><span class="ui-icon ui-icon-arrowthick-2-n-s"></span>Item 1</li>
	<li class="ui-state-default" id="item_2"><span class="ui-icon ui-icon-arrowthick-2-n-s"></span>Item 2</li>
	<li class="ui-state-default" id="item_3"><span class="ui-icon ui-icon-arrowthick-2-n-s"></span>Item 3</li>
	<li class="ui-state-default" id="item_4"><span class="ui-icon ui-icon-arrowthick-2-n-s"></span>Item 4</li>
	<li class="ui-state-default" id="item_5"><span class="ui-icon ui-icon-arrowthick-2-n-s"></span>Item 5</li>
	<li class="ui-state-default" id="item_6"><span class="ui-icon ui-icon-arrowthick-2-n-s"></span>Item 6</li>
	<li class="ui-state-default" id="item_7"><span class="ui-icon ui-icon-arrowthick-2-n-s"></span>Item 7</li>
</ul>
<input type="button" name="Sort" class="sort" value="Sort" />

</div><!-- End demo -->

<div style="display: none;" class="demo-description">

<p>
	Enable a group of DOM elements to be sortable. Click on and drag an
	element to a new spot within the list, and the other items will adjust to
	fit. By default, sortable items share <code>draggable</code> properties.
</p>

</div><!-- End demo-description -->
</body>
</html>
