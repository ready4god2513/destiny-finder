<html>
	<head>
		<title>Rico Accordion Component</title>
		<script type='text/javascript' src='../core/js/prototype.js'></script>
		<script type='text/javascript' src='../core/js/mxAjax.js'></script>
		<script type='text/javascript' src='../core/js/mxRicoAccordion.js'></script>
		<script language="javascript">
			var url = "<cfoutput>#ajaxUrl#</cfoutput>";
			
			function init() {
				new mxAjax.RicoAccordion( 'accordionExample', {panelHeight:227} ); 
			}
			addOnLoadEvent(function() {init();});
		</script>
	   	<style>
			#accordionExample { width : 450px; }
	   	</style>
	   	<LINK REL="stylesheet" type="text/css" href="style.css">
		<link rel="stylesheet" type="text/css" href="style.css"/>
	</head>
	<body>
		
		
		<h1>Using mxRicoAccordion</h1>
		<div style="margin-top:6px; border-top-width:1px; border-top-style:solid;" id="accordionExample">
			<div id="panel1">
				<div id="panel1Header" class="accordionTabTitleBar">
					What Are Requirements?
				</div>
				<div id="panel1Content"  class="accordionTabContentBox">
					The most useful products are those where the developers have understood what the product is intended to accomplish for its users and how it must accomplish that purpose. To understand these things, you must understand what kind of work the users want to do and how the product will affect that work and fit into the organization's goals. What the product does for its users and which constraints it must satisfy in this context are the product's requirements. Apart from a few fortuitous accidents, no product has ever succeeded without prior understanding of its requirements. It does not matter what kind of work the user wishes to do, be it scientific, commercial, e-commerce, or word processing. Nor does it matter which programming language or development tools are used to construct the product. The development processwhether agile, eXtreme Programming, prototyping, the Rational Unified Process, or any other methodis irrelevant to the need for understanding the requirements. 
				</div>
			</div>
		
			<div id="panel2">
				<div id="panel2Header" class="accordionTabTitleBar">
					Functional Requirements?
				</div>
				<div id="panel2Content" class="accordionTabContentBox">
					The functional requirements specify what the product must do. They describe the actions the product must carry out to satisfy the fundamental reasons for its existence. For example, the functional requirement describes an action the product must take if it is to carry out the work for which it is intended. The intention is to understand the functional requirements and so convey to the developers what the product is required to do for its intended operator.
				</div>
			</div>
		
			<div id="panel3">
				<div id="panel3Header"  class="accordionTabTitleBar">
					Writing the Requirements
				</div>
				<div id="panel3Content" class="accordionTabContentBox">
					Writing the requirements refers to the task of putting together a description of the product from the business point of view. Typically, this description is called a specification, and we use the term here to mean whatever description you are compiling, whether it is written or not. It is appropriate to think of this activity as building a specification: You assemble a specification, one requirement at a time, rather than writing it all at once.					
				</div>
			</div>
		</div>
		
		
	</body>
</html>