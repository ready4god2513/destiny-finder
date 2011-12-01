<cfinclude template="functions/admin_functions.cfm">
	<cfquery name="getevents" datasource="#APPLICATION.DSN#" dbtype="ODBC">
	SELECT calevent_title,calevent_start_date,calevent_end_date,calevent_id,calevent_active,calevent_live_date FROM Calendar_Events
	ORDER BY calevent_active,calevent_start_date ASC
	</cfquery>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Calendar Event Listing</title>
	<link rel="stylesheet" href="css/style.css" type="text/css" />
	<link rel="stylesheet" href="css/mocha.css" type="text/css" />
</head>

<body>
<!--- <cfif isDefined("url.memo")>
<cfoutput><div style="width:350px;border:1px dotted ##ff0000; color:##ff0000;font-size:13px;padding-bottom:5px;padding-top:5px;font-weight:bold;text-align:center;margin-left:auto;margin-right:auto;margin-bottom:5px;margin-top:5px;">
<cfif url.memo EQ "new_event">
	 	#url.calevent_title# Has Been Created!
	<cfelseif url.memo EQ "updated">
		#url.calevent_title# Has Been Updated!
	<cfelseif url.memo EQ "deleted">
		#url.calevent_title# Has Been Deleted!
	</cfif>
</div></cfoutput>
</cfif> --->
<cfif isDefined("url.memo")>
	<cfoutput>#listing_memo(action=url.memo, title=url.title)#</cfoutput>
	<!--- <cfmodule template="customtags/write_banner_xml.cfm"> --->
</cfif>

<div style="width:500px;margin-right:auto;margin-left:auto;margin-top:5px;">
	<div id="table_headings">
	<div style="width:170px;float:left; margin-top:4px;">Event Title/Name<a href="cal_event.cfm?calevent_id=new"><img src="images/action_add.gif" />Add New</a></div>
	<div style="width:110px;float:left; margin-top:4px;">Start Date</div>
	<div style="width:125px;float:left; margin-top:4px; text-align:center;">End Date</div>
	<div style="width:85px;float:left; margin-top:4px; text-align:center;">Active</div>
		<div style="clear:both;"></div>
	</div>
	
	<cfoutput query="getevents">
		<div id="<cfif currentrow MOD 2>even_row<cfelse>odd_row</cfif>">
			<div id="name_column" style="width:175px;float:left;"><a href="cal_event.cfm?calevent_id=#getevents.calevent_id#" title="#getevents.calevent_title#"><img src="images/edit.gif" />&nbsp;
			<cfif len(getevents.calevent_title) GT 25>
			#left(getevents.calevent_title, 25)#...
			<cfelse>
			#getevents.calevent_title#
			</cfif>
			
			</a></div>
			<div id="column_one" style="width:110px;">
			#DateFormat(getevents.calevent_start_date, 'mmm, dd yyyy')#
			</div>
			<div id="column_two" style="width:125px; text-align:center;">
			#DateFormat(getevents.calevent_end_date, 'mmm, dd yyyy')#
			</div>
			<div id="column_two" style="width:85px; text-align:center;">
				<cfif getevents.calevent_active EQ 1><img src="images/action_check.gif" /><cfelse><img src="images/action_disabled.gif" /></cfif></div><div style="clear:both;"></div>
		</div>
	</cfoutput>	
<div style="clear:both;"></div>
</div>
</body>
</html>
