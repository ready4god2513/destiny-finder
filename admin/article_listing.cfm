<cfquery name="getarticles" datasource="#DSN#" dbtype="odbc">
SELECT * FROM Articles
<!--- WHERE article_type = <cfqueryparam cfsqltype="cf_sql_integer" value="#URL.article_type#"> --->
ORDER BY LiveDate DESC
</cfquery>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Article Listing</title>
	<link rel="stylesheet" href="css/style.css" type="text/css" />
	<link rel="stylesheet" href="css/mocha.css" type="text/css" />
</head>

<body>
<cfif isDefined("url.memo")>
<div style="width:350px;border:1px dotted #ff0000; color:#ff0000;font-size:13px;padding-bottom:5px;padding-top:5px;font-weight:bold;text-align:center;margin-left:auto;margin-right:auto;margin-bottom:5px;margin-top:5px;">

 <cfif url.memo EQ "new">
	<cfoutput>#url.title# Has Been Added</cfoutput>
 <cfelseif url.memo EQ "updated">
	<cfoutput>#url.title# Has Been Updated</cfoutput>
 <cfelseif url.memo EQ "deleted">
	<cfoutput>#url.title# Has Been Deleted</cfoutput>
 </cfif>
</div>
</cfif>

<cfoutput>
<div style="width:500px;margin-right:auto;margin-left:auto;margin-top:5px;">
	<div id="table_headings">
	<div style="width:375px;float:left;">News Title&nbsp;&nbsp;<a href="articles.cfm?articleid=new"><img src="images/action_add.gif" />Add New</a></div>
	<div style="width:15px;float:left; margin-top:4px;">&nbsp;</div>
	<div style="width:100px;float:left; margin-top:4px;">Live Date</div>
		<div style="clear:both;"></div>
	</div>
</cfoutput>
	
	<cfoutput query="getarticles">
		<div id="<cfif currentrow MOD 2>even_row<cfelse>odd_row</cfif>">
			<div id="name_column" style="width:375px;"><a href="articles.cfm?articleid=#getarticles.articleid#"><img src="images/edit.gif" />&nbsp;
			<cfif LEN(getarticles.title) GT 48>
				#LEFT(getarticles.title,45)#...
			<cfelse>
				#getarticles.title#
			</cfif></a></div>
			<div id="column_one" style="width:15px;">
			&nbsp;</div>
			<div id="column_two" style="width:100px;">#DateFormat(getarticles.LiveDate, 'mmm dd, yy')#</div>
				<div style="clear:both;"></div>
		</div>
	</cfoutput>	
<div style="clear:both;"></div>
</div>
</body>
</html>
