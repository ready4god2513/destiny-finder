<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Custom tag used to create a text box with a javascript calendar popup.  --->

<!--- Attributes --->
<cfparam name="attributes.ID" default="0">
<cfparam name="attributes.CSSPrefix" default="CFW">
<cfparam name="attributes.formfield" default="field1">
<cfparam name="attributes.size" default="15">
<cfparam name="attributes.maxlength" default="30">
<cfparam name="attributes.value" default="">
<cfparam name="attributes.class" default="formfield">
<cfparam name="attributes.formname" default="form1">
<cfparam name="attributes.bgcolor" default="white">
<cfparam name="attributes.prompt" default="">
<cfparam name="attributes.browser" default="MSIE">
<cfparam name="attributes.bversion" default="0">

<!--- By default, use div style for Firefox and IE7, html for all other browsers --->
<cfif attributes.browser IS "Firefox">
	<cfparam name="attributes.style" default="div">
<cfelseif attributes.browser IS "MSIE" AND attributes.bversion GTE 7>
	<cfparam name="attributes.style" default="div">
<cfelse>
	<cfparam name="attributes.style" default="html">
</cfif>

<!--- START --------------------------------------------------------->
<cfif thistag.ExecutionMode is "Start">

<cfoutput>
<script type="text/javascript">
	<cfif attributes.style IS "div">
		var cal#attributes.ID# = new CalendarPopup("div#attributes.ID#");
	<cfelse>
		var cal#attributes.ID# = new CalendarPopup();
	</cfif>	
	
	cal#attributes.ID#.showYearNavigation();
	cal#attributes.ID#.setCssPrefix("#attributes.CSSPrefix#");
	</script>
<cfif len(attributes.prompt)>#attributes.prompt#: </cfif><input type="text" name="#attributes.formfield#" value="#attributes.value#" size="#attributes.size#" maxlength="#attributes.maxlength#" class="#attributes.class#" /> <a href="##" onclick="cal#attributes.ID#.select(document.#attributes.formname#.#attributes.formfield#,'anchor#attributes.ID#','MM/dd/yyyy'); return false;" title="cal#attributes.ID#.select(document.#attributes.formname#.#attributes.formfield#,'anchor#attributes.ID#','MM/dd/yyyy'); return false;" name="anchor#attributes.ID#" id="anchor#attributes.ID#"><img src="#Request.Appsettings.DefaultImages#/icons/Calendar2.gif" alt="" width="16" height="16" border="0" align="top" /></a>
<div id="div#attributes.ID#" style="position:absolute;visibility:hidden;background-color:#attributes.bgcolor#;layer-background-color:#attributes.bgcolor#;"></div>
</cfoutput>


</cfif><!---- TAG END ------------------------------------------------>
