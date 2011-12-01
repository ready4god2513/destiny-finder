<cfinclude template="../checksession_sub.cfm">
<cfinclude template="../functions/admin_functions.cfm">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en" dir="ltr">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>Webvision Control Panel: <cfoutput>#Application.sitename#</cfoutput></title>
	<link rel="stylesheet" href="css/style.css" type="text/css" />
	<link rel="stylesheet" href="css/mocha.css" type="text/css" />
	<script type="text/javascript" src="ckfinder/ckfinder.js"></script>
	<script src="scripts/prototype.js" type="text/javascript"></script>
	<script src="scripts/scriptaculous.js" type="text/javascript"></script>
	<script type="text/javascript" src="scripts/calendarDateInput.js"></script>
	<script type="text/javascript" src="/ckeditor/ckeditor.js"></script>

	<script language="JavaScript" type="text/javascript"><!--
	function populateHiddenVars() {
		document.getElementById('divOrder').value = Sortable.serialize('sortContainer');
		return true;
				}
				//-->
	</script>
</head>
<body>