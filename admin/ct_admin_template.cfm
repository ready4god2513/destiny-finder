<cfinclude template="checksession_sub.cfm">

<CFIF THISTAG.EXECUTIONMODE IS 'START'>
<cfparam name="Attributes.title" default="">
<cfparam name="Attributes.columns" default="">
<cfparam name="Attributes.column_widths" default="">
<cfparam name="Attributes.column_headings" default="">
<cfparam name="Attributes.add_new_link" default="">
<cfparam name="Attributes.sortable_container" default="">
<cfparam name="Attributes.top_section" default="">
<cfparam name="Attributes.xml_update" default="">


<cfinclude template="functions/admin_functions.cfm">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title><cfoutput>#ATTRIBUTES.Title#</cfoutput></title>
	<link rel="stylesheet" href="css/style.css" type="text/css" />
	<link rel="stylesheet" href="css/mocha.css" type="text/css" />
	<script src="scripts/prototype.js" type="text/javascript"></script>
	<script src="scripts/scriptaculous.js" type="text/javascript"></script>
	<script language="JavaScript" type="text/javascript"><!--
	function populateHiddenVars() {
		document.getElementById('divOrder').value = Sortable.serialize('<cfoutput>#ATTRIBUTES.sortable_container#</cfoutput>');
		return true;
				}
				//-->
	</script>
</head>

<body>

<cfif isDefined("url.memo")>
	<cfoutput>#listing_memo(action=url.memo, title=url.title)#</cfoutput>
	<cfif LEN(Attributes.xml_update) GT 0>
		<cfmodule template="customtags/#ATTRIBUTES.xml_update#.cfm">
	</cfif>
</cfif>

<cfif ATTRIBUTES.top_section NEQ "">
<div style="width:500px;margin-left:auto;margin-right:auto;font-weight:bold;">
<cfoutput>#ATTRIBUTES.top_section#</cfoutput>
</div>
</cfif>

<div style="width:500px;margin-right:auto;margin-left:auto;margin-top:5px;">
	<div id="table_headings">
<cfoutput>
	  <cfloop from="1" To="#ATTRIBUTES.columns#" index="i">  
		<div style="width:#ListGetAt(ATTRIBUTES.column_widths, i)#px;float:left; margin-top:4px;">#ListGetAt(ATTRIBUTES.column_headings, i)# <cfif ATTRIBUTES.add_new_link NEQ "" AND i EQ "1">&nbsp;&nbsp;<a href="#ATTRIBUTES.add_new_link#"><img src="images/action_add.gif" />Add New</a></cfif></div> 
	  </cfloop>
</cfoutput>	  
		<div style="clear:both;"></div>
	</div>

<!--- PAGE CONTENT START --->
<CFELSE>
<!--- PAGE CONTENT END --->
<div style="clear:both;"></div>
</div>
</body>
</html>
</cfif>
