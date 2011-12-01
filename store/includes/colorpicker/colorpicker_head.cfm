
<style> img {
	BEHAVIOR: url('includes/colorpicker/pngbehavior.htc')
}
</style>

<script src='includes/colorpicker/colorpicker.js' type='text/javascript'></script>

<cfset fieldlist = "MainTitle,MainText,MainLink,MainVLink,linecolor,Bgcolor,BoxHBgcolor,BoxHText,BoxTBgcolor,BoxTText,formreqOB,InputHBgcolor,InputHText,InputTBgcolor,InputTText,FormReq,OutputHBgcolor,OutputHText,OutputTBgcolor,OutputTText,OutputTAltcolor">

<cfprocessingdirective suppresswhitespace="no">
<!--- colorpicker script --->
<script language='JavaScript'>

<cfoutput>
function colorinit() {
	var colors = new Array();
	<cfloop from="1" to="#ListLen(fieldlist)#" index="x">
		colors[#Evaluate(x-1)#] = document.getElementById('#ListGetAt(fieldlist, x)#');	
	</cfloop>
	
	for (var i=0; i < #ListLen(fieldlist)#; i++) {
	if(colors[i]) attachColorPicker(colors[i]);
	}	
}
</cfoutput>

function changeColorSwatch(thefield,newcolor) {
	var swatch = document.getElementById(thefield + '_swatch');
	swatch.style.backgroundColor=newcolor;
}
</script>
</cfprocessingdirective>

