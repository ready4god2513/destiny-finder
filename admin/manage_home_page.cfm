<!--- QUERY FOR LISTING --->
<cfquery name="gethomeblocks" datasource="#DSN#" dbtype="odbc">
	SELECT block_id, block_title FROM HomeContent
	ORDER BY block_id ASC
</cfquery>


<cfinclude template="functions/admin_functions.cfm">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Home Content Management</title>
	<link rel="stylesheet" href="css/style.css" type="text/css" />
	<link rel="stylesheet" href="css/mocha.css" type="text/css" />
</head>

<body>

<cfif isDefined("url.memo")>
	<cfoutput>#listing_memo(action=url.memo, title=url.title)#</cfoutput>
</cfif>

<div style="width:500px;margin-right:auto;margin-left:auto;margin-top:5px;">
	<div id="table_headings">
		<div style="float:left; margin-top:4px;">Home Page Management&nbsp;&nbsp;</div> 
		<div style="clear:both;"></div>
	</div>

	
	<cfoutput query="gethomeblocks">
		<div id="<cfif currentrow MOD 2>even_row<cfelse>odd_row</cfif>">
			<!--- FOR EVERY COLUMN SET EACH STYLE ELEMENT NEEDS TO ADDRESS THE APPROPRIATE WIDTH AS ASSIGNED ABOVE, THIS IS DONE BY SETTING THE LISTGETAT # TO IT'S RESPECTIVE COLUMN PLACEHOLDER, 1 IS FOR THE FIRST COLUMN, 2 IS FOR THE SECOND, AND SO ON. --->
			<div id="name_column" style="width:100%"><a href="home_content_block.cfm?block_id=#gethomeblocks.block_id#"><img src="images/edit.gif" />&nbsp;#gethomeblocks.block_title#</a></div>
			<div style="clear:both;"></div>
		</div>
	</cfoutput>	
<div style="clear:both;"></div>
</div>
</body>
</html>
